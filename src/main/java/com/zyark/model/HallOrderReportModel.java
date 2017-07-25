package com.zyark.model;

/**
 * Created by ron on 17-7-4.
 */
public class HallOrderReportModel {
    private String orederId;

    private String firstType;

    private String secondType;

    private String type;

    private String salePrice;

    private Double payPrice;

    private Double payIntegral;

    private String payMethod;

    private String hallName;

    private String serverPerson;

    private String username;

    private String nickname;

    private String status;

    private String createTime;

    public HallOrderReportModel() {

    }

    public HallOrderReportModel(String orederId, String firstType, String secondType, String type, String salePrice, Double payPrice, Double payIntegral, String payMethod, String hallName, String serverPerson, String username, String nickname, String status, String createTime) {
        this.orederId = orederId;
        this.firstType = firstType;
        this.secondType = secondType;
        this.type = type;
        this.salePrice = salePrice;
        this.payPrice = payPrice;
        this.payIntegral = payIntegral;
        this.payMethod = payMethod;
        this.hallName = hallName;
        this.serverPerson = serverPerson;
        this.username = username;
        this.nickname = nickname;
        this.status = status;
        this.createTime = createTime;
    }

    public String getOrederId() {
        return orederId;
    }

    public void setOrederId(String orederId) {
        this.orederId = orederId;
    }

    public String getFirstType() {
        return firstType;
    }

    public void setFirstType(String firstType) {
        this.firstType = firstType;
    }

    public String getSecondType() {
        return secondType;
    }

    public void setSecondType(String secondType) {
        this.secondType = secondType;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(String salePrice) {
        this.salePrice = salePrice;
    }

    public Double getPayPrice() {
        return payPrice;
    }

    public void setPayPrice(Double payPrice) {
        this.payPrice = payPrice;
    }

    public Double getPayIntegral() {
        return payIntegral;
    }

    public void setPayIntegral(Double payIntegral) {
        this.payIntegral = payIntegral;
    }

    public String getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(String payMethod) {
        this.payMethod = payMethod;
    }

    public String getHallName() {
        return hallName;
    }

    public void setHallName(String hallName) {
        this.hallName = hallName;
    }

    public String getServerPerson() {
        return serverPerson;
    }

    public void setServerPerson(String serverPerson) {
        this.serverPerson = serverPerson;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
