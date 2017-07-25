package com.zyark.domain;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by ron on 17-7-22.
 */
@Table(name = "access_record")
public class AccessRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String sid;

    private String ipAddress;

    private String handleModule;

    private Date lastAccessTime;

    private String username;

    public AccessRecord() {
       super();
    }

    public AccessRecord(String sid) {
        this.sid = sid;
    }

    public AccessRecord(String sid, String ipAddress, String handleModule, Date lastAccessTime, String username) {
        this.sid = sid;
        this.ipAddress = ipAddress;
        this.handleModule = handleModule;
        this.lastAccessTime = lastAccessTime;
        this.username = username;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getHandleModule() {
        return handleModule;
    }

    public void setHandleModule(String handleModule) {
        this.handleModule = handleModule;
    }

    public Date getLastAccessTime() {
        return lastAccessTime;
    }

    public void setLastAccessTime(Date lastAccessTime) {
        this.lastAccessTime = lastAccessTime;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
