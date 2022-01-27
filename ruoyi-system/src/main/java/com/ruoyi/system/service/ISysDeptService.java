package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.SysDept;

/**
 * 部门管理 服务层
 * 
 * @author ruoyi
 */
public interface ISysDeptService
{
    /**
     * 查询部门管理数据
     * 
     * @param dept 部门信息
     * @return 部门信息集合
     */
    List<SysDept> selectDeptList(SysDept dept);

    /**
     * 构建前端所需要树结构
     * 
     * @param depts 部门列表
     * @return 树结构列表
     */
    List<SysDept> buildDeptTree(List<SysDept> depts);

    /**
     * 构建前端所需要下拉树结构
     * 
     * @param depts 部门列表
     * @return 下拉树结构列表
     */
    List<TreeSelect> buildDeptTreeSelect(List<SysDept> depts);

    /**
     * 根据角色ID查询部门树信息
     * 
     * @param roleId 角色ID
     * @return 选中部门列表
     */
    List<String> selectDeptListByRoleId(String roleId);

    /**
     * 根据部门ID查询信息
     * 
     * @param id 部门ID
     * @return 部门信息
     */
    SysDept selectDeptById(String id);

    /**
     * 根据ID查询所有子部门（正常状态）
     * 
     * @param id 部门ID
     * @return 子部门数
     */
    int selectNormalChildrenDeptById(String id);

    /**
     * 是否存在部门子节点
     * 
     * @param id 部门ID
     * @return 结果
     */
    boolean hasChildById(String id);

    /**
     * 查询部门是否存在用户
     * 
     * @param id 部门ID
     * @return 结果 true 存在 false 不存在
     */
    boolean checkDeptExistUser(String id);

    /**
     * 校验部门名称是否唯一
     * 
     * @param dept 部门信息
     * @return 结果
     */
    String checkDeptNameUnique(SysDept dept);

    /**
     * 校验部门是否有数据权限
     * 
     * @param id 部门id
     */
    void checkDeptDataScope(String id);

    /**
     * 新增保存部门信息
     * 
     * @param dept 部门信息
     * @return 结果
     */
    int insertDept(SysDept dept);

    /**
     * 修改保存部门信息
     * 
     * @param dept 部门信息
     * @return 结果
     */
    int updateDept(SysDept dept);

    /**
     * 删除部门管理信息
     * 
     * @param id 部门ID
     * @return 结果
     */
    int deleteDeptById(String id);
}
