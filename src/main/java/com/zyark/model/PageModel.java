package com.zyark.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ron on 17-4-13.
 */
public class PageModel {

    //pagenum：页码列表  totalnum：总页数  cpage：当前页 ,count:总条数
    private List<Integer> pagenum;

    private Integer totalnum;

    private Long count;

    private Integer cpage;

    public PageModel(Integer totalnum, Long count, Integer cpage) {
        this.pagenum = this.pagenumBuild(totalnum);
        this.totalnum = totalnum;
        this.count = count;
        this.cpage = cpage;
    }

    public List<Integer> getPagenum() {
        return pagenum;
    }

    public void setPagenum(List<Integer> pagenum) {
        this.pagenum = pagenum;
    }

    public Integer getTotalnum() {
        return totalnum;
    }

    public void setTotalnum(Integer totalnum) {
        this.totalnum = totalnum;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public Integer getCpage() {
        return cpage;
    }

    public void setCpage(Integer cpage) {
        this.cpage = cpage;
    }

    public List<Integer> pagenumBuild(Integer totalnum){
        List<Integer> pagenums = new ArrayList<>();
        for (int i = 1; i <= totalnum ; i++) {
            pagenums.add(i);
        }
        return pagenums;
    }
}
