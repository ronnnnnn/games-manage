package com.zyark.service;

import com.zyark.domain.SysResource;
import com.zyark.domain.SysRole;
import com.zyark.model.ServerResponseModel;

import java.util.List;

/**
 * Created by ron on 17-4-6.
 */
public interface SysRoleService extends BaseService<SysRole> {

    public ServerResponseModel<SysRole> selectRoleResource(Integer pageNumber, Integer pageSize);

    public List<SysResource> getResource(SysRole sysRole);

    public Boolean saveTransaction(SysRole sysRole);

    public Boolean updateTransaction(SysRole sysRole);

    public Boolean deleteTransaction(Long id);
}
