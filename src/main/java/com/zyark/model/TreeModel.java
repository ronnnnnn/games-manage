package com.zyark.model;

/**
 * Created by ron on 17-4-14.
 */
public class TreeModel {
    private Long id;
    private Long pId;
    private String name;

    public TreeModel() {
        super();
    }

    public TreeModel(Long id, Long pId, String name) {
        this.id = id;
        this.pId = pId;
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getpId() {
        return pId;
    }

    public void setpId(Long pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
