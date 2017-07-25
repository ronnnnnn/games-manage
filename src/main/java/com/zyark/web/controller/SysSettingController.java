package com.zyark.web.controller;

import com.zyark.domain.SysSetting;
import com.zyark.service.SysSettingService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by ron on 17-4-23.
 */
@RequestMapping("setting")
@Controller
public class SysSettingController extends BaseController {

    @Resource
    SysSettingService sysSettingService;

    /**
     *列表
     */
    @RequestMapping(value = "list",method = RequestMethod.GET)
    @ResponseBody
    public Object getList(HttpServletRequest request,
                          @RequestParam(value = "pageNumber",required = false) Integer pageNumber,
                          @RequestParam(value = "pageSize",required = false)Integer pageSize){
        if (pageNumber == null){
            pageNumber = 1;
        }
        if (pageSize == null){
            pageSize = 10;
        }

        Example example = new Example(SysSetting.class);
        example.or().andEqualTo("isShow",true);
        return sysSettingService.selectPageByExampleV2(example,pageNumber,pageSize);
    }

    /**
     * 添加
     */
    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public Object addSetting(@RequestBody SysSetting sysSetting, HttpServletRequest request){
        sysSetting.setIsShow(true);
        return sysSettingService.saveSelective(sysSetting);
    }

    /**
     * 修改
     */
    @RequestMapping(value = "{id}",method = RequestMethod.POST)
    @ResponseBody
    public Object updateSetting(@RequestBody SysSetting sysSetting){
        return sysSettingService.updateSelective(sysSetting);
    }

    /**
     * 删除
     */
    @RequestMapping(value = "{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public Object deleteSetting(@PathVariable Long id){
        return sysSettingService.delete(new SysSetting(id));
    }

    /**
     * 获取套餐类型列表
     */
    @RequestMapping(value = "ptype",method = RequestMethod.GET)
    @ResponseBody
    public Object getTypeList(){
        Example example = new Example(SysSetting.class);
        example.or().andCondition("sys_code like \'01%\'" );
        example.or().andCondition("sys_code like \'05%\'" );
        return sysSettingService.selectPageByExample(example,null,null);
    }

    /**
     * 获取类型列表 02设备类型
     */
    @RequestMapping(value = "type/{preCode}",method = RequestMethod.GET)
    @ResponseBody
    public Object getTypeList(@PathVariable String preCode){
        Example example = new Example(SysSetting.class);
        example.or().andCondition("sys_code like \'"+preCode+"%\'" );
        return sysSettingService.selectPageByExample(example,null,null);
    }
}
