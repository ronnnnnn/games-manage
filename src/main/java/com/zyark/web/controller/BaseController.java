package com.zyark.web.controller;

import com.alibaba.fastjson.JSON;
import com.zyark.domain.SysUser;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class BaseController {


	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(BaseController.class);
	//将json返回页面
	public void writeJson(Object object,HttpServletResponse response) {
		try {
			String json = JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss");
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().write(json);
			response.getWriter().flush();
			response.getWriter().close();
		   } catch (IOException e) {
			e.printStackTrace();
		}
	}


	protected String saveUploadFile(HttpServletRequest request, MultipartFile upload, String uploadpath, String type) {
		if (upload == null)
			return "";
		
		//SimpleDateFormat sdf = new SimpleDateFormat("\\yyyy\\MM\\dd\\");
		String basePath = "/var/www/files";
//		String basePath = "/home/ron/桌面/乐助";
		logger.info("==============" + basePath);
		String subPath = "/Images/" + uploadpath +"/";
		File dir = new File(basePath + subPath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		String imageName =  UUID.randomUUID().toString() + "."+type;
		String path = basePath + subPath + imageName ;
        File myfile = new File(path);
		logger.info("==============" + path);
		try {
			upload.transferTo(myfile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
	
		return "/pic" + subPath+imageName;
	}

	protected SysUser getCurrentUser(HttpServletRequest request){
		Integer userType = 1;
		SysUser sysUser = (SysUser) request.getAttribute("user");
//		if (sysUser != null){
//			userType = sysUser.getUserType();
//		}
//		return userType;
		return sysUser;
	}
	protected String getUserType(HttpServletRequest request){
        return getCurrentUser(request).getUserType();
	}

}
