package com.zyark.shiro.realm;

import com.zyark.domain.SysUser;
import com.zyark.service.SysUserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import javax.annotation.Resource;

/**
 * Created by ron on 17-4-6.
 */
public class UserRealm extends AuthorizingRealm {

    @Resource
    SysUserService sysUserService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String username = (String) principalCollection.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        authorizationInfo.setRoles(sysUserService.findRoleNames(username));
        authorizationInfo.setStringPermissions(sysUserService.findPermission(username));
        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        String username = (String)authenticationToken.getPrincipal();
        SysUser sysUser = sysUserService.selectOne(new SysUser(username));
        if (sysUser == null){
            SysUser sysUser1 = new SysUser();
            sysUser1.setPhone(username);
            sysUser = sysUserService.selectOne(sysUser1);
        }

        if (sysUser == null){
            throw new UnknownAccountException(); //没找到帐号
        }
        if (Boolean.TRUE.equals(sysUser.getLocked())){
            throw new LockedAccountException(); //帐号被锁定
        }

        SimpleAuthenticationInfo simpleAuthorizationInfo = new SimpleAuthenticationInfo(
                sysUser.getUsername(),
                sysUser.getPassword(),
                ByteSource.Util.bytes(sysUser.getCredentialsSalt()),
                getName()
        );
        return simpleAuthorizationInfo;
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }

    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }

}
