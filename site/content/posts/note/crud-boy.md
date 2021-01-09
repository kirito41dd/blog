---
title: "crud boy"
date: 2020-11-30T11:13:17+08:00
categories: ["note"]
tags: ["sql"]
featuredImage: ""
featuredImagePreview: ""
draft: true
---

总结下工作中学习到的新姿势

## sql

* 直接在查询结果中增加字段
```sql
SELECT *, 123 AS my FROM `table_name` LIMIT 1
``` 


* 利用冲突做大批量更新操作(张金柱大佬亲传)
    * 这样可以拼sql,一次更新多列为自定义🈯值
    * 场景是，查询到很多数据，更新字段值，写回db
    * 至少需要拿到冲突字段，这里是`id`
```sql
INSERT INTO `users` (id, name) VALUES (1, "jinzhu1"), (2, "jinzhu2") ON DUPLICATE KEY UPDATE `name`=VALUES(name)
```


* 表中所有字段必须都是 `NOT NULL` 属性。因为使用 `NULL` 值会存在每一行都会占用额外存储空间、数据迁移容易出错、聚合函数计算结果偏差等问题

* mysql中字符串类型索引查询时必须加引号，不然不会使用索引。原因是不支持函数索引，不加引号会使用了cast函数做隐式类型转换。

## es
* es创建mapping踩坑,`text`会把索引字段分词，搜索用match而不能用term，`keyword`不会进行分词