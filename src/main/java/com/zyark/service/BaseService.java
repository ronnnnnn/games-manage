package com.zyark.service;

import com.zyark.model.ServerResponseModel;

import java.util.List;

/**
 * Created by ron on 17-3-30.
 */

public interface BaseService<T> {

    /**
     * 保存数据
     *
     * @param entity
     *
     * @return
     */
    public int save(T entity);

    /**
     * 保存数据，只保存有值的字段
     *
     * @param entity
     *
     * @return
     */
    public int saveSelective(T entity);

    /**
     * 根新数据
     *
     * @param entity
     *
     * @return
     */
    public int update(T entity);

    /**
     * 更新数据，只更新有值的字段
     *
     * @param entity
     *
     * @return
     */
    public int updateSelective(T entity);

    /**
     * 删除
     *
     * @param entity
     *
     * @return
     */
    public int delete(T entity);

    /**
     * 根据ＩＤ获取数据
     *
     * @param entity
     *
     * @return
     */
    public T selectByPrimary(T entity);


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
    public List<T> selectPage(Integer pageNum, Integer pageSize);

    /**
     * 根据example的条件查找
     *
     * @param example
     * @param pageNum
     * @param pageSize
     *
     * @return
     */
    public List<T> selectPageByExample(Object example, Integer pageNum, Integer pageSize);

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
    public ServerResponseModel<T> selectPageV2(Integer pageNum, Integer pageSize);

    /**
     * 根据example的条件查找
     *
     * @param example
     * @param pageNum
     * @param pageSize
     *
     * @return
     */
    public ServerResponseModel<T> selectPageByExampleV2(Object example, Integer pageNum, Integer pageSize);

    public ServerResponseModel<T> selectByEntity(T entity, Integer pageNum, Integer pageSize);

    public List<T> selectByEntityWithSimpleResult(T entity, Integer pageNum, Integer pageSize);

    /**
     * 返回一个符合条件的实体，多个会抛出异常
     *
     * @param entity
     *
     * @return
     */
    public T selectOne(T entity);


    /**
     * 不分页查找所有
     *
     * @return
     */
    public List<T> findAll();

    /**
     * 批量插入
     */
    public int addAllInList(List<T> entityList);

}
