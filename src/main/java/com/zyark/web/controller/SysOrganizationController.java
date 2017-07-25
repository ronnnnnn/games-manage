package com.zyark.web.controller;

import com.zyark.domain.SysOrganization;
import com.zyark.domain.SysOrganizationHasSysUserKey;
import com.zyark.domain.SysUser;
import com.zyark.model.TreeModel;
import com.zyark.service.SysOrganizationHasSysUserKeyService;
import com.zyark.service.SysOrganizationService;
import com.zyark.service.SysUserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ron on 17-4-13.
 */
@RequestMapping("org")
@Controller
public class SysOrganizationController extends BaseController{

    @Resource
    SysOrganizationService sysOrganizationService;

    @Resource
    SysOrganizationHasSysUserKeyService userOrganizationKeyService;

    @Resource
    SysUserService sysUserService;

    /**
     * 跳转页面
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/page",method = RequestMethod.GET)
    public String getPage(HttpServletRequest request, HttpServletResponse response , Model model){
        List<SysOrganization> sysOrganizations = sysOrganizationService.selectPage(null,null);
        model.addAttribute("orgList",sysOrganizations);
        return "admin/org/list";
    }

    /**
     * 获取组织树
     * @param request
     * @return
     */
    @RequestMapping(value = "/tree",method = RequestMethod.GET)
    @ResponseBody
    public List<TreeModel> getTree(HttpServletRequest request){
        SysOrganization sysOrganization = new SysOrganization();
        sysOrganization.setIsAvaliable(true);
        List<SysOrganization> sysOrganizations = sysOrganizationService.selectByEntityWithSimpleResult(sysOrganization,null,null);
        List<TreeModel> treeData = new ArrayList<>();
        for(SysOrganization sysOrganization1 : sysOrganizations){
            treeData.add(new TreeModel(sysOrganization1.getId(),sysOrganization1.getParentId(),sysOrganization1.getOrganizationName()));
        }
        return treeData;
    }

    /**
     * 获取树节点 ,废弃
     * @param request
     * @param id
     * @param name
     * @return
     */
    @RequestMapping(value = "/tree",method = RequestMethod.POST)
    @ResponseBody
    public List<TreeModel> getTreeNode(HttpServletRequest request,
                                       @RequestParam(value = "id",required = false)Integer id,
                                       @RequestParam(value = "name",required = false)String name){
//        List<TreeModel> treeData = new ArrayList<>();
//        if (id == null){
//            SysOrganization sysOrganization = new SysOrganization();
//            sysOrganization.setId(1L);
//            SysOrganization rootsysOrganization = sysOrganizationService.selectOne(sysOrganization);
//            TreeModel treeModel = new TreeModel(rootsysOrganization.getId(),rootsysOrganization.getParentId(),rootsysOrganization.getOrganizationName());
//            treeData.add(treeModel);
//            return treeData;
//        }else {
//            SysOrganization sysOrganization = new SysOrganization();
//            sysOrganization.setTenantId(this.getTenantId(request));
//            sysOrganization.setParentId(Long.valueOf(id));
//            List<SysOrganization> sysOrganizations = sysOrganizationService.selectByEntity(sysOrganization,null,null).getListDate();
//
//            for(SysOrganization sysOrganization1 : sysOrganizations){
//                treeData.add(new TreeModel(sysOrganization1.getId(),sysOrganization1.getParentId(),sysOrganization1.getOrganizationName()));
//            }
//            return treeData;
//        }
        return null;
    }

    /**
     * 添加树节点
     * @param request
     * @param title
     * @param pId
     * @return
     */
    @RequestMapping(value = "/node",method = RequestMethod.POST)
    @ResponseBody
    public Object addNode(HttpServletRequest request,
                          @RequestParam(value = "title")String title,
                          @RequestParam(value = "pId")Long pId){
//        SysOrganization sysOrganization = new SysOrganization();
//        sysOrganization.setOrganizationName(title);
//        sysOrganization.setParentId(pId);
//        String parentIds = sysOrganizationService.selectOne(new SysOrganization(pId)).getParentIds()  + pId + "/";
//        sysOrganization.setParentIds(parentIds);
//        sysOrganization.setIsAvaliable(true);
//        sysOrganization.setOrgType(2);
//        sysOrganizationService.save(sysOrganization);
        Long cid = 0l;
        cid = sysOrganizationService.addChild(title,pId);
        return new TreeModel(cid,pId,title);
    }

    /**
     * 更新树节点名字
     * @param id
     * @param title
     */
    @RequestMapping(value = "/node/update",method = RequestMethod.POST)
    @ResponseBody
    public Object updateNode(@RequestParam("id")Long id,
                             @RequestParam("title")String title){
        SysOrganization sysOrganization = new SysOrganization(id);
        sysOrganization.setOrganizationName(title);
        sysOrganizationService.updateSelective(sysOrganization);
        return true;
    }

    @RequestMapping(value = "/node/delete",method = RequestMethod.POST)
    @ResponseBody
    public Object deleteNode(@RequestParam("id") Long id ){
//        SysOrganization sysOrganization = new SysOrganization(id);
//        Integer flag = sysOrganizationService.delete(sysOrganization);
//        if (flag == 1){
//            return true;
//        }else {
//            return false;
//        }
          return  sysOrganizationService.deleteChild(id);
    }

    @RequestMapping(value = "/key",method = RequestMethod.POST)
    public void addKey(HttpServletResponse response, @RequestParam("ids")String ids, @RequestParam("orgId")Long orgId){
        String[] sids = ids.split(",");

        Boolean hasHallAdmin = false;

        for(String id : sids){
            //当用户为管理员判断组织中是否有管理员
//            SysUser addUser = sysUserService.selectByPrimary(new SysUser(Long.valueOf(id)));
//            if ("4".equals(addUser.getUserType())){
//                hasHallAdmin =  checkHasHallAdmin(orgId);
//            }
            SysOrganizationHasSysUserKey userOrganizationKey = new SysOrganizationHasSysUserKey(orgId,Long.valueOf(id));
//            if (hasHallAdmin == false){
            userOrganizationKeyService.save(userOrganizationKey);
//            }
        }
        super.writeJson("success",response);
    }

    //判断是否有管理员
    public Boolean checkHasHallAdmin(Long orgId){
        Boolean hasHallAdmin = false;
        SysOrganizationHasSysUserKey sysOrganizationHasSysUserKey = new SysOrganizationHasSysUserKey();
        sysOrganizationHasSysUserKey.setSysOrganizationId(orgId);
        List<SysOrganizationHasSysUserKey> sysOrganizationHasSysUserKeys = userOrganizationKeyService.selectByEntityWithSimpleResult(sysOrganizationHasSysUserKey,null,null);
        for (SysOrganizationHasSysUserKey sysOrganizationHasSysUserKey1 : sysOrganizationHasSysUserKeys){
            SysUser sysUser = sysUserService.selectByPrimary(new SysUser(sysOrganizationHasSysUserKey1.getSysUserId()));
            if ("4".equals(sysUser.getUserType())){
                hasHallAdmin = true;
            }
        }
        return hasHallAdmin;
    }

    @RequestMapping(value = "/key/{id}",method = RequestMethod.DELETE)
    public void deleteKey(HttpServletResponse response, @PathVariable("id") Long id){
        SysOrganizationHasSysUserKey userOrganizationKey = new SysOrganizationHasSysUserKey();
        userOrganizationKey.setSysUserId(id);
        super.writeJson( userOrganizationKeyService.delete(userOrganizationKey),response);
    }

}
