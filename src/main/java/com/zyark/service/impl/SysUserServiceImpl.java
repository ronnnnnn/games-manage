package com.zyark.service.impl;

import com.zyark.dao.*;
import com.zyark.domain.*;
import com.zyark.model.PageModel;
import com.zyark.model.ServerResponseModel;
import com.zyark.service.SysSettingService;
import com.zyark.service.SysUserHasSysRoleKeyService;
import com.zyark.service.SysUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by ron on 17-4-6.
 */
@Service
public class SysUserServiceImpl extends BaseServiceIpml<SysUser> implements SysUserService {

    @Resource
    SysUserHasSysRoleMapper userRoleMapper;

    @Resource
    SysRoleMapper sysRoleMapper;
    @Resource
    SysResourceMapper sysResourceMapper;

    @Resource
    SysUserMapper sysUserMapper;

    @Resource
    SysRoleHasSysResourceMapper roleResourceMapper;

    @Resource
    PasswordHelper passwordHelper;

    @Resource
    SysUserHasSysRoleKeyService sysUserHasSysRoleKeyService;

    @Resource
    SysOrganizationHasSysUserMapper userOrganizationMapper;
    @Resource
    private SysSettingService sysSettingService;



    Logger logger = LoggerFactory.getLogger(SysUserServiceImpl.class);

    /**
     * 根据用户名找到角色
     *
     * @param username
     *
     * @return
     */
    @Override
    public List<SysRole> findRoles(String username) {
        SysUser sysUser = this.selectOne(new SysUser(username));
        SysUserHasSysRoleKey userRoleKey = new SysUserHasSysRoleKey(sysUser.getId());
        List<SysUserHasSysRoleKey> userRoleKeys = userRoleMapper.select(userRoleKey);
        List<Long> roleIds = new ArrayList<Long>();
        for (int i = 0; i < userRoleKeys.size(); i++) {
            roleIds.add(userRoleKeys.get(i).getSysRoleId());
        }
        Example sysRoleExample = new Example(SysRole.class);
        sysRoleExample.or().andIn("id", roleIds);
        List<SysRole> sysRoles = sysRoleMapper.selectByExample(sysRoleExample);
        return sysRoles;
    }


    /**
     * 根据用户名找到角色名
     *
     * @param username
     *
     * @return
     */
    @Override
    public Set<String> findRoleNames(String username) {
        List<SysRole> sysRoles = this.findRoles(username);
        Set<String> roleNames = new HashSet<>();
        for (int i = 0; i < sysRoles.size(); i++) {
            roleNames.add(sysRoles.get(i).getRole());
        }
        return roleNames;
    }

    /**
     * 根据用户名找到资源
     *
     * @param username
     *
     * @return
     */
    @Override
    public List<SysResource> findResources(String username) {
        List<SysRole> sysRoles = this.findRoles(username);
        List<Long> roleIds = new ArrayList<>();
        for (SysRole sysRole : sysRoles) {
            roleIds.add(sysRole.getId());
        }
        Example roleResourceExample = new Example(SysRoleHasSysResourceKey.class);
        roleResourceExample.or().andIn("sysRoleId", roleIds);
        List<SysRoleHasSysResourceKey> roleResourceKeys = roleResourceMapper.selectByExample(roleResourceExample);

        //一个用户可能会有多个角色,多个角色中可能有重复的资源,使用set过滤重复的资源
        Set<Long> resourceIds = new HashSet<>();
        for (SysRoleHasSysResourceKey roleResourceKey : roleResourceKeys) {
            resourceIds.add(roleResourceKey.getSysResourceId());
        }

        Example sysResourceExample = new Example(SysResource.class);
        sysResourceExample.or().andIn("id", new ArrayList<>(resourceIds));
        List<SysResource> sysResources = sysResourceMapper.selectByExample(sysResourceExample);
        return sysResources;
    }

    /**
     * 根据用户名找到资源权限
     *
     * @param username
     *
     * @return
     */
    @Override
    public Set<String> findPermission(String username) {
        List<SysResource> sysResources = this.findResources(username);
        Set<String> permissions = new HashSet<>();
        for (SysResource sysResource : sysResources) {
            permissions.add(sysResource.getPermission());
        }
        return permissions;
    }

    /**
     * 创建用户
     *
     * @param sysUser
     *
     * @return
     */
    @Override
    public Integer createUser(SysUser sysUser) {
        //加密密码
        passwordHelper.encryptPassword(sysUser);
        return super.saveSelective(sysUser);
    }

    /**
     * 更改用户密码
     *
     * @param userId
     * @param newPassword
     */
    @Override
    public void updatePassword(Long userId, String newPassword) {
        SysUser sysUser = this.selectOne(new SysUser(userId));
        passwordHelper.encryptPassword(sysUser);
        this.update(sysUser);
    }

    @Override
    public ServerResponseModel<SysUser> getUserListByOrgId(Long orgId, Integer pageNum, Integer pageSize) {
        SysOrganizationHasSysUserKey userOrganizationKey = new SysOrganizationHasSysUserKey();
        userOrganizationKey.setSysOrganizationId(orgId);
        List<SysOrganizationHasSysUserKey> userOrganizationKeys = userOrganizationMapper.select(userOrganizationKey);
        List<Long> userIds = new ArrayList<>();
        for (SysOrganizationHasSysUserKey userOrganizationKey1 : userOrganizationKeys) {
            userIds.add(userOrganizationKey1.getSysUserId());
        }
        if (userIds.size() == 0) {
            List<SysUser> sysUsers = new ArrayList<>();
            PageModel pageModel = new PageModel(1, 0l, 1);
            return new ServerResponseModel<SysUser>(pageModel, sysUsers);
        } else {
            Example sysUserExample = new Example(SysUser.class);
            sysUserExample.or().andIn("id", userIds);
            return this.selectPageByExampleV2(sysUserExample, pageNum, pageSize);
        }
    }


    @Override
    public SysUser findByOpenId(String openId) {

        return this.selectOne(new SysUser(openId, 0));
    }

    @Override
    public SysUser updateWeChatInfo(SysUser user, String nickName, String avatar) {

        user.setNickname(nickName);
        user.setAvatar(avatar);
        this.update(user);

        return user;
    }

    @Override
    public SysUser createUser(String nickName, String avatar, String openId, SysUser upUser) {

        SysUser user = new SysUser();
        user.setNickname(nickName);
        user.setAvatar(avatar);
        user.setOpenId(openId);
        user.setCreateTime(new Date());
        user.setMoney(new Double(0));
        user.setIntegral(new Double(0));
        user.setUserType(SysUser.TYPE_ORDINARY + "");
        user.setIsDelete(false);

        user.setParentId(upUser.getId());

        //  2/4/5/
        if (null != upUser.getParentIds() && !"".equals(upUser.getParentIds().trim())) {
            user.setParentIds(upUser.getParentIds() + upUser.getId() + "/");
        } else {
            user.setParentIds(upUser.getId() + "/");
        }

        this.save(user);

        return user;
    }

    @Override
    public SysUser findById(Long id) {

        return this.selectOne(new SysUser(id));
    }

    @Override
    public List<SysUser> findUser(List<Long> ids) {

        Example example = new Example(SysUser.class);
        example.createCriteria().andIn("id", ids);
        return this.selectPageByExample(example, null, null);
    }



    @Override
    public Integer updateUser(SysUser sysUser) {
        SysUser orgSysUser = this.selectByPrimary(new SysUser(sysUser.getId()));
        List<Integer> orgRoleIds = orgSysUser.getRoleList();
        List<Integer> updateRoleIds = sysUser.getRoleList();
        Set<Long> morgRoleIds = new HashSet<>();
        Set<Long> mupdateRoleIds = new HashSet<>();
        Set<Long> totalRoles = new HashSet<>();
        for (Integer orid : orgRoleIds) {
            totalRoles.add(Long.valueOf(orid));
            morgRoleIds.add(Long.valueOf(orid));
        }
        for (Integer urid : updateRoleIds) {
            totalRoles.add(Long.valueOf(urid));
            mupdateRoleIds.add(Long.valueOf(urid));
        }
        Set<Long> addKey = new HashSet<>();
        Set<Long> deleteKey = new HashSet<>();
        if (updateRoleIds.size() != 0) {
            for (Long mroleId : totalRoles) {
                //在原来中含有的角色，但在新修改的角色列表没有，
                if (morgRoleIds.contains(mroleId) && !mupdateRoleIds.contains(mroleId)) {
                    deleteKey.add(Long.valueOf(mroleId));
                    //在原来不包含现在有添加
                } else if (!morgRoleIds.contains(mroleId) && mupdateRoleIds.contains(mroleId)) {
                    addKey.add(Long.valueOf(mroleId));
                }
            }

            for (Long roleId : addKey) {
                SysUserHasSysRoleKey sysUserHasSysRoleKey = new SysUserHasSysRoleKey(sysUser.getId(), roleId);
                sysUserHasSysRoleKeyService.saveSelective(sysUserHasSysRoleKey);
            }

            for (Long roleId : deleteKey) {
                SysUserHasSysRoleKey sysUserHasSysRoleKey = new SysUserHasSysRoleKey(sysUser.getId(), roleId);
                sysUserHasSysRoleKeyService.delete(sysUserHasSysRoleKey);
            }
        }
        return this.updateSelective(sysUser);
    }

    @Override
    public Integer saveUser(SysUser sysUser) {
        Integer result = this.saveSelective(sysUser);
        if (sysUser.getRoleList().size() != 0) {
            for (Integer roleId : sysUser.getRoleList()) {
                SysUserHasSysRoleKey sysUserHasSysRoleKey = new SysUserHasSysRoleKey(sysUser.getId(), Long.valueOf
                        (roleId));
                sysUserHasSysRoleKeyService.saveSelective(sysUserHasSysRoleKey);
            }
        }
        return result;
    }
}
