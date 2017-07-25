package com.zyark.web.controller;

import com.zyark.domain.SysResource;
import com.zyark.domain.SysUser;
import com.zyark.service.SysResourceService;
import com.zyark.service.SysUserService;
import com.zyark.web.util.DeviceUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ron on 17-4-7.
 */
@Controller
public class IndexController extends BaseController {


    private Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Resource
    SysUserService sysUserService;

    @Resource
    SysResourceService sysResourceService;

    /**
     * 登录成功后进行跳转
     * @param request
     * @return
     */
    @RequestMapping("/")
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response){
        Serializable cookie = request.getSession().getId();
        SysUser user = (SysUser) request.getAttribute("user");

        //管理员跳转到管理界面
        if("5".equals(user.getUserType()) && !DeviceUtil.isMobileDevice(request.getHeader("user-agent"))){
            List<SysResource> sysResources = sysUserService.findResources(((SysUser)request.getAttribute("user")).getUsername());
            List<SysResource> rootMenus = sysResourceService.findRootMenus();
            Map<String,List<SysResource>> menuMap = new LinkedHashMap<String,List<SysResource>>();
            for (int i = 0; i < rootMenus.size(); i++) {
                SysResource rootResource = rootMenus.get(i);
                List<SysResource> childMenus = new ArrayList<SysResource>();
                for (SysResource childResource : sysResources){
                    if(childResource.getParentId() == rootResource.getId().longValue()){
                        childMenus.add(childResource);
                    }
                }
                if (childMenus.size() != 0){
                    menuMap.put(rootResource.getResourceName(),childMenus);
                }
            }

            ModelAndView modelAndView = new ModelAndView("admin/index");
            modelAndView.addObject("menus",menuMap);
            return modelAndView;
        }else {  //app普通用户返回json数据
//            String sid = request.getSession().getId();
//            logger.info(sid+"===============");
//            user.setSid(sid);
//            return JsonView.Render(new ResponseMessage<SysUser>(200,"success",user),response);
            return null;
        }

    }


}
