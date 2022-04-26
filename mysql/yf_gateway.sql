/*
Navicat MySQL Data Transfer

Source Server         : 长沙停车场-230
Source Server Version : 50626
Source Host           : 192.168.80.230:3306
Source Database       : yf_gateway

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2022-04-20 11:07:22
*/

CREATE DATABASE IF NOT EXISTS yf_gateway;

CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'; 
FLUSH PRIVILEGES;

SET FOREIGN_KEY_CHECKS=0;
use yf_gateway;
-- ----------------------------
-- Table structure for pt_car
-- ----------------------------
DROP TABLE IF EXISTS `pt_car`;
CREATE TABLE `pt_car` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(50) DEFAULT '' COMMENT '车牌号码或临时车牌号码',
  `is_temp_number` tinyint(1) DEFAULT '0' COMMENT '是否是临时车牌（临时车牌是针对无牌车临时生成的车牌号）',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `last_smartpark_id` int(11) DEFAULT '0' COMMENT '最后进的园区id',
  `last_upd_time` int(11) DEFAULT '0' COMMENT '最后进园区更新的时间',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `number` (`number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18312 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='停车场--车';

-- ----------------------------
-- Table structure for pt_car_car_owner
-- ----------------------------
DROP TABLE IF EXISTS `pt_car_car_owner`;
CREATE TABLE `pt_car_car_owner` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `car_id` int(11) DEFAULT '0' COMMENT '是否是黑车',
  `car_owner_id` int(11) DEFAULT '0' COMMENT '车主ID',
  `car_type_id` int(11) DEFAULT '0' COMMENT '车辆类型ID',
  `is_induct_wxpay` tinyint(1) DEFAULT '0' COMMENT '是否开通微信无感支付',
  `induct_time` int(11) DEFAULT '0' COMMENT '授权开通无感支付的时间',
  `contract_id` varchar(50) DEFAULT '' COMMENT '微信委托代扣协议id（开通了无感支付才会有值）',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `smartpark_id` (`smartpark_id`,`car_id`,`car_owner_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='停车场--园区、车和车主关联的表（目前园区ID都为0）';

-- ----------------------------
-- Table structure for pt_car_owner
-- ----------------------------
DROP TABLE IF EXISTS `pt_car_owner`;
CREATE TABLE `pt_car_owner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wx_open_id` varchar(50) DEFAULT '' COMMENT '微信openid',
  `ali_open_id` varchar(50) DEFAULT '' COMMENT '支付宝openid',
  `user_id` int(11) DEFAULT '0' COMMENT '用户ID',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='停车场--临时车车主信息表\r\n';

-- ----------------------------
-- Table structure for pt_gateway_log
-- ----------------------------
DROP TABLE IF EXISTS `pt_gateway_log`;
CREATE TABLE `pt_gateway_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `params` text COMMENT '接口参数',
  `action` varchar(100) DEFAULT '' COMMENT '接口地址',
  `reply` text COMMENT '回应',
  `type` varchar(100) DEFAULT '' COMMENT '类型',
  `log_type` varchar(100) DEFAULT '' COMMENT '日志类型 http pulsar_consumer pulsar_producer等',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=572928 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pt_nav_camera_led
-- ----------------------------
DROP TABLE IF EXISTS `pt_nav_camera_led`;
CREATE TABLE `pt_nav_camera_led` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `parkinglot_id` int(11) DEFAULT '0' COMMENT '停车场ID',
  `camera_number` varchar(50) NOT NULL DEFAULT '' COMMENT '导航相机sn',
  `led_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'led显示屏ID',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `is_del` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除了: 0-否，1-是',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='导航相机和led显示屏绑定关系';

-- ----------------------------
-- Table structure for pt_nav_led
-- ----------------------------
DROP TABLE IF EXISTS `pt_nav_led`;
CREATE TABLE `pt_nav_led` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smartpark_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '园区ID',
  `parkinglot_id` int(11) DEFAULT '0' COMMENT '停车场ID',
  `led_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'led显示屏ID',
  `building_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '楼宇ID',
  `nav_ptag_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '楼宇-车位分组id',
  `path_desc` varchar(50) NOT NULL DEFAULT '' COMMENT '路径描述（led到楼宇的导航路径描述）',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `is_del` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除了: 0-否，1-是',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COMMENT='led显示屏和楼宇绑定关系';

-- ----------------------------
-- Table structure for pt_nav_ptag
-- ----------------------------
DROP TABLE IF EXISTS `pt_nav_ptag`;
CREATE TABLE `pt_nav_ptag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smartpark_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '园区ID',
  `parkinglot_id` int(11) DEFAULT '0' COMMENT '停车场ID',
  `building_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '楼宇ID',
  `name` varchar(500) NOT NULL DEFAULT '' COMMENT '分组名',
  `parking_ids` text NOT NULL COMMENT '车位ids',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `is_del` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除了: 0-否，1-是',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序，优先级，越大优先级越高',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='楼宇绑定车位分组绑定关系';

-- ----------------------------
-- Table structure for pt_parking
-- ----------------------------
DROP TABLE IF EXISTS `pt_parking`;
CREATE TABLE `pt_parking` (
  `id` int(11) unsigned NOT NULL,
  `smartpark_id` int(11) unsigned DEFAULT '0' COMMENT '园区ID',
  `parkinglot_id` int(11) unsigned DEFAULT '0' COMMENT '停车场ID',
  `num` int(11) DEFAULT '0' COMMENT '辅助字段',
  `number` varchar(50) DEFAULT '' COMMENT '车位编号',
  `car_id` int(11) unsigned DEFAULT '0' COMMENT '车ID：使用专用车位的车子',
  `is_special` tinyint(1) unsigned DEFAULT '0' COMMENT '是否专用车位 (0:临时车位,1:专用车位)',
  `add_time` int(11) unsigned DEFAULT '0' COMMENT '添加时间',
  `floor` char(12) DEFAULT '1' COMMENT '楼层',
  `area` char(12) DEFAULT '' COMMENT '区域',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  `status` tinyint(4) DEFAULT '0' COMMENT '停车状态:0=空闲,1=已预定,2=已停车',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='停车场--停车位';

-- ----------------------------
-- Table structure for pt_parking_camera
-- ----------------------------
DROP TABLE IF EXISTS `pt_parking_camera`;
CREATE TABLE `pt_parking_camera` (
  `id` int(11) NOT NULL,
  `camera_id` int(11) DEFAULT '0' COMMENT '车位相机ID',
  `camera_name` varchar(300) DEFAULT '' COMMENT '相机名称',
  `camera_number` varchar(50) DEFAULT '' COMMENT '车位相机设备编号',
  `parking_id` int(11) DEFAULT '0' COMMENT '停车位ID',
  `index` int(11) DEFAULT '0' COMMENT '索引位置，如1，2，3',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `is_del` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除了: 0-否，1-是',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `parkinglot_id` int(11) DEFAULT '0' COMMENT '停车场id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='本地车位和车位相机绑定关系';

-- ----------------------------
-- Table structure for pt_parking_detector
-- ----------------------------
DROP TABLE IF EXISTS `pt_parking_detector`;
CREATE TABLE `pt_parking_detector` (
  `id` int(11) NOT NULL,
  `detector_id` int(11) DEFAULT '0' COMMENT '车位相机ID',
  `detector_name` varchar(300) DEFAULT '' COMMENT '相机名称',
  `detector_number` varchar(50) DEFAULT '' COMMENT '车位相机设备编号',
  `detector_alias` varchar(50) DEFAULT '' COMMENT '网关+别名',
  `parking_id` int(11) DEFAULT '0' COMMENT '停车位ID',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `is_del` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除了: 0-否，1-是',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `parkinglot_id` int(11) DEFAULT '0' COMMENT '停车场id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='本地车位和车位探测器绑定关系';

-- ----------------------------
-- Table structure for sp_building_member
-- ----------------------------
DROP TABLE IF EXISTS `sp_building_member`;
CREATE TABLE `sp_building_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smartpark_id` int(11) NOT NULL DEFAULT '0' COMMENT '园区ID',
  `parkinglot_id` int(11) NOT NULL DEFAULT '0' COMMENT '停车场ID',
  `user_id` int(11) DEFAULT '0' COMMENT '用户ID',
  `company_id` int(11) DEFAULT '0' COMMENT '公司ID',
  `building_id` int(11) DEFAULT '0' COMMENT '楼栋ID',
  `building_name` varchar(55) DEFAULT '' COMMENT '楼栋名称',
  `floor` int(11) DEFAULT '0' COMMENT '楼层',
  `room_id` int(11) DEFAULT '0' COMMENT '房间ID',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='楼栋成员';

-- ----------------------------
-- Table structure for sp_led
-- ----------------------------
DROP TABLE IF EXISTS `sp_led`;
CREATE TABLE `sp_led` (
  `id` int(11) NOT NULL COMMENT 'led设备ID',
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `name` varchar(300) DEFAULT '' COMMENT '设备名称',
  `number` varchar(50) DEFAULT '' COMMENT '设备序列号',
  `sn` varchar(50) DEFAULT '' COMMENT 'LED SN',
  `gateway_sn` varchar(255) DEFAULT '' COMMENT '网关SN',
  `gateway_name` varchar(300) DEFAULT '' COMMENT '网关名称',
  `config` text COMMENT '配置信息（亮度等），json格式',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `is_del` tinyint(11) DEFAULT '0' COMMENT '是否删除',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  `is_sync` tinyint(1) DEFAULT '0' COMMENT '是否已同步到ledStruct',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='停车场--设备表';

-- ----------------------------
-- Table structure for sp_led_area
-- ----------------------------
DROP TABLE IF EXISTS `sp_led_area`;
CREATE TABLE `sp_led_area` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'Led显示屏ID',
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `area_config` text COMMENT '区域配置信息',
  `area_data` text COMMENT '模板各区域绑定的数据源，json格式',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  `is_sync` tinyint(4) DEFAULT '0' COMMENT '是否已同步到LedShow',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Led显示屏和模板的关联信息';

-- ----------------------------
-- Table structure for sp_led_config
-- ----------------------------
DROP TABLE IF EXISTS `sp_led_config`;
CREATE TABLE `sp_led_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `value` text NOT NULL COMMENT '配置值',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '配置类型',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `time_version` int(11) DEFAULT '0' COMMENT '版本时间戳',
  PRIMARY KEY (`id`),
  KEY `type` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='led屏，通用配置表';

-- ----------------------------
-- Table structure for sp_led_push_log
-- ----------------------------
DROP TABLE IF EXISTS `sp_led_push_log`;
CREATE TABLE `sp_led_push_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `led_id` int(11) DEFAULT '0' COMMENT 'LED显示屏ID',
  `led_number` varchar(50) DEFAULT '' COMMENT 'Led显示屏序列号',
  `request_url` varchar(255) DEFAULT '' COMMENT '请求地址',
  `request_content` text COMMENT '请求内容',
  `request_time` bigint(20) DEFAULT '0' COMMENT '请求时间',
  `response_content` text COMMENT '响应内容',
  `response_time` bigint(20) DEFAULT '0' COMMENT '响应时间',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type` (`led_number`,`request_url`),
  KEY `add_time` (`add_time`)
) ENGINE=InnoDB AUTO_INCREMENT=231095 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Led屏推送日志';

-- ----------------------------
-- Table structure for st_pit
-- ----------------------------
DROP TABLE IF EXISTS `st_pit`;
CREATE TABLE `st_pit` (
  `id` int(11) NOT NULL,
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `name` varchar(50) DEFAULT '' COMMENT '名称',
  `toilet_id` int(11) DEFAULT '0' COMMENT '厕所ID',
  `device_id` int(11) DEFAULT '0' COMMENT '探测器ID',
  `device_number` varchar(50) DEFAULT '' COMMENT '探测器编号',
  `device_alias` varchar(50) DEFAULT '' COMMENT '设备别名',
  `device_name` varchar(300) DEFAULT '' COMMENT '探测器名称',
  `has_people` tinyint(1) DEFAULT '0' COMMENT '0：没人，1：有人',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '删除状态',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  PRIMARY KEY (`id`),
  KEY `name` (`toilet_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='厕所坑位';

-- ----------------------------
-- Table structure for st_pit_log
-- ----------------------------
DROP TABLE IF EXISTS `st_pit_log`;
CREATE TABLE `st_pit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `toilet_id` int(11) DEFAULT '0' COMMENT '厕所ID',
  `toilet_name` varchar(50) DEFAULT '' COMMENT '厕所名称',
  `device_id` int(11) DEFAULT '0' COMMENT '设备ID',
  `device_number` varchar(50) DEFAULT '' COMMENT '设备编号',
  `device_name` varchar(50) DEFAULT '' COMMENT '设备名称',
  `pit_id` int(11) DEFAULT '0' COMMENT '坑位ID',
  `pit_name` varchar(50) DEFAULT '' COMMENT '坑位名称',
  `has_people` tinyint(1) DEFAULT '0' COMMENT '0：没人，1：有人',
  `add_time` varchar(20) DEFAULT '0' COMMENT '添加时间',
  `time` int(11) DEFAULT '0' COMMENT '蹲厕时间（分）',
  `message_id` int(11) DEFAULT '0' COMMENT '消息唯一标识',
  `message_publish_time` varchar(20) DEFAULT '' COMMENT '消息发布时间',
  `request_json` varchar(500) DEFAULT '' COMMENT '传递参数json',
  `response_json` varchar(500) DEFAULT '' COMMENT '回复json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`toilet_id`) USING BTREE,
  KEY `pit_id` (`pit_id`) USING BTREE,
  KEY `smartpark_id` (`smartpark_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25790 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='坑位日志';

-- ----------------------------
-- Table structure for st_toilet
-- ----------------------------
DROP TABLE IF EXISTS `st_toilet`;
CREATE TABLE `st_toilet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smartpark_id` int(11) NOT NULL DEFAULT '0' COMMENT '园区ID',
  `name` varchar(50) DEFAULT '' COMMENT '电梯名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，0：禁用，1：启用',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=utf8mb4 COMMENT='厕所';

-- ----------------------------
-- Table structure for v_visit
-- ----------------------------
DROP TABLE IF EXISTS `v_visit`;
CREATE TABLE `v_visit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smartpark_id` int(11) DEFAULT '0' COMMENT '园区ID',
  `visitor_car_numbers` varchar(100) DEFAULT '' COMMENT '访客的车牌号码，多个用英文逗号隔开',
  `visit_building_info` text COMMENT '要访问的公司所在楼栋信息(json)',
  `visit_start_time` int(11) DEFAULT '0' COMMENT '访问开始时间',
  `visit_end_time` int(11) DEFAULT '0' COMMENT '访问结束时间',
  `time_version` int(11) DEFAULT '0' COMMENT '时间版本',
  PRIMARY KEY (`id`),
  KEY `idx_visit_start_time` (`visit_start_time`),
  KEY `idx_visit_end_time` (`visit_end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='访问记录表';

