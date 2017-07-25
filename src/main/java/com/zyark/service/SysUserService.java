package com.zyark.service;

import com.zyark.domain.SysResource;
import com.zyark.domain.SysRole;
import com.zyark.domain.SysUser;
import com.zyark.model.ServerResponseModel;

import java.util.List;
import java.util.Set;

/**
 * ClassName: SysUserService  <br/>
 * Function:  <br/>
 * Reason:  <br/>
 * Date: 2017-05-23 20:13 <br/>
 *
 * @author Ku_ker
 * @version 1.0
 * @JDK 1.7
 */
public interface SysUserService extends BaseService<SysUser> {

    /**
     * 通过OpenId查找用户
     *
     * @param openId
     *         微信的用户openId
     *
     * @return 用户信息
     */
    SysUser findByOpenId(String openId);

    /**
     * 修改用户的微信信息
     *
     * @param user
     *         未修改前的用户信息
     * @param nickName
     *         微信名称
     * @param avatar
     *         微信头像
     *
     * @return 用户信息
     */
    SysUser updateWeChatInfo(SysUser user, String nickName, String avatar);

    /**
     * 创建微信用户
     *
     * @param nickName
     *         微信名称
     * @param avatar
     *         微信头像
     * @param openId
     *         openId
     * @param upUser
     *         上级用户
     *
     * @return 用户信息
     */
    SysUser createUser(String nickName, String avatar, String openId, SysUser upUser);

    /**
     * 通过编号查找用户
     *
     * @param id
     *         用户编号
     *
     * @return 用户信息
     */
    SysUser findById(Long id);

    //------------------------------------------------------------------------

    /**
     * 根据用户名找到角色
     *
     * @param username
     *
     * @return
     */
    public List<SysRole> findRoles(String username);


    /**
     * 根据用户名找到角色名
     *
     * @param username
     *
     * @return
     */
    public Set<String> findRoleNames(String username);

    /**
     * 根据用户名找到资源
     *
     * @param username
     *
     * @return
     */
    public List<SysResource> findResources(String username);

    /**
     * 根据用户名找到资源权限
     *
     * @param username
     *
     * @return
     */
    public Set<String> findPermission(String username);

    /**
     * 创建用户
     *
     * @param sysUser
     *         对象{@link SysUser}
     *
     * @return
     */
    public Integer createUser(SysUser sysUser);

    /**
     * 更改用户密码
     *
     * @param userId
     * @param newPassword
     */
    public void updatePassword(Long userId, String newPassword);

    /**
     * 更具组织获取用户列表
     *
     * @param orgId
     * @param pageNum
     * @param pageSize
     *
     * @return
     */
    public ServerResponseModel<SysUser> getUserListByOrgId(Long orgId, Integer pageNum, Integer pageSize);



    /**
     * 查找所有的用户
     *
     * @param ids
     *         用户编号列表
     *
     * @return
     */
    List<SysUser> findUser(List<Long> ids);

    /**
     * 添加
     */
    Integer updateUser(SysUser sysUser);

    /**
     * 修改
     *
     * @param sysUser
     *
     * @return
     */
    Integer saveUser(SysUser sysUser);

}
