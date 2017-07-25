package com.zyark.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyark.model.PageModel;
import com.zyark.model.ServerResponseModel;
import com.zyark.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.common.Mapper;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ron on 17-3-30.
 */
@Service
public abstract class BaseServiceIpml<T> implements BaseService<T> {

    @Autowired
    public Mapper<T> mapper;

    /**
     * 保存数据
     *
     * @param entity
     *
     * @return
     */
    public int save(T entity) {
        return mapper.insert(entity);
    }

    /**
     * 保存数据，只保存有值的字段
     *
     * @param entity
     *
     * @return
     */
    public int saveSelective(T entity) {
        return mapper.insertSelective(entity);
    }

    /**
     * 根新数据
     *
     * @param entity
     *
     * @return
     */
    public int update(T entity) {
        return mapper.updateByPrimaryKey(entity);
    }

    /**
     * 更新数据，只更新有值的字段
     *
     * @param entity
     *
     * @return
     */
    public int updateSelective(T entity) {
        return mapper.updateByPrimaryKeySelective(entity);
    }

    /**
     * 删除
     *
     * @param entity
     *
     * @return
     */
    public int delete(T entity) {
        return mapper.delete(entity);
    }

    /**
     * 根据ＩＤ获取数据
     *
     * @param entity
     *
     * @return
     */
    public T selectByPrimary(T entity) {
        return mapper.selectByPrimaryKey(entity);
    }


    /**
     * 分页查找
     *
     * @param pageNum
     *         　页数
     * @param pageSize
     *         　页大小
     *
     * @return
     */
    public List<T> selectPage(Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageSize == null) {
            return mapper.selectAll();
        } else {
            PageHelper.startPage(pageNum, pageSize);
            List<T> tList = mapper.selectAll();
            PageInfo pageInfo = new PageInfo(tList);
            if (pageInfo.getLastPage() + 1 <= pageNum) {
                return new ArrayList<>();
            }
            return tList;
        }
    }

    /**
     * 根据example的条件查找
     *
     * @param example
     * @param pageNum
     * @param pageSize
     *
     * @return
     */
    public List<T> selectPageByExample(Object example, Integer pageNum, Integer pageSize) {
        //当页数或页大小为空不进行分页
        if (pageNum == null || pageSize == null) {
            return mapper.selectByExample(example);
        } else {
            PageHelper.startPage(pageNum, pageSize);
            List<T> tList = mapper.selectByExample(example);
            PageInfo pageInfo = new PageInfo(tList);
            if (pageInfo.getLastPage() + 1 <= pageNum) {
                return new ArrayList<>();
            }
            return tList;
        }
    }


    /**
     * 分页查找 直接返回分页信息
     *
     * @param pageNum
     *         　页数
     * @param pageSize
     *         　页大小
     *
     * @return
     */
    public ServerResponseModel<T> selectPageV2(Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageSize == null) {
            return new ServerResponseModel<T>(null, null, mapper.selectAll());
        } else {
            PageHelper.startPage(pageNum, pageSize);
            List<T> tList = mapper.selectAll();
            PageInfo pageInfo = new PageInfo(tList);
            PageModel pageModel = new PageModel(pageInfo.getPages(), pageInfo.getTotal(), pageInfo.getPageNum());
            if (pageInfo.getLastPage() + 1 <= pageNum) {
                return new ServerResponseModel<>(null, null, new ArrayList<T>());
            }
            ServerResponseModel<T> serverResponseModel = new ServerResponseModel<T>(pageModel, null, tList);
            return serverResponseModel;
        }
    }

    /**
     * 根据example的条件查找
     *
     * @param example
     * @param pageNum
     * @param pageSize
     *
     * @return
     */
    public ServerResponseModel<T> selectPageByExampleV2(Object example, Integer pageNum, Integer pageSize) {
        //当页数或页大小为空不进行分页
        if (pageNum == null || pageSize == null) {
            return new ServerResponseModel<T>(null, null, mapper.selectByExample(example));
        } else {
            PageHelper.startPage(pageNum, pageSize);
            List<T> tList = mapper.selectByExample(example);
            PageInfo pageInfo = new PageInfo(tList);
            PageModel pageModel = new PageModel(pageInfo.getPages(), pageInfo.getTotal(), pageInfo.getPageNum());
            if (pageInfo.getLastPage() + 1 <= pageNum) {
                return new ServerResponseModel<>(null, null, new ArrayList<T>());
            }
            ServerResponseModel<T> serverResponseModel = new ServerResponseModel<T>(pageModel, null, tList);
            return serverResponseModel;
        }
    }

    public ServerResponseModel<T> selectByEntity(T entity, Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageSize == null) {
            return new ServerResponseModel<T>(null, null, mapper.select(entity));
        } else {
            PageHelper.startPage(pageNum, pageSize);
            List<T> tList = mapper.select(entity);
            PageInfo pageInfo = new PageInfo(tList);
            PageModel pageModel = new PageModel(pageInfo.getPages(), pageInfo.getTotal(), pageInfo.getPageNum());
            if (pageInfo.getLastPage() + 1 <= pageNum) {
                return new ServerResponseModel<>(null, null, new ArrayList<T>());
            }
            ServerResponseModel<T> serverResponseModel = new ServerResponseModel<T>(pageModel, null, tList);
            return serverResponseModel;
        }
    }

    public List<T> selectByEntityWithSimpleResult(T entity, Integer pageNum, Integer pageSize) {
        if (pageNum == null || pageSize == null) {
            return mapper.select(entity);
        } else {
            PageHelper.startPage(pageNum, pageSize);
            List<T> tList = mapper.select(entity);
            PageInfo pageInfo = new PageInfo(tList);
            //超出页数返回空
            if (pageInfo.getLastPage() + 1 <= pageNum) {
                return new ArrayList<>();
            }
            return tList;
        }
    }

    /**
     * 返回一个符合条件的实体，多个会抛出异常
     *
     * @param entity
     *
     * @return
     */
    public T selectOne(T entity) {
        return mapper.selectOne(entity);
    }

    public List<T> findAll() {

        return mapper.selectAll();
    }

    @Override
    public int addAllInList(List<T> entityList) {
        return 0;
    }
}
