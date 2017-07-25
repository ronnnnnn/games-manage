package com.zyark.web.controller;

import com.zyark.domain.SysOrganizationHasSysUserKey;
import com.zyark.domain.SysUser;
import com.zyark.model.Datagrid;
import com.zyark.model.PageModel2;
import com.zyark.model.ServerResponseModel;
import com.zyark.model.TreeModel;
import com.zyark.service.SysOrganizationHasSysUserKeyService;
import com.zyark.service.SysRoleService;
import com.zyark.service.SysUserService;
import com.zyark.service.impl.PasswordHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import tk.mybatis.mapper.entity.Example;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by ron on 17-4-13.
 */
@RequestMapping("user")
@Controller
public class SysUserController extends BaseController {

    @Resource
    SysUserService sysUserService;

    @Resource
    SysOrganizationHasSysUserKeyService userOrganizationKeyService;

    @Resource
    SysRoleService sysRoleService;

    @Resource
    PasswordHelper passwordHelper;

    @RequestMapping(value = "tree",method = RequestMethod.GET)
    @ResponseBody
    public List<TreeModel> getTree(@RequestParam(value = "pageNumbre",required = false) Integer pageNumber){
        if (pageNumber == null){
            pageNumber = 1;
        }
        SysUser sysUser = new SysUser();
        sysUser.setUserType("0");
        sysUser.setIsDelete(false);
        List<SysUser> sysUserList = sysUserService.selectByEntityWithSimpleResult(sysUser,null,null);
        List<TreeModel> treeModelList = new ArrayList<>();
        for (SysUser sysUser1 : sysUserList){
            TreeModel treeModel = new TreeModel(sysUser1.getId(),sysUser1.getParentId(),sysUser1.getNickname()+"(tel:"+sysUser1.getPhone()+")");
            treeModelList.add(treeModel);
        }
        return  treeModelList;
    }

    @RequestMapping(value = "/page",method = RequestMethod.GET)
    public String getPage(Model model){
        model.addAttribute("roleList",sysRoleService.selectPage(null,null));
        return "admin/user/list";
    }

    /**
     *
     * @param request
     * @param response
     * @param isAdmin 是否管理员
     * @param pageNumber
     * @param pageSize
     */
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public void getList(HttpServletRequest request , HttpServletResponse response,
                        Model model,
                        @RequestParam(value = "isDelete",required = false) Boolean isDelete,
                        @RequestParam(value = "isAdmin",required = false) Boolean isAdmin,
                        @RequestParam(value = "pageNumber",required = false) Integer pageNumber,
                        @RequestParam(value = "pageSize" ,required = false) Integer pageSize){
        if (pageNumber == null){
            pageNumber = 1;
        }
        if (pageSize == null){
            pageSize = 10;
        }
        if (isDelete == null){
            isDelete = false;
        }

        Map<String,List<Object>> roleMap = new HashMap<>();
        List sysRoles = sysRoleService.selectPage(null,null);
        model.addAttribute("roleList",sysRoles);
        roleMap.put("roles",sysRoles);

        SysUser sysUser = new SysUser();
        sysUser.setIsDelete(isDelete);
//        if (isAdmin != null) {
//            sysUser.setIsAdmin(isAdmin);
//        }
//        if(getUserType(request) == 4){
//            SysUser currentSysUser = getUserType();
//            sysUser.se
//        }
        ServerResponseModel<SysUser> userData = sysUserService.selectByEntity(sysUser,pageNumber,pageSize);
        List<SysUser> sysUsers = userData.getListDate();
        List<SysUser> newListDate = new ArrayList<>();
        for (int i = 0 ; i < sysUsers.size() ; i++){
            SysUser sysUser1 =  sysUsers.get(i);
            if (sysUser1.getParentId() != null){
                sysUser1.setParentUser(sysUserService.selectByPrimary(new SysUser(sysUser1.getParentId())));
            }
            newListDate.add(sysUser1);
        }
        userData.setMapDate(roleMap);
//        SysUserExample sysUserExample = new SysUserExample();
//        if (isAdmin == null){//为空不过滤此条件
//            sysUserExample.or().andIsDeleteEqualTo(false).andTenantIdEqualTo(getTenantId(request));
//        }else if (isDelete != null){
//            sysUserExample.or().andIsDeleteEqualTo(isDelete).andTenantIdEqualTo(getTenantId(request));
//        }else {
//            sysUserExample.or().andIsAdminEqualTo(isAdmin).andIsDeleteEqualTo(false).andTenantIdEqualTo(getTenantId(request));
//        }
//        sysUserExample.setOrderByClause("create_time desc");
//        ServerResponseModel<SysUser> userData= sysUserService.selectPageByExampleV2(sysUserExample,pageNumber,pageSize);
        super.writeJson(userData,response);
    }

    /**
     * 不进行真正删除,用户有关联信息
     * @param id
     * @param response
     */
    @RequestMapping(value = "/{id}",method = RequestMethod.DELETE)
    public void deleteUser(@PathVariable Long id, HttpServletResponse response){
        SysUser sysUser = new SysUser();
        sysUser.setId(id);
        sysUser.setIsDelete(true);
        super.writeJson(sysUserService.updateSelective(sysUser),response);
    }

    @RequestMapping(value = "/list/{orgId}",method = RequestMethod.GET)
    public void getListByOrgId(@PathVariable Long orgId, Integer pageNumber, Integer pageSize, HttpServletResponse response){
        if (pageNumber == null){
            pageNumber = 1;
        }
        if (pageSize == null){
            pageSize = 10;
        }
        super.writeJson(sysUserService.getUserListByOrgId(orgId,pageNumber,pageSize),response);
    }

    @RequestMapping(value = "/datagrid")
    public void getDategrid(PageModel2 pageModel2, HttpServletResponse response){
        List<SysOrganizationHasSysUserKey> userOrganizationKeys = userOrganizationKeyService.selectPage(null,null);
        ServerResponseModel<SysUser> sysUserServerResponseModel = null;
        if (userOrganizationKeys.size() == 0){
            sysUserServerResponseModel = sysUserService.selectPageV2(pageModel2.getPage(),pageModel2.getRows());
        }else {
            List<Long> userIds = new ArrayList<>();
            for (SysOrganizationHasSysUserKey userOrganizationKey : userOrganizationKeys) {
                userIds.add(userOrganizationKey.getSysUserId());
            }
            Example sysUserExample = new Example(SysUser.class);
            sysUserExample.or().andEqualTo("isDelete",false).andNotIn("id",userIds);
            sysUserServerResponseModel = sysUserService.selectPageByExampleV2(sysUserExample,pageModel2.getPage(),pageModel2.getRows());
        }
        Datagrid datagrid = new Datagrid(sysUserServerResponseModel.getPageModel().getCount(),sysUserServerResponseModel.getListDate());
        super.writeJson(datagrid,response);
    }

    /**
     *
     * @param type 1 在组织里的查询,其他不过滤不在组织的用户
     * @param key
     * @param pageNumber
     * @param pageSize
     * @param response
     */
    @RequestMapping(value = "/query/{key}",method = RequestMethod.GET)
    public void getUserByKey(Integer type, @PathVariable String key, Integer pageNumber, Integer pageSize, HttpServletResponse response){
        if (pageNumber == null){
            pageNumber = 1;
        }
        if (pageSize == null){
            pageSize = 10;
        }
        //在组织里的用户Id
        List<Long> userIds = new ArrayList<>();
        if (type == 1){
            List<SysOrganizationHasSysUserKey> userOrganizationKeys= userOrganizationKeyService.selectPage(null,null);
            for (SysOrganizationHasSysUserKey userOrganizationKey : userOrganizationKeys){
                userIds.add(userOrganizationKey.getSysUserId());
            }
        }else{
            userIds.add(0L);
        }

        String queryKey = "\'%" + key + "%\'";
        String queryCondition = "username like " + queryKey + " or nickname like " + queryKey + " or phone like " + queryKey;
        Example example = new Example(SysUser.class);
        example.or().andCondition(queryCondition).andNotIn("id",userIds).andEqualTo("isDelete",false);
        super.writeJson(sysUserService.selectPageByExampleV2(example,pageNumber,pageSize),response);

//        SysUserExample sysUserExample = new SysUserExample();
//        sysUserExample.or().andUsernameLike(queryKey);
//        ServerResponseModel<SysUser> result = sysUserService.selectPageByExampleV2(sysUserExample,pageNumber,pageSize);
//        if (result.getListDate().size() == 0){
//            SysUserExample sysUserExample1 = new SysUserExample();
//            sysUserExample1.or().andNicknameLike(queryKey);
//            result = sysUserService.selectPageByExampleV2(sysUserExample1,pageNumber,pageSize);
//            if(result.getListDate().size() == 0){
//                SysUserExample sysUserExample2 = new SysUserExample();
//                sysUserExample2.or().andPhoneLike(queryKey);
//                result = sysUserService.selectPageByExampleV2(sysUserExample2,pageNumber,pageSize);
//                super.writeJson(result,response);
//                return;
//            }else {
//                super.writeJson(result,response);
//                return;
//            }
//        }else {
//            super.writeJson(result,response);
//            return;
//        }
    }

    /**
     * 修改密码
     * @param response
     * @param id
     * @param newPassword
     */
    @RequestMapping(value = "/{id}",method = RequestMethod.PATCH)
    public void updatePassword(HttpServletResponse response, @PathVariable Long id , @RequestBody Map<String,Object> newPassword){
        SysUser sysUser = sysUserService.selectByPrimary(new SysUser(id));
        String mpwd = null;
        if (newPassword.get("newPassword") != null){
            mpwd = (String)newPassword.get("newPassword");
        }
        sysUser.setPassword(mpwd);
        //加密密码
        passwordHelper.encryptPassword(sysUser);
        super.writeJson(sysUserService.updateSelective(sysUser),response);
    }

    @RequestMapping(value = "/{id}",method = RequestMethod.POST)
    public void updateUser(HttpServletResponse response, @PathVariable Long id, @RequestBody SysUser sysUser){
        sysUser.setId(id);
        SysUser checkUser = sysUserService.selectByPrimary(new SysUser(id));
        ServerResponseModel<SysUser> safeUser = sysUserService.selectByEntity(new SysUser(null,sysUser.getPhone()),null,null);
        Integer result = 0;
        //微信修改
        if (checkUser.getPhone() == null){
            result = sysUserService.updateUser(sysUser);
            super.writeJson(result,response);
            return;
        }
        //当电话号码是自己的或者唯一的
        if ( (checkUser.getPhone().equals(sysUser.getPhone())) && (safeUser.getListDate().size() == 1 )){
            sysUser.setPhone(null);
            result = sysUserService.updateUser(sysUser);
        }else if(safeUser.getListDate().size() == 0){
            result = sysUserService.updateUser(sysUser);
        }

        super.writeJson(result,response);
    }

    /**
     * 校验手机和用户名
     * @param field
     * @param sysUser
     * @param response
     */
    @RequestMapping(value = "/check/{field}",method = RequestMethod.POST)
    public void checkPhone(@PathVariable String field, @RequestBody SysUser sysUser, HttpServletResponse response){
        Long userId = sysUser.getId();
        String phone = sysUser.getPhone();
        String username = sysUser.getUsername();

        if(userId == null && phone == null && username == null){
            return;
        }


        //验证username唯一性
        if ("username".equals(field)){

            //当修改时如果不变不验证
            SysUser currentUser = sysUserService.selectByPrimary(new SysUser(sysUser.getId()));
            if(currentUser != null) {
                if (sysUser.getUsername().equals(currentUser.getUsername())) {
                    super.writeJson(true, response);
                    return;
                }
            }

            if (username != null){
                List<SysUser> sysUsers1 = sysUserService.selectByEntity(new SysUser(username),null,null).getListDate();
                if (sysUsers1.size() == 0){
                    super.writeJson(true,response);
                    return;
                }else {
                    super.writeJson(false,response);
                    return;
                }
            }
        }else {//验证phone唯一性

            //当修改时如果不变不验证
            SysUser currentUser = sysUserService.selectByPrimary(new SysUser(sysUser.getId()));
            if (currentUser != null) {
                if (sysUser.getPhone().equals(currentUser.getPhone())) {
                    super.writeJson(true, response);
                    return;
                }
            }

            Example example = null;
            List<SysUser> safeUsers = null;
            if (userId != null){
                example = new Example(SysUser.class);
                example.or().andCondition("id !="+ userId).andCondition("phone = " + phone);
            }else {
                example = new Example(SysUser.class);
                example.or().andCondition("phone = " + phone);
            }
            safeUsers = sysUserService.selectPageByExample(example,null,null);
            if (safeUsers.size() == 0){
                super.writeJson(true,response);
                return;
            } else {
                super.writeJson(false,response);
            }
        }
    }

    @RequestMapping(method = RequestMethod.POST)
    public void addUser(@RequestBody SysUser sysUser, HttpServletResponse response){
        List<SysUser> safeUsername = sysUserService.selectByEntity(new SysUser(sysUser.getUsername()),null,null).getListDate();
        List<SysUser> safePhone = sysUserService.selectByEntity(new SysUser(null,sysUser.getPhone()),null,null).getListDate();
        if (safePhone.size() != 0){
            super.writeJson("手机已经注册过!",response);
            return;
        }else if (safeUsername.size() != 0){
            super.writeJson("用户名已经存在!",response);
            return;
        }
        sysUser.setParentIds("0/");
        sysUser.setCreateTime(new Date());
        sysUser.setAvatar("/static/avater/moren.png");
        sysUser.setIsDelete(false);
        passwordHelper.encryptPassword(sysUser);
        Integer result =  sysUserService.saveUser(sysUser);
        super.writeJson(result,response);
    }

}
