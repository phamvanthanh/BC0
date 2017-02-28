-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: qscompanion
-- ------------------------------------------------------
-- Server version	5.7.17-0ubuntu0.16.04.1

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
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `id` int(6) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES (2050,'Demolition',''),(2360,'Termite control',''),(2740,'Bituminous concrete pavement',''),(2769,'Tactile warning surfaces',''),(3310,'Concrete',''),(3410,'Structural steel',''),(4210,'Brick and block work',''),(5080,'Metal finish - Shop applied',''),(5400,'Cold formed metal framing',''),(5500,'Metal work',''),(5520,'Handrails and balustrades',''),(6100,'Carpentry',''),(6165,'Fiber cement products',''),(6400,'Joinery',''),(7130,'Waterproofing and tanking',''),(7180,'Traffic coating',''),(7200,'Insulation',''),(7600,'Metal roofing',''),(7725,'Fall arrest equipment',''),(8100,'Fire-rated doors and frames',''),(8200,'Doors and door frames',''),(8520,'Metal windows and glazing',''),(8710,'Door hardware',''),(21313,'asdadadadad','adadada'),(123131,'sadadada','');
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_material`
--

DROP TABLE IF EXISTS `activity_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_material` (
  `parentId` int(6) unsigned NOT NULL,
  `childId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`parentId`,`childId`),
  KEY `materialId` (`childId`),
  CONSTRAINT `activity_material_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `activity_material_ibfk_2` FOREIGN KEY (`childId`) REFERENCES `material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_material`
--

LOCK TABLES `activity_material` WRITE;
/*!40000 ALTER TABLE `activity_material` DISABLE KEYS */;
INSERT INTO `activity_material` VALUES (3310,45672),(3310,45673),(3310,45674),(3310,45675),(3310,45676);
/*!40000 ALTER TABLE `activity_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_project`
--

DROP TABLE IF EXISTS `emp_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_project` (
  `projectId` int(11) unsigned NOT NULL,
  `employeeId` int(11) unsigned NOT NULL,
  `endDate` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`projectId`,`employeeId`),
  KEY `employeeId` (`employeeId`),
  CONSTRAINT `emp_project_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `emp_project_ibfk_2` FOREIGN KEY (`employeeId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_project`
--

LOCK TABLES `emp_project` WRITE;
/*!40000 ALTER TABLE `emp_project` DISABLE KEYS */;
INSERT INTO `emp_project` VALUES (11,2,NULL,0),(12,2,NULL,0);
/*!40000 ALTER TABLE `emp_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_project_activity`
--

DROP TABLE IF EXISTS `emp_project_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_project_activity` (
  `employeeId` int(11) unsigned NOT NULL,
  `projectId` int(11) unsigned NOT NULL,
  `parentId` int(3) unsigned NOT NULL,
  `childId` int(6) unsigned NOT NULL,
  PRIMARY KEY (`employeeId`,`projectId`,`parentId`,`childId`),
  KEY `projectId` (`projectId`,`parentId`,`childId`),
  CONSTRAINT `emp_project_activity_ibfk_2` FOREIGN KEY (`projectId`, `parentId`, `childId`) REFERENCES `project_activity` (`projectId`, `parentId`, `childId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_project_activity`
--

LOCK TABLES `emp_project_activity` WRITE;
/*!40000 ALTER TABLE `emp_project_activity` DISABLE KEYS */;
INSERT INTO `emp_project_activity` VALUES (2,11,2,3310),(2,11,8,2360);
/*!40000 ALTER TABLE `emp_project_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_project_material`
--

DROP TABLE IF EXISTS `emp_project_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_project_material` (
  `employeeId` int(11) unsigned NOT NULL,
  `projectId` int(11) unsigned NOT NULL,
  `parentId` int(6) unsigned NOT NULL,
  `childId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`employeeId`,`projectId`,`parentId`,`childId`),
  KEY `projectId` (`projectId`,`parentId`,`childId`),
  CONSTRAINT `emp_project_material_ibfk_1` FOREIGN KEY (`projectId`, `parentId`, `childId`) REFERENCES `project_material` (`projectId`, `parentId`, `childId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_project_material`
--

LOCK TABLES `emp_project_material` WRITE;
/*!40000 ALTER TABLE `emp_project_material` DISABLE KEYS */;
INSERT INTO `emp_project_material` VALUES (2,11,3310,45672),(2,11,3310,45673),(2,11,3310,45674);
/*!40000 ALTER TABLE `emp_project_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_project_section`
--

DROP TABLE IF EXISTS `emp_project_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_project_section` (
  `employeeId` int(11) unsigned NOT NULL,
  `projectId` int(11) unsigned NOT NULL,
  `childId` int(3) unsigned NOT NULL,
  PRIMARY KEY (`employeeId`,`projectId`,`childId`),
  KEY `projectId` (`projectId`,`childId`),
  CONSTRAINT `emp_project_section_ibfk_1` FOREIGN KEY (`projectId`, `childId`) REFERENCES `project_section` (`projectId`, `childId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_project_section`
--

LOCK TABLES `emp_project_section` WRITE;
/*!40000 ALTER TABLE `emp_project_section` DISABLE KEYS */;
INSERT INTO `emp_project_section` VALUES (2,11,2),(2,11,9);
/*!40000 ALTER TABLE `emp_project_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(40) NOT NULL,
  `firstName` varchar(25) NOT NULL,
  `lastName` varchar(25) NOT NULL,
  `dob` date NOT NULL,
  `phone` varchar(20) NOT NULL,
  `city` varchar(25) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gwbs`
--

DROP TABLE IF EXISTS `gwbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gwbs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `lft` int(6) unsigned NOT NULL,
  `rgt` int(6) unsigned NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gwbs`
--

LOCK TABLES `gwbs` WRITE;
/*!40000 ALTER TABLE `gwbs` DISABLE KEYS */;
INSERT INTO `gwbs` VALUES (1,0,'Root',0,105,'Root Node',1),(2,1,'General Requirements',1,22,'',0),(3,1100,'Summary',2,3,'',0),(4,1200,'Price and Payment Procedures',4,5,'',0),(5,1300,'Administrative Requirements',6,7,'',0),(6,1400,'Quality Requirements',8,9,'',0),(7,1500,'Temporary Facilities and Controls',10,11,'',0),(8,1600,'Product Requirements',12,13,'',0),(9,1700,'Execution Requirements',14,15,'',0),(10,1800,'Facility Operation',16,17,'',0),(11,1900,'Facility Decommissioning',18,19,'',0),(12,2,'Site Construction',23,48,'',0),(13,2050,'Basic Site Materials and Methods',24,25,'',0),(14,2100,'Site Remediation',26,27,'',0),(15,2200,'Site Preparation',28,29,'',0),(16,2300,'Earthwork',30,31,'',0),(18,2500,'Utility Services',36,37,'',0),(19,2600,'Drainage and Containment',38,39,'',0),(20,2700,'Bases, Ballasts, Pavements and Appurtenances',40,41,'',0),(21,2450,'Foundation and Load-Bearing Elements',34,35,'',0),(22,2400,'Tunneling, Boring and Jacking',32,33,'',0),(23,2800,'Site Improvements and Amenities',42,43,'',0),(24,2900,'Planting',44,45,'',0),(25,2950,'Site Restoration and Rehabilitation',46,47,'',0),(26,3,'Concrete',49,86,'',0),(27,3050,'Basic Concrete Materials and Methods',50,51,'',0),(28,3100,'Concrete Forms and Accessories',52,61,'',0),(29,3200,'Concrete Reinforcement',62,73,'',0),(30,3300,'Cast-In-Place Concrete',74,75,'',0),(31,3400,'Precast Concrete',76,77,'',0),(32,3500,'Cementitious Decks and Underlayment',78,79,'',0),(33,3600,'Grouts',80,81,'',0),(34,3700,'Mass Concrete',82,83,'',0),(35,3900,'Concrete Restoration and Cleaning',84,85,'',0),(36,4,'Masonry',87,104,'',0),(37,4050,'Basic Masonry Materials and Methods',88,89,'',0),(38,4200,'Masonry Units',90,91,'',0),(39,4400,'Stone',92,93,'',0),(40,4500,'Refractories',94,95,'',0),(41,4600,'Corrosion-Resistant Masonry',96,97,'',0),(42,4700,'Simulated Masonry',98,99,'',0),(43,4800,'Masonry Assemblies',100,101,'',0),(44,4900,'Masonry Restoration and Cleaning',102,103,'',0),(45,3210,'Reinforcing Steel',63,64,'',0),(46,3220,'Welded Wire Fabric',65,66,'',0),(47,3230,'Stressing Tendon',67,68,'',0),(48,3240,'Fibrous Reinforcing',69,70,'',0),(49,3250,'Post-Tensioning',71,72,'',0),(50,3110,'Structural Cast-in-Place Concrete Form',53,54,'',0),(51,3120,'Architectural Cast-in-Place Concrete Form',55,56,'',0),(52,3130,'Permanent Form',57,58,'Permanent Steel Forms, Prefabricated Stair Forms',0),(53,3150,'Concrete Accessories',59,60,'',0);
/*!40000 ALTER TABLE `gwbs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `industry`
--

DROP TABLE IF EXISTS `industry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `industry` (
  `id` int(2) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `industry`
--

LOCK TABLES `industry` WRITE;
/*!40000 ALTER TABLE `industry` DISABLE KEYS */;
INSERT INTO `industry` VALUES (1,'Residential and Commercial buildings',''),(2,'Industrial Plants',''),(3,'Civil and Infrastructure',''),(4,'Road & Bridge','');
/*!40000 ALTER TABLE `industry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `industry_section`
--

DROP TABLE IF EXISTS `industry_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `industry_section` (
  `parentId` int(2) unsigned NOT NULL,
  `childId` int(3) unsigned NOT NULL,
  PRIMARY KEY (`parentId`,`childId`),
  KEY `sectionId` (`childId`),
  CONSTRAINT `industry_section_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `industry` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `industry_section_ibfk_2` FOREIGN KEY (`childId`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `industry_section`
--

LOCK TABLES `industry_section` WRITE;
/*!40000 ALTER TABLE `industry_section` DISABLE KEYS */;
INSERT INTO `industry_section` VALUES (1,1),(2,1),(3,1),(1,2),(2,2),(1,3),(2,3),(3,3),(1,4),(2,4),(3,4),(1,5),(2,5),(3,5),(1,6),(2,6),(3,6),(1,7),(2,7),(3,7),(1,8),(2,8),(3,8),(1,10);
/*!40000 ALTER TABLE `industry_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead`
--

DROP TABLE IF EXISTS `lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `lastName` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `companyName` varchar(100) NOT NULL,
  `level` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) NOT NULL DEFAULT '1',
  `timeStamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead`
--

LOCK TABLES `lead` WRITE;
/*!40000 ALTER TABLE `lead` DISABLE KEYS */;
INSERT INTO `lead` VALUES (3,'Steve','Pelon','qscompanion@gmail.com','+84975622359','Companion Inc',0,1,'2016-12-14 11:41:58');
/*!40000 ALTER TABLE `lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leadMessage`
--

DROP TABLE IF EXISTS `leadMessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leadMessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leadId` int(11) unsigned NOT NULL,
  `message` varchar(200) NOT NULL,
  `timeStamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `leadId` (`leadId`),
  CONSTRAINT `leadMessage_ibfk_1` FOREIGN KEY (`leadId`) REFERENCES `lead` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leadMessage`
--

LOCK TABLES `leadMessage` WRITE;
/*!40000 ALTER TABLE `leadMessage` DISABLE KEYS */;
INSERT INTO `leadMessage` VALUES (14,3,'Please call me back!','2016-12-14 11:41:58');
/*!40000 ALTER TABLE `leadMessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (45672,'Concrete #200',''),(45673,'Concrete #250',''),(45674,'Concrete #300',''),(45675,'Concrete #350',''),(45676,'Concrete #400','');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `industry` int(2) unsigned NOT NULL,
  `leadId` int(11) unsigned NOT NULL,
  `controller` int(11) unsigned DEFAULT NULL,
  `confirmDate` date DEFAULT NULL,
  `closeDate` date DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `industry` (`industry`),
  KEY `leadId` (`leadId`),
  CONSTRAINT `project_ibfk_2` FOREIGN KEY (`industry`) REFERENCES `industry` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_ibfk_3` FOREIGN KEY (`leadId`) REFERENCES `lead` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (11,'River View Church','Australia',1,3,2,'2017-02-14','2017-02-20','Update the link','Update information',0,'2017-02-13 08:43:21'),(12,'Test 1','United State',2,3,2,'2017-02-15','2017-02-21',NULL,NULL,0,'2017-02-13 08:44:17'),(16,'Test 2','Australia',2,3,2,'2017-02-14','2017-02-22','','',0,'2017-02-13 10:07:16');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_activity`
--

DROP TABLE IF EXISTS `project_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_activity` (
  `projectId` int(11) unsigned NOT NULL,
  `parentId` int(3) unsigned NOT NULL,
  `childId` int(6) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`parentId`,`childId`),
  KEY `parentId` (`parentId`,`childId`),
  CONSTRAINT `project_activity_ibfk_1` FOREIGN KEY (`parentId`, `childId`) REFERENCES `section_activity` (`parentId`, `childId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_activity_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_activity`
--

LOCK TABLES `project_activity` WRITE;
/*!40000 ALTER TABLE `project_activity` DISABLE KEYS */;
INSERT INTO `project_activity` VALUES (11,1,5080),(11,1,5500),(11,1,5520),(11,1,6100),(11,1,6165),(11,1,6400),(11,2,3310),(11,3,4210),(11,7,2050),(11,8,2360);
/*!40000 ALTER TABLE `project_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_material`
--

DROP TABLE IF EXISTS `project_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_material` (
  `projectId` int(11) unsigned NOT NULL,
  `parentId` int(6) unsigned NOT NULL,
  `childId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`parentId`,`childId`),
  KEY `parentId` (`parentId`,`childId`),
  CONSTRAINT `project_material_ibfk_1` FOREIGN KEY (`parentId`, `childId`) REFERENCES `activity_material` (`parentId`, `childId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_material_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_material`
--

LOCK TABLES `project_material` WRITE;
/*!40000 ALTER TABLE `project_material` DISABLE KEYS */;
INSERT INTO `project_material` VALUES (11,3310,45672),(11,3310,45673),(11,3310,45674);
/*!40000 ALTER TABLE `project_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_section`
--

DROP TABLE IF EXISTS `project_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_section` (
  `projectId` int(11) unsigned NOT NULL,
  `childId` int(3) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`childId`),
  KEY `childId` (`childId`),
  CONSTRAINT `project_section_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_section_ibfk_2` FOREIGN KEY (`childId`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_section`
--

LOCK TABLES `project_section` WRITE;
/*!40000 ALTER TABLE `project_section` DISABLE KEYS */;
INSERT INTO `project_section` VALUES (11,1),(11,2),(11,3),(11,6),(11,7),(11,8),(11,9);
/*!40000 ALTER TABLE `project_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pwbs`
--

DROP TABLE IF EXISTS `pwbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pwbs` (
  `project_id` int(11) unsigned DEFAULT NULL,
  `code` int(11) unsigned DEFAULT NULL,
  `parent_code` int(11) unsigned DEFAULT NULL,
  `type` tinyint(1) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pwbs`
--

LOCK TABLES `pwbs` WRITE;
/*!40000 ALTER TABLE `pwbs` DISABLE KEYS */;
/*!40000 ALTER TABLE `pwbs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_perm`
--

DROP TABLE IF EXISTS `role_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_perm` (
  `role_id` int(11) unsigned NOT NULL,
  `perm_id` int(11) unsigned NOT NULL,
  KEY `role_id` (`role_id`),
  KEY `perm_id` (`perm_id`),
  CONSTRAINT `role_perm_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `role_perm_ibfk_2` FOREIGN KEY (`perm_id`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_perm`
--

LOCK TABLES `role_perm` WRITE;
/*!40000 ALTER TABLE `role_perm` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_perm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section` (
  `id` int(3) unsigned NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (1,'Architecture',''),(2,'Structure',''),(3,'Masonry',''),(4,'Plumping',''),(5,'Communication and Internet',''),(6,'Fire service',''),(7,'Demolition',''),(8,'Earth treatment',''),(9,'Road & Pavement',''),(10,'A construction section',''),(15,'fsdafsfas','');
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_activity`
--

DROP TABLE IF EXISTS `section_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_activity` (
  `parentId` int(3) unsigned NOT NULL,
  `childId` int(6) unsigned NOT NULL,
  PRIMARY KEY (`parentId`,`childId`),
  KEY `tradeId` (`childId`),
  CONSTRAINT `section_activity_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `section` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `section_activity_ibfk_2` FOREIGN KEY (`childId`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_activity`
--

LOCK TABLES `section_activity` WRITE;
/*!40000 ALTER TABLE `section_activity` DISABLE KEYS */;
INSERT INTO `section_activity` VALUES (7,2050),(8,2360),(9,2769),(2,3310),(2,3410),(3,4210),(1,5080),(2,5400),(1,5500),(1,5520),(1,6100),(1,6165),(1,6400),(1,7130),(1,7200),(1,8100),(1,8520),(1,8710),(1,21313),(6,123131);
/*!40000 ALTER TABLE `section_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `education` tinyint(1) DEFAULT NULL,
  `college` varchar(200) DEFAULT NULL,
  `class` tinyint(1) NOT NULL DEFAULT '2',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Steve','Pelon','steve@cschema.com','thanh03021986','84975622359','QsCompanion',0,'National University of Civil Engineering',0,'2016-12-27 08:10:06',1),(2,'Thanh','Pham','pthanh.ce@gmail.com','123456','0975622359','Home',2,'NUCE',2,'2017-02-09 03:16:52',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wbs`
--

DROP TABLE IF EXISTS `wbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wbs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` int(11) unsigned NOT NULL,
  `parent_code` int(11) unsigned DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) unsigned DEFAULT '1',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wbs`
--

LOCK TABLES `wbs` WRITE;
/*!40000 ALTER TABLE `wbs` DISABLE KEYS */;
INSERT INTO `wbs` VALUES (1,0,NULL,'Root',1,NULL),(2,1,0,'General Requirements',0,NULL),(3,1100,1,'Summary',0,NULL),(4,1200,1,'Price and Payment Procedures',0,NULL),(5,1300,1,'Administrative Requirements',0,NULL),(6,1400,1,'Quality Requirements',0,NULL),(7,1500,1,'Temporary Facilities and Controls',0,NULL),(8,1600,1,'Product Requirements',0,NULL),(9,1700,1,'Execution Requirements',0,NULL),(10,1800,1,'Facility Operation',0,NULL),(11,1900,1,'Facility Decommissioning',0,NULL),(12,2,0,'Site Construction',0,NULL),(13,2050,2,'Basic Site Materials and Methods',0,NULL),(14,2100,2,'Site Remediation',0,NULL),(15,2105,2100,'Chemical Sampling and Analysis',0,NULL),(16,2110,2100,'Excavation, Removal and Handling of Hazardous Material',0,NULL),(17,2115,2100,'Underground Storage Tank Removal',0,NULL),(18,2120,2100,'Off-Site Transportation & Disposal',0,NULL),(19,2125,2100,'Drum Handling',0,NULL),(20,2130,2100,'Site Decontamination',0,NULL),(21,2140,2100,'Landfill Construction and Storage',0,NULL),(22,2200,2,'Site Preparation',0,NULL),(23,2210,2200,'Subsurface Investigation',0,NULL),(24,2220,2200,'Site Demolition',0,NULL);
/*!40000 ALTER TABLE `wbs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-28 10:01:14
