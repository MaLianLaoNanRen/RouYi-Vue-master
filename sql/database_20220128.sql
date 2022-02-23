-- ----------------------------
-- 1、部门表
-- ----------------------------
DROP TABLE IF EXISTS sys_dept;

CREATE TABLE sys_dept
(
    id          VARCHAR(32) NOT NULL COMMENT '部门ID',
    parent_id   VARCHAR(32)          DEFAULT '0' COMMENT '父部门ID',
    ancestors   VARCHAR(255)         DEFAULT '' COMMENT '祖级列表',
    dept_name   VARCHAR(30)          DEFAULT '' COMMENT '部门名称',
    order_num   INT(4)               DEFAULT 0 COMMENT '显示顺序',
    leader      VARCHAR(20)          DEFAULT NULL COMMENT '负责人',
    phone       VARCHAR(11)          DEFAULT NULL COMMENT '联系电话',
    email       VARCHAR(50)          DEFAULT NULL COMMENT '邮箱',
    status      CHAR(1)              DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
    create_by   VARCHAR(64)          DEFAULT NULL COMMENT '创建者',
    create_time DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by   VARCHAR(64)          DEFAULT NULL COMMENT '更新者',
    update_time DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 200 COMMENT = '部门表';

-- ----------------------------
-- 初始化-部门表数据
-- ----------------------------
select @deptId := replace(uuid(), '-', '');
select @deptId01 := replace(uuid(), '-', '');
select @deptId02 := replace(uuid(), '-', '');
select @deptId03 := replace(uuid(), '-', '');
select @deptId04 := replace(uuid(), '-', '');
insert into sys_dept values (@deptId,                  '0',       '0',                                   '若依科技',   0, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);
insert into sys_dept values (@deptId01,                @deptId,   concat('0,', @deptId),                 '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);
insert into sys_dept values (@deptId02,                @deptId,   concat('0,', @deptId),                 '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);
insert into sys_dept values (@deptId03,                @deptId01, concat('0,', @deptId, ',', @deptId01), '研发部门',   1, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);
insert into sys_dept values (replace(uuid(), '-', ''), @deptId01, concat('0,', @deptId, ',', @deptId01), '市场部门',   2, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);
insert into sys_dept values (@deptId04,                @deptId01, concat('0,', @deptId, ',', @deptId01), '测试部门',   3, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);
insert into sys_dept values (replace(uuid(), '-', ''), @deptId01, concat('0,', @deptId, ',', @deptId01), '财务部门',   4, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);
insert into sys_dept values (replace(uuid(), '-', ''), @deptId01, concat('0,', @deptId, ',', @deptId01), '运维部门',   5, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);
insert into sys_dept values (replace(uuid(), '-', ''), @deptId02, concat('0,', @deptId, ',', @deptId02), '市场部门',   1, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);
insert into sys_dept values (replace(uuid(), '-', ''), @deptId02, concat('0,', @deptId, ',', @deptId02), '财务部门',   2, '若依', '15888888888', 'ry@qq.com', '0', 'root', sysdate(), null, null);

-- ----------------------------
-- 2、用户信息表
-- ----------------------------
DROP TABLE IF EXISTS sys_user;

CREATE TABLE sys_user
(
    id          VARCHAR(32) NOT NULL COMMENT '用户ID',
    dept_id     VARCHAR(32)          DEFAULT NULL COMMENT '部门ID',
    user_name   VARCHAR(30) NOT NULL COMMENT '用户账号',
    nick_name   VARCHAR(30) NOT NULL COMMENT '用户昵称',
    user_type   VARCHAR(2)           DEFAULT '00' COMMENT '用户类型（00系统用户）',
    email       VARCHAR(50)          DEFAULT NULL COMMENT '用户邮箱',
    phonenumber VARCHAR(11)          DEFAULT NULL COMMENT '手机号码',
    sex         CHAR(1)              DEFAULT '0' COMMENT '用户性别（0未知 1男 2女）',
    avatar      VARCHAR(100)         DEFAULT NULL COMMENT '头像地址',
    password    VARCHAR(100)         DEFAULT NULL COMMENT '密码',
    status      CHAR(1)              DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
    login_ip    VARCHAR(128)         DEFAULT NULL COMMENT '最后登录IP',
    login_date  DATETIME             DEFAULT NULL COMMENT '最后登录时间',
    create_by   VARCHAR(32)          DEFAULT NULL COMMENT '创建者',
    create_time DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by   VARCHAR(32)          DEFAULT NULL COMMENT '更新者',
    update_time DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark      VARCHAR(500)         DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 100 COMMENT = '用户信息表';

-- ----------------------------
-- 初始化-用户信息表数据
-- ----------------------------
insert into sys_user values('1',  @deptId03, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$nYVATlkU9iWIYuvVy6a1d.C2DXkGrTxPs7uy1bZf4ArrN5Y3e85QG', '0', null, null, 'root', sysdate(), null, null, '管理员');
insert into sys_user values('2',  @deptId04, 'ry',    '若依', '00', 'ry@qq.com',  '15666666666', '2', '', '$2a$10$nYVATlkU9iWIYuvVy6a1d.C2DXkGrTxPs7uy1bZf4ArrN5Y3e85QG', '0', null, null, 'root', sysdate(), null, null, '测试员');

-- ----------------------------
-- 3、岗位信息表
-- ----------------------------
DROP TABLE IF EXISTS sys_post;

CREATE TABLE sys_post
(
    id          VARCHAR(32) NOT NULL COMMENT '岗位ID',
    post_code   VARCHAR(64) NOT NULL COMMENT '岗位编码',
    post_name   VARCHAR(50) NOT NULL COMMENT '岗位名称',
    post_sort   INT(4)      NOT NULL COMMENT '显示顺序',
    status      CHAR(1)     NOT NULL COMMENT '状态（0正常 1停用）',
    create_by   VARCHAR(32)          DEFAULT NULL COMMENT '创建者',
    create_time DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by   VARCHAR(32)          DEFAULT NULL COMMENT '更新者',
    update_time DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark      VARCHAR(500)         DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE = innodb COMMENT = '岗位信息表';

-- ----------------------------
-- 初始化-岗位信息表数据
-- ----------------------------
insert into sys_post values('1', 'ceo',  '董事长',    1, '0', 'root', sysdate(), null, null, null);
insert into sys_post values('2', 'se',   '项目经理',  2, '0', 'root', sysdate(), null, null, null);
insert into sys_post values('3', 'hr',   '人力资源',  3, '0', 'root', sysdate(), null, null, null);
insert into sys_post values('4', 'user', '普通员工',  4, '0', 'root', sysdate(), null, null, null);


-- ----------------------------
-- 4、角色信息表
-- ----------------------------
DROP TABLE IF EXISTS sys_role;

CREATE TABLE sys_role
(
    id                  VARCHAR(32)  NOT NULL COMMENT '角色ID',
    role_name           VARCHAR(30)  NOT NULL COMMENT '角色名称',
    role_key            VARCHAR(100) NOT NULL COMMENT '角色权限字符串',
    role_sort           INT(4)       NOT NULL COMMENT '显示顺序',
    data_scope          CHAR(1)               DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
    menu_check_strictly TINYINT(1)            DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
    dept_check_strictly TINYINT(1)            DEFAULT 1 COMMENT '部门树选择项是否关联显示',
    status              CHAR(1)      NOT NULL COMMENT '角色状态（0正常 1停用）',
    create_by           VARCHAR(32)           DEFAULT NULL COMMENT '创建者',
    create_time         DATETIME     NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by           VARCHAR(32)           DEFAULT NULL COMMENT '更新者',
    update_time         DATETIME              DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark              VARCHAR(500)          DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 100 COMMENT = '角色信息表';

-- ----------------------------
-- 初始化-角色信息表数据
-- ----------------------------
insert into sys_role values('1', '超级管理员',  'admin',  1, 1, 1, 1, '0', 'root', sysdate(), null, null, '超级管理员');
insert into sys_role values('2', '普通角色',    'common', 2, 2, 1, 1, '0', 'root', sysdate(), null, null, '普通角色');

-- ----------------------------
-- 5、菜单权限表
-- ----------------------------
DROP TABLE IF EXISTS sys_menu;

CREATE TABLE sys_menu
(
    id          VARCHAR(32)  NOT NULL COMMENT '菜单ID',
    menu_name   VARCHAR(50) NOT NULL COMMENT '菜单名称',
    parent_id   VARCHAR(32)           DEFAULT 0 COMMENT '父菜单ID',
    order_num   INT(4)               DEFAULT 0 COMMENT '显示顺序',
    path        VARCHAR(200)         DEFAULT '' COMMENT '路由地址',
    component   VARCHAR(255)         DEFAULT NULL COMMENT '组件路径',
    query       VARCHAR(255)         DEFAULT NULL COMMENT '路由参数',
    is_frame    INT(1)               DEFAULT 1 COMMENT '是否为外链（0是 1否）',
    is_cache    INT(1)               DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
    menu_type   CHAR(1)              DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
    visible     CHAR(1)              DEFAULT 0 COMMENT '菜单状态（0显示 1隐藏）',
    status      CHAR(1)              DEFAULT 0 COMMENT '菜单状态（0正常 1停用）',
    perms       VARCHAR(100)         DEFAULT NULL COMMENT '权限标识',
    icon        VARCHAR(100)         DEFAULT '#' COMMENT '菜单图标',
    create_by   VARCHAR(32)          DEFAULT NULL COMMENT '创建者',
    create_time DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by   VARCHAR(32)          DEFAULT NULL COMMENT '更新者',
    update_time DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark      VARCHAR(500)         DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 2000 COMMENT = '菜单权限表';

-- ----------------------------
-- 初始化-菜单信息表数据
-- ----------------------------
select @menu01 := replace(uuid(), '-', '');
select @menu02 := replace(uuid(), '-', '');
select @menu03 := replace(uuid(), '-', '');
select @menu04 := replace(uuid(), '-', '');
-- 一级菜单
insert into sys_menu values(@menu01, '系统管理', '0', '1', 'system',           null, null, 1, 0, 'M', '0', '0', null, 'system',   'root', sysdate(), null, null, '系统管理目录');
insert into sys_menu values(@menu02, '系统监控', '0', '2', 'monitor',          null, null, 1, 0, 'M', '0', '0', null, 'monitor',  'root', sysdate(), null, null, '系统监控目录');
insert into sys_menu values(@menu03, '系统工具', '0', '3', 'tool',             null, null, 1, 0, 'M', '0', '0', null, 'tool',     'root', sysdate(), null, null, '系统工具目录');
insert into sys_menu values(@menu04, '若依官网', '0', '4', 'http://ruoyi.vip', null, null, 0, 0, 'M', '0', '0', null, 'guide',    'root', sysdate(), null, null, '若依官网地址');
-- 二级菜单
select @menu100 := replace(uuid(), '-', '');
select @menu101 := replace(uuid(), '-', '');
select @menu102 := replace(uuid(), '-', '');
select @menu103 := replace(uuid(), '-', '');
select @menu104 := replace(uuid(), '-', '');
select @menu105 := replace(uuid(), '-', '');
select @menu106 := replace(uuid(), '-', '');
select @menu107 := replace(uuid(), '-', '');
select @menu108 := replace(uuid(), '-', '');
select @menu109 := replace(uuid(), '-', '');
select @menu110 := replace(uuid(), '-', '');
select @menu111 := replace(uuid(), '-', '');
select @menu112 := replace(uuid(), '-', '');
select @menu113 := replace(uuid(), '-', '');
select @menu114 := replace(uuid(), '-', '');
select @menu115 := replace(uuid(), '-', '');
select @menu116 := replace(uuid(), '-', '');
insert into sys_menu values(@menu100,  '用户管理', @menu01,   '1', 'user',       'system/user/index',        null, 1, 0, 'C', '0', '0', 'system:user:list',        'user',          'root', sysdate(), null, null, '用户管理菜单');
insert into sys_menu values(@menu101,  '角色管理', @menu01,   '2', 'role',       'system/role/index',        null, 1, 0, 'C', '0', '0', 'system:role:list',        'peoples',       'root', sysdate(), null, null, '角色管理菜单');
insert into sys_menu values(@menu102,  '菜单管理', @menu01,   '3', 'menu',       'system/menu/index',        null, 1, 0, 'C', '0', '0', 'system:menu:list',        'tree-table',    'root', sysdate(), null, null, '菜单管理菜单');
insert into sys_menu values(@menu103,  '部门管理', @menu01,   '4', 'dept',       'system/dept/index',        null, 1, 0, 'C', '0', '0', 'system:dept:list',        'tree',          'root', sysdate(), null, null, '部门管理菜单');
insert into sys_menu values(@menu104,  '岗位管理', @menu01,   '5', 'post',       'system/post/index',        null, 1, 0, 'C', '0', '0', 'system:post:list',        'post',          'root', sysdate(), null, null, '岗位管理菜单');
insert into sys_menu values(@menu105,  '字典管理', @menu01,   '6', 'dict',       'system/dict/index',        null, 1, 0, 'C', '0', '0', 'system:dict:list',        'dict',          'root', sysdate(), null, null, '字典管理菜单');
insert into sys_menu values(@menu106,  '参数设置', @menu01,   '7', 'config',     'system/config/index',      null, 1, 0, 'C', '0', '0', 'system:config:list',      'edit',          'root', sysdate(), null, null, '参数设置菜单');
insert into sys_menu values(@menu107,  '通知公告', @menu01,   '8', 'notice',     'system/notice/index',      null, 1, 0, 'C', '0', '0', 'system:notice:list',      'message',       'root', sysdate(), null, null, '通知公告菜单');
insert into sys_menu values(@menu108,  '日志管理', @menu01,   '9', 'log',        null,                         null, 1, 0, 'M', '0', '0', null,                      'log',           'root', sysdate(), null, null, '日志管理菜单');
insert into sys_menu values(@menu109,  '在线用户', @menu02,   '1', 'online',     'monitor/online/index',     null, 1, 0, 'C', '0', '0', 'monitor:online:list',     'online',        'root', sysdate(), null, null, '在线用户菜单');
insert into sys_menu values(@menu110,  '定时任务', @menu02,   '2', 'job',        'monitor/job/index',        null, 1, 0, 'C', '0', '0', 'monitor:job:list',        'job',           'root', sysdate(), null, null, '定时任务菜单');
insert into sys_menu values(@menu111,  '数据监控', @menu02,   '3', 'druid',      'monitor/druid/index',      null, 1, 0, 'C', '0', '0', 'monitor:druid:list',      'druid',         'root', sysdate(), null, null, '数据监控菜单');
insert into sys_menu values(@menu112,  '服务监控', @menu02,   '4', 'server',     'monitor/server/index',     null, 1, 0, 'C', '0', '0', 'monitor:server:list',     'server',        'root', sysdate(), null, null, '服务监控菜单');
insert into sys_menu values(@menu113,  '缓存监控', @menu02,   '5', 'cache',      'monitor/cache/index',      null, 1, 0, 'C', '0', '0', 'monitor:cache:list',      'redis',         'root', sysdate(), null, null, '缓存监控菜单');
insert into sys_menu values(@menu114,  '表单构建', @menu03,   '1', 'build',      'tool/build/index',         null, 1, 0, 'C', '0', '0', 'tool:build:list',         'build',         'root', sysdate(), null, null, '表单构建菜单');
insert into sys_menu values(@menu115,  '代码生成', @menu03,   '2', 'gen',        'tool/gen/index',           null, 1, 0, 'C', '0', '0', 'tool:gen:list',           'code',          'root', sysdate(), null, null, '代码生成菜单');
insert into sys_menu values(@menu116,  '系统接口', @menu03,   '3', 'swagger',    'tool/swagger/index',       null, 1, 0, 'C', '0', '0', 'tool:swagger:list',       'swagger',       'root', sysdate(), null, null, '系统接口菜单');
-- 三级菜单
select @menu500 := replace(uuid(), '-', '');
select @menu501 := replace(uuid(), '-', '');
insert into sys_menu values(@menu500,  '操作日志', @menu108, '1', 'operlog',    'monitor/operlog/index',    null, 1, 0, 'C', '0', '0', 'monitor:operlog:list',    'form',          'root', sysdate(), null, null, '操作日志菜单');
insert into sys_menu values(@menu501,  '登录日志', @menu108, '2', 'logininfor', 'monitor/logininfor/index', null, 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor',    'root', sysdate(), null, null, '登录日志菜单');
-- 用户管理按钮
select @menu1001 := replace(uuid(), '-', '');
select @menu1002 := replace(uuid(), '-', '');
select @menu1003 := replace(uuid(), '-', '');
select @menu1004 := replace(uuid(), '-', '');
select @menu1005 := replace(uuid(), '-', '');
select @menu1006 := replace(uuid(), '-', '');
select @menu1007 := replace(uuid(), '-', '');
select @menu1007 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1001, '用户查询', @menu100, '1',  null, null, null, 1, 0, 'F', '0', '0', 'system:user:query',          '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1002, '用户新增', @menu100, '2',  null, null, null, 1, 0, 'F', '0', '0', 'system:user:add',            '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1003, '用户修改', @menu100, '3',  null, null, null, 1, 0, 'F', '0', '0', 'system:user:edit',           '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1004, '用户删除', @menu100, '4',  null, null, null, 1, 0, 'F', '0', '0', 'system:user:remove',         '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1005, '用户导出', @menu100, '5',  null, null, null, 1, 0, 'F', '0', '0', 'system:user:export',         '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1006, '用户导入', @menu100, '6',  null, null, null, 1, 0, 'F', '0', '0', 'system:user:import',         '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1007, '重置密码', @menu100, '7',  null, null, null, 1, 0, 'F', '0', '0', 'system:user:resetPwd',       '#', 'root', sysdate(), null, null, null);
-- 角色管理按钮
select @menu1008 := replace(uuid(), '-', '');
select @menu1009 := replace(uuid(), '-', '');
select @menu1010 := replace(uuid(), '-', '');
select @menu1011 := replace(uuid(), '-', '');
select @menu1012 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1008, '角色查询', @menu101, '1',  null, null, null, 1, 0, 'F', '0', '0', 'system:role:query',          '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1009, '角色新增', @menu101, '2',  null, null, null, 1, 0, 'F', '0', '0', 'system:role:add',            '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1010, '角色修改', @menu101, '3',  null, null, null, 1, 0, 'F', '0', '0', 'system:role:edit',           '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1011, '角色删除', @menu101, '4',  null, null, null, 1, 0, 'F', '0', '0', 'system:role:remove',         '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1012, '角色导出', @menu101, '5',  null, null, null, 1, 0, 'F', '0', '0', 'system:role:export',         '#', 'root', sysdate(), null, null, null);
-- 菜单管理按钮
select @menu1013 := replace(uuid(), '-', '');
select @menu1014 := replace(uuid(), '-', '');
select @menu1015 := replace(uuid(), '-', '');
select @menu1016 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1013, '菜单查询', @menu102, '1',  null, null, null, 1, 0, 'F', '0', '0', 'system:menu:query',          '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1014, '菜单新增', @menu102, '2',  null, null, null, 1, 0, 'F', '0', '0', 'system:menu:add',            '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1015, '菜单修改', @menu102, '3',  null, null, null, 1, 0, 'F', '0', '0', 'system:menu:edit',           '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1016, '菜单删除', @menu102, '4',  null, null, null, 1, 0, 'F', '0', '0', 'system:menu:remove',         '#', 'root', sysdate(), null, null, null);
-- 部门管理按钮
select @menu1017 := replace(uuid(), '-', '');
select @menu1018 := replace(uuid(), '-', '');
select @menu1019 := replace(uuid(), '-', '');
select @menu1020 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1017, '部门查询', @menu103, '1',  null, null, null, 1, 0, 'F', '0', '0', 'system:dept:query',          '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1018, '部门新增', @menu103, '2',  null, null, null, 1, 0, 'F', '0', '0', 'system:dept:add',            '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1019, '部门修改', @menu103, '3',  null, null, null, 1, 0, 'F', '0', '0', 'system:dept:edit',           '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1020, '部门删除', @menu103, '4',  null, null, null, 1, 0, 'F', '0', '0', 'system:dept:remove',         '#', 'root', sysdate(), null, null, null);
-- 岗位管理按钮
select @menu1021 := replace(uuid(), '-', '');
select @menu1022 := replace(uuid(), '-', '');
select @menu1023 := replace(uuid(), '-', '');
select @menu1024 := replace(uuid(), '-', '');
select @menu1025 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1021, '岗位查询', @menu104, '1',  null, null, null, 1, 0, 'F', '0', '0', 'system:post:query',          '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1022, '岗位新增', @menu104, '2',  null, null, null, 1, 0, 'F', '0', '0', 'system:post:add',            '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1023, '岗位修改', @menu104, '3',  null, null, null, 1, 0, 'F', '0', '0', 'system:post:edit',           '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1024, '岗位删除', @menu104, '4',  null, null, null, 1, 0, 'F', '0', '0', 'system:post:remove',         '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1025, '岗位导出', @menu104, '5',  null, null, null, 1, 0, 'F', '0', '0', 'system:post:export',         '#', 'root', sysdate(), null, null, null);
-- 字典管理按钮
select @menu1026 := replace(uuid(), '-', '');
select @menu1027 := replace(uuid(), '-', '');
select @menu1028 := replace(uuid(), '-', '');
select @menu1029 := replace(uuid(), '-', '');
select @menu1030 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1026, '字典查询', @menu105, '1', '#', null, null, 1, 0, 'F', '0', '0', 'system:dict:query',          '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1027, '字典新增', @menu105, '2', '#', null, null, 1, 0, 'F', '0', '0', 'system:dict:add',            '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1028, '字典修改', @menu105, '3', '#', null, null, 1, 0, 'F', '0', '0', 'system:dict:edit',           '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1029, '字典删除', @menu105, '4', '#', null, null, 1, 0, 'F', '0', '0', 'system:dict:remove',         '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1030, '字典导出', @menu105, '5', '#', null, null, 1, 0, 'F', '0', '0', 'system:dict:export',         '#', 'root', sysdate(), null, null, null);
-- 参数设置按钮
select @menu1031 := replace(uuid(), '-', '');
select @menu1032 := replace(uuid(), '-', '');
select @menu1033 := replace(uuid(), '-', '');
select @menu1034 := replace(uuid(), '-', '');
select @menu1035 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1031, '参数查询', @menu106, '1', '#', null, null, 1, 0, 'F', '0', '0', 'system:config:query',        '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1032, '参数新增', @menu106, '2', '#', null, null, 1, 0, 'F', '0', '0', 'system:config:add',          '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1033, '参数修改', @menu106, '3', '#', null, null, 1, 0, 'F', '0', '0', 'system:config:edit',         '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1034, '参数删除', @menu106, '4', '#', null, null, 1, 0, 'F', '0', '0', 'system:config:remove',       '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1035, '参数导出', @menu106, '5', '#', null, null, 1, 0, 'F', '0', '0', 'system:config:export',       '#', 'root', sysdate(), null, null, null);
-- 通知公告按钮
select @menu1036 := replace(uuid(), '-', '');
select @menu1037 := replace(uuid(), '-', '');
select @menu1038 := replace(uuid(), '-', '');
select @menu1039 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1036, '公告查询', @menu107, '1', '#', null, null, 1, 0, 'F', '0', '0', 'system:notice:query',        '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1037, '公告新增', @menu107, '2', '#', null, null, 1, 0, 'F', '0', '0', 'system:notice:add',          '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1038, '公告修改', @menu107, '3', '#', null, null, 1, 0, 'F', '0', '0', 'system:notice:edit',         '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1039, '公告删除', @menu107, '4', '#', null, null, 1, 0, 'F', '0', '0', 'system:notice:remove',       '#', 'root', sysdate(), null, null, null);
-- 操作日志按钮
select @menu1040 := replace(uuid(), '-', '');
select @menu1041 := replace(uuid(), '-', '');
select @menu1042 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1040, '操作查询', @menu500, '1', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:operlog:query',      '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1041, '操作删除', @menu500, '2', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:operlog:remove',     '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1042, '日志导出', @menu500, '4', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:operlog:export',     '#', 'root', sysdate(), null, null, null);
-- 登录日志按钮
select @menu1043 := replace(uuid(), '-', '');
select @menu1044 := replace(uuid(), '-', '');
select @menu1045 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1043, '登录查询', @menu501, '1', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:logininfor:query',   '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1044, '登录删除', @menu501, '2', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:logininfor:remove',  '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1045, '日志导出', @menu501, '3', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:logininfor:export',  '#', 'root', sysdate(), null, null, null);
-- 在线用户按钮
select @menu1046 := replace(uuid(), '-', '');
select @menu1047 := replace(uuid(), '-', '');
select @menu1048 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1046, '在线查询', @menu109, '1', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:online:query',       '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1047, '批量强退', @menu109, '2', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1048, '单条强退', @menu109, '3', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'root', sysdate(), null, null, null);
-- 定时任务按钮
select @menu1049 := replace(uuid(), '-', '');
select @menu1050 := replace(uuid(), '-', '');
select @menu1051 := replace(uuid(), '-', '');
select @menu1052 := replace(uuid(), '-', '');
select @menu1053 := replace(uuid(), '-', '');
select @menu1054 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1049, '任务查询', @menu110, '1', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:job:query',          '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1050, '任务新增', @menu110, '2', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:job:add',            '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1051, '任务修改', @menu110, '3', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:job:edit',           '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1052, '任务删除', @menu110, '4', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:job:remove',         '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1053, '状态修改', @menu110, '5', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:job:changeStatus',   '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1054, '任务导出', @menu110, '7', '#', null, null, 1, 0, 'F', '0', '0', 'monitor:job:export',         '#', 'root', sysdate(), null, null, null);
-- 代码生成按钮
select @menu1055 := replace(uuid(), '-', '');
select @menu1056 := replace(uuid(), '-', '');
select @menu1057 := replace(uuid(), '-', '');
select @menu1058 := replace(uuid(), '-', '');
select @menu1059 := replace(uuid(), '-', '');
select @menu1060 := replace(uuid(), '-', '');
insert into sys_menu values(@menu1055, '生成查询', @menu115, '1', '#', null, null, 1, 0, 'F', '0', '0', 'tool:gen:query',             '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1056, '生成修改', @menu115, '2', '#', null, null, 1, 0, 'F', '0', '0', 'tool:gen:edit',              '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1057, '生成删除', @menu115, '3', '#', null, null, 1, 0, 'F', '0', '0', 'tool:gen:remove',            '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1058, '导入代码', @menu115, '2', '#', null, null, 1, 0, 'F', '0', '0', 'tool:gen:import',            '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1059, '预览代码', @menu115, '4', '#', null, null, 1, 0, 'F', '0', '0', 'tool:gen:preview',           '#', 'root', sysdate(), null, null, null);
insert into sys_menu values(@menu1060, '生成代码', @menu115, '5', '#', null, null, 1, 0, 'F', '0', '0', 'tool:gen:code',              '#', 'root', sysdate(), null, null, null);


-- ----------------------------
-- 6、用户和角色关联表  用户N-1角色
-- ----------------------------
DROP TABLE IF EXISTS sys_user_role;

CREATE TABLE sys_user_role
(
    user_id VARCHAR(32) NOT NULL COMMENT '用户ID',
    role_id VARCHAR(32) NOT NULL COMMENT '角色ID',
    PRIMARY KEY (user_id, role_id)
) ENGINE = innodb COMMENT = '用户和角色关联表';

-- ----------------------------
-- 初始化-用户和角色关联表数据
-- ----------------------------
insert into sys_user_role values ('1', '1');
insert into sys_user_role values ('2', '2');


-- ----------------------------
-- 7、角色和菜单关联表  角色1-N菜单
-- ----------------------------
DROP TABLE IF EXISTS sys_role_menu;

CREATE TABLE sys_role_menu
(
    role_id VARCHAR(32) NOT NULL COMMENT '角色ID',
    menu_id VARCHAR(32) NOT NULL COMMENT '菜单ID',
    PRIMARY KEY (role_id, menu_id)
) ENGINE = innodb COMMENT = '角色和菜单关联表';

-- ----------------------------
-- 初始化-角色和菜单关联表数据
-- ----------------------------
insert into sys_role_menu values ('2', @menu01);
insert into sys_role_menu values ('2', @menu02);
insert into sys_role_menu values ('2', @menu03);
insert into sys_role_menu values ('2', @menu04);
insert into sys_role_menu values ('2', @menu100);
insert into sys_role_menu values ('2', @menu101);
insert into sys_role_menu values ('2', @menu102);
insert into sys_role_menu values ('2', @menu103);
insert into sys_role_menu values ('2', @menu104);
insert into sys_role_menu values ('2', @menu105);
insert into sys_role_menu values ('2', @menu106);
insert into sys_role_menu values ('2', @menu107);
insert into sys_role_menu values ('2', @menu108);
insert into sys_role_menu values ('2', @menu109);
insert into sys_role_menu values ('2', @menu110);
insert into sys_role_menu values ('2', @menu111);
insert into sys_role_menu values ('2', @menu112);
insert into sys_role_menu values ('2', @menu113);
insert into sys_role_menu values ('2', @menu114);
insert into sys_role_menu values ('2', @menu115);
insert into sys_role_menu values ('2', @menu116);
insert into sys_role_menu values ('2', @menu500);
insert into sys_role_menu values ('2', @menu501);
insert into sys_role_menu values ('2', @menu1001);
insert into sys_role_menu values ('2', @menu1002);
insert into sys_role_menu values ('2', @menu1003);
insert into sys_role_menu values ('2', @menu1004);
insert into sys_role_menu values ('2', @menu1005);
insert into sys_role_menu values ('2', @menu1006);
insert into sys_role_menu values ('2', @menu1007);
insert into sys_role_menu values ('2', @menu1008);
insert into sys_role_menu values ('2', @menu1009);
insert into sys_role_menu values ('2', @menu1010);
insert into sys_role_menu values ('2', @menu1011);
insert into sys_role_menu values ('2', @menu1012);
insert into sys_role_menu values ('2', @menu1013);
insert into sys_role_menu values ('2', @menu1014);
insert into sys_role_menu values ('2', @menu1015);
insert into sys_role_menu values ('2', @menu1016);
insert into sys_role_menu values ('2', @menu1017);
insert into sys_role_menu values ('2', @menu1018);
insert into sys_role_menu values ('2', @menu1019);
insert into sys_role_menu values ('2', @menu1020);
insert into sys_role_menu values ('2', @menu1021);
insert into sys_role_menu values ('2', @menu1022);
insert into sys_role_menu values ('2', @menu1023);
insert into sys_role_menu values ('2', @menu1024);
insert into sys_role_menu values ('2', @menu1025);
insert into sys_role_menu values ('2', @menu1026);
insert into sys_role_menu values ('2', @menu1027);
insert into sys_role_menu values ('2', @menu1028);
insert into sys_role_menu values ('2', @menu1029);
insert into sys_role_menu values ('2', @menu1030);
insert into sys_role_menu values ('2', @menu1031);
insert into sys_role_menu values ('2', @menu1032);
insert into sys_role_menu values ('2', @menu1033);
insert into sys_role_menu values ('2', @menu1034);
insert into sys_role_menu values ('2', @menu1035);
insert into sys_role_menu values ('2', @menu1036);
insert into sys_role_menu values ('2', @menu1037);
insert into sys_role_menu values ('2', @menu1038);
insert into sys_role_menu values ('2', @menu1039);
insert into sys_role_menu values ('2', @menu1040);
insert into sys_role_menu values ('2', @menu1041);
insert into sys_role_menu values ('2', @menu1042);
insert into sys_role_menu values ('2', @menu1043);
insert into sys_role_menu values ('2', @menu1044);
insert into sys_role_menu values ('2', @menu1045);
insert into sys_role_menu values ('2', @menu1046);
insert into sys_role_menu values ('2', @menu1047);
insert into sys_role_menu values ('2', @menu1048);
insert into sys_role_menu values ('2', @menu1049);
insert into sys_role_menu values ('2', @menu1050);
insert into sys_role_menu values ('2', @menu1051);
insert into sys_role_menu values ('2', @menu1052);
insert into sys_role_menu values ('2', @menu1053);
insert into sys_role_menu values ('2', @menu1054);
insert into sys_role_menu values ('2', @menu1055);
insert into sys_role_menu values ('2', @menu1056);
insert into sys_role_menu values ('2', @menu1057);
insert into sys_role_menu values ('2', @menu1058);
insert into sys_role_menu values ('2', @menu1059);
insert into sys_role_menu values ('2', @menu1060);

-- ----------------------------
-- 8、角色和部门关联表  角色1-N部门
-- ----------------------------
DROP TABLE IF EXISTS sys_role_dept;

CREATE TABLE sys_role_dept
(
    role_id VARCHAR(32) NOT NULL COMMENT '角色ID',
    dept_id VARCHAR(32) NOT NULL COMMENT '部门ID',
    PRIMARY KEY (role_id, dept_id)
) ENGINE = innodb COMMENT = '角色和部门关联表';

-- ----------------------------
-- 初始化-角色和部门关联表数据
-- ----------------------------
insert into sys_role_dept values ('2', @menu100);
insert into sys_role_dept values ('2', @menu101);
insert into sys_role_dept values ('2', @menu105);


-- ----------------------------
-- 9、用户与岗位关联表  用户1-N岗位
-- ----------------------------
DROP TABLE IF EXISTS sys_user_post;

CREATE TABLE sys_user_post
(
    user_id VARCHAR(32) NOT NULL COMMENT '用户ID',
    post_id VARCHAR(32) NOT NULL COMMENT '岗位ID',
    PRIMARY KEY (user_id, post_id)
) ENGINE = innodb COMMENT = '用户与岗位关联表';

-- ----------------------------
-- 初始化-用户与岗位关联表数据
-- ----------------------------
insert into sys_user_post values ('1', '1');
insert into sys_user_post values ('2', '2');


-- ----------------------------
-- 10、操作日志记录
-- ----------------------------
DROP TABLE IF EXISTS sys_oper_log;

CREATE TABLE sys_oper_log
(
    id             VARCHAR(32) NOT NULL COMMENT '日志主键',
    title          VARCHAR(50)          DEFAULT NULL COMMENT '模块标题',
    business_type  INT(2)               DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
    method         VARCHAR(100)         DEFAULT NULL COMMENT '方法名称',
    request_method VARCHAR(10)          DEFAULT NULL COMMENT '请求方式',
    operator_type  INT(1)               DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
    oper_name      VARCHAR(50)          DEFAULT NULL COMMENT '操作人员',
    dept_name      VARCHAR(50)          DEFAULT NULL COMMENT '部门名称',
    oper_url       VARCHAR(255)         DEFAULT NULL COMMENT '请求URL',
    oper_ip        VARCHAR(128)         DEFAULT NULL COMMENT '主机地址',
    oper_location  VARCHAR(255)         DEFAULT NULL COMMENT '操作地点',
    oper_param     VARCHAR(2000)        DEFAULT NULL COMMENT '请求参数',
    json_result    VARCHAR(2000)        DEFAULT NULL COMMENT '返回参数',
    status         INT(1)               DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
    error_msg      VARCHAR(2000)        DEFAULT NULL COMMENT '错误消息',
    oper_time      DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '操作时间',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 100 COMMENT = '操作日志记录';


-- ----------------------------
-- 11、字典类型表
-- ----------------------------
DROP TABLE IF EXISTS sys_dict_type;

CREATE TABLE sys_dict_type
(
    id          VARCHAR(32) NOT NULL COMMENT '字典主键',
    dict_name   VARCHAR(100)         DEFAULT '' COMMENT '字典名称',
    dict_type   VARCHAR(100)         DEFAULT '' COMMENT '字典类型',
    status      CHAR(1)              DEFAULT '0' COMMENT '状态（0正常 1停用）',
    create_by   VARCHAR(32)          DEFAULT NULL COMMENT '创建者',
    create_time DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by   VARCHAR(32)          DEFAULT NULL COMMENT '更新者',
    update_time DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark      VARCHAR(500)         DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id),
    UNIQUE (dict_type)
) ENGINE = innodb
  AUTO_INCREMENT = 100 COMMENT = '字典类型表';


insert into sys_dict_type values(replace(uuid(), '-', ''),  '用户性别', 'sys_user_sex',        '0', 'root', sysdate(), null, null, '用户性别列表');
insert into sys_dict_type values(replace(uuid(), '-', ''),  '菜单状态', 'sys_show_hide',       '0', 'root', sysdate(), null, null, '菜单状态列表');
insert into sys_dict_type values(replace(uuid(), '-', ''),  '系统开关', 'sys_normal_disable',  '0', 'root', sysdate(), null, null, '系统开关列表');
insert into sys_dict_type values(replace(uuid(), '-', ''),  '任务状态', 'sys_job_status',      '0', 'root', sysdate(), null, null, '任务状态列表');
insert into sys_dict_type values(replace(uuid(), '-', ''),  '任务分组', 'sys_job_group',       '0', 'root', sysdate(), null, null, '任务分组列表');
insert into sys_dict_type values(replace(uuid(), '-', ''),  '系统是否', 'sys_yes_no',          '0', 'root', sysdate(), null, null, '系统是否列表');
insert into sys_dict_type values(replace(uuid(), '-', ''),  '通知类型', 'sys_notice_type',     '0', 'root', sysdate(), null, null, '通知类型列表');
insert into sys_dict_type values(replace(uuid(), '-', ''),  '通知状态', 'sys_notice_status',   '0', 'root', sysdate(), null, null, '通知状态列表');
insert into sys_dict_type values(replace(uuid(), '-', ''),  '操作类型', 'sys_oper_type',       '0', 'root', sysdate(), null, null, '操作类型列表');
insert into sys_dict_type values(replace(uuid(), '-', ''),  '系统状态', 'sys_common_status',   '0', 'root', sysdate(), null, null, '登录状态列表');


-- ----------------------------
-- 12、字典数据表
-- ----------------------------
DROP TABLE IF EXISTS sys_dict_data;

CREATE TABLE sys_dict_data
(
    dict_code   VARCHAR(32) NOT NULL COMMENT '字典编码',
    dict_sort   INT(4)               DEFAULT 0 COMMENT '字典排序',
    dict_label  VARCHAR(100)         DEFAULT NULL COMMENT '字典标签',
    dict_value  VARCHAR(100)         DEFAULT NULL COMMENT '字典键值',
    dict_type   VARCHAR(100)         DEFAULT NULL COMMENT '字典类型',
    css_class   VARCHAR(100)         DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
    list_class  VARCHAR(100)         DEFAULT NULL COMMENT '表格回显样式',
    is_default  CHAR(1)              DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
    status      CHAR(1)              DEFAULT '0' COMMENT '状态（0正常 1停用）',
    create_by   VARCHAR(32)          DEFAULT NULL COMMENT '创建者',
    create_time DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by   VARCHAR(32)          DEFAULT NULL COMMENT '更新者',
    update_time DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark      VARCHAR(500)         DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (dict_code)
) ENGINE = innodb
  AUTO_INCREMENT = 100 COMMENT = '字典数据表';

insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '未知',     '0',      'sys_user_sex',        null,   null,      'Y', '0', 'root', sysdate(), null, null, '性别男');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '男',       '1',      'sys_user_sex',        null,   null,      'N', '0', 'root', sysdate(), null, null, '性别女');
insert into sys_dict_data values(replace(uuid(), '-', ''), 3,  '女',       '2',      'sys_user_sex',        null,   null,      'N', '0', 'root', sysdate(), null, null, '性别未知');
insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '显示',     '0',      'sys_show_hide',       null,   'primary', 'Y', '0', 'root', sysdate(), null, null, '显示菜单');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '隐藏',     '1',      'sys_show_hide',       null,   'danger',  'N', '0', 'root', sysdate(), null, null, '隐藏菜单');
insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '正常',     '0',      'sys_normal_disable',  null,   'primary', 'Y', '0', 'root', sysdate(), null, null, '正常状态');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '停用',     '1',      'sys_normal_disable',  null,   'danger',  'N', '0', 'root', sysdate(), null, null, '停用状态');
insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '正常',     '0',      'sys_job_status',      null,   'primary', 'Y', '0', 'root', sysdate(), null, null, '正常状态');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '暂停',     '1',      'sys_job_status',      null,   'danger',  'N', '0', 'root', sysdate(), null, null, '停用状态');
insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '默认',    'DEFAULT', 'sys_job_group',       null,   null,      'Y', '0', 'root', sysdate(), null, null, '默认分组');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '系统',    'SYSTEM',  'sys_job_group',       null,   null,      'N', '0', 'root', sysdate(), null, null, '系统分组');
insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '是',      'Y',       'sys_yes_no',          null,   'primary', 'Y', '0', 'root', sysdate(), null, null, '系统默认是');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '否',      'N',       'sys_yes_no',          null,   'danger',  'N', '0', 'root', sysdate(), null, null, '系统默认否');
insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '通知',    '1',       'sys_notice_type',     null,   'warning', 'Y', '0', 'root', sysdate(), null, null, '通知');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '公告',    '2',       'sys_notice_type',     null,   'success', 'N', '0', 'root', sysdate(), null, null, '公告');
insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '正常',    '0',       'sys_notice_status',   null,   'primary', 'Y', '0', 'root', sysdate(), null, null, '正常状态');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '关闭',    '1',       'sys_notice_status',   null,   'danger',  'N', '0', 'root', sysdate(), null, null, '关闭状态');
insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '新增',    '1',       'sys_oper_type',       null,   'info',    'N', '0', 'root', sysdate(), null, null, '新增操作');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '修改',    '2',       'sys_oper_type',       null,   'info',    'N', '0', 'root', sysdate(), null, null, '修改操作');
insert into sys_dict_data values(replace(uuid(), '-', ''), 3,  '删除',    '3',       'sys_oper_type',       null,   'danger',  'N', '0', 'root', sysdate(), null, null, '删除操作');
insert into sys_dict_data values(replace(uuid(), '-', ''), 4,  '授权',    '4',       'sys_oper_type',       null,   'primary', 'N', '0', 'root', sysdate(), null, null, '授权操作');
insert into sys_dict_data values(replace(uuid(), '-', ''), 5,  '导出',    '5',       'sys_oper_type',       null,   'warning', 'N', '0', 'root', sysdate(), null, null, '导出操作');
insert into sys_dict_data values(replace(uuid(), '-', ''), 6,  '导入',    '6',       'sys_oper_type',       null,   'warning', 'N', '0', 'root', sysdate(), null, null, '导入操作');
insert into sys_dict_data values(replace(uuid(), '-', ''), 7,  '强退',    '7',       'sys_oper_type',       null,   'danger',  'N', '0', 'root', sysdate(), null, null, '强退操作');
insert into sys_dict_data values(replace(uuid(), '-', ''), 8,  '生成代码', '8',       'sys_oper_type',       null,   'warning', 'N', '0', 'root', sysdate(), null, null, '生成操作');
insert into sys_dict_data values(replace(uuid(), '-', ''), 9,  '清空数据', '9',       'sys_oper_type',       null,   'danger',  'N', '0', 'root', sysdate(), null, null, '清空操作');
insert into sys_dict_data values(replace(uuid(), '-', ''), 1,  '成功',    '0',       'sys_common_status',   null,   'primary', 'N', '0', 'root', sysdate(), null, null, '正常状态');
insert into sys_dict_data values(replace(uuid(), '-', ''), 2,  '失败',    '1',       'sys_common_status',   null,   'danger',  'N', '0', 'root', sysdate(), null, null, '停用状态');


-- ----------------------------
-- 13、参数配置表
-- ----------------------------
DROP TABLE IF EXISTS sys_config;

CREATE TABLE sys_config
(
    id           VARCHAR(32) NOT NULL COMMENT '参数主键',
    config_name  VARCHAR(100)         DEFAULT '' COMMENT '参数名称',
    config_key   VARCHAR(100)         DEFAULT '' COMMENT '参数键名',
    config_value VARCHAR(500)         DEFAULT '' COMMENT '参数键值',
    config_type  CHAR(1)              DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
    create_by    VARCHAR(32)          DEFAULT NULL COMMENT '创建者',
    create_time  DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by    VARCHAR(32)          DEFAULT NULL COMMENT '更新者',
    update_time  DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark       VARCHAR(500)         DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 100 COMMENT = '参数配置表';

insert into sys_config values(replace(uuid(), '-', ''), '主框架页-默认皮肤样式名称',     'sys.index.skinName',       'skin-blue',  'Y', 'root', sysdate(), null, null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow' );
insert into sys_config values(replace(uuid(), '-', ''), '用户管理-账号初始密码',        'sys.user.initPassword',    '123456',     'Y', 'root', sysdate(), null, null, '初始化密码 123456' );
insert into sys_config values(replace(uuid(), '-', ''), '主框架页-侧边栏主题',          'sys.index.sideTheme',      'theme-dark', 'Y', 'root', sysdate(), null, null, '深色主题theme-dark，浅色主题theme-light' );
insert into sys_config values(replace(uuid(), '-', ''), '账号自助-验证码开关',          'sys.account.captchaOnOff', 'true',       'Y', 'root', sysdate(), null, null, '是否开启验证码功能（true开启，false关闭）');
insert into sys_config values(replace(uuid(), '-', ''), '账号自助-是否开启用户注册功能', 'sys.account.registerUser',  'false',      'Y', 'root', sysdate(), null, null, '是否开启注册用户功能（true开启，false关闭）');


-- ----------------------------
-- 14、系统访问记录
-- ----------------------------
DROP TABLE IF EXISTS sys_logininfor;

CREATE TABLE sys_logininfor
(
    id             VARCHAR(32) NOT NULL COMMENT '访问ID',
    user_name      VARCHAR(50)  DEFAULT NULL COMMENT '用户账号',
    ipaddr         VARCHAR(128) DEFAULT NULL COMMENT '登录IP地址',
    login_location VARCHAR(255) DEFAULT NULL COMMENT '登录地点',
    browser        VARCHAR(50)  DEFAULT NULL COMMENT '浏览器类型',
    os             VARCHAR(50)  DEFAULT NULL COMMENT '操作系统',
    status         CHAR(1)      DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
    msg            VARCHAR(255) DEFAULT NULL COMMENT '提示消息',
    login_time     DATETIME COMMENT '访问时间',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 100 COMMENT = '系统访问记录';


-- ----------------------------
-- 15、定时任务调度表
-- ----------------------------
DROP TABLE IF EXISTS sys_job;

CREATE TABLE sys_job
(
    id              VARCHAR(32)  NOT NULL COMMENT '任务ID',
    job_name        VARCHAR(64)  NOT NULL COMMENT '任务名称',
    job_group       VARCHAR(64)           DEFAULT 'DEFAULT' COMMENT '任务组名',
    invoke_target   VARCHAR(500) NOT NULL COMMENT '调用目标字符串',
    cron_expression VARCHAR(255)          DEFAULT NULL COMMENT 'cron执行表达式',
    misfire_policy  VARCHAR(20)           DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
    concurrent      CHAR(1)               DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
    status          CHAR(1)               DEFAULT '0' COMMENT '状态（0正常 1暂停）',
    create_by       VARCHAR(32)           DEFAULT NULL COMMENT '创建者',
    create_time     DATETIME     NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by       VARCHAR(32)           DEFAULT NULL COMMENT '更新者',
    update_time     DATETIME              DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark          VARCHAR(500)          DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (id, job_name, job_group)
) ENGINE = innodb
  AUTO_INCREMENT = 100 COMMENT = '定时任务调度表';

insert into sys_job values(replace(uuid(), '-', ''), '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams',                                           '0/10 * * * * ?', '3', '1', '1', 'root', sysdate(), null, null, null);
insert into sys_job values(replace(uuid(), '-', ''), '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')',                                     '0/15 * * * * ?', '3', '1', '1', 'root', sysdate(), null, null, null);
insert into sys_job values(replace(uuid(), '-', ''), '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)',  '0/20 * * * * ?', '3', '1', '1', 'root', sysdate(), null, null, null);


-- ----------------------------
-- 16、定时任务调度日志表
-- ----------------------------
DROP TABLE IF EXISTS sys_job_log;

CREATE TABLE sys_job_log
(
    id             VARCHAR(32)  NOT NULL COMMENT '任务日志ID',
    job_name       VARCHAR(64)  NOT NULL COMMENT '任务名称',
    job_group      VARCHAR(64)  NOT NULL COMMENT '任务组名',
    invoke_target  VARCHAR(500) NOT NULL COMMENT '调用目标字符串',
    job_message    VARCHAR(500)          DEFAULT NULL COMMENT '日志信息',
    status         CHAR(1)               DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
    exception_info VARCHAR(2000)         DEFAULT NULL COMMENT '异常信息',
    create_time    DATETIME     NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    PRIMARY KEY (id)
) ENGINE = innodb COMMENT = '定时任务调度日志表';


-- ----------------------------
-- 17、通知公告表
-- ----------------------------
DROP TABLE IF EXISTS sys_notice;

CREATE TABLE sys_notice
(
    id             VARCHAR(32) NOT NULL COMMENT '公告ID',
    notice_title   VARCHAR(50) NOT NULL COMMENT '公告标题',
    notice_type    CHAR(1)     NOT NULL COMMENT '公告类型（1通知 2公告）',
    notice_content LONGBLOB             DEFAULT NULL COMMENT '公告内容',
    status         CHAR(1)              DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
    create_by      VARCHAR(32)          DEFAULT NULL COMMENT '创建者',
    create_time    DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by      VARCHAR(32)          DEFAULT NULL COMMENT '更新者',
    update_time    DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark         VARCHAR(255)         DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 10 COMMENT = '通知公告表';

-- ----------------------------
-- 初始化-公告信息表数据
-- ----------------------------
insert into sys_notice values('1', '温馨提醒：2018-07-01 若依新版本发布啦', '2', '新版本内容', '0', 'root', sysdate(), null, null, '管理员');
insert into sys_notice values('2', '维护通知：2018-07-01 若依系统凌晨维护', '1', '维护内容',   '0', 'root', sysdate(), null, null, '管理员');


-- ----------------------------
-- 18、代码生成业务表
-- ----------------------------
DROP TABLE IF EXISTS gen_table;

CREATE TABLE gen_table
(
    id                VARCHAR(32) NOT NULL COMMENT '编号',
    table_name        VARCHAR(200)         DEFAULT NULL COMMENT '表名称',
    table_comment     VARCHAR(500)         DEFAULT NULL COMMENT '表描述',
    sub_table_name    VARCHAR(64)          DEFAULT NULL COMMENT '关联子表的表名',
    sub_table_fk_name VARCHAR(64)          DEFAULT NULL COMMENT '子表关联的外键名',
    class_name        VARCHAR(100)         DEFAULT NULL COMMENT '实体类名称',
    tpl_category      VARCHAR(200)         DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
    package_name      VARCHAR(100)         DEFAULT NULL COMMENT '生成包路径',
    module_name       VARCHAR(30)          DEFAULT NULL COMMENT '生成模块名',
    business_name     VARCHAR(30)          DEFAULT NULL COMMENT '生成业务名',
    function_name     VARCHAR(50)          DEFAULT NULL COMMENT '生成功能名',
    function_author   VARCHAR(50)          DEFAULT NULL COMMENT '生成功能作者',
    gen_type          CHAR(1)              DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
    gen_path          VARCHAR(200)         DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
    options           VARCHAR(1000)        DEFAULT NULL COMMENT '其它生成选项',
    create_by         VARCHAR(32)          DEFAULT NULL COMMENT '创建者',
    create_time       DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by         VARCHAR(32)          DEFAULT NULL COMMENT '更新者',
    update_time       DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    remark            VARCHAR(500)         DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 1 COMMENT = '代码生成业务表';


-- ----------------------------
-- 19、代码生成业务表字段
-- ----------------------------
DROP TABLE IF EXISTS gen_table_column;

CREATE TABLE gen_table_column
(
    id             VARCHAR(32) NOT NULL COMMENT '编号',
    table_id       VARCHAR(32)          DEFAULT NULL COMMENT '归属表编号',
    column_name    VARCHAR(200)         DEFAULT NULL COMMENT '列名称',
    column_comment VARCHAR(500)         DEFAULT NULL COMMENT '列描述',
    column_type    VARCHAR(100)         DEFAULT NULL COMMENT '列类型',
    java_type      VARCHAR(500)         DEFAULT NULL COMMENT 'JAVA类型',
    java_field     VARCHAR(200)         DEFAULT NULL COMMENT 'JAVA字段名',
    is_pk          CHAR(1)              DEFAULT '0' COMMENT '是否主键（1是）',
    is_increment   CHAR(1)              DEFAULT '0' COMMENT '是否自增（1是）',
    is_required    CHAR(1)              DEFAULT '0' COMMENT '是否必填（1是）',
    is_insert      CHAR(1)              DEFAULT '0' COMMENT '是否为插入字段（1是）',
    is_edit        CHAR(1)              DEFAULT '0' COMMENT '是否编辑字段（1是）',
    is_list        CHAR(1)              DEFAULT '0' COMMENT '是否列表字段（1是）',
    is_query       CHAR(1)              DEFAULT '0' COMMENT '是否查询字段（1是）',
    query_type     VARCHAR(200)         DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
    html_type      VARCHAR(200)         DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
    dict_type      VARCHAR(200)         DEFAULT NULL COMMENT '字典类型',
    sort           INT                  DEFAULT 0 COMMENT '排序',
    create_by      VARCHAR(32)          DEFAULT NULL COMMENT '创建者',
    create_time    DATETIME    NOT NULL DEFAULT current_timestamp COMMENT '创建时间',
    update_by      VARCHAR(32)          DEFAULT NULL COMMENT '更新者',
    update_time    DATETIME             DEFAULT NULL ON UPDATE current_timestamp COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = innodb
  AUTO_INCREMENT = 1 COMMENT = '代码生成业务表字段';


-- ----------------------------
-- 20、App用户信息表
-- ----------------------------
DROP TABLE IF EXISTS app_user;

CREATE TABLE `app_user` (
    `id` varchar(32) NOT NULL COMMENT '用户ID',
    `nick_name` varchar(30) DEFAULT NULL COMMENT '用户昵称',
    `email` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
    `tel` varchar(11) NOT NULL COMMENT '手机号码',
    `card_id` varchar(50) DEFAULT NULL COMMENT '证件号码',
    `sex` char(1) DEFAULT '0' COMMENT '用户性别（0未知 1男 2女）',
    `avatar` varchar(100) DEFAULT NULL COMMENT '头像地址',
    `password` varchar(100) DEFAULT NULL COMMENT '密码',
    `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
    `login_ip` varchar(128) DEFAULT NULL COMMENT '最后登录IP',
    `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
    `create_by` varchar(32) DEFAULT NULL COMMENT '创建者',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新者',
    `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `remark` varchar(500) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `idx_app_user_tel` (`tel`) USING BTREE COMMENT '手机号码唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='App用户信息表';