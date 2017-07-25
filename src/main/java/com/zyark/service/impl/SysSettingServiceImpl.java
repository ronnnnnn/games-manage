package com.zyark.service.impl;

import com.zyark.domain.SysSetting;
import com.zyark.service.SysSettingService;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * Created by ron on 17-4-23.
 */
@Service
public class SysSettingServiceImpl extends BaseServiceIpml<SysSetting> implements SysSettingService {

    @Override
    public List<SysSetting> findAllByCode(String code) {

        Example example = new Example(SysSetting.class);
        example.createCriteria().andCondition("sys_code like '" + code + "%'");

        return this.selectPageByExample(example, null, null);
    }
}
