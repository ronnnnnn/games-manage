-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: games_manage
-- ------------------------------------------------------
-- Server version	5.7.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_record`
--

DROP TABLE IF EXISTS `access_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sid` varchar(100) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `handle_module` varchar(200) DEFAULT NULL,
  `last_access_time` datetime DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sid_UNIQUE` (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_record`
--

LOCK TABLES `access_record` WRITE;
/*!40000 ALTER TABLE `access_record` DISABLE KEYS */;
INSERT INTO `access_record` VALUES (1,'bdf96c9d-0a59-4199-afd3-e2bebd9995b5','0:0:0:0:0:0:0:1',NULL,'2017-07-22 18:58:50','admin'),(2,'1ac4f734-6ac2-4a3b-8e24-1e63db9b0c63','0:0:0:0:0:0:0:1',NULL,'2017-07-22 19:07:52','admin'),(3,'1a07b434-76a9-4adc-904f-1235db6c970b','0:0:0:0:0:0:0:1',',人力资源','2017-07-22 19:17:00','admin'),(4,'478af873-2f5b-4808-9b08-ce250fe9b444','0:0:0:0:0:0:0:1','人力资源,用户管理,角色管理,资源管理,系统属性','2017-07-22 19:21:41','admin'),(5,'17c13a92-08bb-4d6a-a728-bd1c61be1fcd','10.0.0.8','人力资源,用户管理,资源管理','2017-07-22 19:20:26','admin'),(6,'e37daa59-b5bb-463f-88a1-7cbfd90c7429','0:0:0:0:0:0:0:1','用户管理,资源管理,角色管理,安全日志','2017-07-22 19:56:25','admin'),(7,'3e734f9c-6a40-44b3-906f-fb54c6a2891a','0:0:0:0:0:0:0:1','安全日志','2017-07-22 19:57:29','admin'),(8,'2fc82531-4ce5-4a90-bd07-2f3406edd481','0:0:0:0:0:0:0:1','安全日志','2017-07-22 19:57:38','admin'),(9,'d5b1d6b2-a708-43ed-8880-98aed1393444','0:0:0:0:0:0:0:1','安全日志','2017-07-22 19:57:48','admin'),(10,'b2589473-6c43-4dc1-84ab-e0a502c4654b','0:0:0:0:0:0:0:1','安全日志','2017-07-22 19:57:55','admin'),(11,'2e3de166-3b13-455c-ac39-1bfadd5e032b','0:0:0:0:0:0:0:1','安全日志','2017-07-22 20:04:37','admin');
/*!40000 ALTER TABLE `access_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_organization`
--

DROP TABLE IF EXISTS `sys_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_organization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(100) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(100) DEFAULT NULL,
  `is_avaliable` tinyint(1) DEFAULT NULL,
  `org_type` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='组织表（营业厅组织）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_organization`
--

LOCK TABLES `sys_organization` WRITE;
/*!40000 ALTER TABLE `sys_organization` DISABLE KEYS */;
INSERT INTO `sys_organization` VALUES (1,'组织架构',0,'0/',1,0,NULL),(2,'新罗区',1,'0/1/',1,0,NULL),(4,'东肖街道',2,'0/1/2/',1,1,NULL),(5,'东肖营业厅',4,'0/1/2/4/',1,2,NULL),(6,'漕溪街道',2,'0/1/2/',1,1,NULL),(8,'漕溪营业厅',6,'0/1/2/6/',1,2,NULL);
/*!40000 ALTER TABLE `sys_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_organization_has_sys_user`
--

DROP TABLE IF EXISTS `sys_organization_has_sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_organization_has_sys_user` (
  `sys_organization_id` bigint(20) NOT NULL,
  `sys_user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`sys_organization_id`,`sys_user_id`),
  KEY `fk_sys_organization_has_sys_user_sys_user1_idx` (`sys_user_id`),
  KEY `fk_sys_organization_has_sys_user_sys_organization_idx` (`sys_organization_id`),
  CONSTRAINT `fk_sys_organization_has_sys_user_sys_organization` FOREIGN KEY (`sys_organization_id`) REFERENCES `sys_organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sys_organization_has_sys_user_sys_user1` FOREIGN KEY (`sys_user_id`) REFERENCES `sys_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_organization_has_sys_user`
--

LOCK TABLES `sys_organization_has_sys_user` WRITE;
/*!40000 ALTER TABLE `sys_organization_has_sys_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_organization_has_sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_resource`
--

DROP TABLE IF EXISTS `sys_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resource_name` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `priority` varchar(45) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(100) DEFAULT NULL,
  `permission` varchar(100) DEFAULT NULL,
  `is_avaliable` tinyint(1) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COMMENT='系统资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_resource`
--

LOCK TABLES `sys_resource` WRITE;
/*!40000 ALTER TABLE `sys_resource` DISABLE KEYS */;
INSERT INTO `sys_resource` VALUES (1,'资源','menu','0',0,'0/',NULL,1,NULL),(40,'用户资源管理','menu','01',1,'0/1/','',1,''),(41,'人力资源','menu','0101',40,'0/1/40/','org:*',1,'/org/page'),(42,'组织新增','button','010101',41,'0/1/40/41','org:create',1,' '),(43,'组织修改','button','010102',41,'0/1/40/41','org:update',1,' '),(44,'组织删除','button','010103',41,'0/1/40/41','org:delete',1,' '),(45,'组织查看','button','010104',41,'0/1/40/41','superuser:view',1,' '),(50,'用户管理','menu','0102',40,'0/1/40','user:*',1,'/user/page'),(51,'用户新增','button','010201',50,'0/1/40/50/','user:create',1,''),(52,'用户修改','button','010202',50,'0/1/40/50/','user:update',1,''),(53,'用户删除','button','010203',50,'0/1/40/50/','user:delete',1,''),(54,'用户查看','button','010204',50,'0/1/40/50/','user:view',1,''),(55,'资源管理','menu','0103',40,'0/1/40/','resource:*',1,'/page/resource/list'),(56,'资源新增','button','010301',55,'0/1/40/55/','resource:create',1,''),(57,'资源修改','button','010302',55,'0/1/40/55/','resource:update',1,''),(58,'资源删除','button','010303',55,'0/1/40/55/','resource:delete',1,''),(59,'资源查看','button','010304',55,'0/1/40/55/','resource:view',1,''),(60,'角色管理','menu','0104',40,'0/1/40/','role:*',1,'/page/role/list'),(61,'角色新增','button','010401',60,'0/1/40/60/','role:create',1,''),(62,'角色修改','button','010402',60,'0/1/40/60/','role:update',1,''),(63,'角色删除','button','010403',60,'0/1/40/60/','role:delete',1,''),(64,'角色查看','button','010404',60,'0/1/40/60/','role:view',1,''),(65,'系统设置','menu','09',1,'0//1','',1,''),(66,'系统属性','menu','0901',65,'0//1/65','setting:*',1,'/page/setting/list'),(82,'安全日志','menu','0105',40,'0/1//40','access-record:*',1,'/page/access-record/list');
/*!40000 ALTER TABLE `sys_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(45) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `resource_ids` varchar(100) DEFAULT NULL,
  `is_avaliable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'admin','超级管理员','41,50,55,60,82,66',1);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_has_sys_resource`
--

DROP TABLE IF EXISTS `sys_role_has_sys_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_has_sys_resource` (
  `sys_role_id` bigint(20) NOT NULL,
  `sys_resource_id` bigint(20) NOT NULL,
  PRIMARY KEY (`sys_role_id`,`sys_resource_id`),
  KEY `fk_sys_role_has_sys_resource_sys_resource1_idx` (`sys_resource_id`),
  KEY `fk_sys_role_has_sys_resource_sys_role1_idx` (`sys_role_id`),
  CONSTRAINT `fk_sys_role_has_sys_resource_sys_resource1` FOREIGN KEY (`sys_resource_id`) REFERENCES `sys_resource` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sys_role_has_sys_resource_sys_role1` FOREIGN KEY (`sys_role_id`) REFERENCES `sys_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_has_sys_resource`
--

LOCK TABLES `sys_role_has_sys_resource` WRITE;
/*!40000 ALTER TABLE `sys_role_has_sys_resource` DISABLE KEYS */;
INSERT INTO `sys_role_has_sys_resource` VALUES (1,41),(1,50),(1,55),(1,60),(1,66),(1,82);
/*!40000 ALTER TABLE `sys_role_has_sys_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_setting`
--

DROP TABLE IF EXISTS `sys_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sys_code` varchar(45) DEFAULT NULL,
  `sys_type` varchar(45) DEFAULT NULL,
  `sys_name` varchar(45) DEFAULT NULL,
  `sys_value` varchar(45) DEFAULT NULL,
  `sys_description` varchar(200) DEFAULT NULL,
  `is_show` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='系统设置表，积分设定，宽带错误，办理业务类型均在此处设定';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_setting`
--

LOCK TABLES `sys_setting` WRITE;
/*!40000 ALTER TABLE `sys_setting` DISABLE KEYS */;
INSERT INTO `sys_setting` VALUES (5,'0101','test','test','22','22',1),(6,'2','test2','test2','3','2',1);
/*!40000 ALTER TABLE `sys_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `salt` varchar(100) DEFAULT NULL,
  `role_ids` varchar(100) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `money` double DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `avatar` varchar(200) DEFAULT NULL,
  `nickname` varchar(45) DEFAULT NULL,
  `user_type` int(3) DEFAULT NULL COMMENT '0 普通用户\n1 商家\n2 维修人员\n3 新装人员\n4 营业厅管理员\n5 管理员\n\n',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(45) DEFAULT NULL,
  `open_id` varchar(120) DEFAULT NULL,
  `integral` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `open_id_UNIQUE` (`open_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','d3c59d25033dbf980d29554025c23a75','8d78869f470951332959580424d4bf4f','1',0,0,'18159801259','null','super',5,0,'2017-05-15 19:07:20',0,'0',NULL,0),(2,'wo_shop','2','2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'damin3','4500bfb45a335fc579a42e5b64e11ab1','87effb91b6359f04f7abe54253a98af1','1',0,NULL,'18159801001','/static/avater/moren.png','admin3',5,0,'2017-06-04 16:52:25',NULL,NULL,NULL,NULL),(4,'admin2','e9243a8343f5675e3e56dff0caa89cc5','81df299e5980ec2d26a5a73482308025','1',0,NULL,'18159882111','/static/avater/moren.png','admin2',5,0,'2017-06-04 16:49:22',NULL,NULL,NULL,NULL),(5,'1','1',NULL,'',NULL,NULL,'18159801287',NULL,NULL,3,0,'2017-06-04 16:49:22',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_has_sys_role`
--

DROP TABLE IF EXISTS `sys_user_has_sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_has_sys_role` (
  `sys_user_id` bigint(20) NOT NULL,
  `sys_role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`sys_user_id`,`sys_role_id`),
  KEY `fk_sys_user_has_sys_role_sys_role1_idx` (`sys_role_id`),
  KEY `fk_sys_user_has_sys_role_sys_user1_idx` (`sys_user_id`),
  CONSTRAINT `fk_sys_user_has_sys_role_sys_role1` FOREIGN KEY (`sys_role_id`) REFERENCES `sys_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sys_user_has_sys_role_sys_user1` FOREIGN KEY (`sys_user_id`) REFERENCES `sys_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_has_sys_role`
--

LOCK TABLES `sys_user_has_sys_role` WRITE;
/*!40000 ALTER TABLE `sys_user_has_sys_role` DISABLE KEYS */;
INSERT INTO `sys_user_has_sys_role` VALUES (1,1);
/*!40000 ALTER TABLE `sys_user_has_sys_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-25  9:23:28
