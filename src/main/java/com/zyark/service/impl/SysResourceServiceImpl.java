package com.zyark.service.impl;

import com.zyark.dao.SysResourceMapper;
import com.zyark.domain.SysResource;
import com.zyark.service.SysResourceService;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ron on 17-4-6.
 */
@Service
public class SysResourceServiceImpl extends BaseServiceIpml<SysResource> implements SysResourceService {



    @Override
    public List<SysResource> findRootMenus(){
        Example sysResourceExample = new Example(SysResource.class);
        sysResourceExample.or().andEqualTo("parentId",1L);
        sysResourceExample.setOrderByClause("priority");
        return mapper.selectByExample(sysResourceExample);
    }

    @Override
    public Map<String, String> getResourceMap() {
        Map<String,String> moduleMap = new HashMap<>();
        Example example = new Example(SysResource.class);
        example.or().andNotEqualTo("url",null).andNotEqualTo("url","");
        List<SysResource> sysResourceList = this.selectPageByExample(example,null,null);
        for (SysResource sysResource : sysResourceList){
            moduleMap.put(sysResource.getUrl(),sysResource.getResourceName());
        }
        return moduleMap;
    }
}
