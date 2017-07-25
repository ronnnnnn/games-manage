package com.zyark.service;

import com.zyark.domain.SysSetting;

import java.util.List;

/**
 * ClassName: SysSettingService  <br/>
 * Function:  <br/>
 * Reason:  <br/>
 * Date: 2017-05-24 9:29 <br/>
 *
 * @author Ku_ker
 * @version 1.0
 * @JDK 1.7
 */

public interface SysSettingService extends BaseService<SysSetting>{

    /**
     * 通过code查找所有
     *
     * @param code
     *         {@link SysSetting}的sysCode
     *
     * @return 多个 {@link SysSetting}对象
     */
    List<SysSetting> findAllByCode(String code);

}
