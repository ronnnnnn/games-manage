package com.zyark.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Table(name = "sys_user")
public class SysUser {

    /**
     * 系统默认上级
     */
    @Transient
    public static final Long DEFAULT_UP_USER = 2L;

    //-------------------用户类型

    /**
     * 用户类型：普通用户
     */
    @Transient
    public static final Integer TYPE_ORDINARY = 0;

    /**
     * 用户类型：商家
     */
    @Transient
    public static final Integer TYPE_BUSINESSMEN = 1;

    /**
     * 用户类型：维修人员
     */
    @Transient
    public static final Integer TYPE_MAINTENANCE = 2;

    /**
     * 用户类型：新装人员
     */
    @Transient
    public static final Integer TYPE_DECORATION = 3;

    /**
     * 用户类型：营业厅管理员
     */
    @Transient
    public static final Integer TYPE_MANAGER = 4;

    /**
     * 用户类型：营业厅换卡配送人员
     */
    @Transient
    public static final Integer TYPE_DISTRIBUTION = 6;


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;

    private String password;

    private String salt;

    private String roleIds;

    private Boolean locked;

    private Double money;

    private String phone;

    private String avatar;

    private String nickname;

    /**
     * 0 普通用户
     * 1 商家
     * 2 维修人员
     * 3 新装人员
     * 4 营业厅管理员
     */
    private String userType;

    private Boolean isDelete;

    private Date createTime;

    private Long parentId;

    private String parentIds;

    private String openId;

    private Double integral;

    @Transient
    private SysUser parentUser;

    public SysUser() {
        super();
    }

    public SysUser(String username, String phone) {
        this.username = username;
        this.phone = phone;
    }

    public SysUser getParentUser() {
        return parentUser;
    }

    public void setParentUser(SysUser parentUser) {
        this.parentUser = parentUser;
    }

    public SysUser(Long id) {
        this.id = id;
    }

    public SysUser(String openId, int kuker) {
        this.openId = openId;
    }

    public SysUser(String username) {
        this.username = username;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(String roleIds) {
        this.roleIds = roleIds;
    }

    public Boolean getLocked() {
        return locked;
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public Boolean getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Boolean isDelete) {
        this.isDelete = isDelete;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getParentIds() {
        return parentIds;
    }

    public void setParentIds(String parentIds) {
        this.parentIds = parentIds;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public Double getIntegral() {
        return integral;
    }

    public void setIntegral(Double integral) {
        this.integral = integral;
    }

    public String getCredentialsSalt() {
        return username + salt;
    }

    public List<Integer> getRoleList() {
        List<Integer> roleList = new ArrayList<>();
        if (roleIds != null && !"".equals(roleIds)) {
            String[] roles = roleIds.split(",");
            for (String id : roles) {
                roleList.add(Integer.valueOf(id));
            }
        }
        return roleList;
    }

    public List<Integer> getTypeList() {
        List<Integer> typeList = new ArrayList<>();
        if (userType != null && !"".equals(userType)) {
            String[] types = userType.split(",");
            for (String id : types) {
                typeList.add(Integer.valueOf(id));
            }
        }
        return typeList;
    }

    /**
     * 得到用户的所有上级用户的编号
     *
     * @return（没有上级的时候返回null）
     */
    public Long[] getUpUserIds() {

        if (null != parentIds && !"".equals(parentIds.trim())) {

            String[] idStrArray = parentIds.split("/");
            if (null != idStrArray && 0 < idStrArray.length) {
                Long[] ids = new Long[idStrArray.length];
                for (int i = 0; i < idStrArray.length; i++) {
                    if (null != idStrArray[i] && !"".equals(idStrArray[i].trim())) {
                        ids[i] = Long.parseLong(idStrArray[i]);
                    }
                }

                return ids;
            } else {
                return null;
            }
        } else {
            return null;
        }

    }

    @Transient
    public List<Integer> userTypes;

    public List<Integer> getUserTypes() {
        return getTypeList();
    }

    /**
     * 判断用户是否属于该类型的用户
     *
     * @param user
     *         用户
     * @param types
     *         用户类型
     *
     * @return
     */
    public static boolean isBelong(SysUser user, Integer... types) {

        if (types == null || types.length == 0 || user.getUserType() == null || user.getUserType().equals("")) {
            return false;
        }

        String userTypes = user.getUserType();
        String[] typeArrary = userTypes.split(",");

        if (typeArrary != null && typeArrary.length > 0) {
            for (int i = 0; i < types.length; i++) {
                for (int j = 0; j < typeArrary.length; j++) {
                    try {
                        Integer.parseInt(typeArrary[j]);
                        if (types[i] == Integer.parseInt(typeArrary[j])) {
                            return true;
                        }
                    } catch (Exception e) {
                        return false;
                    }
                }

            }
        }
        return false;
    }

}