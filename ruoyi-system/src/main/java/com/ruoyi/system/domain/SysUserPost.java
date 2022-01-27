package com.ruoyi.system.domain;

import lombok.Data;

/**
 * 用户和岗位关联 sys_user_post
 *
 * @author ruoyi
 */
@Data
public class SysUserPost
{
    /**
     * 用户ID
     */
    private String userId;

    /**
     * 岗位ID
     */
    private String postId;
}
