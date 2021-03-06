package com.zyark.service.impl;

import com.zyark.dao.SysResourceMapper;
import com.zyark.dao.SysRoleHasSysResourceMapper;
import com.zyark.dao.SysRoleMapper;
import com.zyark.domain.SysResource;
import com.zyark.domain.SysRole;
import com.zyark.domain.SysRoleHasSysResourceKey;
import com.zyark.model.ServerResponseModel;
import com.zyark.service.SysRoleService;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by ron on 17-4-6.
 */
@Service
public class SysRoleServiceImpl extends BaseServiceIpml<SysRole> implements SysRoleService {

    @Resource
    SysRoleMapper roleMapper;

    @Resource
    SysRoleHasSysResourceMapper roleResourceMapper;

    @Resource
    SysResourceMapper sysResourceMapper;

    @Override
    public ServerResponseModel<SysRole> selectRoleResource(Integer pageNumber, Integer pageSize){
        ServerResponseModel serverResponseModel = this.selectPageV2(pageNumber,pageSize);
        List<SysRole> sysRoles = serverResponseModel.getListDate();
        List<SysRole> sysRoleList = new ArrayList<>();
        for (SysRole sysRole : sysRoles){
            sysRole.setSysResources(this.getResource(sysRole));
            sysRoleList.add(sysRole);
        }
        serverResponseModel.setListDate(sysRoleList);
        return serverResponseModel;
    }

    @Override
    public List<SysResource> getResource(SysRole sysRole){
        List<SysRoleHasSysResourceKey> keys = roleResourceMapper.select(new SysRoleHasSysResourceKey(sysRole.getId(),null));
        List<Long> ids = new ArrayList<>();
        for (SysRoleHasSysResourceKey roleResourceKey : keys){
            ids.add(roleResourceKey.getSysResourceId());
        }
        if (ids.size() == 0){
            return null;
        }else {
            Example example = new Example(SysResource.class);
            example.or().andIn("id", ids);
            return sysResourceMapper.selectByExample(example);
        }
    }

    @Override
    public Boolean saveTransaction(SysRole sysRole){
        try {
            //保存角色
            sysRole.setIsAvaliable(true);
            roleMapper.insertSelective(sysRole);
            String[] resourceIds = sysRole.getResourceIds().split(",");
            //关联外键
            for (String resourceId : resourceIds){
                roleResourceMapper.insert(new SysRoleHasSysResourceKey(sysRole.getId(),Long.valueOf(resourceId)));
            }
            return true;
        }catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean updateTransaction(SysRole sysRole){
        try {
            //修改其他信息
            roleMapper.updateByPrimaryKeySelective(sysRole);

            //修改关联的外键关系
            List<SysRoleHasSysResourceKey> roleResourceKeys = roleResourceMapper.select(new SysRoleHasSysResourceKey(sysRole.getId(),null));
            //已经关联的resourceId
            Set<Long> resourceIds = new HashSet<>();
            for(SysRoleHasSysResourceKey roleResourceKey : roleResourceKeys){
                resourceIds.add(roleResourceKey.getSysResourceId());
            }
            //要修改的所有外键
            Set<Long> newResourceIds = new HashSet<>();
            String newResids[]  = sysRole.getResourceIds().split(",");
            for(String rid : newResids){
                newResourceIds.add(Long.valueOf(rid));
            }
            //差集
            Set<Long> result = new HashSet<>();
            if (resourceIds.size() > newResourceIds.size()){
                result.addAll(resourceIds);
                result.removeAll(newResourceIds);
            } else {
                result.addAll(newResourceIds);
                result.removeAll(resourceIds);
            }

            if (result != null && result.size() != 0){
                for (Long resid : result){
                    //在差集中存在并且在外键表中存在为要删除的外键
                    if (resourceIds.contains(resid)){
                        roleResourceMapper.delete(new SysRoleHasSysResourceKey(sysRole.getId(),resid));
                    }else {//否者为要添加的外键
                        roleResourceMapper.insert(new SysRoleHasSysResourceKey(sysRole.getId(),resid));
                    }
                }
            }

            return true;
        }catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean deleteTransaction(Long id){
        try {
            //删除外键
            roleResourceMapper.delete(new SysRoleHasSysResourceKey(id,null));
            roleMapper.deleteByPrimaryKey(new SysRole(id));
            return true;
        }catch (Exception e){
            return false;
        }
    }
}
