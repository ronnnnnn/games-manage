package com.zyark.service;

import com.zyark.domain.SysOrganization;

import java.util.List;

/**
 * Created by ron on 17-4-6.
 */
public interface SysOrganizationService extends BaseService<SysOrganization> {

    /**
     * 找出所有未被删除的营业厅
     *
     * @param pageNum
     * @param pageSize
     *
     * @return
     */
    List<SysOrganization> findAll(Integer pageNum, Integer pageSize);

    /**
     * 添加树节点，并改变其祖宗的类型０祖１父２子
     */
    Long addChild(String title, Long pId);

    Boolean deleteChild(Long id);

}
