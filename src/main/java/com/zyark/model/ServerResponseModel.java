package com.zyark.model;

import java.util.List;
import java.util.Map;

/**
 * Created by ron on 17-4-13.
 */
public class ServerResponseModel<T> {

    //分页信息
    private PageModel pageModel;

    //附带数据
    private Map<String,List<Object>> mapData;

    private Map<String,Object> simpleData;


    private List<T> listData;

    public ServerResponseModel() {

    }

    public ServerResponseModel(PageModel pageModel, List<T> listDate) {
        this.pageModel = pageModel;
        this.listData = listDate;
    }

    public ServerResponseModel(PageModel pageModel, Map<String, List<Object>> mapDate, List<T> listDate) {
        this.pageModel = pageModel;
        this.mapData = mapDate;
        this.listData = listDate;
    }

    public Map<String, Object> getSimpleData() {
        return simpleData;
    }

    public void setSimpleData(Map<String, Object> simpleData) {
        this.simpleData = simpleData;
    }

    public PageModel getPageModel() {
        return pageModel;
    }

    public void setPageModel(PageModel pageModel) {
        this.pageModel = pageModel;
    }

    public Map<String, List<Object>> getMapDate() {
        return mapData;
    }

    public void setMapDate(Map<String, List<Object>> mapDate) {
        this.mapData = mapDate;
    }

    public List<T> getListDate() {
        return listData;
    }

    public void setListDate(List<T> listDate) {
        this.listData = listDate;
    }
}
