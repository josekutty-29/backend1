/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: placeme
-- ------------------------------------------------------
-- Server version	11.7.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add content type',4,'add_contenttype'),
(14,'Can change content type',4,'change_contenttype'),
(15,'Can delete content type',4,'delete_contenttype'),
(16,'Can view content type',4,'view_contenttype'),
(17,'Can add session',5,'add_session'),
(18,'Can change session',5,'change_session'),
(19,'Can delete session',5,'delete_session'),
(20,'Can view session',5,'view_session'),
(21,'Can add auth group',6,'add_authgroup'),
(22,'Can change auth group',6,'change_authgroup'),
(23,'Can delete auth group',6,'delete_authgroup'),
(24,'Can view auth group',6,'view_authgroup'),
(25,'Can add auth group permissions',7,'add_authgrouppermissions'),
(26,'Can change auth group permissions',7,'change_authgrouppermissions'),
(27,'Can delete auth group permissions',7,'delete_authgrouppermissions'),
(28,'Can view auth group permissions',7,'view_authgrouppermissions'),
(29,'Can add auth permission',8,'add_authpermission'),
(30,'Can change auth permission',8,'change_authpermission'),
(31,'Can delete auth permission',8,'delete_authpermission'),
(32,'Can view auth permission',8,'view_authpermission'),
(33,'Can add auth user',9,'add_authuser'),
(34,'Can change auth user',9,'change_authuser'),
(35,'Can delete auth user',9,'delete_authuser'),
(36,'Can view auth user',9,'view_authuser'),
(37,'Can add auth user groups',10,'add_authusergroups'),
(38,'Can change auth user groups',10,'change_authusergroups'),
(39,'Can delete auth user groups',10,'delete_authusergroups'),
(40,'Can view auth user groups',10,'view_authusergroups'),
(41,'Can add auth user user permissions',11,'add_authuseruserpermissions'),
(42,'Can change auth user user permissions',11,'change_authuseruserpermissions'),
(43,'Can delete auth user user permissions',11,'delete_authuseruserpermissions'),
(44,'Can view auth user user permissions',11,'view_authuseruserpermissions'),
(45,'Can add django admin log',12,'add_djangoadminlog'),
(46,'Can change django admin log',12,'change_djangoadminlog'),
(47,'Can delete django admin log',12,'delete_djangoadminlog'),
(48,'Can view django admin log',12,'view_djangoadminlog'),
(49,'Can add django content type',13,'add_djangocontenttype'),
(50,'Can change django content type',13,'change_djangocontenttype'),
(51,'Can delete django content type',13,'delete_djangocontenttype'),
(52,'Can view django content type',13,'view_djangocontenttype'),
(53,'Can add django migrations',14,'add_djangomigrations'),
(54,'Can change django migrations',14,'change_djangomigrations'),
(55,'Can delete django migrations',14,'delete_djangomigrations'),
(56,'Can view django migrations',14,'view_djangomigrations'),
(57,'Can add django session',15,'add_djangosession'),
(58,'Can change django session',15,'change_djangosession'),
(59,'Can delete django session',15,'delete_djangosession'),
(60,'Can view django session',15,'view_djangosession'),
(61,'Can add user',16,'add_user'),
(62,'Can change user',16,'change_user'),
(63,'Can delete user',16,'delete_user'),
(64,'Can view user',16,'view_user'),
(65,'Can add placement officer',17,'add_placementofficer'),
(66,'Can change placement officer',17,'change_placementofficer'),
(67,'Can delete placement officer',17,'delete_placementofficer'),
(68,'Can view placement officer',17,'view_placementofficer'),
(69,'Can add placement offer',18,'add_placementoffer'),
(70,'Can change placement offer',18,'change_placementoffer'),
(71,'Can delete placement offer',18,'delete_placementoffer'),
(72,'Can view placement offer',18,'view_placementoffer'),
(73,'Can add student',19,'add_student'),
(74,'Can change student',19,'change_student'),
(75,'Can delete student',19,'delete_student'),
(76,'Can view student',19,'view_student'),
(77,'Can add application',20,'add_application'),
(78,'Can change application',20,'change_application'),
(79,'Can delete application',20,'delete_application'),
(80,'Can view application',20,'view_application'),
(81,'Can add tutor',21,'add_tutor'),
(82,'Can change tutor',21,'change_tutor'),
(83,'Can delete tutor',21,'delete_tutor'),
(84,'Can view tutor',21,'view_tutor'),
(85,'Can add marks',22,'add_marks'),
(86,'Can change marks',22,'change_marks'),
(87,'Can delete marks',22,'delete_marks'),
(88,'Can view marks',22,'view_marks'),
(89,'Can add department',23,'add_department'),
(90,'Can change department',23,'change_department'),
(91,'Can delete department',23,'delete_department'),
(92,'Can view department',23,'view_department');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_main_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_main_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES
(1,'2025-03-15 10:24:27.054198','1','Arun',1,'[{\"added\": {}}]',21,1),
(2,'2025-03-15 10:25:08.363413','3','arun@gmail.com (aa7bcc7d7dc971463978)',2,'[{\"changed\": {\"fields\": [\"Role\"]}}]',16,1),
(3,'2025-03-15 13:10:35.690493','1','Placement Officer: placement@gmail.com',1,'[{\"added\": {}}]',17,1),
(4,'2025-03-15 13:10:48.934912','4','placement@gmail.com (8bef5d7fbdd45163ebcd)',2,'[{\"changed\": {\"fields\": [\"First name\", \"Role\"]}}]',16,1),
(5,'2025-03-15 13:29:49.103068','1','Google (Managed by placement@gmail.com)',1,'[{\"added\": {}}]',18,1),
(6,'2025-03-15 13:38:55.632469','2','Amazon (Managed by placement@gmail.com)',1,'[{\"added\": {}}]',18,1),
(7,'2025-03-24 12:21:05.465670','1','Computer Science',1,'[{\"added\": {}}]',23,1),
(8,'2025-03-24 12:35:41.282026','2','Electrical & Communication',1,'[{\"added\": {}}]',23,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'contenttypes','contenttype'),
(20,'main','application'),
(6,'main','authgroup'),
(7,'main','authgrouppermissions'),
(8,'main','authpermission'),
(9,'main','authuser'),
(10,'main','authusergroups'),
(11,'main','authuseruserpermissions'),
(23,'main','department'),
(12,'main','djangoadminlog'),
(13,'main','djangocontenttype'),
(14,'main','djangomigrations'),
(15,'main','djangosession'),
(22,'main','marks'),
(18,'main','placementoffer'),
(17,'main','placementofficer'),
(19,'main','student'),
(21,'main','tutor'),
(16,'main','user'),
(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2025-03-15 10:19:24.528955'),
(2,'contenttypes','0002_remove_content_type_name','2025-03-15 10:19:24.663443'),
(3,'auth','0001_initial','2025-03-15 10:19:25.142274'),
(4,'auth','0002_alter_permission_name_max_length','2025-03-15 10:19:25.234403'),
(5,'auth','0003_alter_user_email_max_length','2025-03-15 10:19:25.249205'),
(6,'auth','0004_alter_user_username_opts','2025-03-15 10:19:25.267585'),
(7,'auth','0005_alter_user_last_login_null','2025-03-15 10:19:25.280568'),
(8,'auth','0006_require_contenttypes_0002','2025-03-15 10:19:25.284077'),
(9,'auth','0007_alter_validators_add_error_messages','2025-03-15 10:19:25.295769'),
(10,'auth','0008_alter_user_username_max_length','2025-03-15 10:19:25.303495'),
(11,'auth','0009_alter_user_last_name_max_length','2025-03-15 10:19:25.314871'),
(12,'auth','0010_alter_group_name_max_length','2025-03-15 10:19:25.354389'),
(13,'auth','0011_update_proxy_permissions','2025-03-15 10:19:25.366196'),
(14,'auth','0012_alter_user_first_name_max_length','2025-03-15 10:19:25.373932'),
(15,'main','0001_initial','2025-03-15 10:19:27.573652'),
(16,'admin','0001_initial','2025-03-15 10:19:27.868672'),
(17,'admin','0002_logentry_remove_auto_add','2025-03-15 10:19:27.928344'),
(18,'admin','0003_logentry_add_action_flag_choices','2025-03-15 10:19:27.974460'),
(19,'sessions','0001_initial','2025-03-15 10:19:28.056996'),
(20,'main','0002_department_placementoffer_sem','2025-03-23 06:31:12.307561');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES
('380qesc90jk2bfo1uc4c2up8zfn2rtt5','.eJxVjDsOQiEQAO9CbQg_BSztPQPZhV15aiB5n8p4dyV5hbYzk3mJBNta07bQnKYizkKLwy9DyA9qQ5Q7tFuXubd1nlCORO52kdde6HnZ279BhaWOrTHamcA2OrQYCBV7jDkCkUE29uSzhyMrBWCCYmD2VpF2sbgYv1C8P-MBOCY:1twgmg:Q0KDlUWwko-TMpITsQJ0V-ZMzwykl-WoRDLRlF2YKGw','2025-04-07 12:20:02.966206'),
('g6jndza1vb7xlxtlgf67q0zk1hej90jq','.eJxVjDsOwjAQBe_iGln-rmNK-pzBWnsXHECOFCcV4u4QKQW0b2beSyTc1pq2zkuaSJyFEaffLWN5cNsB3bHdZlnmti5TlrsiD9rlOBM_L4f7d1Cx12_tCD14sDaWjNFFFYtGQqNpKE4RMoGGMFwBFTN5a01mU0K23sWACOL9AepVOCw:1tttGq:YzS5uSIVMu_0PoAOWLzJvUxsfBtB9UVsxiXtUBRCehY','2025-03-30 19:03:36.578023'),
('pe07lzgzu9noxd9dk18spzfqa3tqmtwy','.eJxVjDsOQiEQAO9CbQg_BSztPQPZhV15aiB5n8p4dyV5hbYzk3mJBNta07bQnKYizkKLwy9DyA9qQ5Q7tFuXubd1nlCORO52kdde6HnZ279BhaWOrTHamcA2OrQYCBV7jDkCkUE29uSzhyMrBWCCYmD2VpF2sbgYv1C8P-MBOCY:1ttOgE:e1Uyo7g6MiIVx-1FAACbh8ssf5L2ud_3XDeQC1cJedk','2025-03-29 10:23:46.791874');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_application`
--

DROP TABLE IF EXISTS `main_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_application` (
  `appli_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `applied_date` date NOT NULL,
  `offer_id_id` int(11) NOT NULL,
  `reg_no_id` varchar(20) NOT NULL,
  PRIMARY KEY (`appli_id`),
  KEY `main_application_offer_id_id_ccd3a0d2_fk_main_plac` (`offer_id_id`),
  KEY `main_application_reg_no_id_0a49ae31_fk_main_student_reg_no` (`reg_no_id`),
  CONSTRAINT `main_application_offer_id_id_ccd3a0d2_fk_main_plac` FOREIGN KEY (`offer_id_id`) REFERENCES `main_placementoffer` (`offer_id`),
  CONSTRAINT `main_application_reg_no_id_0a49ae31_fk_main_student_reg_no` FOREIGN KEY (`reg_no_id`) REFERENCES `main_student` (`reg_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_application`
--

LOCK TABLES `main_application` WRITE;
/*!40000 ALTER TABLE `main_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_department`
--

DROP TABLE IF EXISTS `main_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` varchar(10) NOT NULL,
  `head` varchar(100) DEFAULT NULL,
  `contact_email` varchar(254) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_department`
--

LOCK TABLES `main_department` WRITE;
/*!40000 ALTER TABLE `main_department` DISABLE KEYS */;
INSERT INTO `main_department` VALUES
(1,'Computer Science','cs','hod 1','hod1@gmail.com','computer science and technology'),
(2,'Electrical & Communication','EC','hod2','hod2@gmail.com','Electrical & Communication Engineering');
/*!40000 ALTER TABLE `main_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_marks`
--

DROP TABLE IF EXISTS `main_marks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_marks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cgpa` decimal(4,2) NOT NULL,
  `backlog` int(10) unsigned NOT NULL CHECK (`backlog` >= 0),
  `sem` int(10) unsigned NOT NULL CHECK (`sem` >= 0),
  `reg_no_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main_marks_reg_no_id_sem_9a4a4703_uniq` (`reg_no_id`,`sem`),
  CONSTRAINT `main_marks_reg_no_id_2091b0c0_fk_main_student_reg_no` FOREIGN KEY (`reg_no_id`) REFERENCES `main_student` (`reg_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_marks`
--

LOCK TABLES `main_marks` WRITE;
/*!40000 ALTER TABLE `main_marks` DISABLE KEYS */;
INSERT INTO `main_marks` VALUES
(1,9.10,2,6,'8fd275e19ed254dedd44');
/*!40000 ALTER TABLE `main_marks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_placementoffer`
--

DROP TABLE IF EXISTS `main_placementoffer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_placementoffer` (
  `offer_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) NOT NULL,
  `cgpa_required` decimal(4,2) NOT NULL,
  `no_of_backpapers` int(10) unsigned NOT NULL CHECK (`no_of_backpapers` >= 0),
  `salary` decimal(12,2) NOT NULL,
  `description` longtext DEFAULT NULL,
  `skillset` longtext DEFAULT NULL,
  `contact_email` varchar(254) NOT NULL,
  `posted_date` date NOT NULL,
  `final_date` date NOT NULL,
  `created_by_id` bigint(20) NOT NULL,
  `sem` int(11) NOT NULL,
  PRIMARY KEY (`offer_id`),
  KEY `main_placementoffer_created_by_id_deb3bcef_fk_main_plac` (`created_by_id`),
  CONSTRAINT `main_placementoffer_created_by_id_deb3bcef_fk_main_plac` FOREIGN KEY (`created_by_id`) REFERENCES `main_placementofficer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_placementoffer`
--

LOCK TABLES `main_placementoffer` WRITE;
/*!40000 ALTER TABLE `main_placementoffer` DISABLE KEYS */;
INSERT INTO `main_placementoffer` VALUES
(5,'Amazon',6.00,0,450000.00,'backend developer','django, python','amazon@gmail.com','2025-03-16','2025-03-31',1,6),
(6,'Meta',8.00,0,600000.00,'software developer','java,Android sdk','meta@gmail.com','2025-03-16','2025-03-26',1,6);
/*!40000 ALTER TABLE `main_placementoffer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_placementoffer_applied_by`
--

DROP TABLE IF EXISTS `main_placementoffer_applied_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_placementoffer_applied_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `placementoffer_id` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main_placementoffer_appl_placementoffer_id_user_i_5cc1d364_uniq` (`placementoffer_id`,`user_id`),
  KEY `main_placementoffer_applied_by_user_id_e33ac03f_fk_main_user_id` (`user_id`),
  CONSTRAINT `main_placementoffer__placementoffer_id_58554ef7_fk_main_plac` FOREIGN KEY (`placementoffer_id`) REFERENCES `main_placementoffer` (`offer_id`),
  CONSTRAINT `main_placementoffer_applied_by_user_id_e33ac03f_fk_main_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_placementoffer_applied_by`
--

LOCK TABLES `main_placementoffer_applied_by` WRITE;
/*!40000 ALTER TABLE `main_placementoffer_applied_by` DISABLE KEYS */;
INSERT INTO `main_placementoffer_applied_by` VALUES
(4,5,2),
(6,5,5);
/*!40000 ALTER TABLE `main_placementoffer_applied_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_placementoffer_liked_by`
--

DROP TABLE IF EXISTS `main_placementoffer_liked_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_placementoffer_liked_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `placementoffer_id` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main_placementoffer_like_placementoffer_id_user_i_8990e550_uniq` (`placementoffer_id`,`user_id`),
  KEY `main_placementoffer_liked_by_user_id_16743491_fk_main_user_id` (`user_id`),
  CONSTRAINT `main_placementoffer__placementoffer_id_2668cd9f_fk_main_plac` FOREIGN KEY (`placementoffer_id`) REFERENCES `main_placementoffer` (`offer_id`),
  CONSTRAINT `main_placementoffer_liked_by_user_id_16743491_fk_main_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_placementoffer_liked_by`
--

LOCK TABLES `main_placementoffer_liked_by` WRITE;
/*!40000 ALTER TABLE `main_placementoffer_liked_by` DISABLE KEYS */;
INSERT INTO `main_placementoffer_liked_by` VALUES
(6,5,2),
(8,5,5);
/*!40000 ALTER TABLE `main_placementoffer_liked_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_placementofficer`
--

DROP TABLE IF EXISTS `main_placementofficer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_placementofficer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `main_placementofficer_user_id_1065fe69_fk_main_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_placementofficer`
--

LOCK TABLES `main_placementofficer` WRITE;
/*!40000 ALTER TABLE `main_placementofficer` DISABLE KEYS */;
INSERT INTO `main_placementofficer` VALUES
(1,4);
/*!40000 ALTER TABLE `main_placementofficer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_student`
--

DROP TABLE IF EXISTS `main_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_student` (
  `reg_no` varchar(20) NOT NULL,
  `department_id` varchar(100) NOT NULL,
  `semester` int(10) unsigned NOT NULL CHECK (`semester` >= 0),
  `date_of_birth` date DEFAULT NULL,
  `batch` varchar(20) NOT NULL,
  `division` varchar(20) DEFAULT NULL,
  `phone_no` varchar(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `tutor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`reg_no`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `main_student_tutor_id_194490d5_fk_main_tutor_tutor_id` (`tutor_id`),
  CONSTRAINT `main_student_tutor_id_194490d5_fk_main_tutor_tutor_id` FOREIGN KEY (`tutor_id`) REFERENCES `main_tutor` (`tutor_id`),
  CONSTRAINT `main_student_user_id_32abd1a3_fk_main_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_student`
--

LOCK TABLES `main_student` WRITE;
/*!40000 ALTER TABLE `main_student` DISABLE KEYS */;
INSERT INTO `main_student` VALUES
('8654e893e765330f7316','Electrical',6,'2002-03-12','2020','A','8967452310',5,1),
('8fd275e19ed254dedd44','computer science',7,'2002-08-23','2020','A','9089674523',2,1),
('kgr21cs2131234567890','computer science',4,'2003-12-23','2020','A','9067452389',6,1);
/*!40000 ALTER TABLE `main_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_tutor`
--

DROP TABLE IF EXISTS `main_tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_tutor` (
  `tutor_id` int(11) NOT NULL AUTO_INCREMENT,
  `tutor_name` varchar(255) NOT NULL,
  `department` varchar(100) NOT NULL,
  `semester` int(10) unsigned NOT NULL CHECK (`semester` >= 0),
  `division` varchar(50) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tutor_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `main_tutor_user_id_7485c0d5_fk_main_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_tutor`
--

LOCK TABLES `main_tutor` WRITE;
/*!40000 ALTER TABLE `main_tutor` DISABLE KEYS */;
INSERT INTO `main_tutor` VALUES
(1,'Arun Das','Computer science',6,'A',3);
/*!40000 ALTER TABLE `main_tutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_user`
--

DROP TABLE IF EXISTS `main_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `regno` varchar(20) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `username` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `regno` (`regno`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_user`
--

LOCK TABLES `main_user` WRITE;
/*!40000 ALTER TABLE `main_user` DISABLE KEYS */;
INSERT INTO `main_user` VALUES
(1,'pbkdf2_sha256$870000$8sJ1q12OGEPwqyxQaUUCVN$5kxSTAnZekhBCNxiGIoSnNTDaNnipWgy4njozLWqaG0=','2025-03-24 12:20:02.959189',1,'','','admin@gmail.com',1,1,'2025-03-15 10:19:53.455529','83a44044db7b109db3ff','student','admin'),
(2,'pbkdf2_sha256$870000$WdZybAfUqrYGnVK0pP6rif$lzQ3zplV7HqGKEvnWPok6HCQE1qnef88W/tNenyWwK8=','2025-03-16 19:03:36.570668',0,'amal','john ','amal@gmail.com',0,1,'2025-03-15 10:21:20.644676','8fd275e19ed254dedd44','student','amal@gmail.com'),
(3,'pbkdf2_sha256$870000$cf2gZCaFsaIVtebbBcQ17F$f0MynrLRxWuKxifTkDBRblpTwg71lHoRNCX2lOzdpT0=','2025-03-16 17:59:09.664824',0,'Arun','A','arun@gmail.com',0,1,'2025-03-15 10:23:34.000000','aa7bcc7d7dc971463978','tutor','arun@gmail.com'),
(4,'pbkdf2_sha256$870000$G8jfUq614LQNOd8a8HoYZy$7diIMFAobbkDS0GEPPH1vWX/8ICfEy8bZ/vofDm0xFc=','2025-03-16 18:22:31.865278',0,'Placement','Officer 1','placement@gmail.com',0,1,'2025-03-15 13:10:22.000000','8bef5d7fbdd45163ebcd','placement_officer','placement@gmail.com'),
(5,'pbkdf2_sha256$870000$r3ICZPnk19LGYRRSMxuk6W$D7VjNEaVoO3EhM2BdTDEK2eesJEoIV1WxMWSYiixTXI=','2025-03-16 16:08:10.452051',0,'Varun','V','varun@gmail.com',0,1,'2025-03-16 06:57:19.909658','8654e893e765330f7316','student','varun@gmail.com'),
(6,'pbkdf2_sha256$870000$AVG7A8gWMzTIPlWexYDPwh$bytM4xx0Y1OupzmDOBD4GWPfS4Netd8eQMYqod0m5EQ=','2025-03-16 18:44:21.404806',0,'john','doe','john@gmail.com',0,1,'2025-03-16 18:44:20.287796','kgr21cs2131234567890','student','john@gmail.com');
/*!40000 ALTER TABLE `main_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_user_groups`
--

DROP TABLE IF EXISTS `main_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main_user_groups_user_id_group_id_ae195797_uniq` (`user_id`,`group_id`),
  KEY `main_user_groups_group_id_a337ba62_fk_auth_group_id` (`group_id`),
  CONSTRAINT `main_user_groups_group_id_a337ba62_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `main_user_groups_user_id_df502602_fk_main_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_user_groups`
--

LOCK TABLES `main_user_groups` WRITE;
/*!40000 ALTER TABLE `main_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_user_user_permissions`
--

DROP TABLE IF EXISTS `main_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main_user_user_permissions_user_id_permission_id_96b9fadf_uniq` (`user_id`,`permission_id`),
  KEY `main_user_user_permi_permission_id_cd2b56a3_fk_auth_perm` (`permission_id`),
  CONSTRAINT `main_user_user_permi_permission_id_cd2b56a3_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `main_user_user_permissions_user_id_451ce57f_fk_main_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_user_user_permissions`
--

LOCK TABLES `main_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `main_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-03-24 18:08:23
