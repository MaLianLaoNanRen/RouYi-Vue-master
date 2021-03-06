## 简介

### 基于若依开源框架做一些修改，具体任务如下：
- [X] 实体类引入Lombok依赖的相关注释
- [X] 添加持久层注释和去除方法前的public
- [X] 消除idea编译器的各种警告
- [X] 表ID改为32位的UUID
- [X] 去除逻辑删除相关字段
- [X] 创建者和更新者改为存对应用户的ID
- [X] 表的创建时间和更新时间改为数据库自动操作
- [X] 后台管理页面增加数字序号
- [X] 去除查询字典键值对时状态为停用的判断
- [X] 前端添加和修改页面对字典键值对做状态判断，停用的变为不可选
- [X] 增加App用户信息表
- [X] 增加xml文件id字段的判断（表的主键必须用'id'这个名称）不然生成的xml插入语句要自己修改