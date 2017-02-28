-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 25, 2016 at 06:26 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `erp`
--

-- --------------------------------------------------------

--
-- Table structure for table `actiontype`
--

CREATE TABLE IF NOT EXISTS `actiontype` (
  `No` int(10) NOT NULL,
  `Code` varchar(15) NOT NULL,
  `Discription` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `attribute`
--

CREATE TABLE IF NOT EXISTS `attribute` (
  `No` int(11) NOT NULL,
  `AttributeType` varchar(100) NOT NULL,
  `AttributeCode` varchar(11) NOT NULL,
  `Description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `budget`
--

CREATE TABLE IF NOT EXISTS `budget` (
  `No` int(11) NOT NULL,
  `contractcode` varchar(25) NOT NULL,
  `subjectcode` varchar(25) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Quantity` double NOT NULL,
  `unit` varchar(5) NOT NULL,
  `rate` int(11) NOT NULL,
  `remark` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `element`
--

CREATE TABLE IF NOT EXISTS `element` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `name` varchar(255) NOT NULL,
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`),
  KEY `no` (`no`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `element`
--

INSERT INTO `element` (`no`, `code`, `name`) VALUES
(1, '100000', 'Tráº§n tháº¡ch cao boral 9mm'),
(22, '100001', 'Tráº§n tháº¡ch cao boral 12mm'),
(23, '100002', 'Tráº§n tháº¡ch cao boral 15mm');

-- --------------------------------------------------------

--
-- Table structure for table `node`
--

CREATE TABLE IF NOT EXISTS `node` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`code`),
  KEY `no` (`no`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `node`
--

INSERT INTO `node` (`no`, `code`, `name`, `description`) VALUES
(2, '1001', 'president', ''),
(4, '1002', 'Chief executive officer', ''),
(5, '1003', 'Production director', ''),
(6, '1004', 'Marketing director', ''),
(7, '1005', 'Project director', ''),
(8, '2001', 'Financial and accounting manager', ''),
(9, '2002', 'Human resource department manager', ''),
(11, '2003', 'Tender department manager', ''),
(12, '2004', 'Cost and contract management department manager', ''),
(13, '3001', 'Cost and contract management department staff', ''),
(14, '3002', 'F&A staff', ''),
(15, '3003', 'Tender dept. staff', ''),
(21, '3004', 'HR staff', '');

-- --------------------------------------------------------

--
-- Table structure for table `noderestriction`
--

CREATE TABLE IF NOT EXISTS `noderestriction` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) NOT NULL,
  `description` varchar(255) NOT NULL,
  KEY `no` (`no`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `noderestriction`
--

INSERT INTO `noderestriction` (`no`, `code`, `description`) VALUES
(1, 'I', 'Initiation'),
(4, 'V', 'View'),
(6, 'RF', 'Receive for further action'),
(7, 'A', 'Approval / Rejection');

-- --------------------------------------------------------

--
-- Table structure for table `str_transaction`
--

CREATE TABLE IF NOT EXISTS `str_transaction` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `transactionNo` int(11) NOT NULL,
  `transactionCode` varchar(50) NOT NULL,
  `controlReference` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL,
  UNIQUE KEY `no_2` (`transactionNo`),
  KEY `No` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `str_transactionhead`
--

CREATE TABLE IF NOT EXISTS `str_transactionhead` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `transactionNo` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `node` varchar(50) NOT NULL,
  `restriction` varchar(50) NOT NULL,
  `reply` int(5) NOT NULL,
  KEY `no` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `str_transactionstorage`
--

CREATE TABLE IF NOT EXISTS `str_transactionstorage` (
  `index` int(11) NOT NULL,
  `transactionNo` int(11) NOT NULL,
  `item` varchar(255) NOT NULL,
  `code` varchar(50) NOT NULL,
  `unit` varchar(5) NOT NULL,
  `quantity` double NOT NULL,
  `unitCost` double NOT NULL,
  `remark` varchar(255) NOT NULL,
  KEY `index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE IF NOT EXISTS `transaction` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stream` tinyint(4) NOT NULL,
  `restriction` tinyint(1) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `code` (`code`),
  KEY `no` (`no`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`no`, `code`, `name`, `stream`, `restriction`) VALUES
(7, '01', 'Office requisite', 1, 0),
(8, '02', 'Sub-contract payment', 1, 2),
(9, '03', 'Project resource request', 1, 2),
(10, '04', 'Clearance of information', -1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `transactioncollection`
--

CREATE TABLE IF NOT EXISTS `transactioncollection` (
  `no` int(11) NOT NULL,
  `transactionnno` varchar(15) NOT NULL,
  `respondednode` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transactionsetup`
--

CREATE TABLE IF NOT EXISTS `transactionsetup` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `transaction` varchar(15) NOT NULL,
  `node` varchar(100) NOT NULL,
  `parentNode` varchar(100) NOT NULL,
  `restriction` varchar(5) NOT NULL,
  KEY `no` (`no`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=57 ;

--
-- Dumping data for table `transactionsetup`
--

INSERT INTO `transactionsetup` (`no`, `transaction`, `node`, `parentNode`, `restriction`) VALUES
(51, '01', '3003', '2002', 'I'),
(52, '02', '3001', '2004', 'I'),
(53, '02', '2004', '1005', 'A'),
(54, '02', '1005', '1002', 'A'),
(55, '02', '1005', '2001', 'RF'),
(56, '01', '2004', '2002', 'I');

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE IF NOT EXISTS `unit` (
  `no` int(11) NOT NULL,
  `abbreviation` varchar(5) NOT NULL,
  `notation` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`no`, `uid`, `email`, `password`, `name`, `title`, `dateOfBirth`, `address`, `city`, `phone`, `homePhone`) VALUES
(31, 'Dang', 'danglv@unh.com.vn', '12345678', 'Le Van Dang', 'Mr.', '1992-01-27', 'Ngoc Lam', 'Hanoi', '123456789', '123456789'),
(1, 'thanhpv', 'pthanh.ce@gmail.com', '03021986', 'Pham Van Thanh', 'Mr.', '2016-04-01', 'La Khe', 'Ha Noi', '0975622359', '0972199097'),
(32, 'Tuda', 'tuda@unh.com.vn', '12345', 'Do Anh Tu', 'Mr.', '1981-12-31', 'Gia Lam', 'Hanoi', '123456789', '12345789');

-- --------------------------------------------------------

--
-- Table structure for table `userassignment`
--

CREATE TABLE IF NOT EXISTS `userassignment` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `node` varchar(100) NOT NULL,
  KEY `no` (`no`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `userassignment`
--

INSERT INTO `userassignment` (`no`, `uid`, `node`) VALUES
(2, 'Dang', '3001'),
(3, 'thanhpv', '2004'),
(4, 'Tuda', '1005');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
