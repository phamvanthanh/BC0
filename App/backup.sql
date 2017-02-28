-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: erp
-- ------------------------------------------------------
-- Server version	5.6.17

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
-- Table structure for table `actiontype`
--

DROP TABLE IF EXISTS `actiontype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actiontype` (
  `No` int(10) NOT NULL,
  `Code` varchar(15) NOT NULL,
  `Discription` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actiontype`
--

LOCK TABLES `actiontype` WRITE;
/*!40000 ALTER TABLE `actiontype` DISABLE KEYS */;
/*!40000 ALTER TABLE `actiontype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute` (
  `No` int(11) NOT NULL,
  `AttributeType` varchar(100) NOT NULL,
  `AttributeCode` varchar(11) NOT NULL,
  `Description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute`
--

LOCK TABLES `attribute` WRITE;
/*!40000 ALTER TABLE `attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budget`
--

DROP TABLE IF EXISTS `budget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `budget` (
  `No` int(11) NOT NULL,
  `contractcode` varchar(25) NOT NULL,
  `subjectcode` varchar(25) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Quantity` double NOT NULL,
  `unit` varchar(5) NOT NULL,
  `rate` int(11) NOT NULL,
  `remark` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budget`
--

LOCK TABLES `budget` WRITE;
/*!40000 ALTER TABLE `budget` DISABLE KEYS */;
/*!40000 ALTER TABLE `budget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `element`
--

DROP TABLE IF EXISTS `element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `element` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `name` varchar(255) NOT NULL,
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`),
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element`
--

LOCK TABLES `element` WRITE;
/*!40000 ALTER TABLE `element` DISABLE KEYS */;
INSERT INTO `element` VALUES (1,'100000','Tráº§n tháº¡ch cao boral 9mm'),(22,'100001','Tráº§n tháº¡ch cao boral 12mm'),(23,'100002','Tráº§n tháº¡ch cao boral 15mm');
/*!40000 ALTER TABLE `element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node`
--

DROP TABLE IF EXISTS `node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`code`),
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node`
--

LOCK TABLES `node` WRITE;
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
INSERT INTO `node` VALUES (2,'1001','president',''),(4,'1002','Chief executive officer',''),(5,'1003','Production director',''),(6,'1004','Marketing director',''),(7,'1005','Project director',''),(8,'2001','Financial and accounting manager',''),(9,'2002','Human resource department manager',''),(11,'2003','Tender department manager',''),(12,'2004','Cost and contract management department manager',''),(13,'3001','Cost and contract management department staff',''),(14,'3002','F&A staff',''),(15,'3003','Tender dept. staff',''),(21,'3004','HR staff','');
/*!40000 ALTER TABLE `node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `noderestriction`
--

DROP TABLE IF EXISTS `noderestriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `noderestriction` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) NOT NULL,
  `description` varchar(255) NOT NULL,
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noderestriction`
--

LOCK TABLES `noderestriction` WRITE;
/*!40000 ALTER TABLE `noderestriction` DISABLE KEYS */;
INSERT INTO `noderestriction` VALUES (1,'I','Initiation'),(4,'V','View'),(6,'RF','Receive for further action'),(7,'A','Approval / Rejection');
/*!40000 ALTER TABLE `noderestriction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `str_transactionhead`
--

DROP TABLE IF EXISTS `str_transactionhead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `str_transactionhead` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `tNo` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `node` varchar(50) NOT NULL,
  `restriction` varchar(50) NOT NULL,
  `reply` int(5) NOT NULL,
  KEY `no` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `str_transactionhead`
--

LOCK TABLES `str_transactionhead` WRITE;
/*!40000 ALTER TABLE `str_transactionhead` DISABLE KEYS */;
/*!40000 ALTER TABLE `str_transactionhead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `str_transactionmaster`
--

DROP TABLE IF EXISTS `str_transactionmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `str_transactionmaster` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `tNo` int(11) NOT NULL,
  `tCode` varchar(50) NOT NULL,
  `cRef` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`tNo`),
  UNIQUE KEY `no_2` (`tNo`),
  KEY `tNo` (`tNo`),
  KEY `index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `str_transactionmaster`
--

LOCK TABLES `str_transactionmaster` WRITE;
/*!40000 ALTER TABLE `str_transactionmaster` DISABLE KEYS */;
/*!40000 ALTER TABLE `str_transactionmaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `str_transactionstorage`
--

DROP TABLE IF EXISTS `str_transactionstorage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `str_transactionstorage` (
  `index` int(11) NOT NULL,
  `tNo` int(11) NOT NULL,
  `item` varchar(255) NOT NULL,
  `code` varchar(50) NOT NULL,
  `unit` varchar(5) NOT NULL,
  `quantity` double NOT NULL,
  `unitCost` double NOT NULL,
  `remark` varchar(255) NOT NULL,
  KEY `index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `str_transactionstorage`
--

LOCK TABLES `str_transactionstorage` WRITE;
/*!40000 ALTER TABLE `str_transactionstorage` DISABLE KEYS */;
/*!40000 ALTER TABLE `str_transactionstorage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stream` tinyint(4) NOT NULL,
  `restriction` tinyint(1) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `code` (`code`),
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (7,'01','Office requisite',1,0),(8,'02','Sub-contract payment',1,2),(9,'03','Project resource request',1,2),(10,'04','Clearance of information',-1,3);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactioncollection`
--

DROP TABLE IF EXISTS `transactioncollection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactioncollection` (
  `no` int(11) NOT NULL,
  `transactionnno` varchar(15) NOT NULL,
  `respondednode` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactioncollection`
--

LOCK TABLES `transactioncollection` WRITE;
/*!40000 ALTER TABLE `transactioncollection` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactioncollection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactionsetup`
--

DROP TABLE IF EXISTS `transactionsetup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionsetup` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `tCode` varchar(15) NOT NULL,
  `node` varchar(100) NOT NULL,
  `parentNode` varchar(100) NOT NULL,
  `restriction` varchar(5) NOT NULL,
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactionsetup`
--

LOCK TABLES `transactionsetup` WRITE;
/*!40000 ALTER TABLE `transactionsetup` DISABLE KEYS */;
INSERT INTO `transactionsetup` VALUES (51,'01','3003','2002','I'),(52,'02','3001','2004','I'),(53,'02','2004','1005','A'),(54,'02','1005','1002','A'),(55,'02','1005','2001','RF'),(56,'01','2004','2002','I');
/*!40000 ALTER TABLE `transactionsetup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit` (
  `no` int(11) NOT NULL,
  `abbreviation` varchar(5) NOT NULL,
  `notation` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(5) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `homePhone` varchar(100) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (31,'Dang','danglv@unh.com.vn','12345678','Le Van Dang','Mr.','1992-01-27','Ngoc Lam','Hanoi','123456789','123456789'),(1,'thanhpv','pthanh.ce@gmail.com','03021986','Pham Van Thanh','Mr.','2016-04-01','La Khe','Ha Noi','0975622359','0972199097'),(32,'Tuda','tuda@unh.com.vn','12345','Do Anh Tu','Mr.','1981-12-31','Gia Lam','Hanoi','123456789','12345789');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userassignment`
--

DROP TABLE IF EXISTS `userassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userassignment` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `node` varchar(100) NOT NULL,
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userassignment`
--

LOCK TABLES `userassignment` WRITE;
/*!40000 ALTER TABLE `userassignment` DISABLE KEYS */;
INSERT INTO `userassignment` VALUES (2,'Dang','3001'),(3,'thanhpv','2004'),(4,'Tuda','1005');
/*!40000 ALTER TABLE `userassignment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-29 23:48:59
