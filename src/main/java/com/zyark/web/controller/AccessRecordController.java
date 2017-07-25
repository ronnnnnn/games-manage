package com.zyark.web.controller;

import com.zyark.domain.AccessRecord;
import com.zyark.model.ServerResponseModel;
import com.zyark.service.AccessRecordService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;

/**
 * Created by ron on 17-7-22.
 */
@RequestMapping("access-record")
@Controller
public class AccessRecordController {

    @Resource
    AccessRecordService accessRecordService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    @ResponseBody
    public ServerResponseModel<AccessRecord> getAccessRecordList(@RequestParam(value = "pageNumber",required = false)Integer pageNumber,
                                                                 @RequestParam(value = "pageSize",required = false)Integer pageSize){
        if (pageNumber == null){
            pageNumber = 1;
        }
        if (pageSize == null){
            pageSize = 10;
        }
        return accessRecordService.selectPageV2(pageNumber,pageSize);
    }

    @RequestMapping(value = "query/{key}",method = RequestMethod.GET)
    @ResponseBody
    public ServerResponseModel<AccessRecord> getQueryList(@PathVariable String key,@RequestParam(value = "pageNumber",required = false)Integer pageNumber,
                                                          @RequestParam(value = "pageSize",required = false)Integer pageSize){
        if (pageNumber == null){
            pageNumber = 1;
        }
        if (pageSize == null){
            pageSize = 10;
        }
        Example example = new Example(AccessRecord.class);
        example.or().andLike("username","%"+key+"%");
        return accessRecordService.selectPageByExampleV2(example,pageNumber,pageSize);
    }
}
