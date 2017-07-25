package com.zyark.web.controller;

import com.zyark.domain.SysResource;
import com.zyark.model.TreeModel;
import com.zyark.service.SysResourceService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ron on 17-4-11.
 */
@RequestMapping("/resource")
@Controller
public class SysResourceController extends BaseController {

    @Resource
    SysResourceService sysResourceService;


    @RequestMapping(method = RequestMethod.POST)
    public void addResource(SysResource sysResource, HttpServletResponse response){
        SysResource parentResource = sysResourceService.selectByPrimary(new SysResource(sysResource.getId()));
        String parentIds = parentResource.getParentIds()+"/"+parentResource.getId();
        sysResource.setId(null);
        sysResource.setParentIds(parentIds);
        sysResource.setParentId(parentResource.getId());
        sysResource.setIsAvaliable(true);
        sysResourceService.saveSelective(sysResource);
        super.writeJson(sysResource.getId(),response);
    }

    @RequestMapping(value = "{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object deleteResource(@PathVariable Long id){
        Boolean result = null;
        try {
            sysResourceService.delete(new SysResource(id));
            result = true;
        }catch (Exception e){
            result = false;
        }
        return result;
    }

    @RequestMapping(value = "/{id}",method = RequestMethod.POST)
    @ResponseBody
    public Object updateREsource(@PathVariable Long id, @RequestBody SysResource sysResource, HttpServletResponse response){
        sysResource.setId(id);
        sysResourceService.updateSelective(sysResource);
        SysResource sysResource1 = sysResourceService.selectByPrimary(sysResource);
        return sysResource1;
    }

    @RequestMapping(value = "/page",method = RequestMethod.GET)
    public String getPage(HttpServletResponse response, Model model){
        List<SysResource> sysResources = sysResourceService.selectPage(null,null);
        model.addAttribute("resourceList",sysResources);
        return "/admin/index";
    }

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public void getList(HttpServletResponse response){
        super.writeJson(sysResourceService.selectPage(null,null),response);
    }

    @RequestMapping(value = "/tree",method = RequestMethod.GET)
    @ResponseBody
    public Object getTree(){
        List<SysResource> sysResources = sysResourceService.selectPage(null,null);
        List<TreeModel> treeModels = new ArrayList<>();
        for (SysResource sysResource : sysResources){
            treeModels.add(new TreeModel(sysResource.getId(),sysResource.getParentId(),sysResource.getResourceName()));
        }
        return treeModels;
    }

    @RequestMapping(value = "/tree2",method = RequestMethod.GET)
    public void getTree2(HttpServletResponse response){
        List<SysResource> sysResources = sysResourceService.selectPage(null,null);
        super.writeJson(sysResources,response);
    }

    @RequestMapping(value = "/{id}",method = RequestMethod.GET)
    public void getResource(@PathVariable Long id, HttpServletResponse response){
        super.writeJson(sysResourceService.selectByPrimary(new SysResource(id)),response);
    }

}
