package com.ruoyi.quartz.mapper;

import java.util.List;

import com.ruoyi.quartz.domain.SysJob;
import org.springframework.stereotype.Repository;

/**
 * 调度任务信息 数据层
 *
 * @author ruoyi
 */
@Repository
public interface SysJobMapper
{
    /**
     * 查询调度任务日志集合
     *
     * @param job 调度信息
     * @return 操作日志集合
     */
    List<SysJob> selectJobList(SysJob job);

    /**
     * 查询所有调度任务
     *
     * @return 调度任务列表
     */
    List<SysJob> selectJobAll();

    /**
     * 通过调度ID查询调度任务信息
     *
     * @param jobId 调度ID
     * @return 角色对象信息
     */
    SysJob selectJobById(String jobId);

    /**
     * 通过调度ID删除调度任务信息
     *
     * @param jobId 调度ID
     * @return 结果
     */
    int deleteJobById(String jobId);

    /**
     * 批量删除调度任务信息
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteJobByIds(String[] ids);

    /**
     * 修改调度任务信息
     *
     * @param job 调度任务信息
     * @return 结果
     */
    int updateJob(SysJob job);

    /**
     * 新增调度任务信息
     *
     * @param job 调度任务信息
     * @return 结果
     */
    int insertJob(SysJob job);
}
