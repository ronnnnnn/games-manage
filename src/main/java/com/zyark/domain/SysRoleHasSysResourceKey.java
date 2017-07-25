package com.zyark.domain;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "sys_role_has_sys_resource")
public class SysRoleHasSysResourceKey {
    @Id
    private Long sysRoleId;

    @Id
    private Long sysResourceId;

    public SysRoleHasSysResourceKey() {
        super();
    }

    public SysRoleHasSysResourceKey(Long sysRoleId, Long sysResourceId) {
        this.sysRoleId = sysRoleId;
        this.sysResourceId = sysResourceId;
    }

    public Long getSysRoleId() {
        return sysRoleId;
    }

    public void setSysRoleId(Long sysRoleId) {
        this.sysRoleId = sysRoleId;
    }

    public Long getSysResourceId() {
        return sysResourceId;
    }

    public void setSysResourceId(Long sysResourceId) {
        this.sysResourceId = sysResourceId;
    }
}