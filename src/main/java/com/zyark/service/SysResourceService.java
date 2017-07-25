package com.zyark.service;

import com.zyark.domain.SysResource;

import java.util.List;
import java.util.Map;

/**
 * Created by ron on 17-4-6.
 */
public interface SysResourceService extends BaseService<SysResource> {

    List<SysResource> findRootMenus();

    Map<String,String> getResourceMap();
}
