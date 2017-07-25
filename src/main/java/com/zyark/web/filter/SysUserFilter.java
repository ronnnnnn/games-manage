package com.zyark.web.filter;

import com.zyark.domain.AccessRecord;
import com.zyark.domain.SysUser;
import com.zyark.service.AccessRecordService;
import com.zyark.service.SysResourceService;
import com.zyark.service.SysUserService;
import com.zyark.web.Constants;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.PathMatchingFilter;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * ron
 * 获取用户信息
 */
public class SysUserFilter extends PathMatchingFilter {

    @Resource
    private SysUserService sysUserService;

    @Resource
    private AccessRecordService accessRecordService;

    @Resource
    private SysResourceService sysResourceService;

    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        String username = (String) SecurityUtils.getSubject().getPrincipal();
        SysUser sysUser = new SysUser(username);
        SysUser mySysUser = sysUserService.selectOne(sysUser);
        request.setAttribute(Constants.CURRENT_USER,mySysUser);

        //记录操作日志
        Map<String,String> moduleMap = sysResourceService.getResourceMap();
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        String url = httpServletRequest.getServletPath();
        String sid = httpServletRequest.getSession().getId();
        AccessRecord accessRecord = accessRecordService.selectOne(new AccessRecord(sid));
        Long time = httpServletRequest.getSession().getLastAccessedTime();
        Date lastAccessedTime = new Date(time);
        String ip = getIpAddr(httpServletRequest);
        if (accessRecord != null){
            accessRecord.setLastAccessTime(lastAccessedTime);
            String oldHandleModule = accessRecord.getHandleModule();
            oldHandleModule = oldHandleModule == null ? "":oldHandleModule;
            if (moduleMap.get(url)!= null&& !moduleMap.get(url).equals("")&&!oldHandleModule.contains(moduleMap.get(url))){
               if (oldHandleModule.equals("")){
                   accessRecord.setHandleModule(moduleMap.get(url));
               }else {
                   accessRecord.setHandleModule(oldHandleModule + "," + moduleMap.get(url));
               }
            }
            accessRecordService.updateSelective(accessRecord);
        }else {
            AccessRecord newAccessRecord = new AccessRecord( sid,  ip,  moduleMap.get(url) ,  lastAccessedTime,  username);
            accessRecordService.saveSelective(newAccessRecord);
        }
        return true;
    }

    public String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
