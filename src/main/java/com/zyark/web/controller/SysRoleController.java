package com.zyark.web.controller;

import com.zyark.domain.SysRole;
import com.zyark.model.ServerResponseModel;
import com.zyark.service.SysRoleHasSysResourceKeyService;
import com.zyark.service.SysRoleService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ron on 17-4-17.
 */
@RequestMapping("/role")
@Controller
public class SysRoleController extends BaseController {

    @Resource
    SysRoleService sysRoleService;

    @Resource
    SysRoleHasSysResourceKeyService roleResourceKeyService;

    /**
     * 为tree提供数据
     * @param response
     */
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public void getList(HttpServletResponse response){
        super.writeJson(sysRoleService.selectPage(null,null),response);
    }

    /**
     * 为过滤器提供数据
     * @param response
     */
    @RequestMapping(value = "/map",method = RequestMethod.GET)
    public void getMap(HttpServletResponse response){
        List<SysRole> sysRoles = sysRoleService.selectPage(null,null);
        Map<String,String> roleMap = new HashMap<>();
        for (SysRole sysRole : sysRoles){
            roleMap.put(String.valueOf(sysRole.getId()),sysRole.getDescription());
        }
        super.writeJson(roleMap,response);
    }

    /**
     * 角色管理列表
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping(value = "/list2",method = RequestMethod.GET)
    @ResponseBody
    public Object getListByPage(@RequestParam(required = false) Integer pageNumber, @RequestParam(required = false) Integer pageSize){
        if (pageNumber == null){
            pageNumber = 1;
        }
        if (pageSize == null){
            pageSize = 10;
        }
        return sysRoleService.selectPageV2(pageNumber,pageSize);
    }

    @RequestMapping(value = "/list3",method = RequestMethod.GET)
    @ResponseBody
    public Object getListWithResource(HttpServletResponse response, @RequestParam(required = false) Integer pageNumber, @RequestParam(required = false)Integer pageSize){
        if (pageNumber == null){
            pageNumber = 1;
        }
        if (pageSize == null){
            pageSize = 10;
        }
        ServerResponseModel<SysRole> serverResponseModel = sysRoleService.selectRoleResource(pageNumber,pageSize);
        return serverResponseModel;
    }

    /**
     * 添加,具体操作需要在service中完成以便支持事务
     * @param sysRole
     * @return
     */
    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public Object addRole(@RequestBody SysRole sysRole){
        return sysRoleService.saveTransaction(sysRole);
    }

    /**
     * 修改
     */
    @RequestMapping(value = "{id}",method = RequestMethod.POST)
    @ResponseBody
    public Object updateRole(@PathVariable Long id, @RequestBody SysRole sysRole){
        sysRole.setId(id);
        return sysRoleService.updateTransaction(sysRole);
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @RequestMapping(value = "{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public Object deleteRole(@PathVariable Long id){
        return sysRoleService.deleteTransaction(id);
    }

}
