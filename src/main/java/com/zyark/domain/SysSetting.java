package com.zyark.domain;

import javax.persistence.*;
import java.util.List;

@Table(name = "sys_setting")
public class SysSetting {

    /**
     * 系统设置Code:宽带新装
     */
    @Transient
    public static final String CODE_DECORATION = "01";

    /**
     * 系统设置Code:故障类型
     */
    @Transient
    public static final String CODE_FAULT_TYPE = "04";

    /**
     * 系统设置Code:手机套餐
     */
    @Transient
    public static final String CODE_PHONE_TYPE = "05";

    /**
     * 系统设置Code:抽成的前缀
     */
    @Transient
    public static final String CODE_TOKEN_PERSENTAGE_PRO = "03";

    /**
     * 系统设置Code:自己的抽成的后缀
     */
    @Transient
    public static final String CODE_SELF_TAKE_PERCENTAGE_SUF = "01";

    /**
     * 系统设置Code:上一级的抽成的后缀
     */
    @Transient
    public static final String CODE_UP_ONE_TAKE_PERCENTAGE_SUF = "02";

    /**
     * 系统设置Code:上二级的抽成的后缀
     */
    @Transient
    public static final String CODE_UP_TWO_TAKE_PERCENTAGE_SUF = "03";

    /**
     * 系统设置Code:上三级的抽成的后缀
     */
    @Transient
    public static final String CODE_UP_THREE_TAKE_PERCENTAGE_SUF = "04";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OrderBy
    private String sysCode;

    private String sysType;

    private String sysName;

    private String sysValue;

    private String sysDescription;

    private Boolean isShow;



    public SysSetting() {

    }

    public SysSetting(String sysCode) {
        this.sysCode = sysCode;
    }

    public SysSetting(Integer packageId, String suffix) {
        this.sysCode = SysSetting.CODE_TOKEN_PERSENTAGE_PRO + packageId + suffix;
    }

    public SysSetting(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSysCode() {
        return sysCode;
    }

    public void setSysCode(String sysCode) {
        this.sysCode = sysCode;
    }

    public String getSysType() {
        return sysType;
    }

    public void setSysType(String sysType) {
        this.sysType = sysType;
    }

    public String getSysName() {
        return sysName;
    }

    public void setSysName(String sysName) {
        this.sysName = sysName;
    }

    public String getSysValue() {
        return sysValue;
    }

    public void setSysValue(String sysValue) {
        this.sysValue = sysValue;
    }

    public String getSysDescription() {
        return sysDescription;
    }

    public void setSysDescription(String sysDescription) {
        this.sysDescription = sysDescription;
    }

    public Boolean getIsShow() {
        return isShow;
    }

    public void setIsShow(Boolean show) {
        isShow = show;
    }
}