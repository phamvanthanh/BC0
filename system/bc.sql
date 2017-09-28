-- phpMyAdmin SQL Dump
-- version 4.0.10.18
-- https://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Sep 13, 2017 at 07:52 AM
-- Server version: 10.0.20-MariaDB-cll-lve
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `nhdyjjgw_bc`
--

-- --------------------------------------------------------

--
-- Table structure for table `active_role`
--

CREATE TABLE IF NOT EXISTS `active_role` (
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role_user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_user_id` (`role_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `audit`
--

CREATE TABLE IF NOT EXISTS `audit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `quantity_id` int(11) unsigned NOT NULL,
  `quantity` double DEFAULT NULL,
  `commit` char(5) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quantity_id` (`quantity_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `audit_files`
--

CREATE TABLE IF NOT EXISTS `audit_files` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `audit_id` int(11) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `audit_id` (`audit_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `audit_markdowns`
--

CREATE TABLE IF NOT EXISTS `audit_markdowns` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `audit_id` int(11) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `audit_id` (`audit_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE IF NOT EXISTS `bids` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_id` (`job_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=37 ;

--
-- Dumping data for table `bids`
--

INSERT INTO `bids` (`id`, `job_id`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
(4, 1, 3, 'awarded', '2017-07-09 00:41:44', '2017-09-06 08:58:02'),
(9, 4, 3, 'awarded', '2017-08-16 18:21:24', '2017-08-19 01:45:18'),
(10, 5, 3, NULL, '2017-08-16 18:27:18', '2017-08-16 18:27:18'),
(12, 1, 13, 'withhold', '2017-08-31 10:10:46', '2017-09-06 08:57:55'),
(13, 21, 6, 'awarded', '2017-09-04 10:43:15', '2017-09-04 10:49:47'),
(14, 20, 3, 'awarded', '2017-09-13 07:13:26', '2017-09-13 07:18:25'),
(15, 22, 3, 'awarded', '2017-09-13 07:13:34', '2017-09-13 07:18:57'),
(16, 23, 3, 'awarded', '2017-09-13 07:13:40', '2017-09-13 07:19:08'),
(17, 24, 3, 'awarded', '2017-09-13 07:13:46', '2017-09-13 07:19:18'),
(18, 25, 3, 'awarded', '2017-09-13 07:13:52', '2017-09-13 07:19:28'),
(19, 26, 3, 'awarded', '2017-09-13 07:13:57', '2017-09-13 07:19:37'),
(20, 27, 3, 'awarded', '2017-09-13 07:14:04', '2017-09-13 07:19:45'),
(21, 29, 3, 'awarded', '2017-09-13 07:14:09', '2017-09-13 07:19:55'),
(22, 30, 3, 'awarded', '2017-09-13 07:14:15', '2017-09-13 07:20:04'),
(23, 31, 3, 'awarded', '2017-09-13 07:14:19', '2017-09-13 07:20:13'),
(24, 32, 3, 'awarded', '2017-09-13 07:14:27', '2017-09-13 07:20:24'),
(25, 33, 3, 'awarded', '2017-09-13 07:14:32', '2017-09-13 07:20:33'),
(26, 34, 3, 'awarded', '2017-09-13 07:14:38', '2017-09-13 07:20:42'),
(27, 35, 3, 'awarded', '2017-09-13 07:14:43', '2017-09-13 07:20:51'),
(28, 36, 3, 'awarded', '2017-09-13 07:14:48', '2017-09-13 07:21:01'),
(29, 37, 3, 'awarded', '2017-09-13 07:14:54', '2017-09-13 07:21:11'),
(30, 38, 3, 'awarded', '2017-09-13 07:15:00', '2017-09-13 07:21:18'),
(31, 39, 3, 'awarded', '2017-09-13 07:15:06', '2017-09-13 07:21:28'),
(32, 40, 3, 'awarded', '2017-09-13 07:15:12', '2017-09-13 07:21:37'),
(33, 41, 3, 'awarded', '2017-09-13 07:15:19', '2017-09-13 07:21:46'),
(34, 42, 3, 'awarded', '2017-09-13 07:15:24', '2017-09-13 07:22:03'),
(35, 43, 3, 'awarded', '2017-09-13 07:15:30', '2017-09-13 07:22:34'),
(36, 44, 3, 'awarded', '2017-09-13 07:15:36', '2017-09-13 07:22:46');

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `folder_id` int(11) unsigned NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `revision` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `folder_id` (`folder_id`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=456 ;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `folder_id`, `path`, `name`, `status`, `created_at`, `updated_at`, `revision`) VALUES
(360, 29, 'uploads/projects/folders/29/1504149642Specification Tender Issue.pdf', 'Specification Tender Issue.pdf', NULL, '2017-08-31 10:20:45', '2017-08-31 10:20:45', NULL),
(395, 30, 'project_files/folders/30/Specification Tender Issue.pdf', 'Specification Tender Issue.pdf', NULL, '2017-08-31 17:47:33', '2017-08-31 17:47:33', NULL),
(396, 31, 'project_files/folders/31/A100 - LEGENDS-rev 0.pdf', 'A100 - LEGENDS-rev 0.pdf', NULL, '2017-08-31 17:48:53', '2017-08-31 17:49:19', NULL),
(397, 31, 'project_files/folders/31/A101-SITE-PLAN-rev 0.pdf', 'A101-SITE-PLAN-rev 0.pdf', NULL, '2017-09-04 14:33:15', '2017-09-04 14:33:15', NULL),
(398, 31, 'project_files/folders/31/A102-STAGE PLANS-rev 0.pdf', 'A102-STAGE PLANS-rev 0.pdf', NULL, '2017-09-04 14:33:20', '2017-09-04 14:33:20', NULL),
(399, 31, 'project_files/folders/31/A201 - GF PLAN-rev 0.pdf', 'A201 - GF PLAN-rev 0.pdf', NULL, '2017-09-04 14:33:20', '2017-09-04 14:33:20', NULL),
(400, 31, 'project_files/folders/31/A202 - FF PLAN-rev 0.pdf', 'A202 - FF PLAN-rev 0.pdf', NULL, '2017-09-04 14:33:23', '2017-09-04 14:33:23', NULL),
(401, 31, 'project_files/folders/31/A211 - GF DEMO PLAN-rev 0.pdf', 'A211 - GF DEMO PLAN-rev 0.pdf', NULL, '2017-09-04 14:33:23', '2017-09-04 14:33:23', NULL),
(402, 31, 'project_files/folders/31/A221 - GF FLOOR FIN-rev 0.pdf', 'A221 - GF FLOOR FIN-rev 0.pdf', NULL, '2017-09-04 14:33:25', '2017-09-04 14:33:25', NULL),
(403, 31, 'project_files/folders/31/A212 - FF DEMO PLAN-rev 0.pdf', 'A212 - FF DEMO PLAN-rev 0.pdf', NULL, '2017-09-04 14:33:26', '2017-09-04 14:33:26', NULL),
(404, 31, 'project_files/folders/31/A222 - FF FLOOR FIN-rev 0.pdf', 'A222 - FF FLOOR FIN-rev 0.pdf', NULL, '2017-09-04 14:33:28', '2017-09-04 14:33:28', NULL),
(405, 31, 'project_files/folders/31/A301 - GF RCP-rev 0.pdf', 'A301 - GF RCP-rev 0.pdf', NULL, '2017-09-04 14:33:28', '2017-09-04 14:33:28', NULL),
(406, 31, 'project_files/folders/31/A401 - ROOF PLAN-rev 0.pdf', 'A401 - ROOF PLAN-rev 0.pdf', NULL, '2017-09-04 14:33:31', '2017-09-04 14:33:31', NULL),
(407, 31, 'project_files/folders/31/A302 - FF RCP-rev 0.pdf', 'A302 - FF RCP-rev 0.pdf', NULL, '2017-09-04 14:33:32', '2017-09-04 14:33:32', NULL),
(408, 31, 'project_files/folders/31/A501 - ELEVATIONS-rev 0.pdf', 'A501 - ELEVATIONS-rev 0.pdf', NULL, '2017-09-04 14:33:33', '2017-09-04 14:33:33', NULL),
(409, 31, 'project_files/folders/31/A601 - SECTIONS-rev 0.pdf', 'A601 - SECTIONS-rev 0.pdf', NULL, '2017-09-04 14:33:34', '2017-09-04 14:33:34', NULL),
(410, 31, 'project_files/folders/31/A701 - DETAILS-rev 0.pdf', 'A701 - DETAILS-rev 0.pdf', NULL, '2017-09-04 14:33:35', '2017-09-04 14:33:35', NULL),
(411, 31, 'project_files/folders/31/A702 - DETAILS-rev 0.pdf', 'A702 - DETAILS-rev 0.pdf', NULL, '2017-09-04 14:33:38', '2017-09-04 14:33:38', NULL),
(412, 31, 'project_files/folders/31/A704 - DETAILS-rev 0.pdf', 'A704 - DETAILS-rev 0.pdf', NULL, '2017-09-04 14:33:39', '2017-09-04 14:33:39', NULL),
(413, 31, 'project_files/folders/31/A703 - DETAILS-rev 0.pdf', 'A703 - DETAILS-rev 0.pdf', NULL, '2017-09-04 14:33:39', '2017-09-04 14:33:39', NULL),
(414, 31, 'project_files/folders/31/A706 - DETAILS-rev 0.pdf', 'A706 - DETAILS-rev 0.pdf', NULL, '2017-09-04 14:33:41', '2017-09-04 14:33:41', NULL),
(415, 31, 'project_files/folders/31/A705 - DETAILS-rev 0.pdf', 'A705 - DETAILS-rev 0.pdf', NULL, '2017-09-04 14:33:41', '2017-09-04 14:33:41', NULL),
(416, 31, 'project_files/folders/31/A707 - DETAILS-rev 0.pdf', 'A707 - DETAILS-rev 0.pdf', NULL, '2017-09-04 14:33:42', '2017-09-04 14:33:42', NULL),
(417, 31, 'project_files/folders/31/A708 - DETAILS-rev 0.pdf', 'A708 - DETAILS-rev 0.pdf', NULL, '2017-09-04 14:33:42', '2017-09-04 14:33:42', NULL),
(418, 31, 'project_files/folders/31/A709 - PLANT PLAN-rev 0.pdf', 'A709 - PLANT PLAN-rev 0.pdf', NULL, '2017-09-04 14:33:43', '2017-09-04 14:33:43', NULL),
(419, 31, 'project_files/folders/31/A710 - DETAILS-rev 0.pdf', 'A710 - DETAILS-rev 0.pdf', NULL, '2017-09-04 14:33:45', '2017-09-04 14:33:45', NULL),
(420, 31, 'project_files/folders/31/A802 - JOINERY DETAILS RECEPTION DESK-rev 0.pdf', 'A802 - JOINERY DETAILS RECEPTION DESK-rev 0.pdf', NULL, '2017-09-04 14:33:48', '2017-09-04 14:33:48', NULL),
(421, 31, 'project_files/folders/31/A801 - ROOM LAYOUTS-WET AREAS - rev0.pdf', 'A801 - ROOM LAYOUTS-WET AREAS - rev0.pdf', NULL, '2017-09-04 14:33:48', '2017-09-04 14:33:48', NULL),
(422, 31, 'project_files/folders/31/A803 - JOINERY DETAILS FF-TEA PREP-rev 0.pdf', 'A803 - JOINERY DETAILS FF-TEA PREP-rev 0.pdf', NULL, '2017-09-04 14:33:49', '2017-09-04 14:33:49', NULL),
(423, 31, 'project_files/folders/31/A804 - JOINERY DETAILS VOLUNTEERS & STAFF - rev 0.pdf', 'A804 - JOINERY DETAILS VOLUNTEERS & STAFF - rev 0.pdf', NULL, '2017-09-04 14:33:49', '2017-09-04 14:33:49', NULL),
(424, 31, 'project_files/folders/31/A806 - JOINERY DETAILS STORAGE-rev 0.pdf', 'A806 - JOINERY DETAILS STORAGE-rev 0.pdf', NULL, '2017-09-04 14:33:50', '2017-09-04 14:33:50', NULL),
(425, 31, 'project_files/folders/31/A805 - JOINERY DETAILS TEA PREP-rev 0.pdf', 'A805 - JOINERY DETAILS TEA PREP-rev 0.pdf', NULL, '2017-09-04 14:33:50', '2017-09-04 14:33:50', NULL),
(426, 31, 'project_files/folders/31/A901 - DOOR SCHED1-rev 0.pdf', 'A901 - DOOR SCHED1-rev 0.pdf', NULL, '2017-09-04 14:33:52', '2017-09-04 14:33:52', NULL),
(427, 31, 'project_files/folders/31/A902 - DOOR SCHED2-rev 0.pdf', 'A902 - DOOR SCHED2-rev 0.pdf', NULL, '2017-09-04 14:33:52', '2017-09-04 14:33:52', NULL),
(428, 31, 'project_files/folders/31/A911 - WIN SCHED1-rev 0.pdf', 'A911 - WIN SCHED1-rev 0.pdf', NULL, '2017-09-04 14:33:54', '2017-09-04 14:33:54', NULL),
(429, 31, 'project_files/folders/31/A903 - DOOR SCHED3-rev 0.pdf', 'A903 - DOOR SCHED3-rev 0.pdf', NULL, '2017-09-04 14:33:54', '2017-09-04 14:33:54', NULL),
(430, 32, 'project_files/folders/32/S04616 - S06 - TEMP PROP PLAN - 0.pdf', 'S04616 - S06 - TEMP PROP PLAN - 0.pdf', NULL, '2017-09-06 14:40:03', '2017-09-06 14:40:03', NULL),
(431, 32, 'project_files/folders/32/S04616 - S05 - GF FOOTING PLAN - 0.pdf', 'S04616 - S05 - GF FOOTING PLAN - 0.pdf', NULL, '2017-09-06 14:40:03', '2017-09-06 14:40:03', NULL),
(432, 32, 'project_files/folders/32/S04616 - S07 - FF SLAB PLAN  - 0.pdf', 'S04616 - S07 - FF SLAB PLAN  - 0.pdf', NULL, '2017-09-06 14:40:03', '2017-09-06 14:40:03', NULL),
(433, 32, 'project_files/folders/32/S04616 - S08 - ROOF PLAN  - 0.pdf', 'S04616 - S08 - ROOF PLAN  - 0.pdf', NULL, '2017-09-06 14:40:04', '2017-09-06 14:40:04', NULL),
(434, 32, 'project_files/folders/32/S04616 - S11 - STRUCTURAL DETAILS - 0.pdf', 'S04616 - S11 - STRUCTURAL DETAILS - 0.pdf', NULL, '2017-09-06 14:40:04', '2017-09-06 14:40:04', NULL),
(435, 32, 'project_files/folders/32/S04616 - S10 - STRUCTURAL DETAILS  - 0.pdf', 'S04616 - S10 - STRUCTURAL DETAILS  - 0.pdf', NULL, '2017-09-06 14:40:04', '2017-09-06 14:40:04', NULL),
(436, 32, 'project_files/folders/32/SECTION  14200 LIFTS REV A.pdf', 'SECTION  14200 LIFTS REV A.pdf', NULL, '2017-09-06 14:40:05', '2017-09-06 14:40:05', NULL),
(437, 30, 'project_files/folders/30/S04616 - S02 - GENERAL NOTES SHEET 2 - 0.pdf', 'S04616 - S02 - GENERAL NOTES SHEET 2 - 0.pdf', NULL, '2017-09-06 14:40:39', '2017-09-06 14:40:39', NULL),
(438, 30, 'project_files/folders/30/S04616 - S01 - GENERAL NOTES SHEET 1 - 0.pdf', 'S04616 - S01 - GENERAL NOTES SHEET 1 - 0.pdf', NULL, '2017-09-06 14:40:40', '2017-09-06 14:40:40', NULL),
(439, 33, 'project_files/folders/33/1516.222.E.02-0.pdf', '1516.222.E.02-0.pdf', NULL, '2017-09-06 14:52:00', '2017-09-06 14:52:00', NULL),
(440, 33, 'project_files/folders/33/1516.222.E.01-0.pdf', '1516.222.E.01-0.pdf', NULL, '2017-09-06 14:52:00', '2017-09-06 14:52:00', NULL),
(441, 33, 'project_files/folders/33/1516.222.E.04-0.pdf', '1516.222.E.04-0.pdf', NULL, '2017-09-06 14:52:21', '2017-09-06 14:52:21', NULL),
(442, 33, 'project_files/folders/33/1516.222.E.03-0.pdf', '1516.222.E.03-0.pdf', NULL, '2017-09-06 14:52:21', '2017-09-06 14:52:21', NULL),
(443, 33, 'project_files/folders/33/1516.222.E.06-0.pdf', '1516.222.E.06-0.pdf', NULL, '2017-09-06 14:52:36', '2017-09-06 14:52:36', NULL),
(444, 33, 'project_files/folders/33/1516.222.E.05-0.pdf', '1516.222.E.05-0.pdf', NULL, '2017-09-06 14:52:42', '2017-09-06 14:52:42', NULL),
(445, 33, 'project_files/folders/33/1516.222.E.07-0.pdf', '1516.222.E.07-0.pdf', NULL, '2017-09-06 14:52:47', '2017-09-06 14:52:47', NULL),
(446, 34, 'project_files/folders/34/27689-1-PER-H00_C.pdf', '27689-1-PER-H00_C.pdf', NULL, '2017-09-06 14:55:27', '2017-09-06 14:55:27', NULL),
(447, 34, 'project_files/folders/34/27689-1-PER-H01_C.pdf', '27689-1-PER-H01_C.pdf', NULL, '2017-09-06 14:55:31', '2017-09-06 14:55:31', NULL),
(448, 34, 'project_files/folders/34/27689-1-PER-H02_D.pdf', '27689-1-PER-H02_D.pdf', NULL, '2017-09-06 14:55:33', '2017-09-06 14:55:33', NULL),
(449, 34, 'project_files/folders/34/27689-1-PER-H03_D.pdf', '27689-1-PER-H03_D.pdf', NULL, '2017-09-06 14:55:40', '2017-09-06 14:55:40', NULL),
(450, 34, 'project_files/folders/34/27689-1-PER-H04_D.pdf', '27689-1-PER-H04_D.pdf', NULL, '2017-09-06 14:55:40', '2017-09-06 14:55:40', NULL),
(451, 34, 'project_files/folders/34/27689-1-PER-H05_D.pdf', '27689-1-PER-H05_D.pdf', NULL, '2017-09-06 14:55:45', '2017-09-06 14:55:45', NULL),
(452, 34, 'project_files/folders/34/27689-1-PER-H06_D.pdf', '27689-1-PER-H06_D.pdf', NULL, '2017-09-06 14:55:46', '2017-09-06 14:55:46', NULL),
(453, 34, 'project_files/folders/34/27689-1-PER-H07_D.pdf', '27689-1-PER-H07_D.pdf', NULL, '2017-09-06 14:55:50', '2017-09-06 14:55:50', NULL),
(454, 34, 'project_files/folders/34/27689-1-PER-H08_A.pdf', '27689-1-PER-H08_A.pdf', NULL, '2017-09-06 14:55:50', '2017-09-06 14:55:50', NULL),
(455, 34, 'project_files/folders/34/27689-1-PER-H09_A.pdf', '27689-1-PER-H09_A.pdf', NULL, '2017-09-06 14:55:52', '2017-09-06 14:55:52', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `folders`
--

CREATE TABLE IF NOT EXISTS `folders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `project_id` int(11) unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=36 ;

--
-- Dumping data for table `folders`
--

INSERT INTO `folders` (`id`, `name`, `project_id`, `created_at`, `updated_at`) VALUES
(29, 'References', 2, '2017-08-31 10:20:15', '2017-08-31 10:20:15'),
(30, 'References', 1, '2017-08-31 17:46:51', '2017-08-31 17:46:51'),
(31, 'Achitecture', 1, '2017-08-31 17:48:36', '2017-08-31 17:48:36'),
(32, 'Structure', 1, '2017-09-06 14:39:32', '2017-09-06 14:39:32'),
(33, 'Electrical', 1, '2017-09-06 14:42:23', '2017-09-06 14:42:23'),
(34, 'Hydraulic', 1, '2017-09-06 14:44:26', '2017-09-06 14:44:26');

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE IF NOT EXISTS `forms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` int(11) unsigned DEFAULT NULL,
  `name` varchar(225) DEFAULT NULL,
  `path` varchar(225) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`id`, `code`, `name`, `path`, `status`, `created_at`, `updated_at`) VALUES
(11, 31000, 'Concrete Forms and Accessories', '/forms/F_31000.xlsx', NULL, '2017-08-04 14:10:00', '2017-09-07 16:29:55'),
(12, 33000, 'Cast-In-Place Concrete', '/forms/F_33000.xlsx', NULL, '2017-09-04 16:15:19', '2017-09-07 16:32:52'),
(13, 34000, 'Precast Concrete', '/forms/F_34000.xlsx', NULL, '2017-09-04 16:15:53', '2017-09-07 16:32:59'),
(14, 35000, 'Cast Decks and Underlayment', '/home/nhdyjjgwhosting/public_html/system/storage/forms/F_35000.xlsx', NULL, '2017-09-04 16:18:03', '2017-09-04 16:18:03'),
(15, 36000, 'Grouts', '/forms/F_36000.xlsx', NULL, '2017-09-04 16:19:28', '2017-09-07 16:33:16'),
(16, 37000, 'Mass Concrete', '/forms/F_37000.xlsx', NULL, '2017-09-04 16:21:04', '2017-09-07 16:33:32'),
(17, 38000, 'Concrete Cutting & Boring', '/forms/F_38000.xlsx', NULL, '2017-09-04 16:22:07', '2017-09-07 16:33:47'),
(18, 42000, 'Masonry Units', '/forms/F_42000.xlsx', NULL, '2017-09-04 16:26:37', '2017-09-07 16:34:04'),
(19, 51000, 'Structural Metal Framing', '/forms/F_51000.xlsx', NULL, '2017-09-04 16:32:43', '2017-09-07 16:34:14'),
(20, 52000, 'Metal Joists', '/forms/F_52000.xlsx', NULL, '2017-09-04 16:33:09', '2017-09-07 16:34:24'),
(21, 53000, 'Metal Deck', '/forms/F_53000.xlsx', NULL, '2017-09-04 16:35:33', '2017-09-07 16:34:37'),
(22, 54000, 'Cold-Formed Metal Framing', '/forms/F_54000.xlsx', NULL, '2017-09-04 16:37:49', '2017-09-07 16:36:15'),
(23, 61000, 'Rough Carpentry', '/forms/F_61000.xlsx', NULL, '2017-09-04 16:39:58', '2017-09-07 16:36:26');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `created_by` int(11) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `project_id`, `name`, `description`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'Structure', 'All structural works of the project', NULL, '2017-07-07 09:05:44', '2017-07-07 09:05:44'),
(2, 1, 'Architecture', 'All architectural works of the project', NULL, '2017-07-23 13:05:04', '2017-07-23 13:05:04');

-- --------------------------------------------------------

--
-- Table structure for table `gwbs`
--

CREATE TABLE IF NOT EXISTS `gwbs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(25) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `section_id` int(11) unsigned NOT NULL,
  `project_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`section_id`,`code`),
  KEY `project_id` (`project_id`,`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=56 ;

--
-- Dumping data for table `gwbs`
--

INSERT INTO `gwbs` (`id`, `code`, `created_at`, `updated_at`, `section_id`, `project_id`) VALUES
(1, '030000', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(2, '0', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(3, '031500', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(4, '031000', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(5, '031513.16', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(6, '031513', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(7, '031113', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(8, '031100', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(9, '032214.10', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(10, '032214', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(11, '032200', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(12, '032000', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(13, '032214.11', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(14, '032214.12', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(15, '032100', '2017-09-12 16:06:16', '2017-09-12 16:06:16', 10, 1),
(16, '033000', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(17, '033100', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(18, '034000', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(19, '034100', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(20, '036000', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(21, '036100', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(22, '036300', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(23, '037200', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(24, '037000', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(25, '037100', '2017-09-12 16:06:27', '2017-09-12 16:06:27', 10, 1),
(26, '042800', '2017-09-12 16:06:42', '2017-09-12 16:06:42', 11, 1),
(27, '042000', '2017-09-12 16:06:42', '2017-09-12 16:06:42', 11, 1),
(28, '040000', '2017-09-12 16:06:42', '2017-09-12 16:06:42', 11, 1),
(29, '0', '2017-09-12 16:06:42', '2017-09-12 16:06:42', 11, 1),
(30, '042600', '2017-09-12 16:06:42', '2017-09-12 16:06:42', 11, 1),
(31, '042100', '2017-09-12 16:06:42', '2017-09-12 16:06:42', 11, 1),
(32, '051200', '2017-09-12 16:06:59', '2017-09-12 16:06:59', 12, 1),
(33, '051000', '2017-09-12 16:06:59', '2017-09-12 16:06:59', 12, 1),
(34, '050000', '2017-09-12 16:06:59', '2017-09-12 16:06:59', 12, 1),
(35, '0', '2017-09-12 16:06:59', '2017-09-12 16:06:59', 12, 1),
(36, '093036', '2017-09-12 16:07:18', '2017-09-12 16:07:18', 13, 1),
(37, '093000', '2017-09-12 16:07:18', '2017-09-12 16:07:18', 13, 1),
(38, '090000', '2017-09-12 16:07:18', '2017-09-12 16:07:18', 13, 1),
(39, '0', '2017-09-12 16:07:18', '2017-09-12 16:07:18', 13, 1),
(52, '093019', '2017-09-12 16:10:12', '2017-09-12 16:10:12', 13, 1),
(53, '093033', '2017-09-12 16:10:15', '2017-09-12 16:10:15', 13, 1),
(54, '093300', '2017-09-12 16:10:18', '2017-09-12 16:10:18', 13, 1),
(55, '093336', '2017-09-12 16:12:08', '2017-09-12 16:12:08', 13, 1);

-- --------------------------------------------------------

--
-- Table structure for table `industry`
--

CREATE TABLE IF NOT EXISTS `industry` (
  `id` int(2) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `industry`
--

INSERT INTO `industry` (`id`, `name`, `description`) VALUES
(1, 'RCB', 'Residential and Commercial buildingsR&C'),
(2, 'IP', 'Industrial Plants'),
(3, 'CI', 'Civil and Infrastructure'),
(4, 'RB', 'Road and Bridge');

-- --------------------------------------------------------

--
-- Table structure for table `issues`
--

CREATE TABLE IF NOT EXISTS `issues` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL,
  `job_id` int(11) unsigned NOT NULL,
  `title` varchar(500) NOT NULL,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `issues`
--

INSERT INTO `issues` (`id`, `user_id`, `job_id`, `title`, `description`, `created_at`, `updated_at`, `status`) VALUES
(1, 1, 1, 'Test issue', 'This is the test issue of the project', '2017-07-25 08:51:01', '2017-08-09 19:24:16', 'closed'),
(18, 3, 1, 'Issue From Project Manager', '<p>Please update MEP documents</p>', '2017-07-27 09:12:50', '2017-07-29 15:13:43', 'closed'),
(20, 3, 1, 'This is my new issue with an image', '<p><img src="/issues/15013151975.png">I need to insert an image here</p><p><br></p>', '2017-07-29 14:59:35', '2017-07-29 14:59:59', NULL),
(21, 3, 4, 'Something about', '<p>Test issue</p>', '2017-09-02 09:10:12', '2017-09-02 09:10:35', 'open'),
(22, 3, 4, 'Issue 2', '<p>Test the issue</p>', '2017-09-02 09:11:45', '2017-09-02 09:11:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `issue_replies`
--

CREATE TABLE IF NOT EXISTS `issue_replies` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `reply` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `job_id` int(11) unsigned NOT NULL,
  `issue_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  KEY `issue_id` (`issue_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Dumping data for table `issue_replies`
--

INSERT INTO `issue_replies` (`id`, `reply`, `created_at`, `updated_at`, `job_id`, `issue_id`, `user_id`) VALUES
(15, 'Anyone help to close my issue change?', '2017-07-27 10:30:38', '2017-07-27 10:38:21', 1, 1, 3),
(29, '<p>Y</p>', '2017-07-29 13:02:24', '2017-07-29 13:36:12', 1, 1, 3),
(30, '<p><br></p>', '2017-07-29 13:27:23', '2017-07-29 13:36:20', 1, 1, 3),
(31, '<p><br></p>', '2017-07-29 14:45:27', '2017-07-29 14:45:27', 1, 18, 3),
(32, '<p>I do not understand your comments at all???</p><p><img src="/issues/1501466052adada.png"></p>', '2017-07-29 15:17:13', '2017-07-31 08:54:14', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `jobable_id` int(11) unsigned NOT NULL,
  `jobable_type` varchar(50) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `rate` int(3) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jobable_id` (`jobable_id`,`jobable_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=45 ;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `jobable_id`, `jobable_type`, `from_date`, `to_date`, `status`, `comment`, `rate`, `created_at`, `updated_at`) VALUES
(1, 1, 'project', '2017-09-01', '2017-09-15', 'active', 'dzxcxzcz', 2, '2017-07-07 00:32:12', '2017-08-30 16:11:44'),
(4, 2, 'project', '2017-09-01', '2017-09-15', 'active', NULL, NULL, '2017-07-12 07:39:03', '2017-08-31 10:25:30'),
(5, 3, 'project', '2017-09-02', '2017-09-28', 'active', NULL, NULL, '2017-07-12 12:35:16', '2017-08-31 13:08:20'),
(20, 10, 'section', '2017-09-01', '2017-09-15', 'active', NULL, NULL, '2017-08-31 13:16:07', '2017-08-31 13:16:07'),
(21, 11, 'section', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-08-31 13:17:52', '2017-09-12 15:50:33'),
(22, 9, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-08-31 14:28:02', '2017-09-12 15:35:39'),
(23, 10, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-08-31 14:35:24', '2017-09-12 15:36:03'),
(24, 11, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-08-31 14:36:35', '2017-09-12 15:51:28'),
(25, 12, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-08-31 14:37:29', '2017-09-12 15:52:18'),
(26, 12, 'section', '2017-09-07', '2017-09-15', 'active', NULL, NULL, '2017-09-07 15:09:06', '2017-09-12 15:44:34'),
(27, 13, 'section', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-07 15:10:28', '2017-09-12 15:45:20'),
(29, 13, 'package', '2017-09-11', '2017-09-14', 'active', NULL, NULL, '2017-09-11 16:27:56', '2017-09-11 16:27:56'),
(30, 14, 'package', '2017-09-11', '2017-09-15', 'active', NULL, NULL, '2017-09-11 16:28:47', '2017-09-12 15:58:22'),
(31, 15, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-11 16:32:52', '2017-09-12 16:02:45'),
(32, 16, 'package', '2017-09-11', '2017-09-14', 'active', NULL, NULL, '2017-09-11 16:36:18', '2017-09-11 16:36:18'),
(33, 17, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 15:37:58', '2017-09-12 15:37:58'),
(34, 18, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 15:38:20', '2017-09-12 15:38:20'),
(35, 19, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 15:39:18', '2017-09-12 15:39:18'),
(36, 20, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 15:53:03', '2017-09-12 15:53:03'),
(37, 21, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 15:53:44', '2017-09-12 15:53:44'),
(38, 22, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 15:54:08', '2017-09-12 15:54:08'),
(39, 23, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 15:58:51', '2017-09-12 15:58:51'),
(40, 24, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 15:59:48', '2017-09-12 15:59:48'),
(41, 25, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 16:00:22', '2017-09-12 16:00:22'),
(42, 26, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 16:03:21', '2017-09-12 16:03:21'),
(43, 27, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 16:04:26', '2017-09-12 16:04:26'),
(44, 28, 'package', '2017-09-12', '2017-09-15', 'active', NULL, NULL, '2017-09-12 16:04:52', '2017-09-12 16:04:52');

-- --------------------------------------------------------

--
-- Table structure for table `job_holders`
--

CREATE TABLE IF NOT EXISTS `job_holders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  `status` char(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_id` (`job_id`,`role_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `job_message`
--

CREATE TABLE IF NOT EXISTS `job_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `from_job_id` int(11) unsigned NOT NULL,
  `to_job_id` int(11) unsigned NOT NULL,
  `message_id` int(11) unsigned NOT NULL,
  `private` tinyint(1) unsigned DEFAULT NULL,
  `read` tinyint(1) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`),
  KEY `from_job_id` (`from_job_id`),
  KEY `to_job_id` (`to_job_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=660 ;

--
-- Dumping data for table `job_message`
--

INSERT INTO `job_message` (`id`, `from_job_id`, `to_job_id`, `message_id`, `private`, `read`, `created_at`, `updated_at`) VALUES
(656, 1, 1, 791, 1, 1, '2017-08-31 09:08:07', '2017-08-31 09:08:09'),
(657, 1, 1, 792, 1, NULL, '2017-08-31 21:27:35', '2017-08-31 21:27:35'),
(658, 4, 4, 793, 1, 1, '2017-09-01 21:31:43', '2017-09-04 14:26:25'),
(659, 4, 4, 794, 1, 1, '2017-09-01 21:32:30', '2017-09-04 14:26:25');

-- --------------------------------------------------------

--
-- Table structure for table `leadMessage`
--

CREATE TABLE IF NOT EXISTS `leadMessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leadId` int(11) unsigned NOT NULL,
  `message` varchar(200) NOT NULL,
  `timeStamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `leadId` (`leadId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `leadMessage`
--

INSERT INTO `leadMessage` (`id`, `leadId`, `message`, `timeStamp`) VALUES
(14, 3, 'Please call me back!', '2016-12-14 11:41:58');

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE IF NOT EXISTS `leads` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `level` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) NOT NULL DEFAULT '1',
  `timeStamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `varify` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `first_name`, `last_name`, `email`, `password`, `phone`, `company_name`, `level`, `display`, `timeStamp`, `varify`) VALUES
(3, 'Steve', 'Pelon', 'qscompanion@gmail.com', '$2y$10$MeJ7NZPxRphUrIJehs.Nde4QR17I3Wl.O66W197PMvw1IFc5aLLD2', '+84975622359', 'Companion Inc', 0, 1, '2016-12-14 11:41:58', 0);

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `url` varchar(1024) NOT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`caption`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `links`
--

INSERT INTO `links` (`id`, `project_id`, `caption`, `url`, `note`, `created_at`, `updated_at`) VALUES
(1, 1, 'Structure', 'https://www.w3schools.com/bootstrap/bootstrap_badges_labels.asp', NULL, '2017-07-18 08:38:54', '2017-07-18 08:38:54'),
(3, 1, 'Architecture', 'https://vuejs.org/v2/api/#v-on', NULL, '2017-07-18 08:51:45', '2017-07-18 08:51:45');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL,
  `message` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=795 ;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `message`, `created_at`, `updated_at`) VALUES
(589, 3, 'Public messages;', '2017-08-20 19:01:18', '2017-08-20 19:01:18'),
(590, 3, 'private messages;', '2017-08-20 19:01:30', '2017-08-20 19:01:30'),
(591, 3, 'send message', '2017-08-20 22:16:52', '2017-08-20 22:16:52'),
(592, 10, 'Send  messages', '2017-08-21 12:48:55', '2017-08-21 12:48:55'),
(593, 13, 'This is fro surveyor', '2017-08-21 18:24:31', '2017-08-21 18:24:31'),
(594, 13, 'Next message to group', '2017-08-21 18:26:45', '2017-08-21 18:26:45'),
(595, 13, 'It is perfect', '2017-08-21 18:26:55', '2017-08-21 18:26:55'),
(596, 3, 'new messages', '2017-08-22 13:55:31', '2017-08-22 13:55:31'),
(597, 10, 'Public message', '2017-08-22 14:06:32', '2017-08-22 14:06:32'),
(598, 10, 'Public message', '2017-08-22 14:06:37', '2017-08-22 14:06:37'),
(599, 10, 'Public message', '2017-08-22 14:06:41', '2017-08-22 14:06:41'),
(600, 10, 'public message', '2017-08-22 14:06:48', '2017-08-22 14:06:48'),
(601, 10, 'public message 5', '2017-08-22 14:06:56', '2017-08-22 14:06:56'),
(602, 10, 'public message 6', '2017-08-22 14:07:02', '2017-08-22 14:07:02'),
(603, 10, 'public message 7', '2017-08-22 14:07:07', '2017-08-22 14:07:07'),
(604, 10, 'public message 8', '2017-08-22 14:07:13', '2017-08-22 14:07:13'),
(605, 10, 'public message 9', '2017-08-22 14:07:17', '2017-08-22 14:07:17'),
(606, 10, 'public message 10', '2017-08-22 14:07:22', '2017-08-22 14:07:22'),
(607, 10, 'Private message 1', '2017-08-22 14:07:51', '2017-08-22 14:07:51'),
(608, 10, 'private message 2', '2017-08-22 14:07:57', '2017-08-22 14:07:57'),
(609, 10, 'private message 3', '2017-08-22 14:08:04', '2017-08-22 14:08:04'),
(610, 10, 'private message 4', '2017-08-22 14:08:10', '2017-08-22 14:08:10'),
(611, 10, 'private message 5', '2017-08-22 14:08:15', '2017-08-22 14:08:15'),
(612, 10, 'private messate 6', '2017-08-22 14:08:22', '2017-08-22 14:08:22'),
(613, 10, 'private message 7', '2017-08-22 14:08:32', '2017-08-22 14:08:32'),
(614, 13, 'Public message from #3 Package Structure 01', '2017-08-22 16:29:25', '2017-08-22 16:29:25'),
(615, 13, 'who from', '2017-08-22 16:39:05', '2017-08-22 16:39:05'),
(616, 13, 'To #2', '2017-08-22 16:39:35', '2017-08-22 16:39:35'),
(617, 13, 'I am your project manager', '2017-08-22 16:51:57', '2017-08-22 16:51:57'),
(618, 13, 'sorry I am your surveyor', '2017-08-22 16:52:19', '2017-08-22 16:52:19'),
(619, 13, 'send a message', '2017-08-22 17:01:44', '2017-08-22 17:01:44'),
(620, 13, 'Message from #3', '2017-08-22 17:05:42', '2017-08-22 17:05:42'),
(621, 13, 'send a ms', '2017-08-22 17:34:36', '2017-08-22 17:34:36'),
(622, 13, 'message send', '2017-08-22 17:45:35', '2017-08-22 17:45:35'),
(623, 13, 'sfsfsfsfs', '2017-08-22 17:56:13', '2017-08-22 17:56:13'),
(624, 13, 'sdfdafafa', '2017-08-22 17:57:00', '2017-08-22 17:57:00'),
(625, 13, 'asdadada', '2017-08-22 17:57:40', '2017-08-22 17:57:40'),
(626, 13, 'sadasdadad', '2017-08-22 17:58:30', '2017-08-22 17:58:30'),
(627, 13, 'dasdjsakdjada', '2017-08-22 17:59:00', '2017-08-22 17:59:00'),
(628, 13, 'send message', '2017-08-22 18:07:51', '2017-08-22 18:07:51'),
(629, 13, 'asadada', '2017-08-22 18:09:49', '2017-08-22 18:09:49'),
(630, 13, 'asdadad', '2017-08-22 18:26:26', '2017-08-22 18:26:26'),
(631, 13, 'I do not know why you cry', '2017-08-22 18:28:51', '2017-08-22 18:28:51'),
(632, 13, 'one more', '2017-08-22 18:29:04', '2017-08-22 18:29:04'),
(633, 13, 'sdfafaf', '2017-08-22 18:29:25', '2017-08-22 18:29:25'),
(634, 13, 'fasdfasfasfasfasfsa', '2017-08-22 18:29:29', '2017-08-22 18:29:29'),
(635, 13, 'fsafafafasf', '2017-08-22 18:29:54', '2017-08-22 18:29:54'),
(636, 13, 'dasdadadgdftgdgdfgsafdsdgfdkkf;kllk435432423342', '2017-08-22 18:30:40', '2017-08-22 18:30:40'),
(637, 10, 'do it', '2017-08-22 19:24:39', '2017-08-22 19:24:39'),
(638, 10, 'dot it please', '2017-08-22 19:24:52', '2017-08-22 19:24:52'),
(639, 10, 'send some with hope', '2017-08-22 20:28:34', '2017-08-22 20:28:34'),
(640, 10, 'send some data', '2017-08-22 20:29:17', '2017-08-22 20:29:17'),
(641, 10, 'stupid', '2017-08-22 20:30:07', '2017-08-22 20:30:07'),
(642, 10, 'please send me stupid', '2017-08-22 20:30:40', '2017-08-22 20:30:40'),
(643, 10, 'this is to update message', '2017-08-22 20:31:16', '2017-08-22 20:31:16'),
(644, 10, 'fuck', '2017-08-22 20:32:15', '2017-08-22 20:32:15'),
(645, 10, 'asdasdada', '2017-08-22 20:34:18', '2017-08-22 20:34:18'),
(646, 10, 'asdadada', '2017-08-22 20:35:00', '2017-08-22 20:35:00'),
(647, 10, 'asdadada', '2017-08-22 20:35:03', '2017-08-22 20:35:03'),
(648, 10, 'ssaadsadasdadadadad', '2017-08-22 20:37:36', '2017-08-22 20:37:36'),
(649, 10, 'dasdadada', '2017-08-22 21:06:26', '2017-08-22 21:06:26'),
(650, 10, 'adsdadada', '2017-08-22 21:07:16', '2017-08-22 21:07:16'),
(651, 10, 'asASsS', '2017-08-22 21:11:01', '2017-08-22 21:11:01'),
(652, 10, 'wqzsdshdakjsdhakdah', '2017-08-22 21:11:23', '2017-08-22 21:11:23'),
(653, 10, 'adadadad', '2017-08-22 21:12:35', '2017-08-22 21:12:35'),
(654, 10, 'sadadadadada', '2017-08-22 21:13:40', '2017-08-22 21:13:40'),
(655, 10, 'dasdadadadadada', '2017-08-22 21:16:17', '2017-08-22 21:16:17'),
(656, 10, 'aSAsSHSKjHK', '2017-08-22 21:16:36', '2017-08-22 21:16:36'),
(657, 10, 'asdadadadad', '2017-08-22 21:17:31', '2017-08-22 21:17:31'),
(658, 10, '4', '2017-08-22 21:18:21', '2017-08-22 21:18:21'),
(659, 10, '5', '2017-08-22 21:20:48', '2017-08-22 21:20:48'),
(660, 10, '6', '2017-08-22 21:21:53', '2017-08-22 21:21:53'),
(661, 10, 'mesage', '2017-08-22 21:24:20', '2017-08-22 21:24:20'),
(662, 10, 'ddsfsafsfjflak', '2017-08-22 21:28:58', '2017-08-22 21:28:58'),
(663, 10, 'asdasdadadad', '2017-08-22 21:29:58', '2017-08-22 21:29:58'),
(664, 10, 'dasdadadada', '2017-08-22 21:30:04', '2017-08-22 21:30:04'),
(665, 10, 'now listent to this room', '2017-08-22 21:37:09', '2017-08-22 21:37:09'),
(666, 10, 'this message also', '2017-08-22 21:37:57', '2017-08-22 21:37:57'),
(667, 13, 'return', '2017-08-22 21:38:48', '2017-08-22 21:38:48'),
(668, 10, 'asdsadada', '2017-08-22 21:44:49', '2017-08-22 21:44:49'),
(669, 13, 'from chatroom 2', '2017-08-22 21:49:20', '2017-08-22 21:49:20'),
(670, 10, 'here from chat room 2', '2017-08-22 21:50:42', '2017-08-22 21:50:42'),
(671, 13, 'from chat room 3', '2017-08-22 21:51:31', '2017-08-22 21:51:31'),
(672, 13, 'from chat room 3', '2017-08-22 21:53:32', '2017-08-22 21:53:32'),
(673, 13, 'from room 3', '2017-08-22 21:56:28', '2017-08-22 21:56:28'),
(674, 10, 'can listen to room 3', '2017-08-22 21:56:53', '2017-08-22 21:56:53'),
(675, 13, 'from room 3', '2017-08-22 21:57:04', '2017-08-22 21:57:04'),
(676, 13, 'room 3', '2017-08-22 22:01:05', '2017-08-22 22:01:05'),
(677, 13, '12', '2017-08-22 22:01:48', '2017-08-22 22:01:48'),
(678, 13, '12', '2017-08-22 22:02:34', '2017-08-22 22:02:34'),
(679, 13, '13', '2017-08-22 22:02:38', '2017-08-22 22:02:38'),
(680, 13, '30', '2017-08-22 22:03:08', '2017-08-22 22:03:08'),
(681, 13, '31', '2017-08-22 22:04:33', '2017-08-22 22:04:33'),
(682, 13, '32', '2017-08-22 22:05:36', '2017-08-22 22:05:36'),
(683, 13, 'Still #3', '2017-08-22 22:06:03', '2017-08-22 22:06:03'),
(684, 13, 'here it comes', '2017-08-22 22:06:22', '2017-08-22 22:06:22'),
(685, 13, 'from 6', '2017-08-22 22:08:12', '2017-08-22 22:08:12'),
(686, 10, 'from 3', '2017-08-22 22:08:38', '2017-08-22 22:08:38'),
(687, 10, 'from 2', '2017-08-22 22:08:40', '2017-08-22 22:08:40'),
(688, 13, 'from 6 af', '2017-08-22 22:09:20', '2017-08-22 22:09:20'),
(689, 10, 'public from Section controller', '2017-08-27 18:29:07', '2017-08-27 18:29:07'),
(690, 13, 'Public from #3 - Package Structure 01', '2017-08-27 18:30:20', '2017-08-27 18:30:20'),
(691, 10, 'Public from #2 Section Structure', '2017-08-27 18:32:59', '2017-08-27 18:32:59'),
(692, 13, 'Public from #3 Package Structure 01', '2017-08-27 18:34:10', '2017-08-27 18:34:10'),
(693, 10, 'chatroom2 established', '2017-08-27 18:35:24', '2017-08-27 18:35:24'),
(694, 13, 'why it does not sent', '2017-08-27 18:36:51', '2017-08-27 18:36:51'),
(695, 13, 'send', '2017-08-27 18:36:54', '2017-08-27 18:36:54'),
(696, 13, 'chatroom3 sent data', '2017-08-27 18:39:26', '2017-08-27 18:39:26'),
(697, 10, 'chatroom2 send back data', '2017-08-27 18:39:52', '2017-08-27 18:39:52'),
(698, 10, 'from chatroom2', '2017-08-27 18:40:50', '2017-08-27 18:40:50'),
(699, 13, 'from chatroom3', '2017-08-27 18:41:19', '2017-08-27 18:41:19'),
(700, 13, 'from #3', '2017-08-27 18:42:04', '2017-08-27 18:42:04'),
(701, 10, 'from #2', '2017-08-27 18:42:13', '2017-08-27 18:42:13'),
(702, 13, 'From #3 Group chat', '2017-08-27 18:52:41', '2017-08-27 18:52:41'),
(703, 10, 'from #3 group chat', '2017-08-27 18:54:11', '2017-08-27 18:54:11'),
(704, 10, 'from #2 group chat', '2017-08-27 18:54:50', '2017-08-27 18:54:50'),
(705, 13, 'from #2 group chat', '2017-08-27 18:55:21', '2017-08-27 18:55:21'),
(706, 13, 'From #3 Group chat', '2017-08-27 18:55:45', '2017-08-27 18:55:45'),
(707, 10, 'BAck from #2', '2017-08-27 18:56:30', '2017-08-27 18:56:30'),
(708, 3, 'from #1 Project manager', '2017-08-28 08:58:04', '2017-08-28 08:58:04'),
(709, 10, 'from #2 Section Struture', '2017-08-28 08:58:23', '2017-08-28 08:58:23'),
(710, 3, 'from #1 Project', '2017-08-28 08:59:22', '2017-08-28 08:59:22'),
(711, 3, '#1 again', '2017-08-28 09:07:09', '2017-08-28 09:07:09'),
(712, 10, 'you should receive from #2 too', '2017-08-28 09:08:02', '2017-08-28 09:08:02'),
(713, 10, 'from #2', '2017-08-28 09:09:40', '2017-08-28 09:09:40'),
(714, 10, 'from #2 again', '2017-08-28 09:09:57', '2017-08-28 09:09:57'),
(715, 3, 'Y i do not see from #2', '2017-08-28 09:10:22', '2017-08-28 09:10:22'),
(716, 10, '#1 shall list to #2', '2017-08-28 09:10:56', '2017-08-28 09:10:56'),
(717, 10, 'from #2', '2017-08-28 09:21:06', '2017-08-28 09:21:06'),
(718, 10, '#2', '2017-08-28 09:28:35', '2017-08-28 09:28:35'),
(719, 10, '#21', '2017-08-28 09:31:38', '2017-08-28 09:31:38'),
(720, 10, '#22', '2017-08-28 09:38:08', '2017-08-28 09:38:08'),
(721, 10, '#1', '2017-08-28 09:38:26', '2017-08-28 09:38:26'),
(722, 10, '#23', '2017-08-28 09:38:48', '2017-08-28 09:38:48'),
(723, 10, '#24', '2017-08-28 09:41:53', '2017-08-28 09:41:53'),
(724, 10, '#25', '2017-08-28 09:43:27', '2017-08-28 09:43:27'),
(725, 10, '#26', '2017-08-28 09:45:41', '2017-08-28 09:45:41'),
(726, 3, '#1', '2017-08-28 09:46:09', '2017-08-28 09:46:09'),
(727, 3, '#11', '2017-08-28 09:46:24', '2017-08-28 09:46:24'),
(728, 3, '#12', '2017-08-28 09:48:27', '2017-08-28 09:48:27'),
(729, 10, '#13', '2017-08-28 09:50:19', '2017-08-28 09:50:19'),
(730, 10, '#14', '2017-08-28 09:50:41', '2017-08-28 09:50:41'),
(731, 10, '#15', '2017-08-28 09:52:07', '2017-08-28 09:52:07'),
(732, 10, '#16', '2017-08-28 09:52:20', '2017-08-28 09:52:20'),
(733, 10, '#17', '2017-08-28 09:52:24', '2017-08-28 09:52:24'),
(734, 10, '#18', '2017-08-28 09:52:26', '2017-08-28 09:52:26'),
(735, 10, '#19', '2017-08-28 09:52:32', '2017-08-28 09:52:32'),
(736, 10, 'private from #2', '2017-08-28 10:13:26', '2017-08-28 10:13:26'),
(737, 3, '#private from #1', '2017-08-28 10:13:50', '2017-08-28 10:13:50'),
(738, 10, 'Turn back private from #2', '2017-08-28 10:14:13', '2017-08-28 10:14:13'),
(739, 10, 'Public listent to number 1', '2017-08-28 10:18:30', '2017-08-28 10:18:30'),
(740, 3, 'this is from #1', '2017-08-28 10:18:59', '2017-08-28 10:18:59'),
(741, 3, 'but private', '2017-08-28 10:19:05', '2017-08-28 10:19:05'),
(742, 10, 'Public from #2', '2017-08-28 10:30:02', '2017-08-28 10:30:02'),
(743, 10, 'Public from #2', '2017-08-28 10:31:10', '2017-08-28 10:31:10'),
(744, 3, 'Public from #1', '2017-08-28 10:31:23', '2017-08-28 10:31:23'),
(745, 3, 'Public #2 could not see this', '2017-08-28 10:33:00', '2017-08-28 10:33:00'),
(746, 3, 'Public #2 could not see again', '2017-08-28 10:33:39', '2017-08-28 10:33:39'),
(747, 3, 'private from #2', '2017-08-28 10:35:07', '2017-08-28 10:35:07'),
(748, 3, 'private #2', '2017-08-28 10:37:30', '2017-08-28 10:37:30'),
(749, 3, 'dasdadada', '2017-08-28 10:43:26', '2017-08-28 10:43:26'),
(750, 3, 'fsdfsfsfsfsf', '2017-08-28 10:43:52', '2017-08-28 10:43:52'),
(751, 3, 'dsfsfsfs', '2017-08-28 10:44:24', '2017-08-28 10:44:24'),
(752, 3, 'sddfdsdfsfsf', '2017-08-28 10:44:55', '2017-08-28 10:44:55'),
(753, 3, '#2 listen private from #1', '2017-08-28 10:46:27', '2017-08-28 10:46:27'),
(754, 3, '#2 listen private from #1 10:46 AM', '2017-08-28 10:47:56', '2017-08-28 10:47:56'),
(755, 10, '#1 should privately see this', '2017-08-28 10:49:10', '2017-08-28 10:49:10'),
(756, 10, 'Public from #2', '2017-08-28 10:50:19', '2017-08-28 10:50:19'),
(757, 10, 'again', '2017-08-28 10:50:33', '2017-08-28 10:50:33'),
(758, 3, 'public works well', '2017-08-28 10:50:49', '2017-08-28 10:50:49'),
(759, 3, 'why you do not see my #', '2017-08-28 10:51:34', '2017-08-28 10:51:34'),
(760, 10, 'private #2 of #1 see this', '2017-08-28 10:52:20', '2017-08-28 10:52:20'),
(761, 10, 'private #2 of #1 see', '2017-08-28 10:55:52', '2017-08-28 10:55:52'),
(762, 10, 'private #2 of #1 seeing', '2017-08-28 11:05:34', '2017-08-28 11:05:34'),
(763, 3, 'why?', '2017-08-28 11:06:00', '2017-08-28 11:06:00'),
(764, 10, 'this is private1', '2017-08-28 11:10:30', '2017-08-28 11:10:30'),
(765, 10, 'this is from priavte2', '2017-08-28 11:11:42', '2017-08-28 11:11:42'),
(766, 3, 'hi', '2017-08-28 11:18:20', '2017-08-28 11:18:20'),
(767, 3, 'asdada', '2017-08-28 11:22:04', '2017-08-28 11:22:04'),
(768, 3, 'what the hell', '2017-08-28 11:22:13', '2017-08-28 11:22:13'),
(769, 10, 'send it publicly', '2017-08-28 12:15:38', '2017-08-28 12:15:38'),
(770, 10, 'send it privately', '2017-08-28 12:16:02', '2017-08-28 12:16:02'),
(771, 10, 'private2 send msg', '2017-08-28 12:17:35', '2017-08-28 12:17:35'),
(772, 3, 'private1 send msg to private2', '2017-08-28 12:18:39', '2017-08-28 12:18:39'),
(773, 10, 'private2 send ms to private1', '2017-08-28 12:19:41', '2017-08-28 12:19:41'),
(774, 3, 'private1 open channel private1', '2017-08-28 12:20:07', '2017-08-28 12:20:07'),
(775, 10, 'private 2 listen', '2017-08-28 12:20:30', '2017-08-28 12:20:30'),
(776, 3, 'private channel works', '2017-08-28 12:20:46', '2017-08-28 12:20:46'),
(777, 10, 'public channel send ms', '2017-08-28 12:21:02', '2017-08-28 12:21:02'),
(778, 3, 'public #1 send message', '2017-08-28 12:21:18', '2017-08-28 12:21:18'),
(779, 3, 'public1 send', '2017-08-28 12:23:29', '2017-08-28 12:23:29'),
(780, 10, 'public2 send', '2017-08-28 12:23:50', '2017-08-28 12:23:50'),
(781, 3, 'public1 send', '2017-08-28 12:23:59', '2017-08-28 12:23:59'),
(782, 10, 'public1 send again', '2017-08-28 12:24:16', '2017-08-28 12:24:16'),
(783, 10, 'sorry i am public2', '2017-08-28 12:24:30', '2017-08-28 12:24:30'),
(784, 10, 'from public2', '2017-08-28 12:26:51', '2017-08-28 12:26:51'),
(785, 3, 'from me', '2017-08-28 12:27:00', '2017-08-28 12:27:00'),
(786, 10, 'from public 2', '2017-08-28 12:27:10', '2017-08-28 12:27:10'),
(787, 3, 'ok public works fine', '2017-08-28 12:27:21', '2017-08-28 12:27:21'),
(788, 3, 'we need to add immediate message insertion', '2017-08-28 12:27:40', '2017-08-28 12:27:40'),
(789, 3, 'this is the first message', '2017-08-30 14:51:19', '2017-08-30 14:51:19'),
(790, 3, 'send it ps', '2017-08-30 15:00:36', '2017-08-30 15:00:36'),
(791, 1, 'I am sending this message to project manager', '2017-08-31 09:08:07', '2017-08-31 09:08:07'),
(792, 1, 'please send me the quantity file before 5th, Sep', '2017-08-31 21:27:35', '2017-08-31 21:27:35'),
(793, 3, 'Hello Client', '2017-09-01 21:31:43', '2017-09-01 21:31:43'),
(794, 3, 'Please upload drawings and references for Structure Section', '2017-09-01 21:32:30', '2017-09-01 21:32:30');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2017_05_09_001258_alter_users_table', 2),
(4, '2017_05_09_001259_alter_users_table', 3),
(5, '2017_05_09_001261_alter_users_table', 4),
(6, '2017_05_10_144508_create_role_user_pivot_table', 5),
(7, '2017_06_14_094750_entrust_setup_tables', 6);

-- --------------------------------------------------------

--
-- Table structure for table `nations`
--

CREATE TABLE IF NOT EXISTS `nations` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `abbreviation` char(10) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `nations`
--

INSERT INTO `nations` (`id`, `name`, `abbreviation`, `created_at`, `updated_at`, `created_by`) VALUES
(1, 'United States', 'US', '2017-07-05 15:53:48', '2017-07-05 09:12:20', 5),
(2, 'Canada', 'CAN', '2017-07-05 15:53:48', '2017-07-05 09:13:19', 5),
(3, 'Australia', 'AUS', '2017-07-05 08:55:10', '2017-07-05 09:13:22', 5),
(4, 'United Kingdom', 'UK', '2017-07-05 08:55:57', '2017-07-05 09:13:24', 5),
(5, 'United Arab Emirates', 'UAE', '2017-07-07 01:30:48', '2017-07-07 01:30:48', 5);

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE IF NOT EXISTS `packages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `section_id` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `area` double DEFAULT NULL,
  `complexity` double DEFAULT NULL,
  `description` text,
  `status` tinyint(1) unsigned DEFAULT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`section_id`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `section_id`, `name`, `area`, `complexity`, `description`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(9, 10, '30000 AA10', 3000, 1.5, 'All 30000 works area AA10', NULL, NULL, '2017-08-31 14:28:02', '2017-09-12 15:54:59'),
(10, 10, '30000 AA20', 3500, 1.5, 'All 30000 works area AA20', NULL, NULL, '2017-08-31 14:35:24', '2017-09-12 15:55:07'),
(11, 11, '40000 AA10', 3000, 1.5, 'All 4000 works area AA10', NULL, NULL, '2017-08-31 14:36:35', '2017-09-12 21:18:06'),
(12, 11, '40000 AA20', 3500, 1.5, 'All 4000 works area AA20', NULL, NULL, '2017-08-31 14:37:29', '2017-09-12 21:18:12'),
(13, 12, '50000 AA10', 3000, 1.5, 'All 50000 and related works AA10', NULL, NULL, '2017-09-11 16:27:56', '2017-09-12 21:20:35'),
(14, 12, '50000 AA20', 3500, 1.5, 'All 50000 and related works AA20', NULL, NULL, '2017-09-11 16:28:47', '2017-09-12 21:20:42'),
(15, 13, '90000 AA10', 3000, 1.5, 'All 90000 works AA10', NULL, NULL, '2017-09-11 16:32:52', '2017-09-12 21:24:43'),
(16, 13, '90000 AA20', 3500, 1.5, 'All 90000 works AA10', NULL, NULL, '2017-09-11 16:36:18', '2017-09-12 21:25:05'),
(17, 10, '30000 AA30', 4000, 1.5, 'All 30000 works area AA30', NULL, NULL, '2017-09-12 15:37:58', '2017-09-12 15:55:13'),
(18, 10, '30000 AA40', 3500, 1.5, 'All 30000 works area AA40', NULL, NULL, '2017-09-12 15:38:20', '2017-09-12 15:55:20'),
(19, 10, '30000 AA50', 3500, 1.5, 'All 30000 works area AA50', NULL, NULL, '2017-09-12 15:39:18', '2017-09-12 15:55:26'),
(20, 11, '40000 AA30', 4000, 1.5, 'All 4000 works area AA30', NULL, NULL, '2017-09-12 15:53:03', '2017-09-12 16:13:01'),
(21, 11, '40000 AA40', 3500, 1.5, 'All 4000 works area AA40', NULL, NULL, '2017-09-12 15:53:44', '2017-09-12 21:18:24'),
(22, 11, '40000 AA50', 3500, 1.5, 'All 4000 works area AA40', NULL, NULL, '2017-09-12 15:54:08', '2017-09-12 21:19:24'),
(23, 12, '50000 AA30', 4000, 1.5, 'All 50000 and related works AA30', NULL, NULL, '2017-09-12 15:58:51', '2017-09-12 21:20:51'),
(24, 12, '50000 AA40', 3500, 1.5, 'All 50000 and related works AA40', NULL, NULL, '2017-09-12 15:59:48', '2017-09-12 21:20:59'),
(25, 12, '50000 AA50', 3500, 1.5, 'All 50000 and related works AA50', NULL, NULL, '2017-09-12 16:00:22', '2017-09-12 21:21:11'),
(26, 13, '90000 AA30', 4000, 1.5, 'All 90000 works AA30', NULL, NULL, '2017-09-12 16:03:21', '2017-09-12 16:13:32'),
(27, 13, '90000 AA40', 3500, 1.5, 'All 90000 works AA40', NULL, NULL, '2017-09-12 16:04:26', '2017-09-12 21:26:27'),
(28, 13, '90000 AA50', 3500, 1.5, 'All 90000 works AA40', NULL, NULL, '2017-09-12 16:04:52', '2017-09-12 16:04:52');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('pth121288@gmail.com', '$2y$10$lP3apUPOX./QzKjQ8hIb6u60zIaUlJ4wPC/KRTiKoqIkwDyUkaCnW', '2017-07-07 03:28:47'),
('thanhpv@hotmail.com', '$2y$10$Io2ID4zFxYpiCdVFXIx4y.5Gd8m.6CDdN5CYlksy4nB9MU7t03Jz6', '2017-09-02 09:04:22'),
('minhdung.nguyen86@gmail.com', '$2y$10$o8oGU.QS/d2/s6z8VkI.2ubdj.MhUb.3LZDdWV/3DcixhdegmfIi2', '2017-09-02 14:48:21'),
('thanphungdung@gmail.com', '$2y$10$BsQigkCXTuCe7LNImkGH4.3L53ms84CaCVAu22QEdbqhBIrzRDQn6', '2017-09-04 03:00:16'),
('qscompanion@gmail.com', '$2y$10$ZikL7ilSgwm8TAgWMQNpAOfz66Xa/2p7AwKTOHxDnO.HEa/faEx2W', '2017-09-04 03:35:55'),
('pthanh.ce@gmail.com', '$2y$10$x0fQjZyF33aIY9cjhz/TruFfc5didIuugt5lgrSjFrlUk4H.IptTm', '2017-09-04 03:36:08');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=29 ;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'create-update-project', 'Create, update project', 'Create new projects, update existing projects information', '2017-06-14 05:44:28', '2017-07-06 23:22:48'),
(2, 'postpone-project', 'Postpone project', 'Postpone a active project', '2017-06-14 09:35:39', '2017-07-06 19:57:17'),
(3, 'import-quantity', 'Import quantity', 'Import quantity files to quantity model', '2017-07-04 04:31:35', '2017-07-06 04:54:44'),
(4, 'import-audit', 'Import audit', 'Import quantity audit files to audit model', '2017-07-04 04:33:51', '2017-07-06 04:54:50'),
(5, 'create-update-user', 'Create, update user', 'Create and update new user to the system', '2017-07-06 02:35:41', '2017-07-06 19:57:40'),
(6, 'create-delete-folder', 'Create, delete folder', 'Create, delete project''s folders', '2017-07-06 02:36:55', '2017-07-12 01:25:49'),
(7, 'attach-detach-role-permissions', 'Attach, detach role''s permissions', 'Giving role permissions', '2017-07-06 03:45:11', '2017-07-06 19:58:05'),
(8, 'upload-file', 'Upload file', 'Upload project''s files', '2017-07-06 19:56:15', '2017-07-06 19:58:18'),
(9, 'delete-folder', 'Delete folder', 'Delete project''s folders', '2017-07-06 19:56:59', '2017-07-06 19:56:59'),
(11, 'create-update-section', 'Create, update sections', 'Create, up date project sections', '2017-07-06 23:25:51', '2017-08-15 07:34:26'),
(12, 'create-update-nation', 'create-update-nation', 'Create, update nation', '2017-07-06 23:27:12', '2017-07-06 23:27:12'),
(13, 'bid-job', 'Bid job', 'Bid a job', '2017-07-06 23:28:56', '2017-07-06 23:28:56'),
(14, 'award-withhold-job', 'Award withhold job', 'Award, withold job to, from bidder', '2017-07-06 23:30:56', '2017-07-06 23:32:35'),
(15, 'activate-deactivate-job', 'Activate, deactivate job', 'Activate, deactivate jobs', '2017-07-06 23:31:59', '2017-07-06 23:31:59'),
(16, 'create-update-pwbs', 'Create, update pwbs', 'Create, update pwbs', '2017-07-06 23:35:12', '2017-07-06 23:35:12'),
(17, 'delete-file', 'Delete file', 'Delete project files', '2017-07-06 23:38:01', '2017-07-06 23:38:01'),
(18, 'create-update-link', 'Create, update link', 'Create, update project''s links', '2017-07-06 23:38:31', '2017-07-06 23:38:31'),
(19, 'delete-link', 'Delete link', 'Delete project''s links', '2017-07-06 23:39:05', '2017-07-06 23:39:05'),
(20, 'attach-detach-role', 'Attach, detach role', 'Attach, detach user''s roles', '2017-07-07 00:37:53', '2017-07-07 00:37:53'),
(21, 'create-update-role', 'Creat, update role', 'Create, update roles', '2017-07-07 01:40:05', '2017-07-07 01:40:05'),
(22, 'create-update-package', 'Create, update package', 'Create, update packages', '2017-07-07 02:16:11', '2017-07-07 02:16:11'),
(23, 'update-pwbs-unit', 'Update pwbs unit', 'Update unit to pwbs items', '2017-07-13 04:29:16', '2017-07-13 04:29:16'),
(24, 'create-update-file', 'Create, update file', 'Create, update project files', '2017-07-18 01:05:53', '2017-08-31 10:40:40'),
(25, 'create-update-issue', 'Create, update issue', 'Create, update a job issue', '2017-07-25 00:37:25', '2017-07-25 00:37:25'),
(26, 'upload-delete-form', 'Upload, delete form', 'Upload and delete forms', '2017-08-04 01:36:32', '2017-08-04 01:36:32'),
(27, 'rate-job', 'Rate job', 'Rate and comment on a job', '2017-08-12 00:17:56', '2017-08-12 00:17:56'),
(28, 'create-delete-wbs', 'Create, delete wbs', 'Create, update, delete global work breakdown structure', '2017-08-17 03:17:32', '2017-08-17 03:17:32');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE IF NOT EXISTS `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 15),
(1, 16),
(1, 17),
(3, 11),
(4, 11),
(5, 12),
(5, 17),
(6, 16),
(6, 17),
(7, 17),
(8, 17),
(9, 17),
(11, 17),
(12, 17),
(13, 11),
(13, 13),
(13, 19),
(14, 17),
(16, 13),
(16, 17),
(18, 17),
(20, 17),
(21, 17),
(22, 17),
(23, 13),
(24, 17),
(25, 11),
(25, 13),
(25, 16),
(25, 19),
(26, 17),
(27, 11),
(27, 13),
(27, 18),
(27, 19),
(28, 17);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `industry_id` int(2) unsigned DEFAULT NULL,
  `nation_id` tinyint(2) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `description` text,
  `requirement` text,
  `status` tinyint(1) DEFAULT '0',
  `created_by` int(11) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `industry` (`industry_id`),
  KEY `projects_ibfk_1` (`user_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `industry_id`, `nation_id`, `user_id`, `description`, `requirement`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'NSRP - CT01', 1, 1, 1, '- This is a refurbish project so please be careful with old and new elements.', '- Build the wbs and notify prior to quantity takeoffs\n- Sections\n + Arch & Finish Works,\n + Structural Works\n + Electrical\n + Air conditioning\n + Plumping\n\n- Packages:\n+ Ground floor,\n+ 1st Floor\n+ 2nd Floor\n+ Roof Floor', 0, NULL, '2017-07-07 00:32:12', '2017-09-12 15:57:08'),
(2, 'Star Fall City', 1, 1, 1, 'The project is a refurbish project, so please be careful with old and new elements', 'Please build the Wbs and notify me prior to quantitfication', 0, NULL, '2017-07-12 07:39:03', '2017-08-31 10:23:54'),
(3, 'Start City', 1, 1, 1, NULL, NULL, 0, NULL, '2017-07-12 12:35:16', '2017-07-12 12:35:42');

-- --------------------------------------------------------

--
-- Table structure for table `pwbs`
--

CREATE TABLE IF NOT EXISTS `pwbs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned DEFAULT NULL,
  `code` char(25) DEFAULT NULL,
  `parent_code` char(25) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantify` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `unit` char(5) DEFAULT NULL,
  `extension` tinyint(1) NOT NULL DEFAULT '0',
  `commit` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`code`),
  KEY `code` (`code`),
  KEY `project_id_2` (`project_id`,`parent_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=215 ;

--
-- Dumping data for table `pwbs`
--

INSERT INTO `pwbs` (`id`, `project_id`, `code`, `parent_code`, `name`, `description`, `quantify`, `unit`, `extension`, `commit`, `created_at`, `updated_at`) VALUES
(171, 1, '032214', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:07:18', '2017-09-12 15:07:18'),
(172, 1, '032200', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:07:18', '2017-09-12 15:07:18'),
(173, 1, '032000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:07:18', '2017-09-12 15:07:18'),
(174, 1, '030000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:07:18', '2017-09-12 15:07:18'),
(175, 1, '0', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:07:18', '2017-09-12 15:07:18'),
(177, 1, '042600', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:08:05', '2017-09-12 15:29:05'),
(178, 1, '042000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:08:05', '2017-09-12 15:08:05'),
(179, 1, '040000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:08:05', '2017-09-12 15:08:05'),
(181, 1, '042800', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:08:05', '2017-09-12 15:29:10'),
(182, 1, '031100', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:09:23', '2017-09-12 15:09:23'),
(183, 1, '031000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:09:23', '2017-09-12 15:09:23'),
(184, 1, '031113', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:09:23', '2017-09-12 15:28:06'),
(185, 1, '032100', NULL, NULL, NULL, 0, 'ton', 0, NULL, '2017-09-12 15:09:36', '2017-09-12 15:28:13'),
(186, 1, '033000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:10:06', '2017-09-12 15:10:06'),
(187, 1, '033100', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:10:06', '2017-09-12 15:28:30'),
(188, 1, '034100', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:10:30', '2017-09-12 15:28:35'),
(189, 1, '034000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:10:30', '2017-09-12 15:10:30'),
(190, 1, '036000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:10:47', '2017-09-12 15:10:47'),
(191, 1, '042100', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:11:00', '2017-09-12 15:28:52'),
(194, 1, '031513.16', NULL, NULL, NULL, 0, 'm2', 0, NULL, '2017-09-12 15:13:27', '2017-09-12 15:28:09'),
(195, 1, '031513', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:13:27', '2017-09-12 15:13:27'),
(196, 1, '031500', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:13:27', '2017-09-12 15:13:27'),
(197, 1, '036100', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:14:13', '2017-09-12 15:28:38'),
(198, 1, '036300', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:14:17', '2017-09-12 15:28:42'),
(199, 1, '037100', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:14:28', '2017-09-12 15:28:45'),
(200, 1, '037000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:14:28', '2017-09-12 15:14:28'),
(201, 1, '037200', NULL, NULL, NULL, 0, 'm3', 0, NULL, '2017-09-12 15:14:31', '2017-09-12 15:28:48'),
(202, 1, '051200', NULL, NULL, NULL, 0, 'ton', 0, NULL, '2017-09-12 15:15:11', '2017-09-12 15:29:18'),
(203, 1, '051000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:15:11', '2017-09-12 15:15:11'),
(204, 1, '050000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:15:11', '2017-09-12 15:15:11'),
(205, 1, '093000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:16:17', '2017-09-12 15:16:17'),
(206, 1, '090000', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 15:16:17', '2017-09-12 15:16:17'),
(207, 1, '093036', NULL, NULL, NULL, 0, 'm2', 0, NULL, '2017-09-12 15:16:17', '2017-09-12 15:29:27'),
(208, 1, '032214.10', '032214', 'Welded Wire Fabric Reinforcing A6', NULL, 0, 'm2', 1, NULL, '2017-09-12 15:30:45', '2017-09-12 15:31:12'),
(209, 1, '032214.11', '032214', 'Welded Wire Fabric Reinforcing A7', NULL, 0, 'm2', 1, NULL, '2017-09-12 15:30:53', '2017-09-12 15:31:14'),
(210, 1, '032214.12', '032214', 'Welded Wire Fabric Reinforcing A8', NULL, 0, 'm2', 1, NULL, '2017-09-12 15:31:01', '2017-09-12 15:31:15'),
(211, 1, '093019', NULL, NULL, NULL, 0, 'm2', 0, NULL, '2017-09-12 16:08:20', '2017-09-13 07:10:48'),
(212, 1, '093033', NULL, NULL, NULL, 0, 'm2', 0, NULL, '2017-09-12 16:08:29', '2017-09-13 07:10:50'),
(213, 1, '093300', NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-09-12 16:08:45', '2017-09-12 16:08:45'),
(214, 1, '093336', NULL, NULL, NULL, 0, 'm2', 0, NULL, '2017-09-12 16:08:45', '2017-09-13 07:10:55');

-- --------------------------------------------------------

--
-- Table structure for table `quantity`
--

CREATE TABLE IF NOT EXISTS `quantity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` int(11) unsigned NOT NULL,
  `code` int(11) unsigned NOT NULL,
  `quantity` double DEFAULT NULL,
  `commit` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_id` (`job_id`,`code`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `quantity_files`
--

CREATE TABLE IF NOT EXISTS `quantity_files` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `quantity_id` int(11) unsigned NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quantity_id` (`quantity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `quantity_markdowns`
--

CREATE TABLE IF NOT EXISTS `quantity_markdowns` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `quantity_id` int(11) unsigned NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quantity_id` (`quantity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`, `created_by`) VALUES
(11, 'surveyor', 'Surveyor', 'Responsible to packages', '2017-06-04 06:53:37', '2017-06-14 12:41:30', NULL),
(12, 'admin', 'Admin', 'System responsibility', '2017-06-06 15:50:54', '2017-06-14 12:41:40', NULL),
(13, 'project_manager', 'Project Manager', 'Responsible to assigned projects', '2017-06-14 11:28:32', '2017-06-14 12:41:49', NULL),
(15, 'sales_manager', 'Sales Manager', 'Responsible to sales force', '2017-06-14 11:35:01', '2017-08-05 13:59:09', NULL),
(16, 'client', 'Client', 'Company''s clients', '2017-06-21 08:06:54', '2017-06-21 08:07:24', NULL),
(17, 'superuser', 'Super User', 'Full power user', '2017-07-05 07:24:40', '2017-07-05 08:01:05', NULL),
(18, 'project_director', 'Project Director', 'Control, supervise projects', '2017-07-07 08:42:02', '2017-07-07 08:42:02', NULL),
(19, 'qto_controller', 'Qto Controller', 'Control  Gwbs and surveying team', '2017-07-07 08:44:22', '2017-07-07 08:44:22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE IF NOT EXISTS `role_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_2` (`user_id`,`role_id`),
  UNIQUE KEY `user_id` (`user_id`,`active`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`id`, `user_id`, `role_id`, `active`, `created_at`, `updated_at`) VALUES
(16, 5, 17, 1, '2017-07-06 18:03:04', '2017-07-08 04:12:30'),
(21, 3, 13, NULL, '2017-07-07 16:46:46', '2017-07-07 16:46:46'),
(23, 4, 18, NULL, '2017-07-07 16:53:17', '2017-07-07 16:53:17'),
(25, 10, 19, NULL, '2017-07-10 18:18:54', '2017-07-10 18:18:54'),
(33, 1, 16, NULL, '2017-07-15 17:55:35', '2017-07-15 17:55:35'),
(34, 4, 12, NULL, '2017-08-06 05:11:36', '2017-08-06 05:11:36'),
(35, 8, 11, NULL, '2017-09-04 10:22:20', '2017-09-04 10:22:20'),
(39, 13, 11, NULL, '2017-09-06 09:08:09', '2017-09-06 09:08:09'),
(41, 6, 18, NULL, '2017-09-07 16:35:22', '2017-09-07 16:35:22'),
(42, 3, 19, NULL, '2017-09-13 07:12:40', '2017-09-13 07:12:40'),
(43, 3, 11, NULL, '2017-09-13 07:12:45', '2017-09-13 07:12:45');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE IF NOT EXISTS `sections` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `created_by` int(11) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `project_id`, `name`, `description`, `created_by`, `created_at`, `updated_at`) VALUES
(10, 1, 'Section 30000', 'All concrete and related works', NULL, '2017-08-31 13:16:07', '2017-09-12 15:41:24'),
(11, 1, 'Section 40000', 'All masonry and related works', NULL, '2017-08-31 13:17:52', '2017-09-12 15:43:46'),
(12, 1, 'Section 50000', 'All metal and related works', NULL, '2017-09-07 15:09:06', '2017-09-12 15:44:34'),
(13, 1, 'Section 90000', 'All finishes and related works', NULL, '2017-09-07 15:10:28', '2017-09-12 15:49:16');

-- --------------------------------------------------------

--
-- Table structure for table `unreads`
--

CREATE TABLE IF NOT EXISTS `unreads` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(11) unsigned NOT NULL,
  `job_id` int(11) unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=198 ;

--
-- Dumping data for table `unreads`
--

INSERT INTO `unreads` (`id`, `message_id`, `job_id`, `created_at`, `updated_at`) VALUES
(59, 318, 0, '2017-07-30 17:00:38', '2017-07-30 17:00:38'),
(60, 319, 0, '2017-07-30 17:00:42', '2017-07-30 17:00:42'),
(61, 320, 0, '2017-07-30 17:00:47', '2017-07-30 17:00:47'),
(62, 321, 0, '2017-07-30 17:00:49', '2017-07-30 17:00:49'),
(63, 322, 0, '2017-07-30 17:00:50', '2017-07-30 17:00:50'),
(64, 323, 0, '2017-07-30 17:00:51', '2017-07-30 17:00:51'),
(65, 324, 0, '2017-07-30 17:00:53', '2017-07-30 17:00:53'),
(66, 325, 0, '2017-07-30 17:00:55', '2017-07-30 17:00:55'),
(67, 326, 0, '2017-07-30 17:00:56', '2017-07-30 17:00:56'),
(68, 327, 0, '2017-07-30 17:01:00', '2017-07-30 17:01:00'),
(69, 328, 0, '2017-07-30 17:01:02', '2017-07-30 17:01:02'),
(70, 329, 0, '2017-07-30 17:01:13', '2017-07-30 17:01:13'),
(71, 330, 0, '2017-07-30 17:01:21', '2017-07-30 17:01:21'),
(72, 331, 0, '2017-07-30 17:01:25', '2017-07-30 17:01:25'),
(73, 332, 0, '2017-07-30 17:01:28', '2017-07-30 17:01:28'),
(74, 333, 0, '2017-07-30 17:01:34', '2017-07-30 17:01:34'),
(75, 334, 0, '2017-07-30 17:02:20', '2017-07-30 17:02:20'),
(76, 335, 0, '2017-07-30 17:02:23', '2017-07-30 17:02:23'),
(77, 336, 0, '2017-07-30 17:02:29', '2017-07-30 17:02:29'),
(78, 337, 0, '2017-07-30 17:02:31', '2017-07-30 17:02:31'),
(79, 338, 0, '2017-07-30 17:02:36', '2017-07-30 17:02:36'),
(80, 339, 0, '2017-07-30 17:43:35', '2017-07-30 17:43:35'),
(81, 340, 0, '2017-07-30 17:43:55', '2017-07-30 17:43:55'),
(82, 341, 0, '2017-07-30 17:44:04', '2017-07-30 17:44:04'),
(83, 342, 0, '2017-07-30 17:44:32', '2017-07-30 17:44:32'),
(84, 343, 0, '2017-07-30 17:44:47', '2017-07-30 17:44:47'),
(85, 344, 0, '2017-07-30 17:45:03', '2017-07-30 17:45:03'),
(86, 345, 0, '2017-07-30 17:45:16', '2017-07-30 17:45:16'),
(87, 346, 0, '2017-07-30 17:45:26', '2017-07-30 17:45:26'),
(88, 347, 0, '2017-07-30 17:45:34', '2017-07-30 17:45:34'),
(89, 348, 0, '2017-07-30 17:46:07', '2017-07-30 17:46:07'),
(90, 349, 0, '2017-07-30 17:46:43', '2017-07-30 17:46:43'),
(91, 350, 0, '2017-07-30 18:03:19', '2017-07-30 18:03:19'),
(92, 351, 0, '2017-07-30 18:03:22', '2017-07-30 18:03:22'),
(93, 352, 0, '2017-07-30 18:03:27', '2017-07-30 18:03:27'),
(94, 353, 0, '2017-07-30 18:03:33', '2017-07-30 18:03:33'),
(95, 354, 0, '2017-07-30 18:03:48', '2017-07-30 18:03:48'),
(96, 355, 0, '2017-07-30 18:03:55', '2017-07-30 18:03:55'),
(97, 358, 1, '2017-07-31 08:49:17', '2017-07-31 08:49:17'),
(98, 359, 1, '2017-08-02 13:41:15', '2017-08-02 13:41:15'),
(99, 360, 2, '2017-08-13 15:57:14', '2017-08-13 15:57:14'),
(100, 361, 1, '2017-08-19 22:06:33', '2017-08-19 22:06:33'),
(101, 362, 1, '2017-08-19 22:06:33', '2017-08-19 22:06:33'),
(102, 363, 1, '2017-08-19 22:06:34', '2017-08-19 22:06:34'),
(103, 364, 1, '2017-08-19 22:06:34', '2017-08-19 22:06:34'),
(104, 365, 1, '2017-08-19 22:06:34', '2017-08-19 22:06:34'),
(105, 366, 1, '2017-08-19 22:06:35', '2017-08-19 22:06:35'),
(106, 367, 1, '2017-08-19 22:06:36', '2017-08-19 22:06:36'),
(107, 368, 1, '2017-08-19 22:06:36', '2017-08-19 22:06:36'),
(108, 369, 1, '2017-08-19 22:06:36', '2017-08-19 22:06:36'),
(109, 370, 1, '2017-08-19 22:06:36', '2017-08-19 22:06:36'),
(110, 371, 1, '2017-08-19 22:06:36', '2017-08-19 22:06:36'),
(111, 372, 1, '2017-08-19 22:06:36', '2017-08-19 22:06:36'),
(112, 373, 1, '2017-08-19 22:06:36', '2017-08-19 22:06:36'),
(113, 374, 1, '2017-08-19 22:06:37', '2017-08-19 22:06:37'),
(114, 375, 1, '2017-08-19 22:06:37', '2017-08-19 22:06:37'),
(115, 376, 1, '2017-08-19 22:06:37', '2017-08-19 22:06:37'),
(116, 377, 1, '2017-08-19 22:06:38', '2017-08-19 22:06:38'),
(117, 378, 1, '2017-08-19 22:06:38', '2017-08-19 22:06:38'),
(118, 379, 1, '2017-08-19 22:06:38', '2017-08-19 22:06:38'),
(119, 380, 1, '2017-08-19 22:06:38', '2017-08-19 22:06:38'),
(120, 381, 1, '2017-08-19 22:06:39', '2017-08-19 22:06:39'),
(121, 382, 1, '2017-08-19 22:06:39', '2017-08-19 22:06:39'),
(122, 383, 1, '2017-08-19 22:06:39', '2017-08-19 22:06:39'),
(123, 384, 1, '2017-08-19 22:06:39', '2017-08-19 22:06:39'),
(124, 385, 1, '2017-08-19 22:06:39', '2017-08-19 22:06:39'),
(125, 386, 1, '2017-08-19 22:06:39', '2017-08-19 22:06:39'),
(126, 387, 1, '2017-08-19 22:06:39', '2017-08-19 22:06:39'),
(127, 388, 1, '2017-08-19 22:06:40', '2017-08-19 22:06:40'),
(128, 389, 1, '2017-08-19 22:06:40', '2017-08-19 22:06:40'),
(129, 390, 1, '2017-08-19 22:06:40', '2017-08-19 22:06:40'),
(130, 391, 1, '2017-08-19 22:06:40', '2017-08-19 22:06:40'),
(131, 392, 1, '2017-08-19 22:06:40', '2017-08-19 22:06:40'),
(132, 393, 1, '2017-08-19 22:06:41', '2017-08-19 22:06:41'),
(133, 394, 1, '2017-08-19 22:06:41', '2017-08-19 22:06:41'),
(134, 395, 1, '2017-08-19 22:06:41', '2017-08-19 22:06:41'),
(135, 396, 1, '2017-08-19 22:06:42', '2017-08-19 22:06:42'),
(136, 397, 1, '2017-08-19 22:06:42', '2017-08-19 22:06:42'),
(137, 398, 1, '2017-08-19 22:06:42', '2017-08-19 22:06:42'),
(138, 399, 1, '2017-08-19 22:06:42', '2017-08-19 22:06:42'),
(139, 400, 1, '2017-08-19 22:06:42', '2017-08-19 22:06:42'),
(140, 401, 1, '2017-08-19 22:06:42', '2017-08-19 22:06:42'),
(141, 402, 1, '2017-08-19 22:06:43', '2017-08-19 22:06:43'),
(142, 403, 1, '2017-08-19 22:06:43', '2017-08-19 22:06:43'),
(143, 404, 1, '2017-08-19 22:06:43', '2017-08-19 22:06:43'),
(144, 405, 1, '2017-08-19 22:06:43', '2017-08-19 22:06:43'),
(145, 406, 1, '2017-08-19 22:06:43', '2017-08-19 22:06:43'),
(146, 407, 1, '2017-08-19 22:06:43', '2017-08-19 22:06:43'),
(147, 408, 1, '2017-08-19 22:06:44', '2017-08-19 22:06:44'),
(148, 409, 1, '2017-08-19 22:06:44', '2017-08-19 22:06:44'),
(149, 410, 1, '2017-08-19 22:06:44', '2017-08-19 22:06:44'),
(150, 411, 1, '2017-08-19 22:06:44', '2017-08-19 22:06:44'),
(151, 412, 1, '2017-08-19 22:06:44', '2017-08-19 22:06:44'),
(152, 413, 1, '2017-08-19 22:07:25', '2017-08-19 22:07:25'),
(153, 414, 1, '2017-08-19 22:09:44', '2017-08-19 22:09:44'),
(154, 415, 1, '2017-08-19 22:09:59', '2017-08-19 22:09:59'),
(155, 416, 1, '2017-08-19 22:10:04', '2017-08-19 22:10:04'),
(156, 417, 1, '2017-08-19 22:10:08', '2017-08-19 22:10:08'),
(157, 418, 1, '2017-08-19 22:10:10', '2017-08-19 22:10:10'),
(158, 419, 1, '2017-08-19 22:10:14', '2017-08-19 22:10:14'),
(159, 420, 1, '2017-08-19 22:10:17', '2017-08-19 22:10:17'),
(160, 421, 1, '2017-08-19 22:10:20', '2017-08-19 22:10:20'),
(161, 422, 1, '2017-08-19 22:10:24', '2017-08-19 22:10:24'),
(162, 423, 1, '2017-08-19 22:10:28', '2017-08-19 22:10:28'),
(163, 424, 1, '2017-08-19 22:10:32', '2017-08-19 22:10:32'),
(164, 425, 1, '2017-08-19 22:10:36', '2017-08-19 22:10:36'),
(165, 426, 1, '2017-08-19 22:10:40', '2017-08-19 22:10:40'),
(166, 427, 1, '2017-08-19 22:10:44', '2017-08-19 22:10:44'),
(167, 428, 1, '2017-08-19 22:10:48', '2017-08-19 22:10:48'),
(168, 429, 1, '2017-08-19 22:10:52', '2017-08-19 22:10:52'),
(169, 430, 1, '2017-08-19 22:11:01', '2017-08-19 22:11:01'),
(170, 431, 1, '2017-08-19 22:38:42', '2017-08-19 22:38:42'),
(171, 432, 1, '2017-08-19 22:38:53', '2017-08-19 22:38:53'),
(172, 433, 1, '2017-08-19 22:39:02', '2017-08-19 22:39:02'),
(173, 434, 1, '2017-08-19 22:39:07', '2017-08-19 22:39:07'),
(174, 435, 1, '2017-08-19 22:39:13', '2017-08-19 22:39:13'),
(175, 436, 1, '2017-08-19 22:39:21', '2017-08-19 22:39:21'),
(176, 437, 1, '2017-08-19 22:39:27', '2017-08-19 22:39:27'),
(177, 438, 1, '2017-08-19 22:39:31', '2017-08-19 22:39:31'),
(178, 439, 1, '2017-08-19 22:39:33', '2017-08-19 22:39:33'),
(179, 440, 1, '2017-08-19 22:39:34', '2017-08-19 22:39:34'),
(180, 441, 1, '2017-08-19 22:39:35', '2017-08-19 22:39:35'),
(181, 442, 1, '2017-08-19 22:39:35', '2017-08-19 22:39:35'),
(182, 443, 1, '2017-08-19 22:39:36', '2017-08-19 22:39:36'),
(183, 444, 1, '2017-08-19 22:39:36', '2017-08-19 22:39:36'),
(184, 445, 1, '2017-08-19 22:39:36', '2017-08-19 22:39:36'),
(185, 446, 1, '2017-08-19 22:39:36', '2017-08-19 22:39:36'),
(186, 447, 1, '2017-08-19 22:39:37', '2017-08-19 22:39:37'),
(187, 448, 1, '2017-08-19 22:39:38', '2017-08-19 22:39:38'),
(188, 449, 1, '2017-08-19 22:39:38', '2017-08-19 22:39:38'),
(189, 450, 1, '2017-08-19 22:39:38', '2017-08-19 22:39:38'),
(190, 451, 1, '2017-08-19 22:39:38', '2017-08-19 22:39:38'),
(191, 452, 1, '2017-08-19 22:39:38', '2017-08-19 22:39:38'),
(192, 453, 1, '2017-08-19 22:39:38', '2017-08-19 22:39:38'),
(193, 454, 1, '2017-08-19 22:39:39', '2017-08-19 22:39:39'),
(194, 455, 1, '2017-08-19 22:39:39', '2017-08-19 22:39:39'),
(195, 456, 1, '2017-08-19 22:39:39', '2017-08-19 22:39:39'),
(196, 457, 1, '2017-08-19 22:39:39', '2017-08-19 22:39:39'),
(197, 458, 1, '2017-08-19 22:39:39', '2017-08-19 22:39:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `nation_id` tinyint(3) unsigned NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `nation_id` (`nation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `first_name`, `last_name`, `phone`, `organization`, `nation_id`, `message`, `created_at`, `updated_at`, `remember_token`, `created_by`, `active`, `status`) VALUES
(1, 'minhdung.nguyen86@gmail.com', '$2y$10$K1.WIzVc1XkFpe9WUoBW9urnTx1NfeCaRZN2C2K.QdfXbTk68dVMq', 'Minh Dung', 'Nguyen', '0123456789', 'Home', 1, NULL, '2017-05-08 22:29:12', '2017-08-16 14:16:25', 'MavDbjhRj3bBHHYs5uFLDI3EGOycUeCbAQeQGVgiV41nGe6rxW6Mi0q5J6lX', NULL, 1, 1),
(3, 'thanhpv@hotmail.com', '$2y$10$ZW2cPlb82cavop6EyXudqeHqJfGhobFDso5dxyMjJtTop/sAzFfAm', 'Khanh Huy', 'Pham', '0123456789', 'School', 2, NULL, '2017-05-08 22:29:12', '2017-08-10 09:01:31', '0RbtxFqYdmaI3bmezsjR39KOMLdDBJkBrpArr1hOqCIEcmtfdIkGzdPXgvMq', NULL, 1, 1),
(4, 'qscompanion@gmail.com', '$2y$10$O6F7Q815bg4zsxYwShgtd.qKjlJIuJNkI3si0ScyqbChOSct5T3xe', 'Steve', 'Pelon', '0975622359', 'QsCompanion', 1, NULL, '2017-05-08 22:29:12', '2017-08-13 11:36:12', 'VYgTj1WF6bCKbc6zHLFVSgJJIrI4BjjZE41G33jdfNMwipOeyGp3e5kylYuo', NULL, NULL, 1),
(5, 'pthanh.ce@gmail.com', '$2y$10$3FKTzC2FiZMjLaPtWw3HtuYrvC0KoGPuX3RYN/6iTAyfEGDrg8..2', 'Thanh', 'Pv', '0123456789', 'QsCompanion', 1, NULL, '2017-05-09 01:22:36', '2017-08-10 09:00:27', 'nBmj7SJU8FJgaTOILscgj3zEXEymYnSbBxdssiEWDBfpgIuiQcgGHk0RZsPI', NULL, 1, 1),
(6, 'dinhtuyen.mta@gmail.com', '$2y$10$R2SVfVySSFMF88ExhroR/ee7NhqovUAlr98HzFcp7TzRcFv5.kW6u', 'Tuyen', 'Dinh', '0989364126', 'Company', 1, 'sdfsdfsfs', '2017-05-11 08:27:38', '2017-09-04 10:40:35', '8CsaYJevD87KJeTRxXT4NifhToZA0wocm9Z2JIeYpEyvDCnxfEb1tjWVrF1U', NULL, NULL, 1),
(8, 'pth121288@gmail.com', '4cd9f63083b7ba0bba8aa1dc0753b3a1', 'Hung Tuan', 'Pham', '0123456789', 'Samsung E&C', 2, 'sdfsdfsfs', '2017-05-11 08:36:58', '2017-08-10 09:01:47', NULL, NULL, NULL, 1),
(9, 'thanphungdung@gmail.com', '36abc5609f7429ef5e7a2a7813cff460', 'Dung', 'Thanh Phung', '0936121664', 'Home', 1, 'Make A Update Test', '2017-05-11 08:38:36', '2017-09-04 09:46:35', NULL, NULL, NULL, 1),
(10, 'nationfortun3@gmail.com', '$2y$10$a.OF5TvvFrkz6ql15ovWyOdrkgFYqOwvYRRJzjS1lHmNQZYj/kOBi', 'Hung', 'Pham', '123456789', 'QsCompanion', 1, 'Check message', '2017-05-11 09:50:07', '2017-08-10 09:02:07', 'mAEJpkYIRaWvScAxTHXx0zc1oaJdDuGlkidvSf4yBlmDsjbct1mYzkWeSDQw', NULL, NULL, 1),
(13, 'tuanhung.more@gmail.com', '$2y$10$Ht4js1kPKzce4LIWU/scCexA6dcbhMqSpDS8Lc1GKuuAkmyCj9qQu', 'Tuan Hung', 'Pham', '123456789', 'Home', 2, 'Check message', '2017-05-11 09:53:24', '2017-08-30 07:56:27', 'cRG9hnCK8o9FiY5pMo1z0qkradbamOjZkztn0k5wiV96v3eObCBzNt8Agum1', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `wbs`
--

CREATE TABLE IF NOT EXISTS `wbs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(25) DEFAULT NULL,
  `parent_code` char(25) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `extension` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `quantify` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent_child_k` (`code`,`parent_code`),
  UNIQUE KEY `code` (`code`),
  KEY `parent_code` (`parent_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3936 ;

--
-- Dumping data for table `wbs`
--

INSERT INTO `wbs` (`id`, `code`, `parent_code`, `name`, `description`, `extension`, `status`, `quantify`, `created_at`, `updated_at`) VALUES
(1, '0', NULL, 'Root', NULL, 0, 1, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(166, '101000', '100000', 'Information Specialties', NULL, 0, 0, 0, '2017-06-24 23:12:38', '2017-09-11 10:06:55'),
(168, '102000', '100000', 'Interior Specialties', NULL, 0, 0, 0, '2017-06-24 23:12:38', '2017-09-11 10:06:55'),
(190, '110000', '0', 'Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(191, '110100', '110000', 'Maintenance Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(192, '110200', '110000', 'Security and Vault Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(193, '110300', '110000', 'Teller and Service Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(194, '110400', '110000', 'Ecclesiastical Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(211, '111000', '110000', 'Vehicle and Pedestrian Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(212, '111100', '110000', 'Vehicle Service Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(213, '111200', '110000', 'Parking Control Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(214, '111300', '110000', 'Loading Dock Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(215, '111400', '110000', 'Pedestrian Control Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(216, '111500', '110000', 'Security, Detention, and Banking Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(217, '111600', '110000', 'Vault Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(218, '111700', '110000', 'Teller and Service Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(220, '111800', '110000', 'Security Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(221, '111900', '110000', 'Detention Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(222, '112000', '110000', 'Commercial Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(223, '112100', '110000', 'Mercantile and Service Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(224, '112200', '110000', 'Refrigerated Display Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(225, '112300', '110000', 'Commercial Laundry and Dry Cleaning Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(226, '112400', '110000', 'Maintenance Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(227, '112500', '110000', 'Hospitality Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(229, '112600', '110000', 'Unit Kitchens', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(230, '112700', '110000', 'Photographic Processing Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(231, '112800', '110000', 'Office Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(232, '112900', '110000', 'Postal, Packaging, and Shipping Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(233, '113000', '110000', 'Residential Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(234, '113100', '110000', 'Residential Appliances', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(235, '113300', '110000', 'Retractable Stairs', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(236, '113400', '110000', 'Residential Ceiling Fans', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(237, '114000', '110000', 'Foodservice Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(238, '114100', '110000', 'Foodservice Storage Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(239, '114200', '110000', 'Food Preparation Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(240, '114300', '110000', 'Food Delivery Carts and Conveyors', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(241, '114400', '110000', 'Food Cooking Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(242, '114600', '110000', 'Food Dispensing Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(243, '114700', '110000', 'Ice Machines', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(244, '114800', '110000', 'Cleaning and Disposal Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(245, '115000', '110000', 'Educational and Scientific Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(246, '115100', '110000', 'Library Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(247, '115200', '110000', 'Audio-Visual Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(248, '115300', '110000', 'Laboratory Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(249, '115500', '110000', 'Planetarium Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(250, '115600', '110000', 'Observatory Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(251, '115700', '110000', 'Vocational Shop Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(252, '115900', '110000', 'Exhibit Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(253, '116000', '110000', 'Entertainment Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(254, '116100', '110000', 'Broadcast, Theater, and Stage Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(255, '116200', '110000', 'Musical Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(256, '116300', '110000', 'Athletic and Recreational Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(257, '116600', '110000', 'Athletic Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(258, '116700', '110000', 'Recreational Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(259, '116800', '110000', 'Play Field Equipment and Structures', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(261, '117000', '110000', 'Healthcare Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(262, '117100', '110000', 'Medical Sterilizing Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(263, '117200', '110000', 'Examination and Treatment Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(264, '117300', '110000', 'Patient Care Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(265, '117400', '110000', 'Dental Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(266, '117500', '110000', 'Optical Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(267, '117600', '110000', 'Operating Room Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(268, '117700', '110000', 'Radiology Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(269, '117800', '110000', 'Mortuary Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(270, '117900', '110000', 'Therapy Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(271, '118000', '110000', 'Collection and Disposal Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(272, '118200', '110000', 'Solid Waste Handling Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(273, '119000', '110000', 'Other Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(274, '119100', '110000', 'Religious Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(275, '119200', '110000', 'Agricultural Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(276, '119300', '110000', 'Horticultural Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(277, '119500', '110000', 'Arts and Crafts Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(278, '120000', '0', 'Furnishings', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(279, '120100', '120000', 'Operation and Maintenance of Furnishings', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(280, '120500', '120000', 'Common Work Results for Furnishings', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(281, '120600', '120000', 'Schedules for Furnishings', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(282, '120800', '120000', 'Commissioning of Furnishings', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(284, '121000', '120000', 'Art', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(285, '121100', '120000', 'Murals', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(286, '121200', '120000', 'Wall Decorations', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(287, '121400', '120000', 'Sculptures', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(288, '121700', '120000', 'Art Glass', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(289, '121900', '120000', 'Religious Art', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(290, '122000', '120000', 'Window Treatments', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(291, '122100', '120000', 'Window Blinds', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(292, '122200', '120000', 'Curtains and Drapes', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(293, '122300', '120000', 'Interior Shutters', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(294, '122400', '120000', 'Window Shades', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(295, '122500', '120000', 'Window Treatment Operating Hardware', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(296, '122600', '120000', 'Interior Daylighting Devices', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(297, '123000', '120000', 'Casework', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(298, '123100', '120000', 'Manufactured Metal Casework', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(299, '123200', '120000', 'Manufactured Wood Casework', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(300, '123400', '120000', 'Manufactured Plastic Casework', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(301, '123500', '120000', 'Specialty Casework', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(302, '123600', '120000', 'Countertops', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(303, '124000', '120000', 'Furnishings and Accessories', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(304, '124100', '120000', 'Office Accessories', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(305, '124200', '120000', 'Table Accessories', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(306, '124300', '120000', 'Portable Lamps', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(307, '124400', '120000', 'Bath Furnishings', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(308, '124500', '120000', 'Bedroom Furnishings', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(309, '124600', '120000', 'Furnishing Accessories', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(310, '124800', '120000', 'Rugs and Mats', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(311, '125000', '120000', 'Furniture', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(312, '125100', '120000', 'Office Furniture', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(313, '125200', '120000', 'Seating', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(314, '125300', '120000', 'Retail Furniture', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(315, '125400', '120000', 'Hospitality Furniture', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(316, '125500', '120000', 'Detention Furniture', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(317, '125600', '120000', 'Institutional Furniture', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(318, '125700', '120000', 'Industrial Furniture', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(319, '125800', '120000', 'Residential Furniture', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(320, '125900', '120000', 'Systems Furniture', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(321, '126000', '120000', 'Multiple Seating', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(322, '126100', '120000', 'Fixed Audience Seating', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(323, '126200', '120000', 'Portable Audience Seating', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(324, '126300', '120000', 'Stadium and Arena Seating', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(325, '126400', '120000', 'Booths and Tables', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(326, '126500', '120000', 'Multiple-Use Fixed Seating', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(327, '126600', '120000', 'Telescoping Stands', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(328, '126700', '120000', 'Pews and Benches', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(329, '126800', '120000', 'Seat and Table Assemblies', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(330, '129000', '120000', 'Other Furnishings', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(331, '129200', '120000', 'Interior Planters and Artificial Plants', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(332, '129300', '120000', 'Site Furnishings', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(333, '130000', '0', 'Special Construction', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(334, '130100', '130000', 'Operation and Maintenance of Special Construction', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(335, '130500', '130000', 'Common Work Results for Special Construction', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(336, '130600', '130000', 'Schedules for Special Construction', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(337, '130800', '130000', 'Commissioning of Special Construction', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(338, '131000', '130000', 'Special Facility Components', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(339, '131100', '130000', 'Swimming Pools', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(340, '131200', '130000', 'Fountains', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(341, '131300', '130000', 'Aquariums', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(342, '131400', '130000', 'Amusement Park Structures and Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(343, '131700', '130000', 'Tubs and Pools', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(344, '131800', '130000', 'Ice Rinks', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(345, '131900', '130000', 'Kennels and Animal Shelters', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(346, '132000', '130000', 'Special Purpose Rooms', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(347, '132100', '130000', 'Controlled Environment Rooms', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(348, '132200', '130000', 'Office Shelters and Booths', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(349, '132300', '130000', 'Planetariums', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(350, '132400', '130000', 'Special Activity Rooms', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(351, '132600', '130000', 'Fabricated Rooms', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(352, '132700', '130000', 'Vaults', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(353, '132800', '130000', 'Athletic and Recreational Special Construction', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(354, '133000', '130000', 'Special Structures', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(355, '133100', '130000', 'Fabric Structures', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(356, '133200', '130000', 'Space Frames', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(357, '133300', '130000', 'Geodesic Structures', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(358, '133400', '130000', 'Fabricated Engineered Structures', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(359, '133500', '130000', 'Rammed Earth Construction', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(360, '133600', '130000', 'Towers', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(362, '134000', '130000', 'Integrated Construction', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(363, '134200', '130000', 'Building Modules', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(364, '134400', '130000', 'Modular Mezzanines', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(365, '134800', '130000', 'Sound, Vibration, and Seismic Control', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(366, '134900', '130000', 'Radiation Protection', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(367, '135000', '130000', 'Special Instrumentation', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(368, '135100', '130000', 'Stress Instrumentation', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(369, '135200', '130000', 'Seismic Instrumentation', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(370, '135300', '130000', 'Meteorological Instrumentation', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(371, '140000', '0', 'Conveying Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(372, '140100', '140000', 'Operation and Maintenance of Conveying Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(373, '140500', '140000', 'Common Work Results for Conveying Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(374, '140600', '140000', 'Schedules for Conveying Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(375, '140800', '140000', 'Commissioning of Conveying Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(376, '141000', '140000', 'Dumbwaiters', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(377, '141100', '140000', 'Manual Dumbwaiters', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(378, '141200', '140000', 'Electric Dumbwaiters', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(379, '141400', '140000', 'Hydraulic Dumbwaiters', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(380, '142000', '140000', 'Elevators', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(381, '142100', '142000', 'Electric Traction Elevators', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(382, '142400', '142000', 'Hydraulic Elevators', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(383, '142600', '142000', 'Limited-Use/Limited-Application Elevators', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(384, '142700', '142000', 'Custom Elevator Cabs and Doors', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(385, '142800', '142000', 'Elevator Equipment and Controls', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(386, '143000', '140000', 'Escalators and Moving Walks', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(387, '144000', '140000', 'Lifts', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(388, '147000', '140000', 'Turntables', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(389, '148000', '140000', 'Scaffolding', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(390, '149000', '140000', 'Other Conveying Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(391, '210000', '0', 'Fire Suppression', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(392, '211000', '210000', 'Water-Based Fire-Suppression Systems', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(393, '212000', '210000', 'Fire-Extinguishing Systems', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(394, '213000', '210000', 'Fire Pumps', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(395, '214000', '210000', 'Fire-Suppression Water Storage', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(396, '220000', '0', 'Plumbing', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(397, '221000', '220000', 'Plumbing Piping', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(398, '223000', '220000', 'Plumbing Equipment', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(400, '225000', '220000', 'Pool and Fountain Plumbing Systems', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(401, '224000', '220000', 'Plumbing Fixtures', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(402, '226000', '220000', 'Gas and Vacuum Systems for Laboratory', '', 0, 0, 0, '2017-06-24 23:12:38', '2017-06-24 23:12:49'),
(423, '030110', '030100', 'Maintenance of Concrete Forming and Accessories', NULL, 0, 0, 0, '2017-08-18 10:59:35', '2017-09-08 09:48:10'),
(424, '030120', '030100', 'Maintenance of Concrete Reinforcing', NULL, 0, 0, 0, '2017-08-18 11:00:22', '2017-09-08 09:48:10'),
(952, '64216', '064200', 'Flush Wood Paneling', NULL, 0, 0, 0, '2017-08-19 13:43:56', '2017-09-11 09:23:58'),
(953, '64219', '064200', 'Plastic-Laminate-Faced Wood Paneling', NULL, 0, 0, 0, '2017-08-19 13:44:46', '2017-09-11 09:23:58'),
(955, '64313', '064300', 'Wood Stairs', NULL, 0, 0, 0, '2017-08-19 13:46:46', '2017-09-11 09:35:55'),
(956, '64316', '064300', 'Wood Railings', NULL, 0, 0, 0, '2017-08-19 13:47:11', '2017-09-11 09:35:55'),
(997, '66600', '066000', 'Custom Ornamental  Simulated Woodwork', NULL, 0, 0, 0, '2017-08-19 14:22:01', '2017-09-11 09:52:51'),
(1968, '101100', '101000', 'Visual Display Units', NULL, 0, 0, 0, '2017-08-30 09:08:22', '2017-08-30 09:08:22'),
(1969, '101113', '101100', 'Chalkboards', NULL, 0, 0, 0, '2017-08-30 09:08:53', '2017-08-30 09:08:53'),
(1970, '10111313', '101113', 'Fixed Chalkboards', NULL, 0, 0, 0, '2017-08-30 09:11:18', '2017-08-30 09:11:18'),
(1971, '10111323', '101113', 'Modular-Support-Mounted Chalkboards', NULL, 0, 0, 0, '2017-08-30 09:11:37', '2017-08-30 09:11:37'),
(1972, '10111333', '101113', 'Rail-Mounted Chalkboards', NULL, 0, 0, 0, '2017-08-30 09:11:52', '2017-08-30 09:11:52'),
(1973, '10111343', '101113', 'Portable Chalkboards', NULL, 0, 0, 0, '2017-08-30 09:12:11', '2017-08-30 09:12:11'),
(1974, '101116', '101100', 'Markerboards', NULL, 0, 0, 0, '2017-08-30 09:12:30', '2017-08-30 09:12:30'),
(1975, '10111613', '101116', 'Fixed Markerboards', NULL, 0, 0, 0, '2017-08-30 09:12:54', '2017-08-30 09:12:54'),
(1976, '10111623', '101116', 'Modular-Support-Mounted Markerboards', NULL, 0, 0, 0, '2017-08-30 09:13:08', '2017-08-30 09:13:08'),
(1977, '10111633', '101116', 'Rail-Mounted Markerboards', NULL, 0, 0, 0, '2017-08-30 09:13:24', '2017-08-30 09:13:24'),
(1978, '10111643', '101116', 'Portable Markerboards', NULL, 0, 0, 0, '2017-08-30 09:13:38', '2017-08-30 09:13:38'),
(1979, '10111653', '101116', 'Electronic Markerboards', NULL, 0, 0, 0, '2017-08-30 09:13:54', '2017-08-30 09:13:54'),
(1980, '101123', '101100', 'Tackboards', NULL, 0, 0, 0, '2017-08-30 09:14:12', '2017-08-30 09:14:12'),
(1981, '10112313', '101123', 'Fixed Tackboards', NULL, 0, 0, 0, '2017-08-30 09:14:33', '2017-08-30 09:14:33'),
(1982, '10112323', '101123', 'Modular-Support-Mounted Tackboards', NULL, 0, 0, 0, '2017-08-30 09:14:46', '2017-08-30 09:14:46'),
(1983, '10112333', '101123', 'Rail-Mounted Tackboards', NULL, 0, 0, 0, '2017-08-30 09:15:00', '2017-08-30 09:15:00'),
(1984, '10112343', '101123', 'Portable Tackboards', NULL, 0, 0, 0, '2017-08-30 09:15:14', '2017-08-30 09:15:14'),
(1985, '101133', '101100', 'Sliding Visual Display Units', NULL, 0, 0, 0, '2017-08-30 09:15:41', '2017-08-30 09:15:41'),
(1986, '10113313', '101133', 'Horizontal-Sliding Visual Display Units', NULL, 0, 0, 0, '2017-08-30 09:15:55', '2017-08-30 09:15:55'),
(1987, '10113323', '101133', 'Vertical-Sliding Visual Display Units', NULL, 0, 0, 0, '2017-08-30 09:16:09', '2017-08-30 09:16:09'),
(1988, '101136', '101100', 'Visual Display Conference Units', NULL, 0, 0, 0, '2017-08-30 09:16:26', '2017-08-30 09:16:26'),
(1989, '101139', '101100', 'Visual Display Rails', NULL, 0, 0, 0, '2017-08-30 09:16:41', '2017-08-30 09:16:41'),
(1990, '101143', '101100', 'Visual Display Wall Panels', NULL, 0, 0, 0, '2017-08-30 09:16:59', '2017-08-30 09:16:59'),
(1991, '101146', '101100', 'Visual Display Fabrics', NULL, 0, 0, 0, '2017-08-30 09:17:12', '2017-08-30 09:17:12'),
(1992, '101200', '101000', 'Display Cases', NULL, 0, 0, 0, '2017-08-30 09:17:46', '2017-08-30 09:17:46'),
(1993, '101300', '101000', 'Directories', NULL, 0, 0, 0, '2017-08-30 09:18:00', '2017-08-30 09:18:00'),
(1994, '101313', '101300', 'Electronic Directories', NULL, 0, 0, 0, '2017-08-30 09:18:19', '2017-08-30 09:18:19'),
(1995, '101323', '101300', 'Illuminated Directories', NULL, 0, 0, 0, '2017-08-30 09:18:33', '2017-08-30 09:18:33'),
(1996, '101400', '101000', 'Signage', NULL, 0, 0, 0, '2017-08-30 09:18:52', '2017-08-30 09:18:52'),
(1997, '101416', '101400', 'Plaques', NULL, 0, 0, 0, '2017-08-30 09:19:09', '2017-08-30 09:19:09'),
(1998, '101419', '101400', 'Dimensional Letter Signage', NULL, 0, 0, 0, '2017-08-30 09:19:22', '2017-08-30 09:19:22'),
(1999, '101423', '101400', 'Panel Signage', NULL, 0, 0, 0, '2017-08-30 09:19:35', '2017-08-30 09:19:35'),
(2000, '10142313', '101423', 'Engraved Panel Signage', NULL, 0, 0, 0, '2017-08-30 09:26:30', '2017-08-30 09:26:30'),
(2001, '101426', '101400', 'Post and Panel/Pylon Signage', NULL, 0, 0, 0, '2017-08-30 09:26:50', '2017-08-30 09:26:50'),
(2002, '101433', '101400', 'Illuminated Panel Signage', NULL, 0, 0, 0, '2017-08-30 09:27:09', '2017-08-30 09:27:09'),
(2003, '101443', '101400', 'Photoluminescent Signage', NULL, 0, 0, 0, '2017-08-30 09:27:22', '2017-08-30 09:27:22'),
(2004, '101453', '101400', 'Traffic Signage', NULL, 0, 0, 0, '2017-08-30 09:27:45', '2017-08-30 09:27:45'),
(2005, '10145313', '101453', 'Transportation Reference Markers', NULL, 0, 0, 0, '2017-08-30 09:28:08', '2017-08-30 09:28:08'),
(2006, '101463', '101400', 'Electronic Message Signage', NULL, 0, 0, 0, '2017-08-30 09:28:27', '2017-08-30 09:28:27'),
(2007, '101464', '101400', 'Audible Signage', NULL, 0, 0, 0, '2017-08-30 09:28:44', '2017-08-30 09:28:44'),
(2008, '101466', '101400', 'Floating Signage', NULL, 0, 0, 0, '2017-08-30 09:29:02', '2017-08-30 09:29:02'),
(2009, '101467', '101400', 'Tactile Signage', NULL, 0, 0, 0, '2017-08-30 09:29:15', '2017-08-30 09:29:15'),
(2010, '101700', '101000', 'Telephone Specialties', NULL, 0, 0, 0, '2017-08-30 09:37:16', '2017-08-30 09:37:16'),
(2011, '101713', '101700', 'Telephone Directory Units', NULL, 0, 0, 0, '2017-08-30 09:37:36', '2017-08-30 09:37:36'),
(2012, '101716', '101700', 'Telephone Enclosures', NULL, 0, 0, 0, '2017-08-30 09:37:55', '2017-08-30 09:37:55'),
(2013, '10171613', '101716', 'Telephone Stalls', NULL, 0, 0, 0, '2017-08-30 09:38:20', '2017-08-30 09:38:20'),
(2014, '10171616', '101716', 'Telephone Alcoves', NULL, 0, 0, 0, '2017-08-30 09:38:43', '2017-08-30 09:38:43'),
(2015, '101719', '101700', 'Telephone Shelving', NULL, 0, 0, 0, '2017-08-30 09:39:05', '2017-08-30 09:39:05'),
(2016, '101800', '101000', 'Informational Kiosks', NULL, 0, 0, 0, '2017-08-30 09:39:24', '2017-08-30 09:39:24'),
(2017, '102100', '102000', 'Compartments and Cubicles', NULL, 0, 0, 0, '2017-08-30 09:40:35', '2017-08-30 09:40:35'),
(2018, '102113', '102100', 'Toilet Compartments', NULL, 0, 0, 0, '2017-08-30 09:40:55', '2017-08-30 09:40:55'),
(2019, '10211313', '102113', 'Metal Toilet Compartments', NULL, 0, 0, 0, '2017-08-30 09:41:12', '2017-08-30 09:41:12'),
(2020, '10211314', '102113', 'Stainless-Steel Toilet Compartments', NULL, 0, 0, 0, '2017-08-30 09:41:31', '2017-08-30 09:41:31'),
(2021, '10211316', '102113', 'Plastic-Laminate-Clad Toilet Compartments', NULL, 0, 0, 0, '2017-08-30 09:41:57', '2017-08-30 09:41:57'),
(2022, '10211317', '102113', 'Phenolic-Core Toilet Compartments', NULL, 0, 0, 0, '2017-08-30 09:42:14', '2017-08-30 09:42:14'),
(2023, '10211319', '102113', 'Plastic Toilet Compartments', NULL, 0, 0, 0, '2017-08-30 09:42:30', '2017-08-30 09:42:30'),
(2024, '10211323', '102113', 'Particleboard Toilet Compartments', NULL, 0, 0, 0, '2017-08-30 09:42:46', '2017-08-30 09:42:46'),
(2025, '10211340', '102113', 'Stone Toilet Compartments', NULL, 0, 0, 0, '2017-08-30 09:43:05', '2017-08-30 09:43:05'),
(2026, '102116', '102100', 'Shower and Dressing Compartments', NULL, 0, 0, 0, '2017-08-30 09:44:06', '2017-08-30 09:44:06'),
(2027, '10211613', '102116', 'Metal Shower and Dressing Compartments', NULL, 0, 0, 0, '2017-08-30 09:44:27', '2017-08-30 09:44:27'),
(2028, '10211614', '102116', 'Stainless-Steel Shower and Dressing Compartments', NULL, 0, 0, 0, '2017-08-30 09:44:46', '2017-08-30 09:44:46'),
(2029, '10211616', '102116', 'Plastic-Laminate-Clad Shower and Dressing Compartments', NULL, 0, 0, 0, '2017-08-30 09:45:05', '2017-08-30 09:45:05'),
(2030, '10211617', '102116', 'Phenolic-Core Shower and Dressing Compartments', NULL, 0, 0, 0, '2017-08-30 09:45:24', '2017-08-30 09:45:24'),
(2032, '10211619', '102116', 'Plastic Shower and Dressing Compartments', NULL, 0, 0, 0, '2017-08-30 09:46:11', '2017-08-30 09:46:11'),
(2033, '10211623', '102116', 'Particleboard Shower and Dressing Compartments', NULL, 0, 0, 0, '2017-08-30 09:47:07', '2017-08-30 09:47:07'),
(2034, '10211640', '102116', 'Stone Shower and Dressing Compartments', NULL, 0, 0, 0, '2017-08-30 09:47:42', '2017-08-30 09:47:42'),
(2035, '102123', '102100', 'Cubicle Curtains and Track', NULL, 0, 0, 0, '2017-08-30 09:48:12', '2017-08-30 09:48:12'),
(2036, '10212313', '102123', 'Cubicle Curtains', NULL, 0, 0, 0, '2017-08-30 09:48:30', '2017-08-30 09:48:30'),
(2037, '10212316', '102123', 'Cubicle Track and Hardware', NULL, 0, 0, 0, '2017-08-30 09:48:48', '2017-08-30 09:48:48'),
(2038, '102126', '102100', 'Room Darkening Curtains and Tracks', NULL, 0, 0, 0, '2017-08-30 09:49:10', '2017-08-30 09:49:10'),
(2039, '102200', '100000', 'Partitions', NULL, 0, 0, 0, '2017-08-30 09:51:15', '2017-09-11 10:06:55'),
(2040, '102213', '102200', 'Wire Mesh Partitions', NULL, 0, 0, 0, '2017-08-30 09:51:35', '2017-08-30 09:51:35'),
(2041, '102214', '102200', 'Expanded Metal Partitions', NULL, 0, 0, 0, '2017-08-30 09:51:54', '2017-08-30 09:51:54'),
(2042, '102216', '102200', 'Folding Gates', NULL, 0, 0, 0, '2017-08-30 09:52:15', '2017-08-30 09:52:15'),
(2043, '102219', '102200', 'Demountable Partitions', NULL, 0, 0, 0, '2017-08-30 09:52:36', '2017-08-30 09:52:36'),
(2044, '10221913', '102219', 'Demountable Metal Partitions', NULL, 0, 0, 0, '2017-08-30 09:52:54', '2017-08-30 09:52:54'),
(2045, '10221933', '102219', 'Demountable Plastic Partitions', NULL, 0, 0, 0, '2017-08-30 09:53:12', '2017-08-30 09:53:37'),
(2046, '10221943', '102219', 'Demountable Composite Partitions', NULL, 0, 0, 0, '2017-08-30 09:53:59', '2017-08-30 09:53:59'),
(2047, '10221953', '102219', 'Demountable Gypsum Partitions', NULL, 0, 0, 0, '2017-08-30 09:54:17', '2017-08-30 09:54:17'),
(2048, '102223', '102200', 'Portable Partitions, Screens, and Panels', NULL, 0, 0, 0, '2017-08-30 09:54:42', '2017-08-30 09:54:42'),
(2049, '10222313', '102223', 'Wall Screens', NULL, 0, 0, 0, '2017-08-30 09:56:15', '2017-08-30 09:56:15'),
(2050, '10222323', '102223', 'Movable Panel Systems', NULL, 0, 0, 0, '2017-08-30 09:56:30', '2017-08-30 09:56:30'),
(2051, '102233', '102200', 'Accordion Folding Partitions', NULL, 0, 0, 0, '2017-08-30 09:56:59', '2017-08-30 09:56:59'),
(2052, '102236', '102200', 'Coiling Partitions', NULL, 0, 0, 0, '2017-08-30 09:57:16', '2017-08-30 09:57:16'),
(2053, '102239', '102200', 'Folding Panel Partitions', NULL, 0, 0, 0, '2017-08-30 09:57:32', '2017-08-30 09:57:32'),
(2054, '10223913', '102239', 'Folding Glass-Panel Partitions', NULL, 0, 0, 0, '2017-08-30 09:57:48', '2017-08-30 09:57:48'),
(2055, '102243', '102200', 'Sliding Partitions', NULL, 0, 0, 0, '2017-08-30 09:58:07', '2017-08-30 09:58:07'),
(2056, '102500', '100000', 'Service Walls', NULL, 0, 0, 0, '2017-08-30 09:58:31', '2017-09-11 10:06:55'),
(2057, '102513', '102500', 'Patient Bed Service Walls', NULL, 0, 0, 0, '2017-08-30 09:58:47', '2017-08-30 09:58:47'),
(2058, '102516', '102500', 'Modular Service Walls', NULL, 0, 0, 0, '2017-08-30 09:59:04', '2017-08-30 09:59:04'),
(2059, '102600', '100000', 'Wall and Door Protection', NULL, 0, 0, 0, '2017-08-30 09:59:20', '2017-09-11 10:06:55'),
(2060, '102613', '102600', 'Corner Guards', NULL, 0, 0, 0, '2017-08-30 09:59:37', '2017-08-30 09:59:37'),
(2061, '102616', '102600', 'Bumper Guards', NULL, 0, 0, 0, '2017-08-30 09:59:50', '2017-08-30 09:59:50'),
(2062, '10261613', '102616', 'Bumper Rails', NULL, 0, 0, 0, '2017-08-30 10:00:09', '2017-08-30 10:00:09'),
(2063, '10261616', '102616', 'Protective Corridor Handrails', NULL, 0, 0, 0, '2017-08-30 10:00:25', '2017-08-30 10:00:25'),
(2064, '102623', '102600', 'Protective Wall Covering', NULL, 0, 0, 0, '2017-08-30 10:00:43', '2017-08-30 10:00:43'),
(2065, '10262313', '102623', 'Impact Resistant Wall Protection', NULL, 0, 0, 0, '2017-08-30 10:01:05', '2017-08-30 10:01:05'),
(2066, '10262316', '102623', 'Fiberglass Reinforced Protective Wall Covering', NULL, 0, 0, 0, '2017-08-30 10:01:21', '2017-08-30 10:01:21'),
(2067, '102633', '102600', 'Door and Frame Protection', NULL, 0, 0, 0, '2017-08-30 10:01:38', '2017-08-30 10:01:38'),
(2068, '102641', '102600', 'Bullet Resistant Panels', NULL, 0, 0, 0, '2017-08-30 10:01:53', '2017-08-30 10:01:53'),
(2069, '102800', '100000', 'Toilet, Bath, and Laundry Accessories', NULL, 0, 0, 0, '2017-08-30 10:02:10', '2017-09-11 10:06:55'),
(2070, '102813', '102800', 'Toilet Accessories', NULL, 0, 0, 0, '2017-08-30 10:02:26', '2017-08-30 10:02:26'),
(2071, '10281313', '102813', 'Commercial Toilet Accessories', NULL, 0, 0, 0, '2017-08-30 10:03:19', '2017-08-30 10:03:19'),
(2072, '10281319', '102813', 'Healthcare Toilet Accessories', NULL, 0, 0, 0, '2017-08-30 10:03:38', '2017-08-30 10:03:38'),
(2073, '10281353', '102813', 'Security Toilet Accessories', NULL, 0, 0, 0, '2017-08-30 10:04:11', '2017-08-30 10:04:11'),
(2075, '10291363', '102813', 'Detention Toilet Accessories', NULL, 0, 0, 0, '2017-08-30 10:10:54', '2017-08-30 10:10:54'),
(2076, '102816', '102800', 'Bath Accessories', NULL, 0, 0, 0, '2017-08-30 10:11:26', '2017-08-30 10:11:26'),
(2077, '10281613', '102816', 'Residential Bath Accessories', NULL, 0, 0, 0, '2017-08-30 10:11:45', '2017-08-30 10:11:45'),
(2078, '102819', '102800', 'Tub and Shower Enclosures', NULL, 0, 0, 0, '2017-08-30 10:12:04', '2017-08-30 10:12:04'),
(2079, '10281916', '102819', 'Shower Doors', NULL, 0, 0, 0, '2017-08-30 10:12:33', '2017-08-30 10:12:33'),
(2080, '10281919', '102819', 'Tub Doors', NULL, 0, 0, 0, '2017-08-30 10:12:52', '2017-08-30 10:12:52'),
(2081, '102823', '102800', 'Laundry Accessories', NULL, 0, 0, 0, '2017-08-30 10:13:56', '2017-08-30 10:13:56'),
(2082, '10282313', '102823', 'Built-In Ironing Boards', NULL, 0, 0, 0, '2017-08-30 10:14:19', '2017-08-30 10:14:19'),
(2083, '10282316', '102823', 'Clothes Drying Racks', NULL, 0, 0, 0, '2017-08-30 10:14:34', '2017-08-30 10:14:34'),
(2084, '102826', '102800', 'Hygiene and Custodial Accessories', NULL, 0, 0, 0, '2017-08-30 10:14:49', '2017-08-30 10:14:49'),
(2085, '103000', '100000', 'Fireplaces and Stoves', NULL, 0, 0, 0, '2017-08-30 10:15:11', '2017-09-11 10:06:55'),
(2086, '103100', '103000', 'Manufactured Fireplaces', NULL, 0, 0, 0, '2017-08-30 10:15:28', '2017-08-30 10:15:28'),
(2087, '103113', '103100', 'Manufactured Fireplace Chimneys', NULL, 0, 0, 0, '2017-08-30 10:15:44', '2017-08-30 10:15:44'),
(2088, '103116', '103100', 'Manufactured Fireplace Forms', NULL, 0, 0, 0, '2017-08-30 10:15:59', '2017-08-30 10:15:59'),
(2089, '103200', '103000', 'Fireplace Specialties', NULL, 0, 0, 0, '2017-08-30 10:16:17', '2017-08-30 10:16:17'),
(2090, '103213', '103200', 'Fireplace Dampers', NULL, 0, 0, 0, '2017-08-30 10:16:31', '2017-08-30 10:16:31'),
(2091, '103216', '103200', 'Fireplace Inserts', NULL, 0, 0, 0, '2017-08-30 10:16:43', '2017-08-30 10:16:43'),
(2092, '103219', '103200', 'Fireplace Screens', NULL, 0, 0, 0, '2017-08-30 10:16:56', '2017-08-30 10:16:56'),
(2093, '103223', '103200', 'Fireplace Doors', NULL, 0, 0, 0, '2017-08-30 10:17:10', '2017-08-30 10:17:10'),
(2094, '103226', '103200', 'Fireplace Water Heaters', NULL, 0, 0, 0, '2017-08-30 10:17:22', '2017-08-30 10:17:22'),
(2095, '103500', '103000', 'Stoves', NULL, 0, 0, 0, '2017-08-30 10:17:44', '2017-08-30 10:17:44'),
(2096, '103513', '103500', 'Heating Stoves', NULL, 0, 0, 0, '2017-08-30 10:17:57', '2017-08-30 10:17:57'),
(2097, '103523', '103500', 'Cooking Stoves', NULL, 0, 0, 0, '2017-08-30 10:18:09', '2017-08-30 10:18:09'),
(2098, '104000', '100000', 'Safety Specialties', NULL, 0, 0, 0, '2017-08-30 10:35:31', '2017-09-11 10:06:55'),
(2099, '104100', '104000', 'Emergency Access and Information Cabinets', NULL, 0, 0, 0, '2017-08-30 10:35:49', '2017-08-30 10:35:49'),
(2100, '104113', '104100', 'Fire Department Plan Cabinets', NULL, 0, 0, 0, '2017-08-30 10:36:14', '2017-08-30 10:36:14'),
(2101, '104116', '104100', 'Emergency Key Cabinets', NULL, 0, 0, 0, '2017-08-30 10:36:30', '2017-08-30 10:36:30'),
(2102, '104300', '104000', 'Emergency Aid Specialties', NULL, 0, 0, 0, '2017-08-30 10:36:47', '2017-08-30 10:36:47'),
(2103, '104313', '104300', 'Defibrillator Cabinets', NULL, 0, 0, 0, '2017-08-30 10:37:07', '2017-08-30 10:37:07'),
(2104, '104316', '104300', 'First Aid Cabinets', NULL, 0, 0, 0, '2017-08-30 10:37:20', '2017-08-30 10:37:20'),
(2105, '104321', '104300', 'Accessibility Evacuation Chairs', NULL, 0, 0, 0, '2017-08-30 10:37:33', '2017-08-30 10:37:33'),
(2106, '104331', '104300', 'Respiration Equipment', NULL, 0, 0, 0, '2017-08-30 10:37:48', '2017-08-30 10:37:48'),
(2107, '104333', '104300', 'Breathing Air Replenishment Systems', NULL, 0, 0, 0, '2017-08-30 11:06:48', '2017-08-30 11:06:48'),
(2108, '104400', '104000', 'Fire Protection Specialties', NULL, 0, 0, 0, '2017-08-30 11:07:11', '2017-08-30 11:07:11'),
(2109, '104413', '104400', 'Fire Protection Cabinets', NULL, 0, 0, 0, '2017-08-30 11:07:38', '2017-08-30 11:07:38'),
(2110, '10441353', '104413', 'Security Fire Extinguisher Cabinets', NULL, 0, 0, 0, '2017-08-30 11:08:01', '2017-08-30 11:08:01'),
(2111, '104416', '104400', 'Fire Extinguishers', NULL, 0, 0, 0, '2017-08-30 11:08:18', '2017-08-30 11:08:18'),
(2112, '10441613', '104416', 'Portable Fire Extinguishers', NULL, 0, 0, 0, '2017-08-30 11:08:37', '2017-08-30 11:08:37'),
(2113, '10441616', '104416', 'Wheeled Fire Extinguisher Units', NULL, 0, 0, 0, '2017-08-30 11:08:51', '2017-08-30 11:08:51'),
(2114, '104419', '104400', 'Fire Blankets', NULL, 0, 0, 0, '2017-08-30 11:09:15', '2017-08-30 11:09:15'),
(2115, '104443', '104400', 'Fire Extinguisher Accessories', NULL, 0, 0, 0, '2017-08-30 11:09:30', '2017-08-30 11:09:30'),
(2116, '104500', '104000', 'Photoluminescent Exit Specialties', NULL, 0, 0, 0, '2017-08-30 11:09:51', '2017-08-30 11:09:51'),
(2117, '105000', '100000', 'Storage Specialties', NULL, 0, 0, 0, '2017-08-30 11:10:11', '2017-09-11 10:06:55'),
(2118, '105100', '105000', 'Lockers', NULL, 0, 0, 0, '2017-08-30 11:10:28', '2017-08-30 11:10:28'),
(2119, '105113', '105100', 'Metal Lockers', NULL, 0, 0, 0, '2017-08-30 11:11:00', '2017-08-30 11:11:00'),
(2120, '10511313', '105113', 'Coin-Operated Metal Lockers', NULL, 0, 0, 0, '2017-08-30 11:11:19', '2017-08-30 11:11:19'),
(2121, '105116', '105100', 'Wood Lockers', NULL, 0, 0, 0, '2017-08-30 11:11:38', '2017-08-30 11:11:38'),
(2122, '105123', '105100', 'Plastic-Laminate-Clad Lockers', NULL, 0, 0, 0, '2017-08-30 11:11:55', '2017-08-30 11:13:20'),
(2123, '105126', '105100', 'Plastic Lockers', NULL, 0, 0, 0, '2017-08-30 11:12:09', '2017-08-30 11:12:09'),
(2124, '10512613', '105126', 'Recycled Plastic Lockers', NULL, 0, 0, 0, '2017-08-30 11:12:25', '2017-08-30 11:12:25'),
(2125, '105129', '105100', 'Phenolic Lockers', NULL, 0, 0, 0, '2017-08-30 11:12:42', '2017-08-30 11:12:42'),
(2126, '105133', '105100', 'Glass Lockers', NULL, 0, 0, 0, '2017-08-30 11:13:44', '2017-08-30 11:13:44'),
(2127, '105143', '105100', 'Wire Mesh Storage Lockers', NULL, 0, 0, 0, '2017-08-30 11:14:04', '2017-08-30 11:14:04'),
(2128, '105153', '105100', 'Locker Room Benches', NULL, 0, 0, 0, '2017-08-30 11:14:19', '2017-08-30 11:14:19'),
(2129, '105500', '105000', 'Locker Room Benches', NULL, 0, 0, 0, '2017-08-30 11:17:29', '2017-08-30 11:17:29'),
(2130, '105513', '105500', 'Central Mail Delivery Boxes', NULL, 0, 0, 0, '2017-08-30 11:18:10', '2017-08-30 11:18:10'),
(2131, '10551313', '105513', 'Cluster Box Units', NULL, 0, 0, 0, '2017-08-30 11:18:28', '2017-08-30 11:18:28'),
(2132, '105516', '105500', 'Mail Collection Boxes', NULL, 0, 0, 0, '2017-08-30 11:18:47', '2017-08-30 11:18:47'),
(2133, '105519', '105500', 'Receiving Boxes', NULL, 0, 0, 0, '2017-08-30 11:21:53', '2017-08-30 11:21:53'),
(2134, '105523', '105500', 'Mail Boxes', NULL, 0, 0, 0, '2017-08-30 11:22:07', '2017-08-30 11:22:07'),
(2135, '10552313', '105523', 'Apartment Mail Boxes', NULL, 0, 0, 0, '2017-08-30 11:22:34', '2017-08-30 11:22:34'),
(2136, '10552316', '105523', 'Mail Box Directories', NULL, 0, 0, 0, '2017-08-30 11:22:51', '2017-08-30 11:22:51'),
(2137, '10552319', '105523', 'Mail Box Key Keepers', NULL, 0, 0, 0, '2017-08-30 11:23:21', '2017-08-30 11:23:21'),
(2138, '105526', '105500', 'Parcel Lockers', NULL, 0, 0, 0, '2017-08-30 11:23:38', '2017-08-30 11:23:38'),
(2139, '105533', '105500', 'Data Distribution Boxes', NULL, 0, 0, 0, '2017-08-30 11:23:56', '2017-08-30 11:23:56'),
(2140, '105536', '105500', 'Package Depositories', NULL, 0, 0, 0, '2017-08-30 11:24:13', '2017-08-30 11:24:13'),
(2141, '105591', '105500', 'Mail Chutes', NULL, 0, 0, 0, '2017-08-30 11:24:27', '2017-08-30 11:24:27'),
(2142, '105600', '105000', 'Storage Assemblies', NULL, 0, 0, 0, '2017-08-30 11:24:46', '2017-08-30 11:24:46'),
(2143, '105613', '105600', 'Metal Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:25:02', '2017-08-30 11:25:02'),
(2144, '10561313', '105613', 'End-Panel-Support Metal Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:25:18', '2017-08-30 11:25:18'),
(2145, '10561316', '105613', 'Post-and-Shelf Metal Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:25:40', '2017-08-30 11:25:40'),
(2146, '10561319', '105613', 'Post-and-Beam Metal Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:25:55', '2017-08-30 11:25:55'),
(2147, '10561323', '105613', 'Cantilever Metal Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:26:11', '2017-08-30 11:26:11'),
(2148, '105616', '105600', 'Fabricated Wood Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:26:29', '2017-08-30 11:26:29'),
(2149, '105617', '105600', 'Wall-Mounted Standards and Shelving', NULL, 0, 0, 0, '2017-08-30 11:26:44', '2017-08-30 11:26:44'),
(2150, '105619', '105600', 'Plastic Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:27:20', '2017-08-30 11:27:20'),
(2151, '10561913', '105619', 'Recycled Plastic Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:27:45', '2017-08-30 11:27:45'),
(2152, '105623', '105600', 'Wire Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:28:17', '2017-08-30 11:28:17'),
(2153, '105626', '105600', 'Mobile Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:28:36', '2017-08-30 11:28:36'),
(2154, '10562613', '105626', 'Manual Mobile Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:28:56', '2017-08-30 11:28:56'),
(2155, '10562623', '105626', 'Motorized Mobile Storage Shelving', NULL, 0, 0, 0, '2017-08-30 11:29:12', '2017-08-30 11:29:12'),
(2156, '105629', '105600', 'Storage Racks', NULL, 0, 0, 0, '2017-08-30 11:29:30', '2017-08-30 11:29:30'),
(2157, '10562913', '105629', 'Flow Storage Racks', NULL, 0, 0, 0, '2017-08-30 11:29:52', '2017-08-30 11:29:52'),
(2158, '10562916', '105629', 'Pallet Storage Racks', NULL, 0, 0, 0, '2017-08-30 11:30:32', '2017-08-30 11:30:32'),
(2159, '10562919', '105629', 'Movable-Shelf Storage Racks', NULL, 0, 0, 0, '2017-08-30 11:30:51', '2017-08-30 11:30:51'),
(2160, '10562923', '105629', 'Stacker Storage Racks', NULL, 0, 0, 0, '2017-08-30 11:31:09', '2017-08-30 11:31:09'),
(2161, '10562926', '105629', 'Cantilever Storage Racks', NULL, 0, 0, 0, '2017-08-30 11:31:32', '2017-08-30 11:31:32'),
(2162, '10562929', '105629', 'Drive-In Storage Racks', NULL, 0, 0, 0, '2017-08-30 11:31:46', '2017-08-30 11:31:46'),
(2163, '10562933', '105629', 'Drive-Through Storage Racks', NULL, 0, 0, 0, '2017-08-30 11:32:01', '2017-08-30 11:32:01'),
(2164, '10562943', '105629', 'Wine Storage Racks', NULL, 0, 0, 0, '2017-08-30 11:32:20', '2017-08-30 11:32:20'),
(2165, '105633', '105600', 'Mercantile Storage Assemblies', NULL, 0, 0, 0, '2017-08-30 11:32:38', '2017-08-30 11:32:38'),
(2166, '105700', '105000', 'Wardrobe and Closet Specialties', NULL, 0, 0, 0, '2017-08-30 11:33:04', '2017-08-30 11:33:04'),
(2167, '105713', '105700', 'Hat and Coat Racks', NULL, 0, 0, 0, '2017-08-30 11:33:21', '2017-08-30 11:33:21'),
(2168, '105716', '105700', 'Boot Racks', NULL, 0, 0, 0, '2017-08-30 11:33:37', '2017-08-30 11:33:37'),
(2169, '105723', '105700', 'Closet and Utility Shelving', NULL, 0, 0, 0, '2017-08-30 11:33:54', '2017-08-30 11:33:54'),
(2170, '10572313', '105723', 'Wire Closet and Utility Shelving', NULL, 0, 0, 0, '2017-08-30 11:34:11', '2017-08-30 11:34:11'),
(2171, '10572316', '105723', 'Plastic-Laminate-Clad Closet and Utility Shelving', NULL, 0, 0, 0, '2017-08-30 11:34:30', '2017-08-30 11:34:30'),
(2172, '10572319', '105723', 'Wood Closet and Utility Shelving', NULL, 0, 0, 0, '2017-08-30 11:34:48', '2017-08-30 11:34:48'),
(2173, '105733', '105700', 'Closet and Utility Shelving Hardware', NULL, 0, 0, 0, '2017-08-30 11:35:04', '2017-08-30 11:35:04'),
(2174, '105736', '105700', 'Closet Doors', NULL, 0, 0, 0, '2017-08-30 11:35:16', '2017-08-30 11:35:16'),
(2175, '10573613', '105736', 'Sliding Closet Doors', NULL, 0, 0, 0, '2017-08-30 11:35:32', '2017-08-30 11:35:32'),
(2176, '10573616', '105736', 'Bifold Closet Doors', NULL, 0, 0, 0, '2017-08-30 11:35:51', '2017-08-30 11:35:51'),
(2177, '107000', '100000', 'Exterior Specialties', NULL, 0, 0, 0, '2017-08-30 11:36:50', '2017-09-11 10:06:55'),
(2178, '107100', '107000', 'Exterior Protection', NULL, 0, 0, 0, '2017-08-30 11:37:08', '2017-08-30 11:37:08'),
(2179, '107113', '107100', 'Exterior Sun Control Devices', NULL, 0, 0, 0, '2017-08-30 11:37:23', '2017-08-30 11:37:23'),
(2180, '10711313', '107113', 'Exterior Shutters', NULL, 0, 0, 0, '2017-08-30 11:37:38', '2017-08-30 11:37:38'),
(2181, '10711319', '107113', 'Rolling Exterior Shutters', NULL, 0, 0, 0, '2017-08-30 11:37:53', '2017-08-30 11:37:53'),
(2182, '10711323', '107113', 'Coiling Exterior Shutters', NULL, 0, 0, 0, '2017-08-30 11:38:10', '2017-08-30 11:38:10'),
(2183, '10711326', '107113', 'Decorative Exterior Shutters', NULL, 0, 0, 0, '2017-08-30 11:38:35', '2017-08-30 11:38:35'),
(2184, '10711329', '107113', 'Side-Hinged Exterior Shutters', NULL, 0, 0, 0, '2017-08-30 11:38:52', '2017-08-30 11:38:52'),
(2185, '10711353', '107113', 'Exterior Daylighting Devices', NULL, 0, 0, 0, '2017-08-30 11:39:07', '2017-08-30 11:39:24'),
(2186, '10711343', '107113', 'Fixed Sun Screens', NULL, 0, 0, 0, '2017-08-30 11:39:41', '2017-08-30 11:39:41'),
(2187, '107116', '107100', 'Storm Panels', NULL, 0, 0, 0, '2017-08-30 11:40:05', '2017-08-30 11:40:05'),
(2188, '10711613', '107116', 'Demountable Storm Panels', NULL, 0, 0, 0, '2017-08-30 11:40:21', '2017-08-30 11:40:21'),
(2189, '10711616', '107116', 'Movable Storm Panels', NULL, 0, 0, 0, '2017-08-30 11:40:37', '2017-08-30 11:40:37'),
(2190, '107119', '107100', 'Flood Barriers', NULL, 0, 0, 0, '2017-08-30 11:41:00', '2017-08-30 11:41:00'),
(2191, '10711916', '107119', 'Removable Flood Barriers', NULL, 0, 0, 0, '2017-08-30 13:53:44', '2017-08-30 13:53:44'),
(2192, '107300', '107000', 'Protective Covers', NULL, 0, 0, 0, '2017-08-30 13:54:20', '2017-08-30 13:54:20'),
(2193, '107313', '107300', 'Awnings', NULL, 0, 0, 0, '2017-08-30 13:54:39', '2017-08-30 13:54:39'),
(2194, '10731313', '107313', 'Metal Awnings', NULL, 0, 0, 0, '2017-08-30 13:55:43', '2017-08-30 13:55:43'),
(2195, '10731323', '107313', 'Fabric Awnings', NULL, 0, 0, 0, '2017-08-30 13:55:59', '2017-08-30 13:55:59'),
(2196, '10731336', '107313', 'Point Supported Glass Awnings', NULL, 0, 0, 0, '2017-08-30 13:56:15', '2017-08-30 13:56:15'),
(2197, '107316', '107300', 'Canopies', NULL, 0, 0, 0, '2017-08-30 13:57:23', '2017-08-30 13:57:23'),
(2198, '10731613', '107316', 'Metal Canopies', NULL, 0, 0, 0, '2017-08-30 13:59:28', '2017-08-30 13:59:28'),
(2199, '10731623', '107316', 'Fabric Canopies', NULL, 0, 0, 0, '2017-08-30 14:00:05', '2017-08-30 14:00:05'),
(2200, '10731633', '107316', 'Glazed Canopies', NULL, 0, 0, 0, '2017-08-30 14:00:26', '2017-08-30 14:00:26'),
(2201, '10731636', '107316', 'Point Supported Glass Canopie', NULL, 0, 0, 0, '2017-08-30 14:01:06', '2017-08-30 14:01:06'),
(2202, '107323', '107300', 'Car Shelters', NULL, 0, 0, 0, '2017-08-30 14:01:38', '2017-08-30 14:01:38'),
(2203, '107326', '107300', 'Walkway Coverings', NULL, 0, 0, 0, '2017-08-30 14:01:56', '2017-08-30 14:01:56'),
(2204, '10732613', '107326', 'Metal Walkway Coverings', NULL, 0, 0, 0, '2017-08-30 14:02:18', '2017-08-30 14:02:18'),
(2205, '10732623', '107326', 'Fabric Walkway Coverings', NULL, 0, 0, 0, '2017-08-30 14:02:36', '2017-08-30 14:02:36'),
(2206, '10732633', '107326', 'Glazed Walkway Coverings', NULL, 0, 0, 0, '2017-08-30 14:02:52', '2017-08-30 14:02:52'),
(2207, '10732636', '107326', 'Point Supported Glass Walkway Coverings', NULL, 0, 0, 0, '2017-08-30 14:03:13', '2017-08-30 14:03:13'),
(2208, '107333', '107300', 'Marquees', NULL, 0, 0, 0, '2017-08-30 14:03:56', '2017-08-30 14:03:56'),
(2209, '107343', '107300', 'Transportation Stop Shelters', NULL, 0, 0, 0, '2017-08-30 14:04:48', '2017-08-30 14:04:48');
INSERT INTO `wbs` (`id`, `code`, `parent_code`, `name`, `description`, `extension`, `status`, `quantify`, `created_at`, `updated_at`) VALUES
(2210, '107400', '107000', 'Manufactured E xterior Specialties', NULL, 0, 0, 0, '2017-08-30 14:05:11', '2017-08-30 14:05:11'),
(2211, '107413', '107400', 'Exterior Clocks', NULL, 0, 0, 0, '2017-08-30 14:05:28', '2017-08-30 14:05:28'),
(2212, '107423', '107400', 'Cupolas', NULL, 0, 0, 0, '2017-08-30 14:05:43', '2017-08-30 14:05:43'),
(2213, '107426', '107400', 'Spires', NULL, 0, 0, 0, '2017-08-30 14:05:59', '2017-08-30 14:05:59'),
(2214, '107429', '107400', 'Steeples', NULL, 0, 0, 0, '2017-08-30 14:06:12', '2017-08-30 14:06:12'),
(2215, '107433', '107400', 'Weathervanes', NULL, 0, 0, 0, '2017-08-30 14:06:25', '2017-08-30 14:06:25'),
(2216, '107443', '107400', 'Below-Grade Egress Assemblies', NULL, 0, 0, 0, '2017-08-30 14:06:41', '2017-08-30 14:06:41'),
(2217, '107446', '107400', 'Window Wells', NULL, 0, 0, 0, '2017-08-30 14:06:56', '2017-08-30 14:06:56'),
(2218, '107500', '107000', 'Flagpoles', NULL, 0, 0, 0, '2017-08-30 14:07:18', '2017-08-30 14:07:18'),
(2219, '107513', '107500', 'Automatic Flagpoles', NULL, 0, 0, 0, '2017-08-30 14:07:36', '2017-08-30 14:07:36'),
(2220, '107516', '107500', 'Ground-Set Flagpoles', NULL, 0, 0, 0, '2017-08-30 14:07:52', '2017-08-30 14:07:52'),
(2221, '107519', '107500', 'Nautical Flagpoles', NULL, 0, 0, 0, '2017-08-30 14:08:06', '2017-08-30 14:08:06'),
(2222, '107523', '107500', 'Wall-Mounted Flagpoles', NULL, 0, 0, 0, '2017-08-30 14:08:23', '2017-08-30 14:08:23'),
(2223, '107526', '107500', 'Roof-Mounted Flagpoles', NULL, 0, 0, 0, '2017-08-30 14:08:39', '2017-08-30 14:08:39'),
(2224, '107529', '107500', 'Plaza-Mounted Flagpoles', NULL, 0, 0, 0, '2017-08-30 14:08:58', '2017-08-30 14:08:58'),
(2225, '108000', '100000', 'Other Specialties', NULL, 0, 0, 0, '2017-08-30 14:10:03', '2017-09-11 10:06:55'),
(2226, '108100', '108000', 'Pest Control Devices', NULL, 0, 0, 0, '2017-08-30 14:10:42', '2017-08-30 14:10:42'),
(2227, '108113', '108100', 'Bird Control Devices', NULL, 0, 0, 0, '2017-08-30 14:11:04', '2017-08-30 14:11:04'),
(2228, '108116', '108100', 'Insect Control Devices', NULL, 0, 0, 0, '2017-08-30 14:11:19', '2017-08-30 14:11:19'),
(2229, '108119', '108100', 'Rodent Control Devices', NULL, 0, 0, 0, '2017-08-30 14:11:33', '2017-08-30 14:11:33'),
(2230, '108200', '108000', 'Grilles and Screens', NULL, 0, 0, 0, '2017-08-30 14:11:56', '2017-08-30 14:11:56'),
(2231, '108213', '108200', 'Exterior Grilles and Screens', NULL, 0, 0, 0, '2017-08-30 14:12:19', '2017-08-30 14:12:19'),
(2232, '108219', '108200', 'Exterior Sound Screens', NULL, 0, 0, 0, '2017-08-30 14:12:36', '2017-08-30 14:12:36'),
(2233, '108223', '108200', 'Interior Grilles and Screens', NULL, 0, 0, 0, '2017-08-30 14:12:49', '2017-08-30 14:12:49'),
(2234, '108300', '108000', 'Flags and Banners', NULL, 0, 0, 0, '2017-08-30 14:13:05', '2017-08-30 14:13:05'),
(2235, '108313', '108300', 'Flags', NULL, 0, 0, 0, '2017-08-30 14:13:20', '2017-08-30 14:13:20'),
(2236, '108316', '108300', 'Banners', NULL, 0, 0, 0, '2017-08-30 14:13:33', '2017-08-30 14:13:33'),
(2237, '108400', '108000', 'Gas Lighting', NULL, 0, 0, 0, '2017-08-30 14:13:54', '2017-08-30 14:13:54'),
(2238, '108413', '108400', 'Exterior Gas Lighting', NULL, 0, 0, 0, '2017-08-30 14:14:08', '2017-08-30 14:14:08'),
(2239, '108416', '108400', 'Interior Gas Lighting', NULL, 0, 0, 0, '2017-08-30 14:14:23', '2017-08-30 14:14:23'),
(2240, '108600', '108000', 'Security Mirrors and Domes', NULL, 0, 0, 0, '2017-08-30 14:14:59', '2017-08-30 14:14:59'),
(2241, '108800', '108000', 'Scales', NULL, 0, 0, 0, '2017-08-30 14:15:18', '2017-08-30 14:15:18'),
(2249, '030000', '0', 'Concrete', NULL, 0, 0, 0, '2017-09-08 08:30:39', '2017-09-08 08:30:39'),
(2254, '030123', '030100', 'Maintenance of Stressing Tendons', NULL, 0, 0, 0, '2017-09-08 08:55:12', '2017-09-08 09:48:10'),
(2255, '030100', '030000', 'Maintenance of Concrete', NULL, 0, 0, 0, '2017-09-08 09:48:10', '2017-09-08 09:48:10'),
(2256, '030140', '030100', 'Maintenance of Precast Concrete', NULL, 0, 0, 0, '2017-09-08 09:48:30', '2017-09-08 09:48:30'),
(2258, '030150', '030100', 'Maintenance of Cast Decks and Underlayment', NULL, 0, 0, 0, '2017-09-08 09:54:26', '2017-09-08 09:54:26'),
(2263, '030130', '030100', 'Maintenance of Cast-in-Place Concrete', NULL, 0, 0, 0, '2017-09-08 09:55:13', '2017-09-08 09:55:13'),
(2264, '030160', '030100', 'Maintenance of Grouting', NULL, 0, 0, 0, '2017-09-08 09:55:24', '2017-09-08 09:55:24'),
(2265, '030170', '030100', 'Maintenance of Mass Concrete', NULL, 0, 0, 0, '2017-09-08 09:55:31', '2017-09-08 09:55:31'),
(2266, '030180', '030100', 'Maintenance of Concrete Cutting and Boring', NULL, 0, 0, 0, '2017-09-08 09:55:38', '2017-09-08 09:55:38'),
(2267, '030300', '030000', 'Conversation Treatment for Period Concrete', NULL, 0, 0, 0, '2017-09-08 09:55:54', '2017-09-08 09:55:54'),
(2268, '030330', '030300', 'Conservation Treatment for Period Cast-in-Place Concrete', NULL, 0, 0, 0, '2017-09-08 09:56:02', '2017-09-08 09:56:02'),
(2269, '030331', '030300', 'Conservation Treatment for Period Structural Concrete', NULL, 0, 0, 0, '2017-09-08 09:56:09', '2017-09-08 09:56:09'),
(2270, '030333', '030300', 'Conservation Treatment for Period Architectural Concrete', NULL, 0, 0, 0, '2017-09-08 09:56:15', '2017-09-08 09:56:15'),
(2271, '030500', '030000', 'Common Work Results for Concrete', NULL, 0, 0, 0, '2017-09-08 09:56:27', '2017-09-08 09:56:27'),
(2272, '030505', '030500', 'Selective Demolition for Concrete', NULL, 0, 0, 0, '2017-09-08 09:56:36', '2017-09-08 09:56:36'),
(2273, '030600', '030000', 'Schedules for Concrete', NULL, 0, 0, 0, '2017-09-08 09:56:49', '2017-09-08 09:56:49'),
(2274, '030610', '030600', 'Schedules for Concrete Forming and Accessories', NULL, 0, 0, 0, '2017-09-08 09:56:57', '2017-09-08 09:56:57'),
(2275, '030620', '030600', 'Schedules for Concrete Reinforcing', NULL, 0, 0, 0, '2017-09-08 09:57:03', '2017-09-08 09:57:03'),
(2278, '030630', '030600', 'Schedules for Cast-in-Place Concrete', NULL, 0, 0, 0, '2017-09-08 09:57:27', '2017-09-08 09:57:27'),
(2279, '020000', '0', 'Existing Conditions', NULL, 0, 0, 0, '2017-09-08 09:58:04', '2017-09-08 09:58:04'),
(2280, '020500', '020000', 'Common Work Results for Existing Conditions', NULL, 0, 0, 0, '2017-09-08 09:58:17', '2017-09-08 09:58:17'),
(2281, '021000', '020000', 'Site Remediation', NULL, 0, 0, 0, '2017-09-08 09:58:25', '2017-09-08 09:58:25'),
(2282, '022000', '020000', 'Assessment', NULL, 0, 0, 0, '2017-09-08 09:58:33', '2017-09-08 09:58:33'),
(2283, '022100', '022000', 'Surveys', NULL, 0, 0, 0, '2017-09-08 09:58:41', '2017-09-08 09:58:41'),
(2284, '023000', '020000', 'Earthwork', NULL, 0, 0, 0, '2017-09-08 09:58:50', '2017-09-08 09:58:50'),
(2285, '024000', '020000', 'Demolition and Structure Moving', NULL, 0, 0, 0, '2017-09-08 09:58:57', '2017-09-08 09:58:57'),
(2286, '024100', '024000', 'Demolition', NULL, 0, 0, 0, '2017-09-08 09:59:05', '2017-09-08 09:59:05'),
(2287, '024116', '024100', 'Structure Demolition', NULL, 0, 0, 0, '2017-09-08 09:59:12', '2017-09-08 09:59:12'),
(2288, '024500', '020000', 'Foundation and Load-Bearing Elements', NULL, 0, 0, 0, '2017-09-08 09:59:24', '2017-09-08 09:59:24'),
(2289, '025000', '020000', 'Utility Services', NULL, 0, 0, 0, '2017-09-08 09:59:34', '2017-09-08 09:59:34'),
(2290, '026000', '020000', 'Drainage and Containment', NULL, 0, 0, 0, '2017-09-08 09:59:40', '2017-09-08 09:59:40'),
(2291, '027000', '020000', 'Bases, Ballasts, Pavements and Appurtenances', NULL, 0, 0, 0, '2017-09-08 09:59:47', '2017-09-08 09:59:47'),
(2292, '028000', '020000', 'Site Improvements and Amenities', NULL, 0, 0, 0, '2017-09-08 09:59:53', '2017-09-08 09:59:53'),
(2293, '029000', '020000', 'Planting', NULL, 0, 0, 0, '2017-09-08 10:00:00', '2017-09-08 10:00:00'),
(2294, '029500', '020000', 'Site Restoration and Rehabilitation', NULL, 0, 0, 0, '2017-09-08 10:00:07', '2017-09-08 10:00:07'),
(2295, '040000', '0', 'Masonry', NULL, 0, 0, 0, '2017-09-08 10:00:20', '2017-09-08 10:00:20'),
(2296, '040100', '040000', 'Maintenance of Masonry', NULL, 0, 0, 0, '2017-09-08 10:00:33', '2017-09-08 10:00:33'),
(2297, '040120', '040100', 'Maintenance of Unit Masonry', NULL, 0, 0, 0, '2017-09-08 10:00:41', '2017-09-08 10:00:41'),
(2303, '040140', '040100', 'Maintenance of Stone Assemblies', NULL, 0, 0, 0, '2017-09-08 10:01:52', '2017-09-08 10:01:52'),
(2307, '040150', '040100', 'Maintenance of Refractory Masonry', NULL, 0, 0, 0, '2017-09-08 10:02:21', '2017-09-08 10:02:21'),
(2308, '040160', '040100', 'Maintenance of Corrosion-Resistant Masonry', NULL, 0, 0, 0, '2017-09-08 10:02:27', '2017-09-08 10:02:27'),
(2309, '040170', '040100', 'Maintenance of Manufactured Masonry', NULL, 0, 0, 0, '2017-09-08 10:02:35', '2017-09-08 10:02:35'),
(2310, '040300', '040000', 'Conservation Treatment for Period Masonry', NULL, 0, 0, 0, '2017-09-08 10:02:48', '2017-09-08 10:02:48'),
(2311, '040301', '040300', 'Maintenance for Period Masonry', NULL, 0, 0, 0, '2017-09-08 10:04:01', '2017-09-08 10:04:01'),
(2317, '030640', '030600', 'Schedules for Precast Concrete', NULL, 0, 0, 0, '2017-09-08 11:19:13', '2017-09-08 11:19:13'),
(2319, '030650', '030600', 'Schedules for Cast Decks and Underlayment', NULL, 0, 0, 0, '2017-09-08 11:19:44', '2017-09-08 11:19:44'),
(2320, '030660', '030600', 'Schedules for Grouting', NULL, 0, 0, 0, '2017-09-08 11:19:53', '2017-09-08 11:19:53'),
(2321, '030670', '030600', 'Schedules for Mass Concrete', NULL, 0, 0, 0, '2017-09-08 11:20:03', '2017-09-08 11:20:03'),
(2322, '030680', '030600', 'Schedules for Concrete Cutting and Boring', NULL, 0, 0, 0, '2017-09-08 11:20:11', '2017-09-08 11:20:11'),
(2323, '030800', '030000', 'Commissioning of Concrete', NULL, 0, 0, 0, '2017-09-10 09:46:38', '2017-09-10 09:46:38'),
(2324, '031000', '030000', 'Concrete Forms and Accessories', NULL, 0, 0, 0, '2017-09-10 09:46:47', '2017-09-10 09:46:47'),
(2325, '031100', '031000', 'Concrete Forming', NULL, 0, 0, 0, '2017-09-10 09:46:56', '2017-09-10 09:46:56'),
(2326, '031113', '031100', 'Structural Cast-in-Place Concrete Forming', NULL, 0, 0, 0, '2017-09-10 09:47:03', '2017-09-10 09:47:03'),
(2327, '031113.13', '031113', 'Concrete Slip Forming', NULL, 0, 0, 0, '2017-09-10 09:47:14', '2017-09-10 09:47:14'),
(2328, '031113.16', '031113', 'Concrete Shoring', NULL, 0, 0, 0, '2017-09-10 09:47:27', '2017-09-10 09:47:27'),
(2329, '031113.19', '031113', 'Falsework', NULL, 0, 0, 0, '2017-09-10 09:47:36', '2017-09-10 09:47:36'),
(2330, '031116', '031100', 'Architectural Cast-in Place Concrete Forming', NULL, 0, 0, 0, '2017-09-10 09:47:44', '2017-09-10 09:47:44'),
(2331, '031116.13', '031116', 'Concrete Form Liners', NULL, 0, 0, 0, '2017-09-10 09:47:55', '2017-09-10 09:47:55'),
(2332, '031119', '031100', 'Insulating Concrete Forming', NULL, 0, 0, 0, '2017-09-10 09:48:03', '2017-09-10 09:48:03'),
(2333, '031123', '031100', 'Permanent Stair Forming', NULL, 0, 0, 0, '2017-09-10 09:48:10', '2017-09-10 09:48:10'),
(2334, '031126', '031100', 'Permanent Tier Forming', NULL, 0, 0, 0, '2017-09-10 09:48:19', '2017-09-10 09:48:19'),
(2335, '031500', '031000', 'Concrete Accessories', NULL, 0, 0, 0, '2017-09-10 09:48:27', '2017-09-10 09:48:27'),
(2336, '031513', '031500', 'Waterstops', NULL, 0, 0, 0, '2017-09-10 09:48:32', '2017-09-10 09:48:32'),
(2337, '031513.13', '031513', 'Non-Expanding Waterstops', NULL, 0, 0, 0, '2017-09-10 09:48:54', '2017-09-10 09:48:54'),
(2338, '031513.16', '031513', 'Expanding Waterstops', NULL, 0, 0, 0, '2017-09-10 09:49:07', '2017-09-10 09:49:07'),
(2339, '031513.19', '031513', 'Combination Expanding and Injection Hose Waterstops', NULL, 0, 0, 0, '2017-09-10 09:49:22', '2017-09-10 09:49:22'),
(2340, '031513.21', '031513', 'Injection Hose Waterstops', NULL, 0, 0, 0, '2017-09-10 09:49:31', '2017-09-10 09:49:31'),
(2341, '031516', '031500', 'Concrete Construction Joints', NULL, 0, 0, 0, '2017-09-10 09:49:44', '2017-09-10 09:49:44'),
(2342, '031519', '031500', 'Cast-In Concrete Anchors', NULL, 0, 0, 0, '2017-09-10 09:49:50', '2017-09-10 09:49:50'),
(2343, '031521', '031500', 'Termite Barrier', NULL, 0, 0, 0, '2017-09-10 09:49:56', '2017-09-10 09:49:56'),
(2344, '040301.13', '040301', 'Period Masonry Cleaning', NULL, 0, 0, 0, '2017-09-10 09:50:50', '2017-09-10 09:50:50'),
(2345, '040305', '040300', 'Common Work Results for Period Masonry', NULL, 0, 0, 0, '2017-09-10 09:51:00', '2017-09-10 09:51:00'),
(2346, '040305.13', '040305', 'Period Masonry Mortaring', NULL, 0, 0, 0, '2017-09-10 09:51:09', '2017-09-10 09:51:09'),
(2347, '040305.16', '040305', 'Period Masonry Grouting', NULL, 0, 0, 0, '2017-09-10 09:51:18', '2017-09-10 09:51:18'),
(2348, '040305.19', '040305', 'Period Masonry Anchorage and Reinforcing', NULL, 0, 0, 0, '2017-09-10 09:51:26', '2017-09-10 09:51:26'),
(2349, '040322', '040300', 'Conservation Treatment for Period Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 09:51:41', '2017-09-10 09:51:41'),
(2350, '040321', '040300', 'Conservation Treatment for Period Clay Unit Masonry', NULL, 0, 0, 0, '2017-09-10 09:51:56', '2017-09-10 09:51:56'),
(2351, '040321.19', '040321', 'Clay Brick Conservation Treatment', NULL, 0, 0, 0, '2017-09-10 09:52:07', '2017-09-10 09:52:07'),
(2352, '040321.21', '040321', 'Terra Cotta Conservation Treatment', NULL, 0, 0, 0, '2017-09-10 09:52:16', '2017-09-10 09:52:16'),
(2353, '040321.23', '040321', 'Fiance Block Conservation Treatment', NULL, 0, 0, 0, '2017-09-10 09:52:23', '2017-09-10 09:52:23'),
(2354, '040324', '040300', 'Conservation Treatment for Period Adobe Unit Masonry', NULL, 0, 0, 0, '2017-09-10 09:52:40', '2017-09-10 09:52:40'),
(2355, '040343', '040300', 'Conservation Treatment for Period Stone Masonry', NULL, 0, 0, 0, '2017-09-10 09:52:51', '2017-09-10 09:52:51'),
(2356, '040500', '040000', 'Common Work Results for Masonry', NULL, 0, 0, 0, '2017-09-10 09:53:19', '2017-09-10 09:53:19'),
(2357, '040505', '040500', 'Selective Demolition for Masonry', NULL, 0, 0, 0, '2017-09-10 09:53:24', '2017-09-10 09:53:24'),
(2358, '040513', '040500', 'Masonry Mortaring', NULL, 0, 0, 0, '2017-09-10 09:53:31', '2017-09-10 09:53:31'),
(2359, '040513.16', '040513', 'Chemical-Resistant Masonry Mortaring', NULL, 0, 0, 0, '2017-09-10 09:55:37', '2017-09-10 09:55:37'),
(2360, '040513.19', '040513', 'Epoxy Masonry Mortaring', NULL, 0, 0, 0, '2017-09-10 09:55:46', '2017-09-10 09:55:46'),
(2361, '040513.23', '040513', 'Surface Bonding Masonry Mortaring', NULL, 0, 0, 0, '2017-09-10 09:55:57', '2017-09-10 09:55:57'),
(2362, '040513.26', '040513', 'Engineered Masonry Mortaring', NULL, 0, 0, 0, '2017-09-10 09:56:07', '2017-09-10 09:56:07'),
(2363, '040513.29', '040513', 'Refractory Masonry Mortaring', NULL, 0, 0, 0, '2017-09-10 09:56:15', '2017-09-10 09:56:15'),
(2364, '040513.91', '040513', 'Masonry Restoration Mortaring', NULL, 0, 0, 0, '2017-09-10 09:56:23', '2017-09-10 09:56:23'),
(2365, '040516', '040500', 'Masonry Grouting', NULL, 0, 0, 0, '2017-09-10 09:59:15', '2017-09-10 09:59:15'),
(2366, '040516.16', '040516', 'Chemical-Resistant Masonry Grouting', NULL, 0, 0, 0, '2017-09-10 09:59:25', '2017-09-10 09:59:25'),
(2367, '040516.26', '040516', 'Engineered Masonry Grouting', NULL, 0, 0, 0, '2017-09-10 09:59:36', '2017-09-10 09:59:36'),
(2368, '040519', '040500', 'Masonry Anchorage and Reinforcing', NULL, 0, 0, 0, '2017-09-10 10:00:08', '2017-09-10 10:00:08'),
(2369, '040519.13', '040519', 'Continuous Joint Reinforcing', NULL, 0, 0, 0, '2017-09-10 10:00:16', '2017-09-10 10:00:16'),
(2370, '040519.16', '040519', 'Masonry Anchors', NULL, 0, 0, 0, '2017-09-10 10:00:28', '2017-09-10 10:00:28'),
(2371, '040519.26', '040519', 'Masonry Reinforcing Bars', NULL, 0, 0, 0, '2017-09-10 10:00:36', '2017-09-10 10:00:36'),
(2372, '040519.29', '040519', 'Stone Anchors', NULL, 0, 0, 0, '2017-09-10 10:00:48', '2017-09-10 10:00:48'),
(2373, '040521', '040500', 'Masonry Strengthening', NULL, 0, 0, 0, '2017-09-10 10:01:02', '2017-09-10 10:01:02'),
(2374, '040523', '040500', 'Masonry Accessories', NULL, 0, 0, 0, '2017-09-10 10:01:08', '2017-09-10 10:01:08'),
(2375, '040523.13', '040523', 'Masonry Control and Expansion Joints', NULL, 0, 0, 0, '2017-09-10 10:01:21', '2017-09-10 10:01:21'),
(2376, '040523.16', '040523', 'Masonry Embedded Flashing', NULL, 0, 0, 0, '2017-09-10 10:01:29', '2017-09-10 10:01:29'),
(2377, '040523.19', '040523', 'Masonry Cavity Drainage, Weepholes, and Vents', NULL, 0, 0, 0, '2017-09-10 10:01:38', '2017-09-10 10:01:38'),
(2378, '040600', '040000', 'Schedules for Masonry', NULL, 0, 0, 0, '2017-09-10 10:02:43', '2017-09-10 10:02:43'),
(2379, '040620', '040600', 'Schedules for Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:02:50', '2017-09-10 10:02:50'),
(2381, '040620.13', '040620', 'Masonry Unit Schedule', NULL, 0, 0, 0, '2017-09-10 10:03:03', '2017-09-10 10:03:03'),
(2382, '040640', '040600', 'Schedules for Stone Assemblies', NULL, 0, 0, 0, '2017-09-10 10:03:10', '2017-09-10 10:03:10'),
(2383, '040650', '040600', 'Schedules for Refractory Masonry', NULL, 0, 0, 0, '2017-09-10 10:03:20', '2017-09-10 10:03:20'),
(2384, '040660', '040600', 'Schedules for Corrosion-Resistant Masonry', NULL, 0, 0, 0, '2017-09-10 10:03:28', '2017-09-10 10:03:28'),
(2385, '040670', '040600', 'Schedules for Manufactured Masonry', NULL, 0, 0, 0, '2017-09-10 10:03:34', '2017-09-10 10:03:34'),
(2386, '040800', '040000', 'Commissioning of Masonry', NULL, 0, 0, 0, '2017-09-10 10:03:42', '2017-09-10 10:03:42'),
(2387, '042000', '040000', 'Masonry Units', NULL, 0, 0, 0, '2017-09-10 10:03:59', '2017-09-10 10:03:59'),
(2388, '042100', '042000', 'Clay Masonry Unit', NULL, 0, 0, 0, '2017-09-10 10:04:05', '2017-09-10 10:04:05'),
(2389, '042113', '042100', 'Brick Masonry', NULL, 0, 0, 0, '2017-09-10 10:04:10', '2017-09-10 10:04:10'),
(2390, '042113.13', '042113', 'Brick Veneer Masonry', NULL, 0, 0, 0, '2017-09-10 10:04:18', '2017-09-10 10:04:18'),
(2391, '042113.23', '042113', 'Surface-Bonded Brick Masonry', NULL, 0, 0, 0, '2017-09-10 10:04:26', '2017-09-10 10:04:26'),
(2392, '042116', '042100', 'Ceramic Glazed Clay Masonry', NULL, 0, 0, 0, '2017-09-10 10:04:32', '2017-09-10 10:04:32'),
(2393, '042119', '042100', 'Clay Tile Masonry', NULL, 0, 0, 0, '2017-09-10 10:04:38', '2017-09-10 10:04:38'),
(2394, '042123', '042100', 'Structural Clay Tile Masonry', NULL, 0, 0, 0, '2017-09-10 10:04:45', '2017-09-10 10:04:45'),
(2395, '042126', '042100', 'Glazed Structural Clay Tile Masonry', NULL, 0, 0, 0, '2017-09-10 10:04:51', '2017-09-10 10:04:51'),
(2396, '042129', '042100', 'Terra Cotta Masonry', NULL, 0, 0, 0, '2017-09-10 10:04:56', '2017-09-10 10:04:56'),
(2397, '042200', '042000', 'Concrete Masonry Unit', NULL, 0, 0, 0, '2017-09-10 10:05:04', '2017-09-10 10:05:04'),
(2398, '042200.13', '042200', 'Concrete Unit Veneer Masonry', NULL, 0, 0, 0, '2017-09-10 10:05:12', '2017-09-10 10:05:12'),
(2399, '042200.16', '042200', 'Surface-Bonded Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:05:20', '2017-09-10 10:05:20'),
(2401, '042200.19', '042200', 'Insulated Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:05:44', '2017-09-10 10:05:44'),
(2402, '042223', '042200', 'Architectural Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:06:53', '2017-09-10 10:06:53'),
(2403, '042223.13', '042223', 'Exposed Aggregate Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:07:19', '2017-09-10 10:07:19'),
(2405, '042223.16', '042223', 'Fluted Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:08:00', '2017-09-10 10:08:00'),
(2406, '042223.19', '042223', 'Molded-Face Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:08:13', '2017-09-10 10:08:13'),
(2407, '042223.23', '042223', 'Prefaced Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:08:41', '2017-09-10 10:08:41'),
(2408, '042223.26', '042223', 'Sound-Absorbing Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:08:55', '2017-09-10 10:08:55'),
(2409, '042223.29', '042223', 'Split-Face Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:09:03', '2017-09-10 10:09:03'),
(2410, '042226', '042200', 'Autoclaved Aerated Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:09:13', '2017-09-10 10:09:13'),
(2411, '042233', '042200', 'Interlocking Concrete Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:09:20', '2017-09-10 10:09:20'),
(2412, '042300', '042000', 'Glass Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:10:15', '2017-09-10 10:10:15'),
(2413, '042313', '042300', 'Vertical Glass Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:10:20', '2017-09-10 10:10:20'),
(2414, '042316', '042300', 'Glass Unit Masonry Floors', NULL, 0, 0, 0, '2017-09-10 10:10:25', '2017-09-10 10:10:25'),
(2415, '042319', '042300', 'Glass Unit Masonry Skylights', NULL, 0, 0, 0, '2017-09-10 10:10:30', '2017-09-10 10:10:30'),
(2416, '042400', '042000', 'Glazed Concrete Masonry Units', NULL, 0, 0, 0, '2017-09-10 10:10:38', '2017-09-10 10:10:38'),
(2417, '042413', '042400', 'Site-Cast Adobe Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:10:44', '2017-09-10 10:10:44'),
(2418, '042416', '042400', 'Manufactured Adobe Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:10:49', '2017-09-10 10:10:49'),
(2419, '042500', '042000', 'Unit Masonry Panels', NULL, 0, 0, 0, '2017-09-10 10:11:02', '2017-09-10 10:11:02'),
(2420, '042513', '042500', 'Metal-Supported Unit Masonry Panels', NULL, 0, 0, 0, '2017-09-10 10:11:07', '2017-09-10 10:11:07'),
(2421, '042600', '042000', 'Single-Wythe Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:11:14', '2017-09-10 10:11:14'),
(2422, '042613', '042600', 'Masonry Veneer', NULL, 0, 0, 0, '2017-09-10 10:11:20', '2017-09-10 10:11:20'),
(2423, '042700', '042000', 'Multiple-Wythe Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:11:29', '2017-09-10 10:11:29'),
(2424, '042713', '042700', 'Composite Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:11:35', '2017-09-10 10:11:35'),
(2425, '042723', '042700', 'Cavity Wall Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:11:40', '2017-09-10 10:11:40'),
(2426, '042800', '042000', 'Concrete Form Masonry Units', NULL, 0, 0, 0, '2017-09-10 10:11:46', '2017-09-10 10:11:46'),
(2427, '042813', '042800', 'Dry-Stacked, Concrete-Filled Masonry Units', NULL, 0, 0, 0, '2017-09-10 10:11:53', '2017-09-10 10:11:53'),
(2428, '042823', '042800', 'Mortar-Set, Concrete-Filled Masonry Units', NULL, 0, 0, 0, '2017-09-10 10:11:58', '2017-09-10 10:11:58'),
(2429, '042900', '042000', 'Engineered Unit Masonry', NULL, 0, 0, 0, '2017-09-10 10:12:03', '2017-09-10 10:12:03'),
(2430, '044000', '040000', 'Stone', NULL, 0, 0, 0, '2017-09-10 10:12:09', '2017-09-10 10:12:09'),
(2431, '044100', '044000', 'Dry-Placed Stone', NULL, 0, 0, 0, '2017-09-10 10:12:16', '2017-09-10 10:12:16'),
(2432, '044200', '044000', 'Exterior Stone Cladding', NULL, 0, 0, 0, '2017-09-10 10:12:21', '2017-09-10 10:12:21'),
(2433, '044213', '044200', 'Masonry-Supported Stone Cladding', NULL, 0, 0, 0, '2017-09-10 10:12:28', '2017-09-10 10:12:28'),
(2434, '044216', '044200', 'Steel-Stud-Supported Stone Cladding', NULL, 0, 0, 0, '2017-09-10 10:12:37', '2017-09-10 10:12:37'),
(2435, '044219', '044200', 'Strongback-Frame-Supported Stone Cladding', NULL, 0, 0, 0, '2017-09-10 10:12:42', '2017-09-10 10:12:42'),
(2436, '044223', '044200', 'Truss-Supported Stone Cladding', NULL, 0, 0, 0, '2017-09-10 10:12:49', '2017-09-10 10:12:49'),
(2437, '044226', '044200', 'Grid-System-Supported Stone Cladding', NULL, 0, 0, 0, '2017-09-10 10:12:55', '2017-09-10 10:12:55'),
(2438, '044243', '044200', 'Stone Panels for Curtain Walls', NULL, 0, 0, 0, '2017-09-10 10:13:00', '2017-09-10 10:13:00'),
(2439, '044300', '044000', 'Stone Masonry', NULL, 0, 0, 0, '2017-09-10 10:13:55', '2017-09-10 10:13:55'),
(2440, '044313', '044300', 'Stone Masonry Veneer', NULL, 0, 0, 0, '2017-09-10 10:13:59', '2017-09-10 10:13:59'),
(2441, '044313.13', '044313', 'Anchored Stone Masonry Veneer', NULL, 0, 0, 0, '2017-09-10 10:14:07', '2017-09-10 10:14:07'),
(2442, '044313.16', '044313', 'Adhered Stone Masonry Veneer', NULL, 0, 0, 0, '2017-09-10 10:14:15', '2017-09-10 10:14:15'),
(2443, '044316', '044300', 'Stone Fabrications', NULL, 0, 0, 0, '2017-09-10 10:14:21', '2017-09-10 10:14:21'),
(2444, '045000', '040000', 'Refractories', NULL, 0, 0, 0, '2017-09-10 10:14:32', '2017-09-10 10:14:32'),
(2445, '045100', '045000', 'Flue Liner Masonry', NULL, 0, 0, 0, '2017-09-10 10:14:39', '2017-09-10 10:14:39'),
(2446, '045200', '045000', 'Combustion Chamber Masonry', NULL, 0, 0, 0, '2017-09-10 10:14:45', '2017-09-10 10:14:45'),
(2447, '045300', '045000', 'Castable Refractory Masonry', NULL, 0, 0, 0, '2017-09-10 10:14:51', '2017-09-10 10:14:51'),
(2448, '045400', '045000', 'Refractory Brick Masonry', NULL, 0, 0, 0, '2017-09-10 10:14:56', '2017-09-10 10:14:56'),
(2449, '045700', '045000', 'Masonry Fireplaces', NULL, 0, 0, 0, '2017-09-10 10:15:01', '2017-09-10 10:15:01'),
(2450, '045733', '045700', 'Modular Masonry Fireplaces', NULL, 0, 0, 0, '2017-09-10 10:15:06', '2017-09-10 10:15:06'),
(2451, '046000', '040000', 'Corrosion-Resistant Masonry', NULL, 0, 0, 0, '2017-09-10 10:15:14', '2017-09-10 10:15:14'),
(2452, '046100', '046000', 'Chemical-Resistant Brick Masonry', NULL, 0, 0, 0, '2017-09-10 10:15:19', '2017-09-10 10:15:19'),
(2453, '046200', '046000', 'Vitrified Clay Liner Plate', NULL, 0, 0, 0, '2017-09-10 10:15:24', '2017-09-10 10:15:24'),
(2454, '047000', '040000', 'Simulated Masonry', NULL, 0, 0, 0, '2017-09-10 10:17:05', '2017-09-10 10:17:05'),
(2455, '047100', '047000', 'Manufactured Brick Masonry', NULL, 0, 0, 0, '2017-09-10 10:17:12', '2017-09-10 10:17:12'),
(2456, '047113', '047100', 'Calcium Silicate Manufactured Brick Masonry', NULL, 0, 0, 0, '2017-09-10 10:17:19', '2017-09-10 10:17:19'),
(2457, '047200', '047000', 'Cast Stone Masonry', NULL, 0, 0, 0, '2017-09-10 10:17:24', '2017-09-10 10:17:24'),
(2458, '047300', '047000', 'Manufactured Stone Masonry', NULL, 0, 0, 0, '2017-09-10 10:17:29', '2017-09-10 10:17:29'),
(2459, '047313', '047300', 'Calcium Silicate Manufactured Stone Masonry', NULL, 0, 0, 0, '2017-09-10 10:17:33', '2017-09-10 10:17:33'),
(2460, '050000', '0', 'Metals', NULL, 0, 0, 0, '2017-09-10 10:19:31', '2017-09-10 10:19:31'),
(2461, '050100', '050000', 'Maintenance of Metals', NULL, 0, 0, 0, '2017-09-10 10:19:37', '2017-09-10 10:19:37'),
(2462, '050110', '050100', 'Maintenance of Structural Metal Framing', NULL, 0, 0, 0, '2017-09-10 10:19:44', '2017-09-10 10:19:44'),
(2463, '050120', '050100', 'Maintenance of Metal Joists', NULL, 0, 0, 0, '2017-09-10 10:19:51', '2017-09-10 10:19:51'),
(2464, '050130', '050100', 'Maintenance of Metal Decking', NULL, 0, 0, 0, '2017-09-10 10:19:57', '2017-09-10 10:19:57'),
(2465, '050140', '050100', 'Maintenance of Cold-Formed Metal Framing', NULL, 0, 0, 0, '2017-09-10 10:20:04', '2017-09-10 10:20:04'),
(2466, '050150', '050100', 'Maintenance of Metal Fabrications', NULL, 0, 0, 0, '2017-09-10 10:20:09', '2017-09-10 10:20:09'),
(2467, '050170', '050100', 'Maintenance of Decorative Metal', NULL, 0, 0, 0, '2017-09-10 10:20:15', '2017-09-10 10:20:15'),
(2468, '050170.91', '050170', 'Historic Treatment of Decorative Metal', NULL, 0, 0, 0, '2017-09-10 10:20:23', '2017-09-10 10:20:23'),
(2469, '050300', '050000', 'Conservation Treatment for Period Metals', NULL, 0, 0, 0, '2017-09-10 10:20:30', '2017-09-10 10:20:30'),
(2470, '050312', '050300', 'Conservation Treatment for Period Structural Steel', NULL, 0, 0, 0, '2017-09-10 10:20:36', '2017-09-10 10:20:36'),
(2471, '050312.12', '050312', 'Conservation Treatment for Period Structural Steel for Buildings', NULL, 0, 0, 0, '2017-09-10 10:20:46', '2017-09-10 10:20:46'),
(2472, '050312.23', '050312', 'Conservation Treatment for Period Structural Steel for Buildings', NULL, 0, 0, 0, '2017-09-10 10:20:56', '2017-09-10 10:20:56'),
(2473, '050351', '050300', 'Conservation Treatment for Period Metal Stairs', NULL, 0, 0, 0, '2017-09-10 10:21:03', '2017-09-10 10:21:03'),
(2474, '050358', '050300', 'Conservation Treatment for Period Column Covers', NULL, 0, 0, 0, '2017-09-10 10:21:10', '2017-09-10 10:21:10'),
(2475, '050370', '050300', 'Conservation Treatment for Period Decorative Metal', NULL, 0, 0, 0, '2017-09-10 10:21:16', '2017-09-10 10:21:16'),
(2476, '050371', '050300', 'Conservation Treatment for Period Decorative Metal Stairs', NULL, 0, 0, 0, '2017-09-10 10:21:23', '2017-09-10 10:21:23'),
(2477, '050373', '050300', 'Conservation Treatment for Period Decorative Metal Railings', NULL, 0, 0, 0, '2017-09-10 10:21:30', '2017-09-10 10:21:30'),
(2478, '050375', '050300', 'Conservation Treatment for Period Decorative Formed Metal', NULL, 0, 0, 0, '2017-09-10 10:21:36', '2017-09-10 10:21:36'),
(2479, '050376', '050300', 'Conservation Treatment for Period Decorative Forged Metal', NULL, 0, 0, 0, '2017-09-10 10:21:41', '2017-09-10 10:21:41'),
(2480, '050500', '050000', 'Common Work Results for Metals', NULL, 0, 0, 0, '2017-09-10 10:21:51', '2017-09-10 10:21:51'),
(2481, '050505', '050500', 'Selective Demolition for Metals', NULL, 0, 0, 0, '2017-09-10 10:21:56', '2017-09-10 10:21:56'),
(2482, '050513', '050500', 'Shop-Applied Coatings for Metal', NULL, 0, 0, 0, '2017-09-10 10:22:03', '2017-09-10 10:22:03'),
(2483, '050519', '050500', 'Post-Installed Concrete Anchors', NULL, 0, 0, 0, '2017-09-10 10:23:19', '2017-09-10 10:23:19'),
(2484, '050523', '050500', 'Metal Fastenings', NULL, 0, 0, 0, '2017-09-10 10:23:24', '2017-09-10 10:23:24'),
(2485, '050553', '050500', 'Security Metal Fastenings', NULL, 0, 0, 0, '2017-09-10 10:23:29', '2017-09-10 10:23:29'),
(2486, '050600', '050000', 'Schedules for Metals', NULL, 0, 0, 0, '2017-09-10 10:25:39', '2017-09-10 10:25:39'),
(2487, '050610', '050600', 'Schedules for Structural Metal Framing', NULL, 0, 0, 0, '2017-09-10 10:25:45', '2017-09-10 10:25:45'),
(2488, '050610.13', '050610', 'Steel Column Schedule', NULL, 0, 0, 0, '2017-09-10 10:25:54', '2017-09-10 10:25:54'),
(2489, '050610.16', '050610', 'Steel Beam Schedule', NULL, 0, 0, 0, '2017-09-10 10:26:02', '2017-09-10 10:26:02'),
(2490, '050620', '050600', 'Schedules for Metal Joists', NULL, 0, 0, 0, '2017-09-10 10:26:30', '2017-09-10 10:26:30'),
(2491, '050620.13', '050620', 'Steel Joist Schedule', NULL, 0, 0, 0, '2017-09-10 10:26:38', '2017-09-10 10:26:38'),
(2492, '050630', '050600', 'Schedules for Metal Decking', NULL, 0, 0, 0, '2017-09-10 10:27:01', '2017-09-10 10:27:01'),
(2493, '050640', '050600', 'Schedules for Cold-Formed Metal Framing', NULL, 0, 0, 0, '2017-09-10 10:27:07', '2017-09-10 10:27:07'),
(2494, '050650', '050600', 'Schedules for Metal Fabrications', NULL, 0, 0, 0, '2017-09-10 10:27:12', '2017-09-10 10:27:12'),
(2495, '050670', '050600', 'Schedules for Decorative Metal', NULL, 0, 0, 0, '2017-09-10 10:27:17', '2017-09-10 10:27:17'),
(2496, '050800', '050000', 'Commissioning of Metals', NULL, 0, 0, 0, '2017-09-10 10:27:24', '2017-09-10 10:27:24'),
(2497, '051000', '050000', 'Structural Metal Framing', NULL, 0, 0, 0, '2017-09-10 10:27:30', '2017-09-10 10:27:30'),
(2498, '051200', '051000', 'Structural Steel', NULL, 0, 0, 0, '2017-09-10 10:28:20', '2017-09-10 10:28:20'),
(2499, '051213', '051200', 'Architecturally-Exposed Structural Steel Framing', NULL, 0, 0, 0, '2017-09-10 10:28:27', '2017-09-10 10:28:27'),
(2500, '051216', '051200', 'Fabricated Fireproofed Steel Columns', NULL, 0, 0, 0, '2017-09-10 10:28:34', '2017-09-10 10:28:34'),
(2501, '051219', '051200', 'Buckling Restrained Braces', NULL, 0, 0, 0, '2017-09-10 10:28:40', '2017-09-10 10:28:40'),
(2502, '051223', '051200', 'Structural Steel for Buildings', NULL, 0, 0, 0, '2017-09-10 10:28:45', '2017-09-10 10:28:45'),
(2503, '051233', '051200', 'Structural Steel for Bridges', NULL, 0, 0, 0, '2017-09-10 10:28:49', '2017-09-10 10:28:49'),
(2504, '051300', '051000', 'Structural Stainless-Steel Framing', NULL, 0, 0, 0, '2017-09-10 10:31:16', '2017-09-10 10:31:16'),
(2505, '051400', '051000', 'Structural Aluminum', NULL, 0, 0, 0, '2017-09-10 10:31:22', '2017-09-10 10:31:22'),
(2506, '051413', '051400', 'Architecturally-Exposed Structural Aluminum Framing', NULL, 0, 0, 0, '2017-09-10 10:31:27', '2017-09-10 10:31:27'),
(2507, '051500', '051000', 'Wire Rope Assemblies', NULL, 0, 0, 0, '2017-09-10 10:31:33', '2017-09-10 10:31:33'),
(2508, '051513', '051500', 'Aluminum Wire Rope Assemblies', NULL, 0, 0, 0, '2017-09-10 10:31:39', '2017-09-10 10:31:39'),
(2509, '051516', '051500', 'Steel Wire Rope Assemblies', NULL, 0, 0, 0, '2017-09-10 10:31:43', '2017-09-10 10:31:43'),
(2510, '051519', '051500', 'Stainless-Steel Wire Rope Assemblies', NULL, 0, 0, 0, '2017-09-10 10:31:49', '2017-09-10 10:31:49'),
(2511, '051600', '051000', 'Structural Cabling', NULL, 0, 0, 0, '2017-09-10 10:32:14', '2017-09-10 10:32:14'),
(2512, '051613', '051600', 'Cable Bow Truss Assemblies', NULL, 0, 0, 0, '2017-09-10 10:32:20', '2017-09-10 10:32:20'),
(2513, '051633', '051600', 'Bridge Cabling', NULL, 0, 0, 0, '2017-09-10 10:32:26', '2017-09-10 10:32:26'),
(2514, '051700', '051000', 'Structural Rod Assemblies', NULL, 0, 0, 0, '2017-09-10 10:32:33', '2017-09-10 10:32:33'),
(2515, '051900', '051000', 'Tension Rod and Cable Truss Assemblies', NULL, 0, 0, 0, '2017-09-10 10:32:38', '2017-09-10 10:32:38'),
(2516, '051913', '051900', 'Façade Support Truss Assemblies', NULL, 0, 0, 0, '2017-09-10 10:32:45', '2017-09-10 10:32:45'),
(2517, '051919', '051900', 'Canopy Support Truss Assemblies', NULL, 0, 0, 0, '2017-09-10 10:32:50', '2017-09-10 10:32:50'),
(2518, '052000', '050000', 'Metal Joists', NULL, 0, 0, 0, '2017-09-10 10:33:01', '2017-09-10 10:33:01'),
(2519, '052100', '052000', 'Steel Joist Framing', NULL, 0, 0, 0, '2017-09-10 10:33:10', '2017-09-10 10:33:10'),
(2520, '052113', '052100', 'Deep Longspan Steel Joist Framing', NULL, 0, 0, 0, '2017-09-10 10:33:15', '2017-09-10 10:33:15'),
(2521, '052116', '052100', 'Longspan Steel Joist Framing', NULL, 0, 0, 0, '2017-09-10 10:33:21', '2017-09-10 10:33:21'),
(2522, '052119', '052100', 'Open Web Steel Joist Framing', NULL, 0, 0, 0, '2017-09-10 10:33:26', '2017-09-10 10:33:26'),
(2523, '052123', '052100', 'Steel Joist Girder Framing', NULL, 0, 0, 0, '2017-09-10 10:33:32', '2017-09-10 10:33:32'),
(2524, '052500', '052000', 'Aluminum Joist Framing', NULL, 0, 0, 0, '2017-09-10 10:33:38', '2017-09-10 10:33:38'),
(2525, '053000', '050000', 'Metal Deck', NULL, 0, 0, 0, '2017-09-10 10:33:47', '2017-09-10 10:33:47'),
(2526, '053100', '053000', 'Steel Decking', NULL, 0, 0, 0, '2017-09-10 10:33:54', '2017-09-10 10:33:54'),
(2527, '053113', '053100', 'Steel Floor Decking', NULL, 0, 0, 0, '2017-09-10 10:34:00', '2017-09-10 10:34:00'),
(2528, '053123', '053100', 'Steel Roof Decking', NULL, 0, 0, 0, '2017-09-10 10:34:06', '2017-09-10 10:34:06'),
(2529, '053133', '053100', 'Steel Form Decking', NULL, 0, 0, 0, '2017-09-10 10:34:11', '2017-09-10 10:34:11'),
(2530, '053300', '053000', 'Aluminum Deck', NULL, 0, 0, 0, '2017-09-10 10:34:17', '2017-09-10 10:34:17'),
(2531, '053313', '053300', 'Aluminum Floor Decking', NULL, 0, 0, 0, '2017-09-10 10:34:24', '2017-09-10 10:34:24'),
(2532, '053323', '053300', 'Aluminum Roof Decking', NULL, 0, 0, 0, '2017-09-10 10:34:29', '2017-09-10 10:34:29'),
(2533, '053400', '053000', 'Acoustical Metal Deck', NULL, 0, 0, 0, '2017-09-10 10:34:34', '2017-09-10 10:34:34'),
(2534, '053500', '053000', 'Raceway Decking Assemblies', NULL, 0, 0, 0, '2017-09-10 10:34:40', '2017-09-10 10:34:40'),
(2535, '053600', '053000', 'Composite Metal Decking', NULL, 0, 0, 0, '2017-09-10 10:34:46', '2017-09-10 10:34:46'),
(2536, '053613', '053600', 'Composite Steel Plate and Elastomer Decking', NULL, 0, 0, 0, '2017-09-10 10:34:55', '2017-09-10 10:34:55'),
(2537, '054000', '050000', 'Cold-Formed Metal Framing', NULL, 0, 0, 0, '2017-09-10 10:35:03', '2017-09-10 10:35:03'),
(2538, '054100', '054000', 'Structural Metal Stud Framing', NULL, 0, 0, 0, '2017-09-10 10:35:10', '2017-09-10 10:35:10'),
(2539, '054200', '054000', 'Cold-Formed Metal Joist Framing', NULL, 0, 0, 0, '2017-09-10 10:35:17', '2017-09-10 10:35:17'),
(2540, '054213', '054200', 'Cold-Formed Metal Floor Joist Framing', NULL, 0, 0, 0, '2017-09-10 10:35:23', '2017-09-10 10:35:23'),
(2541, '054223', '054200', 'Cold-Formed Metal Roof Joist Framing', NULL, 0, 0, 0, '2017-09-10 10:35:29', '2017-09-10 10:35:29'),
(2542, '054300', '054000', 'Slotted Channel Framing', NULL, 0, 0, 0, '2017-09-10 10:35:44', '2017-09-10 10:35:44'),
(2543, '054400', '054000', 'Cold-Formed Metal Trusses', NULL, 0, 0, 0, '2017-09-10 10:35:50', '2017-09-10 10:35:50'),
(2544, '054413', '054400', 'Cold-Formed Metal Roof Trusses', NULL, 0, 0, 0, '2017-09-10 10:35:55', '2017-09-10 10:35:55'),
(2545, '054500', '054000', 'Metal Support Assemblies', NULL, 0, 0, 0, '2017-09-10 10:36:03', '2017-09-10 10:36:03'),
(2546, '054513', '054500', 'Mechanical Metal Supports', NULL, 0, 0, 0, '2017-09-10 10:36:08', '2017-09-10 10:36:08'),
(2547, '054516', '054500', 'Electrical Metal Supports', NULL, 0, 0, 0, '2017-09-10 10:36:13', '2017-09-10 10:36:13'),
(2548, '054519', '054500', 'Communications Metal Supports', NULL, 0, 0, 0, '2017-09-10 10:36:17', '2017-09-10 10:36:17'),
(2549, '054523', '054500', 'Healthcare Metal Supports', NULL, 0, 0, 0, '2017-09-10 10:36:22', '2017-09-10 10:36:22'),
(2550, '055000', '050000', 'Metal Fabrications', NULL, 0, 0, 0, '2017-09-10 10:36:45', '2017-09-10 10:36:45'),
(2551, '055100', '055000', 'Metal Stairs', NULL, 0, 0, 0, '2017-09-10 10:36:51', '2017-09-10 10:36:51'),
(2552, '055113', '055100', 'Metal Pan Stairs', NULL, 0, 0, 0, '2017-09-10 10:36:58', '2017-09-10 10:36:58'),
(2553, '055116', '055100', 'Metal Floor Plate Stairs', NULL, 0, 0, 0, '2017-09-10 10:37:04', '2017-09-10 10:37:04'),
(2554, '055117', '055100', 'Alternating Tread Stairs', NULL, 0, 0, 0, '2017-09-10 10:37:13', '2017-09-10 10:37:13'),
(2555, '055119', '055100', 'Metal Grating Stairs', NULL, 0, 0, 0, '2017-09-10 10:37:18', '2017-09-10 10:37:18'),
(2556, '055123', '055100', 'Metal Fire Escapes', NULL, 0, 0, 0, '2017-09-10 10:37:23', '2017-09-10 10:37:23'),
(2557, '055133', '055100', 'Metal Ladders', NULL, 0, 0, 0, '2017-09-10 10:37:30', '2017-09-10 10:37:30'),
(2558, '055133.13', '055133', 'Vertical Metal Ladders', NULL, 0, 0, 0, '2017-09-10 10:38:34', '2017-09-10 10:38:34'),
(2559, '055133.16', '055133', 'Inclined Metal Ladders', NULL, 0, 0, 0, '2017-09-10 10:38:44', '2017-09-10 10:38:44'),
(2560, '055133.23', '055133', 'Alternating Tread Ladders', NULL, 0, 0, 0, '2017-09-10 10:38:51', '2017-09-10 10:38:51'),
(2561, '055136', '055100', 'Metal Walkways', NULL, 0, 0, 0, '2017-09-10 10:38:58', '2017-09-10 10:38:58'),
(2562, '055136.13', '055136', 'Metal Catwalks', NULL, 0, 0, 0, '2017-09-10 10:39:06', '2017-09-10 10:39:06'),
(2563, '055136.16', '055136', 'Metal Ramps', NULL, 0, 0, 0, '2017-09-10 10:39:13', '2017-09-10 10:39:13'),
(2564, '055136.19', '055136', 'Metal Platforms', NULL, 0, 0, 0, '2017-09-10 10:39:21', '2017-09-10 10:39:21'),
(2565, '055200', '055000', 'Metal Railings', NULL, 0, 0, 0, '2017-09-10 10:39:27', '2017-09-10 10:39:27'),
(2566, '055213', '055200', 'Pipe and Tube Railings', NULL, 0, 0, 0, '2017-09-10 10:39:33', '2017-09-10 10:39:33'),
(2567, '055300', '055000', 'Metal Gratings', NULL, 0, 0, 0, '2017-09-10 10:39:38', '2017-09-10 10:39:38'),
(2568, '055313', '055300', 'Bar Gratings', NULL, 0, 0, 0, '2017-09-10 10:39:43', '2017-09-10 10:39:43'),
(2569, '055316', '055300', 'Plank Gratings', NULL, 0, 0, 0, '2017-09-10 10:39:47', '2017-09-10 10:39:47'),
(2570, '055319', '055300', 'Expanded Metal Gratings', NULL, 0, 0, 0, '2017-09-10 10:39:52', '2017-09-10 10:39:52'),
(2571, '055400', '055000', 'Metal Floor Plates', NULL, 0, 0, 0, '2017-09-10 10:39:57', '2017-09-10 10:39:57'),
(2572, '055500', '055000', 'Metal Stair Treads and Nosings', NULL, 0, 0, 0, '2017-09-10 10:40:02', '2017-09-10 10:40:02'),
(2573, '055513', '055500', 'Metal Stair Treads', NULL, 0, 0, 0, '2017-09-10 10:40:07', '2017-09-10 10:40:07'),
(2574, '055516', '055500', 'Metal Stair Nosings', NULL, 0, 0, 0, '2017-09-10 10:40:11', '2017-09-10 10:40:11'),
(2575, '055600', '055000', 'Metal Castings', NULL, 0, 0, 0, '2017-09-10 10:40:18', '2017-09-10 10:40:18'),
(2576, '055800', '055000', 'Formed Metal Fabrications', NULL, 0, 0, 0, '2017-09-10 10:40:23', '2017-09-10 10:40:23'),
(2577, '055813', '055800', 'Column Covers', NULL, 0, 0, 0, '2017-09-10 10:40:27', '2017-09-10 10:40:27'),
(2578, '055816', '055800', 'Formed Metal Enclosures', NULL, 0, 0, 0, '2017-09-10 10:40:35', '2017-09-10 10:40:35'),
(2579, '055819', '055800', 'Heating/Cooling Unit Covers', NULL, 0, 0, 0, '2017-09-10 10:40:41', '2017-09-10 10:40:41'),
(2580, '055823', '055800', 'Formed Metal Guards', NULL, 0, 0, 0, '2017-09-10 10:40:47', '2017-09-10 10:40:47'),
(2581, '055900', '055000', 'Metal Specialties', NULL, 0, 0, 0, '2017-09-10 10:40:55', '2017-09-10 10:40:55'),
(2582, '055913', '055900', 'Metal Balconies', NULL, 0, 0, 0, '2017-09-10 10:40:59', '2017-09-10 10:40:59'),
(2583, '055963', '055900', 'Detention Enclosures', NULL, 0, 0, 0, '2017-09-10 10:41:04', '2017-09-10 10:41:04'),
(2584, '057000', '050000', 'Decorative Metal', NULL, 0, 0, 0, '2017-09-10 10:41:11', '2017-09-10 10:41:11'),
(2585, '057100', '057000', 'Decorative Metal Stairs', NULL, 0, 0, 0, '2017-09-10 10:41:17', '2017-09-10 10:41:17'),
(2586, '057113', '057100', 'Fabricated Metal Spiral Stairs', NULL, 0, 0, 0, '2017-09-10 10:41:23', '2017-09-10 10:41:23'),
(2587, '057300', '057000', 'Decorative Metal Railings', NULL, 0, 0, 0, '2017-09-10 10:41:30', '2017-09-10 10:41:30'),
(2588, '057313', '057300', 'Glazed Decorative Metal Railings', NULL, 0, 0, 0, '2017-09-10 10:41:35', '2017-09-10 10:41:35'),
(2589, '057316', '057300', 'Wire Rope Decorative Metal Railings', NULL, 0, 0, 0, '2017-09-10 10:41:40', '2017-09-10 10:41:40'),
(2590, '057400', '057000', 'Decorative Metal Castings', NULL, 0, 0, 0, '2017-09-10 10:49:35', '2017-09-10 10:49:35'),
(2591, '057500', '057000', 'Decorative Formed Metal', NULL, 0, 0, 0, '2017-09-10 10:49:57', '2017-09-10 10:49:57'),
(2592, '057600', '057000', 'Decorative Forged Metal', NULL, 0, 0, 0, '2017-09-10 10:50:03', '2017-09-10 10:50:03'),
(2593, '057700', '057000', 'Decorative Extruded Metal', NULL, 0, 0, 0, '2017-09-10 10:50:08', '2017-09-10 10:50:08'),
(2594, '058000', '050000', 'Expansion Control', NULL, 0, 0, 0, '2017-09-10 10:50:13', '2017-09-10 10:50:13'),
(2595, '059000', '050000', 'Metal Restoration and Cleaning', NULL, 0, 0, 0, '2017-09-10 10:50:17', '2017-09-10 10:50:17'),
(2596, '060000', '0', 'Wood and Plastics', NULL, 0, 0, 0, '2017-09-10 10:50:24', '2017-09-10 10:50:24'),
(2597, '060100', '060000', 'Maintenance of Wood, Plastics, and Composites', NULL, 0, 0, 0, '2017-09-10 10:50:33', '2017-09-10 10:50:33'),
(2598, '060110', '060100', 'Maintenance of Rough Carpentry', NULL, 0, 0, 0, '2017-09-10 10:50:39', '2017-09-10 10:50:39'),
(2599, '060110.71', '060110', 'Rough Carpentry Rehabilitation', NULL, 0, 0, 0, '2017-09-10 10:50:48', '2017-09-10 10:50:48'),
(2600, '060110.91', '060110', 'Rough Carpentry Restoration', NULL, 0, 0, 0, '2017-09-10 10:50:56', '2017-09-10 10:50:56'),
(2601, '060110.92', '060110', 'Rough Carpentry Preservation', NULL, 0, 0, 0, '2017-09-10 10:51:04', '2017-09-10 10:51:04'),
(2602, '060120', '060100', 'Maintenance of Finish Carpentry', NULL, 0, 0, 0, '2017-09-10 10:51:10', '2017-09-10 10:51:10'),
(2603, '060120.71', '060120', 'Finish Carpentry Rehabilitation', NULL, 0, 0, 0, '2017-09-10 10:51:19', '2017-09-10 10:51:19'),
(2604, '060120.91', '060120', 'Finish Carpentry Restoration', NULL, 0, 0, 0, '2017-09-10 10:51:28', '2017-09-10 10:51:28'),
(2605, '060120.92', '060120', 'Finish Carpentry Preservation', NULL, 0, 0, 0, '2017-09-10 10:51:36', '2017-09-10 10:51:36'),
(2606, '060140', '060100', 'Maintenance of Architectural Woodwork', NULL, 0, 0, 0, '2017-09-10 10:52:20', '2017-09-10 10:52:20'),
(2607, '060140.51', '060140', 'Architectural Woodwork Cleaning', NULL, 0, 0, 0, '2017-09-10 10:52:28', '2017-09-10 10:52:28'),
(2608, '060140.61', '060140', 'Architectural Woodwork Refinishing', NULL, 0, 0, 0, '2017-09-10 10:52:35', '2017-09-10 10:52:35'),
(2609, '060140.91', '060140', 'Architectural Woodwork Restoration', NULL, 0, 0, 0, '2017-09-10 10:52:43', '2017-09-10 10:52:43'),
(2610, '060150', '060100', 'Maintenance of Structural Plastics', NULL, 0, 0, 0, '2017-09-10 10:52:56', '2017-09-10 10:52:56'),
(2611, '060160', '060100', 'Maintenance of Plastic Fabrications', NULL, 0, 0, 0, '2017-09-10 10:55:17', '2017-09-10 10:55:17'),
(2612, '060160.51', '060160', 'Plastic Cleaning', NULL, 0, 0, 0, '2017-09-10 10:55:24', '2017-09-10 10:55:24'),
(2613, '060160.71', '060160', 'Plastic Rehabilitation', NULL, 0, 0, 0, '2017-09-10 10:55:32', '2017-09-10 10:55:32'),
(2614, '060160.91', '060160', 'Plastic Restoration', NULL, 0, 0, 0, '2017-09-10 10:55:39', '2017-09-10 10:55:39'),
(2615, '060160.92', '060160', 'Plastic Preservation', NULL, 0, 0, 0, '2017-09-10 10:55:47', '2017-09-10 10:55:47'),
(2616, '060170', '060100', 'Maintenance of Structural Composites', NULL, 0, 0, 0, '2017-09-10 10:55:54', '2017-09-10 10:55:54'),
(2617, '060180', '060100', 'Maintenance of Composite Assemblies', NULL, 0, 0, 0, '2017-09-10 10:56:01', '2017-09-10 10:56:01'),
(2618, '060180.51', '060180', 'Composite Cleaning', NULL, 0, 0, 0, '2017-09-10 10:56:07', '2017-09-10 10:56:07'),
(2619, '060180.71', '060180', 'Composite Rehabilitation', NULL, 0, 0, 0, '2017-09-10 10:56:16', '2017-09-10 10:56:16'),
(2620, '060180.91', '060180', 'Composite Restoration', NULL, 0, 0, 0, '2017-09-10 10:56:26', '2017-09-10 10:56:26'),
(2621, '060180.92', '060180', 'Composite Preservation', NULL, 0, 0, 0, '2017-09-10 10:56:34', '2017-09-10 10:56:34'),
(2622, '060300', '060000', 'Conservation Treatment for Period Wood', NULL, 0, 0, 0, '2017-09-10 10:57:10', '2017-09-10 10:57:10'),
(2623, '060301', '060300', 'Maintenance for Period Wood', NULL, 0, 0, 0, '2017-09-10 10:57:15', '2017-09-10 10:57:15'),
(2624, '060301.31', '060301', 'Period Wood Storage and Protection', NULL, 0, 0, 0, '2017-09-10 10:57:24', '2017-09-10 10:57:24'),
(2625, '060305', '060300', 'Common Work Results for Period Wood', NULL, 0, 0, 0, '2017-09-10 10:57:31', '2017-09-10 10:57:31'),
(2626, '060305.73', '060305', 'Long-term Period Wood Treatment', NULL, 0, 0, 0, '2017-09-10 10:57:38', '2017-09-10 10:57:38'),
(2627, '060305.74', '060305', 'Eradication of Insects in Period Wood', NULL, 0, 0, 0, '2017-09-10 10:57:46', '2017-09-10 10:57:46'),
(2628, '060305.75', '060305', 'Antiseptic Treatment of Period Wood', NULL, 0, 0, 0, '2017-09-10 10:57:57', '2017-09-10 10:57:57'),
(2629, '060313', '060300', 'Conservation Treatment of Period Log Construction', NULL, 0, 0, 0, '2017-09-10 10:58:23', '2017-09-10 10:58:23'),
(2630, '060313.23', '060313', 'Conservation Treatment for Period Heavy Timber', NULL, 0, 0, 0, '2017-09-10 10:58:30', '2017-09-10 10:58:30'),
(2631, '060320', '060300', 'Conservation Treatment for Period Finish Carpentry', NULL, 0, 0, 0, '2017-09-10 10:58:38', '2017-09-10 10:58:38'),
(2632, '060320.13', '060320', 'Period Exterior Finish Carpentry', NULL, 0, 0, 0, '2017-09-10 10:58:47', '2017-09-10 10:58:47'),
(2633, '060320.23', '060320', 'Period Interior Finish Carpentry', NULL, 0, 0, 0, '2017-09-10 10:58:55', '2017-09-10 10:58:55'),
(2634, '060340', '060300', 'Conservation Treatment for Period Architectural Woodwork', NULL, 0, 0, 0, '2017-09-10 10:59:22', '2017-09-10 10:59:22'),
(2636, '060340.13', '060340', 'Period Exterior Architectural Woodwork', NULL, 0, 0, 0, '2017-09-10 10:59:35', '2017-09-10 10:59:35'),
(2637, '060340.23', '060340', 'Period Interior Architectural Woodwork', NULL, 0, 0, 0, '2017-09-10 10:59:43', '2017-09-10 10:59:43'),
(2638, '060500', '060000', 'Common Work Results for Wood, Plastics, and Composites', NULL, 0, 0, 0, '2017-09-10 10:59:51', '2017-09-10 10:59:51'),
(2639, '060505', '060500', 'Selective Demolition for Wood, Plastics, and Composites', NULL, 0, 0, 0, '2017-09-10 10:59:58', '2017-09-10 10:59:58'),
(2640, '060523', '060500', 'Wood, Plastic, and Composite Fastenings', NULL, 0, 0, 0, '2017-09-10 11:00:04', '2017-09-10 11:00:04'),
(2641, '060573', '060500', 'Wood Treatment', NULL, 0, 0, 0, '2017-09-10 11:00:11', '2017-09-10 11:00:11'),
(2642, '060573.13', '060573', 'Fire-Retardant Wood Treatment', NULL, 0, 0, 0, '2017-09-10 11:00:20', '2017-09-10 11:00:20'),
(2643, '060573.33', '060573', 'Preservative Wood Treatment', NULL, 0, 0, 0, '2017-09-10 11:00:27', '2017-09-10 11:00:27'),
(2644, '060573.91', '060573', 'Long-Term Wood Treatment', NULL, 0, 0, 0, '2017-09-10 11:00:36', '2017-09-10 11:00:36'),
(2645, '060573.93', '060573', 'Eradication of Insects in Wood', NULL, 0, 0, 0, '2017-09-10 11:00:44', '2017-09-10 11:00:44'),
(2646, '060573.96', '060573', 'Antiseptic Treatment of Wood', NULL, 0, 0, 0, '2017-09-10 11:00:53', '2017-09-10 11:00:53'),
(2647, '060583', '060573', 'Shop-Applied Wood Coatings', NULL, 0, 0, 0, '2017-09-10 11:01:00', '2017-09-10 11:01:00'),
(2648, '060600', '060000', 'Schedules for Wood , Plastics, and Composites', NULL, 0, 0, 0, '2017-09-10 11:01:07', '2017-09-10 11:01:07'),
(2649, '060610', '060600', 'Schedules for Rough Carpentry', NULL, 0, 0, 0, '2017-09-10 11:01:13', '2017-09-10 11:01:13'),
(2650, '060610.13', '060610', 'Nailing Schedule', NULL, 0, 0, 0, '2017-09-10 11:01:20', '2017-09-10 11:01:20'),
(2651, '060610.16', '060610', 'Wood Beam Schedule', NULL, 0, 0, 0, '2017-09-10 11:01:30', '2017-09-10 11:01:30'),
(2652, '060610.19', '060610', 'Plywood Shear Wall Schedule', NULL, 0, 0, 0, '2017-09-10 11:01:37', '2017-09-10 11:01:37'),
(2653, '060610.23', '060610', 'Plywood Web Joist Schedule', NULL, 0, 0, 0, '2017-09-10 11:01:45', '2017-09-10 11:01:45'),
(2654, '060610.26', '060610', 'Wood Truss Schedule', NULL, 0, 0, 0, '2017-09-10 11:01:52', '2017-09-10 11:01:52'),
(2655, '060620', '060600', 'Schedules for Finish Carpentry', NULL, 0, 0, 0, '2017-09-10 11:03:55', '2017-09-10 11:03:55'),
(2656, '060640', '060600', 'Schedules for Architectural Woodwork', NULL, 0, 0, 0, '2017-09-10 11:04:00', '2017-09-10 11:04:00'),
(2657, '060650', '060600', 'Schedules for Structural Plastics', NULL, 0, 0, 0, '2017-09-10 11:04:04', '2017-09-10 11:04:04'),
(2658, '060660', '060600', 'Schedules for Plastic Fabrications', NULL, 0, 0, 0, '2017-09-10 11:04:08', '2017-09-10 11:04:08'),
(2659, '060670', '060600', 'Schedules for Structural Composites', NULL, 0, 0, 0, '2017-09-10 11:04:13', '2017-09-10 11:04:13'),
(2660, '060680', '060600', 'Schedules for Composite Assemblies', NULL, 0, 0, 0, '2017-09-10 11:04:17', '2017-09-10 11:04:17'),
(2661, '060800', '060000', 'Commissioning of Wo od, Plastics, and Composites', NULL, 0, 0, 0, '2017-09-10 11:04:23', '2017-09-10 11:04:23'),
(2662, '061000', '060000', 'Rough Carpentry', NULL, 0, 0, 0, '2017-09-10 11:04:27', '2017-09-10 11:04:27'),
(2663, '061053', '061000', 'Miscellaneous Rough Carpentry', NULL, 0, 0, 0, '2017-09-10 11:04:33', '2017-09-10 11:04:33'),
(2664, '061063', '061000', 'Exterior Rough Carpentry', NULL, 0, 0, 0, '2017-09-10 11:04:37', '2017-09-10 11:04:37');
INSERT INTO `wbs` (`id`, `code`, `parent_code`, `name`, `description`, `extension`, `status`, `quantify`, `created_at`, `updated_at`) VALUES
(2665, '061100', '061000', 'Wood Framing', NULL, 0, 0, 0, '2017-09-10 11:04:43', '2017-09-10 11:04:43'),
(2666, '061113', '061100', 'Engineered Wood Products', NULL, 0, 0, 0, '2017-09-10 11:04:48', '2017-09-10 11:04:48'),
(2667, '061116', '061100', 'Mechanically Graded Lumber', NULL, 0, 0, 0, '2017-09-10 11:04:57', '2017-09-10 11:04:57'),
(2668, '061200', '061000', 'Structural Panels', NULL, 0, 0, 0, '2017-09-10 11:05:03', '2017-09-10 11:05:03'),
(2669, '061213', '061200', 'Cementitious Reinforced Panels', NULL, 0, 0, 0, '2017-09-10 11:05:07', '2017-09-10 11:05:07'),
(2670, '061216', '061200', 'Stressed Skin Panels', NULL, 0, 0, 0, '2017-09-10 11:05:13', '2017-09-10 11:05:13'),
(2671, '061300', '061000', 'Heavy Timber Construction', NULL, 0, 0, 0, '2017-09-10 11:05:18', '2017-09-10 11:05:18'),
(2672, '061313', '061300', 'Log Construction', NULL, 0, 0, 0, '2017-09-10 11:05:24', '2017-09-10 11:05:24'),
(2673, '061316', '061300', 'Pole Construction', NULL, 0, 0, 0, '2017-09-10 11:05:29', '2017-09-10 11:05:29'),
(2674, '061323', '061300', 'Heavy Timber Framing', NULL, 0, 0, 0, '2017-09-10 11:05:34', '2017-09-10 11:05:34'),
(2675, '061326', '061300', 'Heavy Timber Trusses', NULL, 0, 0, 0, '2017-09-10 11:05:40', '2017-09-10 11:05:40'),
(2676, '061333', '061300', 'Heavy Timber Pier Construction', NULL, 0, 0, 0, '2017-09-10 11:05:49', '2017-09-10 11:05:49'),
(2677, '061400', '061000', 'Treated Wood Foundations', NULL, 0, 0, 0, '2017-09-10 11:06:31', '2017-09-10 11:06:31'),
(2678, '061500', '061000', 'Wood Decking', NULL, 0, 0, 0, '2017-09-10 11:06:36', '2017-09-10 11:06:36'),
(2679, '061513', '061500', 'Wood Floor Decking', NULL, 0, 0, 0, '2017-09-10 11:06:41', '2017-09-10 11:06:41'),
(2680, '061516', '061500', 'Wood Roof Decking', NULL, 0, 0, 0, '2017-09-10 11:06:46', '2017-09-10 11:06:46'),
(2681, '061519', '061500', 'Timber Decking', NULL, 0, 0, 0, '2017-09-10 11:06:51', '2017-09-10 11:06:51'),
(2682, '061523', '061500', 'Laminated Wood Decking', NULL, 0, 0, 0, '2017-09-10 11:06:56', '2017-09-10 11:06:56'),
(2683, '061533', '061500', 'Wood Patio Decking', NULL, 0, 0, 0, '2017-09-10 11:07:01', '2017-09-10 11:07:01'),
(2684, '061600', '061000', 'Sheating', NULL, 0, 0, 0, '2017-09-10 11:07:06', '2017-09-10 11:07:06'),
(2685, '061613', '061600', 'Insulating Sheathing', NULL, 0, 0, 0, '2017-09-10 11:07:11', '2017-09-10 11:07:11'),
(2686, '061623', '061600', 'Subflooring', NULL, 0, 0, 0, '2017-09-10 11:07:17', '2017-09-10 11:07:17'),
(2687, '061626', '061600', 'Underlayment', NULL, 0, 0, 0, '2017-09-10 11:07:23', '2017-09-10 11:07:23'),
(2688, '061633', '061600', 'Wood Board Sheathing', NULL, 0, 0, 0, '2017-09-10 11:07:35', '2017-09-10 11:07:35'),
(2689, '061636', '061600', 'Wood Panel Product Sheathing', NULL, 0, 0, 0, '2017-09-10 11:07:42', '2017-09-10 11:07:42'),
(2690, '061643', '061600', 'Gypsum Sheathing', NULL, 0, 0, 0, '2017-09-10 11:07:47', '2017-09-10 11:07:47'),
(2691, '061653', '061600', 'Moisture-Resistant Sheathing Board', NULL, 0, 0, 0, '2017-09-10 11:07:52', '2017-09-10 11:07:52'),
(2692, '061663', '061600', 'Cementitious Sheathing', NULL, 0, 0, 0, '2017-09-10 11:07:57', '2017-09-10 11:07:57'),
(2693, '061700', '061000', 'Shop-Fabricated Structural Wood', NULL, 0, 0, 0, '2017-09-10 11:08:05', '2017-09-10 11:08:05'),
(2694, '061713', '061700', 'Laminated Veneer Lumber', NULL, 0, 0, 0, '2017-09-10 11:08:10', '2017-09-10 11:08:10'),
(2695, '061719', '061700', 'Cross-Laminated Timber', NULL, 0, 0, 0, '2017-09-10 11:08:14', '2017-09-10 11:08:14'),
(2696, '061723', '061700', 'Parallel Strand Lumber', NULL, 0, 0, 0, '2017-09-10 11:08:19', '2017-09-10 11:08:19'),
(2697, '061733', '061700', 'Wood I-Joists', NULL, 0, 0, 0, '2017-09-10 11:08:24', '2017-09-10 11:08:24'),
(2698, '061736', '061700', 'Metal-Web Wood Joists', NULL, 0, 0, 0, '2017-09-10 11:08:29', '2017-09-10 11:08:29'),
(2699, '061743', '061700', 'Rim Boards', NULL, 0, 0, 0, '2017-09-10 11:08:34', '2017-09-10 11:08:34'),
(2700, '061753', '061700', 'Shop-Fabricated Wood Trusses', NULL, 0, 0, 0, '2017-09-10 11:08:42', '2017-09-10 11:08:42'),
(2701, '061800', '061000', 'Glued-Laminated Construction', NULL, 0, 0, 0, '2017-09-10 11:09:38', '2017-09-10 11:09:38'),
(2702, '061813', '061800', 'Glued-Laminated Beams', NULL, 0, 0, 0, '2017-09-10 11:09:43', '2017-09-10 11:09:43'),
(2703, '061816', '061800', 'Glued-Laminated Columns', NULL, 0, 0, 0, '2017-09-10 11:09:49', '2017-09-10 11:09:49'),
(2704, '062000', '060000', 'Finish Carpentry', NULL, 0, 0, 0, '2017-09-10 11:09:55', '2017-09-10 11:09:55'),
(2705, '062013', '062000', 'Exterior Finish Carpentry', NULL, 0, 0, 0, '2017-09-10 11:10:07', '2017-09-10 11:10:07'),
(2706, '062023', '062000', 'Interior Finish Carpentry', NULL, 0, 0, 0, '2017-09-10 11:10:14', '2017-09-10 11:10:14'),
(2707, '062200', '062000', 'Millwork', NULL, 0, 0, 0, '2017-09-10 11:10:19', '2017-09-10 11:10:19'),
(2708, '062213', '062200', 'Standard Pattern Wood Trim', NULL, 0, 0, 0, '2017-09-10 11:10:24', '2017-09-10 11:10:24'),
(2713, '032000', '030000', 'Concrete Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:25:12', '2017-09-10 20:25:12'),
(2714, '032100', '032000', 'Reinforcement Bars', NULL, 0, 0, 0, '2017-09-10 20:25:22', '2017-09-10 20:25:22'),
(2715, '032111', '032100', 'Plain Steel Reinforcement Bars', NULL, 0, 0, 0, '2017-09-10 20:33:17', '2017-09-10 20:33:17'),
(2716, '032113', '032100', 'Galvanized Reinforcement Steel Bars', NULL, 0, 0, 0, '2017-09-10 20:33:23', '2017-09-10 20:33:23'),
(2717, '032116', '032100', 'Epoxy-Coated Reinforcement Steel Bars', NULL, 0, 0, 0, '2017-09-10 20:33:29', '2017-09-10 20:33:29'),
(2718, '032119', '032100', 'Stainless Steel Reinforcement Bars', NULL, 0, 0, 0, '2017-09-10 20:33:36', '2017-09-10 20:33:36'),
(2719, '032121', '032100', 'Composite Reinforcement Bars', NULL, 0, 0, 0, '2017-09-10 20:33:43', '2017-09-10 20:33:43'),
(2720, '032121.11', '032121', 'Glass Fiber-Reinforced Polymer Reinforcement Bars', NULL, 0, 0, 0, '2017-09-10 20:33:50', '2017-09-10 20:33:50'),
(2721, '032121.13', '032121', 'Organic Fiber-Reinforced Polymer Reinforcement Bars', NULL, 0, 0, 0, '2017-09-10 20:33:56', '2017-09-10 20:33:56'),
(2722, '032121.16', '032121', 'Carbon Fiber-Reinforced Polymer Reinforcement Bars', NULL, 0, 0, 0, '2017-09-10 20:34:01', '2017-09-10 20:34:01'),
(2723, '032200', '032000', 'Fabric and Grid Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:34:11', '2017-09-10 20:34:11'),
(2724, '032213', '032200', 'Galvanized Welded Wire Fabric Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:34:19', '2017-09-10 20:34:19'),
(2725, '032214', '032200', 'Welded Wire Fabric Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:34:24', '2017-09-10 20:34:24'),
(2726, '032216', '032200', 'Epoxy-Coated Welded Wire Fabric Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:34:29', '2017-09-10 20:34:29'),
(2727, '032219', '032200', 'Composite Grid Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:34:34', '2017-09-10 20:34:34'),
(2728, '032300', '032000', 'Stressed Tendon Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:34:43', '2017-09-10 20:34:43'),
(2729, '032400', '032000', 'Fibrous Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:34:48', '2017-09-10 20:34:48'),
(2730, '032500', '032000', 'Composite Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:34:53', '2017-09-10 20:34:53'),
(2731, '032513', '032500', 'Glass Fiber-Reinforced Polymer Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:34:58', '2017-09-10 20:34:58'),
(2732, '032516', '032500', 'Organic Fiber-Reinforced Polymer Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:35:04', '2017-09-10 20:35:04'),
(2733, '032519', '032500', 'Carbon Fiber-Reinforced Polymer Reinforcing', NULL, 0, 0, 0, '2017-09-10 20:35:08', '2017-09-10 20:35:08'),
(2734, '033000', '030000', 'Cast-In-Place Concrete', NULL, 0, 0, 0, '2017-09-10 20:35:21', '2017-09-10 20:35:21'),
(2735, '033053', '033000', 'Miscellaneous Cast-in-Place Concrete', NULL, 0, 0, 0, '2017-09-10 20:35:28', '2017-09-10 20:35:28'),
(2736, '033100', '033000', 'Structural Concrete', NULL, 0, 0, 0, '2017-09-10 20:35:35', '2017-09-10 20:35:35'),
(2737, '033113', '033100', 'Heavyweight Structural Concrete', NULL, 0, 0, 0, '2017-09-10 20:35:40', '2017-09-10 20:35:40'),
(2738, '033116', '033100', 'Lightweight Structural Concrete', NULL, 0, 0, 0, '2017-09-10 20:35:45', '2017-09-10 20:35:45'),
(2739, '033119', '033100', 'Shrinkage-Compensating Structural Concrete', NULL, 0, 0, 0, '2017-09-10 20:35:52', '2017-09-10 20:35:52'),
(2740, '033123', '033100', 'High-Performance Structural Concrete', NULL, 0, 0, 0, '2017-09-10 20:35:57', '2017-09-10 20:35:57'),
(2741, '033124', '033100', 'Ultra High-Performance Structural Concrete', NULL, 0, 0, 0, '2017-09-10 20:36:02', '2017-09-10 20:36:02'),
(2742, '033126', '033100', 'Self-Compacting Concrete', NULL, 0, 0, 0, '2017-09-10 20:36:14', '2017-09-10 20:36:14'),
(2743, '033300', '033000', 'Architectural Concrete', NULL, 0, 0, 0, '2017-09-10 20:36:43', '2017-09-10 20:36:43'),
(2744, '033313', '033300', 'Heavyweight Architectural Concrete', NULL, 0, 0, 0, '2017-09-10 20:36:50', '2017-09-10 20:36:50'),
(2745, '033316', '033300', 'Lightweight Architectural Concrete', NULL, 0, 0, 0, '2017-09-10 20:36:55', '2017-09-10 20:36:55'),
(2746, '033400', '033000', 'Low Density Concrete', NULL, 0, 0, 0, '2017-09-10 20:37:01', '2017-09-10 20:37:01'),
(2747, '033500', '033000', 'Concrete Finishing', NULL, 0, 0, 0, '2017-09-10 20:40:14', '2017-09-10 20:40:14'),
(2749, '033513', '033500', 'High-Tolerance Concrete Floor Finishing', NULL, 0, 0, 0, '2017-09-10 20:42:36', '2017-09-10 20:42:36'),
(2750, '030150.51', '030150', 'Cleaning Cast Decks and Underlayment', NULL, 0, 0, 0, '2017-09-10 20:43:52', '2017-09-10 20:43:52'),
(2751, '030150.61', '030150', 'Resurfacing of Cast Decks and Underlayment', NULL, 0, 0, 0, '2017-09-10 20:43:59', '2017-09-10 20:43:59'),
(2752, '030150.71', '030150', 'Rehabilitation of Cast Decks and Underlayment', NULL, 0, 0, 0, '2017-09-10 20:44:06', '2017-09-10 20:44:06'),
(2753, '030150.72', '030150', 'Strengthening of Cast Decks and Underlayment', NULL, 0, 0, 0, '2017-09-10 20:44:14', '2017-09-10 20:44:14'),
(2754, '030620.13', '030620', 'Concrete Beam Reinforcing Schedule', NULL, 0, 0, 0, '2017-09-10 20:44:33', '2017-09-10 20:44:33'),
(2755, '030620.16', '030620', 'Concrete Slab Reinforcing Schedule', NULL, 0, 0, 0, '2017-09-10 20:44:47', '2017-09-10 20:44:47'),
(2756, '033516', '033500', 'Heavy-Duty Concrete Floor Finishing', NULL, 0, 0, 0, '2017-09-10 20:45:10', '2017-09-10 20:45:10'),
(2757, '033519', '033500', 'Colored Concrete Finishing', NULL, 0, 0, 0, '2017-09-10 20:45:19', '2017-09-10 20:45:19'),
(2758, '033523', '033500', 'Exposed Aggregate Concrete Finishing', NULL, 0, 0, 0, '2017-09-10 20:45:28', '2017-09-10 20:45:28'),
(2759, '033526', '033500', 'Grooved Concrete Surface Finishing', NULL, 0, 0, 0, '2017-09-10 20:45:33', '2017-09-10 20:45:33'),
(2760, '033529', '033500', 'Tooled Concrete Finishing', NULL, 0, 0, 0, '2017-09-10 20:45:40', '2017-09-10 20:45:40'),
(2761, '033533', '033500', 'Stamped Concrete Finishing', NULL, 0, 0, 0, '2017-09-10 20:45:49', '2017-09-10 20:45:49'),
(2762, '033543', '033500', 'Polished Concrete Finishing', NULL, 0, 0, 0, '2017-09-10 20:45:58', '2017-09-10 20:45:58'),
(2763, '033543.13', '033543', 'Polished and Dyed Concrete Finishing', NULL, 0, 0, 0, '2017-09-10 20:46:08', '2017-09-10 20:46:08'),
(2764, '033543.16', '033543', 'Polished and Stained Concrete Finishing', NULL, 0, 0, 0, '2017-09-10 20:46:18', '2017-09-10 20:46:18'),
(2765, '033546', '033500', 'Concrete Topical Treatment', NULL, 0, 0, 0, '2017-09-10 20:46:26', '2017-09-10 20:46:26'),
(2766, '030130.51', '030130', 'Cleaning of Cast-in-Place Concrete', NULL, 0, 0, 0, '2017-09-11 07:59:14', '2017-09-11 07:59:14'),
(2767, '030130.61', '030130', 'Resurfacing of Cast-in-Place Concrete', NULL, 0, 0, 0, '2017-09-11 07:59:23', '2017-09-11 07:59:23'),
(2768, '030130.71', '030130', 'Rehabilitation of Cast-in-Place Concrete', NULL, 0, 0, 0, '2017-09-11 07:59:33', '2017-09-11 07:59:33'),
(2769, '030130.72', '030130', 'Strengthening of Cast-in-Place Concrete', NULL, 0, 0, 0, '2017-09-11 07:59:48', '2017-09-11 07:59:48'),
(2770, '030140.51', '030140', 'Cleaning of Precast Concrete', NULL, 0, 0, 0, '2017-09-11 07:59:57', '2017-09-11 07:59:57'),
(2774, '030140.61', '030140', 'Resurfacing of Precast Concrete', NULL, 0, 0, 0, '2017-09-11 08:00:32', '2017-09-11 08:00:32'),
(2775, '030140.71', '030140', 'Rehabilitation of Precast Concrete', NULL, 0, 0, 0, '2017-09-11 08:00:39', '2017-09-11 08:00:39'),
(2776, '030140.72', '030140', 'Strengthening of Precast Concrete', NULL, 0, 0, 0, '2017-09-11 08:00:46', '2017-09-11 08:00:46'),
(2777, '030630.13', '030630', 'Concrete Footing Schedule', NULL, 0, 0, 0, '2017-09-11 08:01:00', '2017-09-11 08:01:00'),
(2778, '030630.16', '030630', 'Concrete Column Schedule', NULL, 0, 0, 0, '2017-09-11 08:01:07', '2017-09-11 08:01:07'),
(2779, '030630.19', '030630', 'Concrete Slab Schedule', NULL, 0, 0, 0, '2017-09-11 08:01:15', '2017-09-11 08:01:15'),
(2780, '030630.23', '030630', 'Concrete Shaft Schedule', NULL, 0, 0, 0, '2017-09-11 08:01:23', '2017-09-11 08:01:23'),
(2781, '030630.26', '030630', 'Concrete Beam Schedule', NULL, 0, 0, 0, '2017-09-11 08:01:30', '2017-09-11 08:01:30'),
(2782, '030640.13', '030640', 'Precast Concrete Panel Schedule', NULL, 0, 0, 0, '2017-09-11 08:01:39', '2017-09-11 08:01:39'),
(2783, '033700', '033000', 'Specially Placed Concrete', NULL, 0, 0, 0, '2017-09-11 08:02:08', '2017-09-11 08:02:08'),
(2784, '033713', '033700', 'Shotcrete', NULL, 0, 0, 0, '2017-09-11 08:02:15', '2017-09-11 08:02:15'),
(2785, '033716', '033700', 'Pumped Concrete', NULL, 0, 0, 0, '2017-09-11 08:02:21', '2017-09-11 08:02:21'),
(2786, '033719', '033700', 'Pneumatically Placed Concrete', NULL, 0, 0, 0, '2017-09-11 08:02:27', '2017-09-11 08:02:27'),
(2787, '033723', '033700', 'Roller-Compacted Concrete', NULL, 0, 0, 0, '2017-09-11 08:02:32', '2017-09-11 08:02:32'),
(2788, '033726', '033700', 'Underwater Placed Concrete', NULL, 0, 0, 0, '2017-09-11 08:02:44', '2017-09-11 08:02:44'),
(2789, '033800', '033000', 'Post-Tensioned Concrete', NULL, 0, 0, 0, '2017-09-11 08:02:58', '2017-09-11 08:02:58'),
(2790, '033813', '033800', 'Post-Tensioned Concrete Preparation', NULL, 0, 0, 0, '2017-09-11 08:03:05', '2017-09-11 08:03:05'),
(2791, '033816', '033800', 'Unbonded Post-Tensioned Concrete', NULL, 0, 0, 0, '2017-09-11 08:03:11', '2017-09-11 08:03:11'),
(2792, '033819', '033800', 'Bonded Post-Tensioned Concrete', NULL, 0, 0, 0, '2017-09-11 08:03:17', '2017-09-11 08:03:17'),
(2793, '033900', '033000', 'Concrete Curing', NULL, 0, 0, 0, '2017-09-11 08:03:24', '2017-09-11 08:03:24'),
(2794, '033913', '033900', 'Water Concrete Curing', NULL, 0, 0, 0, '2017-09-11 08:03:41', '2017-09-11 08:03:41'),
(2795, '033916', '033900', 'Sand Concrete Curing', NULL, 0, 0, 0, '2017-09-11 08:03:53', '2017-09-11 08:03:53'),
(2796, '033923', '033900', 'Membrane Concrete Curing', NULL, 0, 0, 0, '2017-09-11 08:04:05', '2017-09-11 08:04:05'),
(2797, '033923.13', '033923', 'Chemical Compound Membrane Concrete Curing', NULL, 0, 0, 0, '2017-09-11 08:04:20', '2017-09-11 08:04:20'),
(2798, '033923.23', '033923', 'Sheet Membrane Concrete Curing', NULL, 0, 0, 0, '2017-09-11 08:04:34', '2017-09-11 08:04:34'),
(2799, '034000', '030000', 'Precast Concrete', NULL, 0, 0, 0, '2017-09-11 08:04:55', '2017-09-11 08:04:55'),
(2800, '034100', '034000', 'Precast Structural Concrete', NULL, 0, 0, 0, '2017-09-11 08:06:39', '2017-09-11 08:06:39'),
(2801, '034113', '034100', 'Precast Concrete Hollow Core Planks', NULL, 0, 0, 0, '2017-09-11 08:06:48', '2017-09-11 08:06:48'),
(2802, '034116', '034100', 'Precast Concrete Slabs', NULL, 0, 0, 0, '2017-09-11 08:06:59', '2017-09-11 08:06:59'),
(2803, '034123', '034100', 'Precast Concrete Stairs', NULL, 0, 0, 0, '2017-09-11 08:07:09', '2017-09-11 08:07:09'),
(2804, '034133', '034100', 'Precast Structural Pretensioned Concrete', NULL, 0, 0, 0, '2017-09-11 08:07:18', '2017-09-11 08:07:18'),
(2805, '034136', '034100', 'Precast Structural Post-Tensioned Concrete', NULL, 0, 0, 0, '2017-09-11 08:07:26', '2017-09-11 08:07:26'),
(2806, '034500', '034000', 'Precast Architectural Concrete', NULL, 0, 0, 0, '2017-09-11 08:07:42', '2017-09-11 08:07:42'),
(2807, '034513', '034500', 'Faced Architectural Precast Concrete', NULL, 0, 0, 0, '2017-09-11 08:07:51', '2017-09-11 08:07:51'),
(2808, '034533', '034500', 'Precast Architectural Pretensioned Concrete', NULL, 0, 0, 0, '2017-09-11 08:07:58', '2017-09-11 08:07:58'),
(2809, '034536', '034500', 'Precast Architectural Post-Tensioned Concrete', NULL, 0, 0, 0, '2017-09-11 08:08:04', '2017-09-11 08:08:04'),
(2810, '034700', '034000', 'Site-Cast Concrete', NULL, 0, 0, 0, '2017-09-11 08:08:11', '2017-09-11 08:08:11'),
(2811, '034713', '034700', 'Tilt-Up Concrete', NULL, 0, 0, 0, '2017-09-11 08:08:19', '2017-09-11 08:08:19'),
(2812, '034716', '034700', 'Lift-Slab Concrete', NULL, 0, 0, 0, '2017-09-11 08:08:27', '2017-09-11 08:08:27'),
(2813, '034800', '034000', 'Precast Concrete Specialties', NULL, 0, 0, 0, '2017-09-11 08:37:21', '2017-09-11 08:37:21'),
(2814, '034813', '034800', 'Precast Concrete Bollards', NULL, 0, 0, 0, '2017-09-11 08:37:29', '2017-09-11 08:37:29'),
(2815, '034813.11', '034813', 'Precast Concrete Security Bollards', NULL, 0, 0, 0, '2017-09-11 08:37:38', '2017-09-11 08:37:38'),
(2816, '034816', '034800', 'Precast Concrete Splash Blocks', NULL, 0, 0, 0, '2017-09-11 08:37:46', '2017-09-11 08:37:46'),
(2817, '034819', '034800', 'Precast Concrete Stair Treads', NULL, 0, 0, 0, '2017-09-11 08:38:33', '2017-09-11 08:38:33'),
(2818, '034826', '034800', 'Precast Concrete Parking Bumpers', NULL, 0, 0, 0, '2017-09-11 08:38:42', '2017-09-11 08:38:42'),
(2819, '034833', '034800', 'Precast Pre-Framed Concrete Panels', NULL, 0, 0, 0, '2017-09-11 08:38:51', '2017-09-11 08:38:51'),
(2820, '034843', '034800', 'Precast Concrete Trim', NULL, 0, 0, 0, '2017-09-11 08:38:59', '2017-09-11 08:38:59'),
(2821, '034900', '034000', 'Glass-Fiber-Reinforced Concrete', NULL, 0, 0, 0, '2017-09-11 08:39:20', '2017-09-11 08:39:20'),
(2822, '034913', '034900', 'Glass-Fiber-Reinforced Concrete Column Covers', NULL, 0, 0, 0, '2017-09-11 08:39:31', '2017-09-11 08:39:31'),
(2823, '034916', '034900', 'Glass-Fiber-Reinforced Concrete Spandrels', NULL, 0, 0, 0, '2017-09-11 08:39:39', '2017-09-11 08:39:39'),
(2824, '034943', '034900', 'Glass-Fiber-Reinforced Concrete Trim', NULL, 0, 0, 0, '2017-09-11 08:39:49', '2017-09-11 08:39:49'),
(2825, '035000', '030000', 'Cast Decks and Underlayment', NULL, 0, 0, 0, '2017-09-11 08:40:23', '2017-09-11 08:40:23'),
(2826, '035100', '035000', 'Cast Roof Decks', NULL, 0, 0, 0, '2017-09-11 08:40:30', '2017-09-11 08:40:30'),
(2827, '035113', '035100', 'Cementitious Wood Fiber Decks', NULL, 0, 0, 0, '2017-09-11 08:40:45', '2017-09-11 08:40:45'),
(2828, '035116', '035100', 'Gypsum Concrete Roof Decks', NULL, 0, 0, 0, '2017-09-11 08:41:37', '2017-09-11 08:41:37'),
(2829, '035200', '035000', 'Lightweight Concrete Roof Insulation', NULL, 0, 0, 0, '2017-09-11 08:42:09', '2017-09-11 08:42:09'),
(2830, '035213', '035200', 'Composite Concrete Roof Insulation', NULL, 0, 0, 0, '2017-09-11 08:42:17', '2017-09-11 08:42:17'),
(2831, '035216', '035200', 'Lightweight Insulating Concrete', NULL, 0, 0, 0, '2017-09-11 08:43:31', '2017-09-11 08:43:31'),
(2832, '035216.13', '035216', 'Lightweight Cellular Insulating Concrete', NULL, 0, 0, 0, '2017-09-11 08:47:24', '2017-09-11 08:47:24'),
(2833, '035216.16', '035216', 'Lightweight Aggregate Insulating Concrete', NULL, 0, 0, 0, '2017-09-11 08:49:18', '2017-09-11 08:49:18'),
(2834, '035300', '035000', 'Concrete Topping', NULL, 0, 0, 0, '2017-09-11 08:49:27', '2017-09-11 08:49:27'),
(2835, '035313', '035300', 'Emery-Aggregate Concrete Topping', NULL, 0, 0, 0, '2017-09-11 08:52:33', '2017-09-11 08:52:33'),
(2836, '035316', '035300', 'Iron-Aggregate Concrete Topping', NULL, 0, 0, 0, '2017-09-11 08:52:42', '2017-09-11 08:52:42'),
(2837, '035319', '035300', 'Concrete Overlayment', NULL, 0, 0, 0, '2017-09-11 08:52:47', '2017-09-11 08:52:47'),
(2838, '035400', '035000', 'Cast Underlayment', NULL, 0, 0, 0, '2017-09-11 08:53:26', '2017-09-11 08:53:26'),
(2839, '035413', '035400', 'Gypsum Cement Underlayment', NULL, 0, 0, 0, '2017-09-11 08:53:43', '2017-09-11 08:53:43'),
(2840, '035416', '035400', 'Hydraulic Cement Underlayment', NULL, 0, 0, 0, '2017-09-11 08:54:39', '2017-09-11 08:54:39'),
(2841, '036000', '030000', 'Grouts', NULL, 0, 0, 0, '2017-09-11 08:55:23', '2017-09-11 08:55:23'),
(2842, '036100', '036000', 'Cementitious Grouting', NULL, 0, 0, 0, '2017-09-11 08:55:37', '2017-09-11 08:55:37'),
(2843, '036113', '036100', 'Dry-Pack Grouting', NULL, 0, 0, 0, '2017-09-11 08:56:04', '2017-09-11 08:56:04'),
(2844, '036200', '036000', 'Non-Shrink Grouting', NULL, 0, 0, 0, '2017-09-11 08:56:22', '2017-09-11 08:56:22'),
(2845, '036213', '036200', 'Non-Metallic Non-Shrink Grouting', NULL, 0, 0, 0, '2017-09-11 08:56:38', '2017-09-11 08:56:38'),
(2846, '036216', '036200', 'Metallic Non-Shrink Grouting', NULL, 0, 0, 0, '2017-09-11 08:56:54', '2017-09-11 08:56:54'),
(2847, '036300', '036000', 'Epoxy Grouting', NULL, 0, 0, 0, '2017-09-11 08:57:05', '2017-09-11 08:57:05'),
(2848, '036400', '036000', 'Injection Grouting', NULL, 0, 0, 0, '2017-09-11 08:57:15', '2017-09-11 08:57:15'),
(2849, '037000', '030000', 'Mass Concrete', NULL, 0, 0, 0, '2017-09-11 08:57:41', '2017-09-11 08:57:41'),
(2850, '037100', '037000', 'Mass Concrete for Raft Foundations', NULL, 0, 0, 0, '2017-09-11 08:57:55', '2017-09-11 08:57:55'),
(2851, '037200', '037000', 'Mass Concrete for Dams', NULL, 0, 0, 0, '2017-09-11 08:58:05', '2017-09-11 08:58:05'),
(2852, '038000', '030000', 'Concrete Cutting & Boring', NULL, 0, 0, 0, '2017-09-11 08:58:54', '2017-09-11 08:58:54'),
(2853, '038100', '038000', 'Concrete Cutting', NULL, 0, 0, 0, '2017-09-11 08:59:47', '2017-09-11 08:59:47'),
(2854, '038113', '038100', 'Flat Concrete Sawing', NULL, 0, 0, 0, '2017-09-11 08:59:56', '2017-09-11 08:59:56'),
(2855, '038116', '038100', 'Track Mounted Concrete Wall Sawing', NULL, 0, 0, 0, '2017-09-11 09:00:04', '2017-09-11 09:00:04'),
(2856, '038119', '038100', 'Wire Concrete Wall Sawing', NULL, 0, 0, 0, '2017-09-11 09:00:12', '2017-09-11 09:00:12'),
(2857, '038123', '038100', 'Hand Concrete Wall Sawing', NULL, 0, 0, 0, '2017-09-11 09:00:21', '2017-09-11 09:00:21'),
(2858, '038126', '038100', 'Chain Concrete Wall Sawing', NULL, 0, 0, 0, '2017-09-11 09:00:29', '2017-09-11 09:00:29'),
(2859, '038200', '038000', 'Concrete Boring', NULL, 0, 0, 0, '2017-09-11 09:00:49', '2017-09-11 09:00:49'),
(2860, '038213', '038200', 'Concrete Core Drilling', NULL, 0, 0, 0, '2017-09-11 09:00:57', '2017-09-11 09:00:57'),
(2861, '040120.41', '040120', 'Unit Masonry Stabilization', NULL, 0, 0, 0, '2017-09-11 09:01:48', '2017-09-11 09:01:48'),
(2862, '040120.51', '040120', 'Unit Masonry Maintenance', NULL, 0, 0, 0, '2017-09-11 09:01:57', '2017-09-11 09:01:57'),
(2863, '040120.52', '040120', 'Unit Masonry Cleaning', NULL, 0, 0, 0, '2017-09-11 09:02:04', '2017-09-11 09:02:04'),
(2864, '040140.51', '040140', 'Stone Maintenance', NULL, 0, 0, 0, '2017-09-11 09:07:48', '2017-09-11 09:07:48'),
(2865, '040140.52', '040140', 'Stone Cleaning', NULL, 0, 0, 0, '2017-09-11 09:07:58', '2017-09-11 09:07:58'),
(2866, '040140.91', '040140', 'Stone Restoration', NULL, 0, 0, 0, '2017-09-11 09:08:38', '2017-09-11 09:08:38'),
(2867, '062500', '062000', 'Prefinished Paneling', NULL, 0, 0, 0, '2017-09-11 09:14:09', '2017-09-11 09:14:09'),
(2868, '062513', '062500', 'Prefinished Hardboard Paneling', NULL, 0, 0, 0, '2017-09-11 09:14:27', '2017-09-11 09:14:27'),
(2869, '062516', '062500', 'Prefinished Plywood Paneling', NULL, 0, 0, 0, '2017-09-11 09:14:42', '2017-09-11 09:14:42'),
(2870, '062600', '062000', 'Board Paneling', NULL, 0, 0, 0, '2017-09-11 09:15:29', '2017-09-11 09:15:29'),
(2871, '062613', '062600', 'Profile Board Paneling', NULL, 0, 0, 0, '2017-09-11 09:15:43', '2017-09-11 09:15:43'),
(2872, '064000', '060000', 'Architectural Woodwork', NULL, 0, 0, 0, '2017-09-11 09:16:10', '2017-09-11 09:16:10'),
(2873, '064013', '064000', 'Exterior Architectural Woodwork', NULL, 0, 0, 0, '2017-09-11 09:17:06', '2017-09-11 09:17:06'),
(2874, '064023', '064000', 'Interior Architectural Woodwork', NULL, 0, 0, 0, '2017-09-11 09:17:14', '2017-09-11 09:17:14'),
(2875, '064100', '064000', 'Architectural Wood Casework', NULL, 0, 0, 0, '2017-09-11 09:22:44', '2017-09-11 09:22:44'),
(2876, '064113', '064100', 'Wood-Veneer-Faced Architectural Cabinets', NULL, 0, 0, 0, '2017-09-11 09:23:02', '2017-09-11 09:23:02'),
(2877, '064116', '064100', 'Plastic-Laminate-Clad Architectural Cabinets', NULL, 0, 0, 0, '2017-09-11 09:23:13', '2017-09-11 09:23:13'),
(2878, '064193', '064100', 'Cabinet and Drawer Hardware', NULL, 0, 0, 0, '2017-09-11 09:23:22', '2017-09-11 09:23:22'),
(2879, '064200', '064000', 'Wood Paneling', NULL, 0, 0, 0, '2017-09-11 09:23:58', '2017-09-11 09:23:58'),
(2880, '064213', '064200', 'Wood Board Paneling', NULL, 0, 0, 0, '2017-09-11 09:24:12', '2017-09-11 09:24:12'),
(2881, '064214', '064200', 'Stile and Rail Wood Paneling', NULL, 0, 0, 0, '2017-09-11 09:24:24', '2017-09-11 09:24:24'),
(2882, '064300', '064000', 'Wood Stairs and Railings', NULL, 0, 0, 0, '2017-09-11 09:35:55', '2017-09-11 09:35:55'),
(2883, '064400', '064000', 'Ornamental Woodwork', NULL, 0, 0, 0, '2017-09-11 09:39:13', '2017-09-11 09:39:13'),
(2884, '064413', '064400', 'Wood Turnings', NULL, 0, 0, 0, '2017-09-11 09:40:47', '2017-09-11 09:40:47'),
(2885, '064416', '064400', 'Wood Pilasters', NULL, 0, 0, 0, '2017-09-11 09:41:09', '2017-09-11 09:41:09'),
(2886, '064419', '064400', 'Wood Grilles', NULL, 0, 0, 0, '2017-09-11 09:41:19', '2017-09-11 09:41:19'),
(2887, '064423', '064400', 'Wood Corbels', NULL, 0, 0, 0, '2017-09-11 09:42:02', '2017-09-11 09:42:02'),
(2888, '064426', '064400', 'Wood Cupolas', NULL, 0, 0, 0, '2017-09-11 09:43:27', '2017-09-11 09:43:27'),
(2889, '064429', '064400', 'Wood Finials', NULL, 0, 0, 0, '2017-09-11 09:43:34', '2017-09-11 09:43:34'),
(2890, '064433', '064400', 'Wood Mantels', NULL, 0, 0, 0, '2017-09-11 09:43:42', '2017-09-11 09:43:42'),
(2891, '064436', '064400', 'Wood Pediment Heads', NULL, 0, 0, 0, '2017-09-11 09:43:49', '2017-09-11 09:43:49'),
(2892, '064439', '064400', 'Wood Posts and Columns', NULL, 0, 0, 0, '2017-09-11 09:44:05', '2017-09-11 09:44:05'),
(2893, '064600', '064000', 'Wood Trim', NULL, 0, 0, 0, '2017-09-11 09:44:20', '2017-09-11 09:44:20'),
(2894, '064613', '064600', 'Wood Door and Window Casings', NULL, 0, 0, 0, '2017-09-11 09:44:30', '2017-09-11 09:44:30'),
(2895, '064616', '064600', 'Wood Aprons', NULL, 0, 0, 0, '2017-09-11 09:48:04', '2017-09-11 09:48:04'),
(2896, '064623', '064600', 'Wood Chair Rails', NULL, 0, 0, 0, '2017-09-11 09:48:23', '2017-09-11 09:48:23'),
(2897, '064626', '064600', 'Wood Cornices', NULL, 0, 0, 0, '2017-09-11 09:48:32', '2017-09-11 09:48:32'),
(2898, '064629', '064600', 'Wood Fasciae and Soffits', NULL, 0, 0, 0, '2017-09-11 09:49:10', '2017-09-11 09:49:10'),
(2899, '064633', '064600', 'Wood Stops, Stools, and Sills', NULL, 0, 0, 0, '2017-09-11 09:49:18', '2017-09-11 09:49:18'),
(2900, '064691', '064600', 'Splicing of Wooden Components', NULL, 0, 0, 0, '2017-09-11 09:49:24', '2017-09-11 09:49:24'),
(2901, '064800', '064000', 'Wood Frames', NULL, 0, 0, 0, '2017-09-11 09:49:57', '2017-09-11 09:49:57'),
(2902, '064813', '064800', 'Exterior Wood Door Frames', NULL, 0, 0, 0, '2017-09-11 09:50:05', '2017-09-11 09:50:05'),
(2903, '064816', '064800', 'Interior Wood Door Frames', NULL, 0, 0, 0, '2017-09-11 09:50:12', '2017-09-11 09:50:12'),
(2904, '064823', '064800', 'Stick-Built Wood Windows', NULL, 0, 0, 0, '2017-09-11 09:50:18', '2017-09-11 09:50:18'),
(2905, '064826', '064800', 'Wood-Veneer Frames', NULL, 0, 0, 0, '2017-09-11 09:50:24', '2017-09-11 09:50:24'),
(2906, '064900', '064000', 'Wood Screens and Shutters', NULL, 0, 0, 0, '2017-09-11 09:50:32', '2017-09-11 09:50:32'),
(2907, '064913', '064900', 'Wood Screens', NULL, 0, 0, 0, '2017-09-11 09:50:40', '2017-09-11 09:50:40'),
(2908, '064916', '064900', 'Wood Blinds', NULL, 0, 0, 0, '2017-09-11 09:50:46', '2017-09-11 09:50:46'),
(2909, '064919', '064900', 'Wood Shutters', NULL, 0, 0, 0, '2017-09-11 09:50:53', '2017-09-11 09:50:53'),
(2910, '065000', '060000', 'Structural Plastics', NULL, 0, 0, 0, '2017-09-11 09:51:02', '2017-09-11 09:51:02'),
(2911, '065100', '065000', 'Structural Plastic Shapes and Plates', NULL, 0, 0, 0, '2017-09-11 09:51:09', '2017-09-11 09:51:09'),
(2912, '065113', '065100', 'Plastic Lumber', NULL, 0, 0, 0, '2017-09-11 09:51:16', '2017-09-11 09:51:16'),
(2913, '065200', '065000', 'Plastic Structural Assemblies', NULL, 0, 0, 0, '2017-09-11 09:51:23', '2017-09-11 09:51:23'),
(2914, '065300', '065000', 'Plastic Decking', NULL, 0, 0, 0, '2017-09-11 09:51:29', '2017-09-11 09:51:29'),
(2915, '065313', '065300', 'Solid Plastic Decking', NULL, 0, 0, 0, '2017-09-11 09:51:36', '2017-09-11 09:51:36'),
(2916, '066000', '060000', 'Plastic Fabrications', NULL, 0, 0, 0, '2017-09-11 09:52:51', '2017-09-11 09:52:51'),
(2917, '066100', '066000', 'Cast Polymer Fabrications', NULL, 0, 0, 0, '2017-09-11 09:53:04', '2017-09-11 09:53:04'),
(2918, '066113', '066100', 'Simulated Stone Fabrications', NULL, 0, 0, 0, '2017-09-11 09:53:18', '2017-09-11 09:53:18'),
(2919, '066116', '066100', 'Solid Surfacing Fabrications', NULL, 0, 0, 0, '2017-09-11 09:53:32', '2017-09-11 09:53:32'),
(2920, '066300', '066000', 'Plastic Railings', NULL, 0, 0, 0, '2017-09-11 09:53:39', '2017-09-11 09:53:39'),
(2921, '066400', '066000', 'Plastic Paneling', NULL, 0, 0, 0, '2017-09-11 09:54:15', '2017-09-11 09:54:15'),
(2922, '066413', '066400', 'Plastic Lattice Paneling', NULL, 0, 0, 0, '2017-09-11 09:54:35', '2017-09-11 09:54:35'),
(2923, '066500', '066000', 'Plastic Trim', NULL, 0, 0, 0, '2017-09-11 09:55:37', '2017-09-11 09:55:37'),
(2924, '067000', '060000', 'Structural Composites', NULL, 0, 0, 0, '2017-09-11 10:03:13', '2017-09-11 10:03:13'),
(2925, '067100', '067000', 'Structural Composite Shapes and Plates', NULL, 0, 0, 0, '2017-09-11 10:03:20', '2017-09-11 10:03:20'),
(2926, '067113', '067100', 'Composite Lumber', NULL, 0, 0, 0, '2017-09-11 10:03:26', '2017-09-11 10:03:26'),
(2927, '067200', '067000', 'Composite Structural Assemblies', NULL, 0, 0, 0, '2017-09-11 10:03:33', '2017-09-11 10:03:33'),
(2928, '067213', '067200', 'Composite Joist Assemblies', NULL, 0, 0, 0, '2017-09-11 10:03:39', '2017-09-11 10:03:39'),
(2929, '067223', '067200', 'Composite Stair Assemblies', NULL, 0, 0, 0, '2017-09-11 10:03:45', '2017-09-11 10:03:45'),
(2930, '067300', '067000', 'Composite Decking', NULL, 0, 0, 0, '2017-09-11 10:03:51', '2017-09-11 10:03:51'),
(2931, '067313', '067300', 'Composite Structural Decking', NULL, 0, 0, 0, '2017-09-11 10:03:59', '2017-09-11 10:03:59'),
(2932, '067400', '067000', 'Composite Gratings', NULL, 0, 0, 0, '2017-09-11 10:04:06', '2017-09-11 10:04:06'),
(2933, '067413', '067400', 'Fiberglass Reinforced Gratings', NULL, 0, 0, 0, '2017-09-11 10:04:13', '2017-09-11 10:04:13'),
(2934, '068000', '060000', 'Composite Fabrications', NULL, 0, 0, 0, '2017-09-11 10:04:25', '2017-09-11 10:04:25'),
(2935, '068100', '068000', 'Composite Railings', NULL, 0, 0, 0, '2017-09-11 10:04:35', '2017-09-11 10:04:35'),
(2936, '068113', '068100', 'Glass-Fiber-Reinforced Plastic Railings', NULL, 0, 0, 0, '2017-09-11 10:04:42', '2017-09-11 10:04:42'),
(2937, '068200', '068000', 'Composite Trim', NULL, 0, 0, 0, '2017-09-11 10:05:53', '2017-09-11 10:05:53'),
(2938, '068300', '068000', 'Composite Paneling', NULL, 0, 0, 0, '2017-09-11 10:05:59', '2017-09-11 10:05:59'),
(2939, '068313', '068300', 'Resin Composite Paneling', NULL, 0, 0, 0, '2017-09-11 10:06:04', '2017-09-11 10:06:04'),
(2940, '068316', '068300', 'Fiberglass Reinforced Paneling', NULL, 0, 0, 0, '2017-09-11 10:06:09', '2017-09-11 10:06:09'),
(2942, '100000', '0', 'Specialties', NULL, 0, 0, 0, '2017-09-11 10:06:55', '2017-09-11 10:06:55'),
(2943, '070000', '0', 'Thermal and Moisture Protection', NULL, 0, 0, 0, '2017-09-11 10:11:17', '2017-09-11 10:11:17'),
(2944, '070100', '070000', 'Operation and Maintenance of Thermal and Moisture Protection', NULL, 0, 0, 0, '2017-09-11 10:11:29', '2017-09-11 10:11:29'),
(2945, '070110', '070100', 'Maintenance of Dampproofing and Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:11:42', '2017-09-11 10:11:42'),
(2947, '070110.81', '070110', 'Waterproofing Replacement', NULL, 0, 0, 0, '2017-09-11 10:11:57', '2017-09-11 10:11:57'),
(2948, '070120', '070100', 'Maintenance of Thermal Protection', NULL, 0, 0, 0, '2017-09-11 10:12:07', '2017-09-11 10:12:07'),
(2949, '070130', '070100', 'Maintenance of Steep Slope Roofing', NULL, 0, 0, 0, '2017-09-11 10:12:14', '2017-09-11 10:12:14'),
(2950, '070140', '070100', 'Maintenance of Roofing and Siding Panels', NULL, 0, 0, 0, '2017-09-11 10:12:22', '2017-09-11 10:12:22'),
(2953, '070150', '070100', 'Maintenance of Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 10:13:47', '2017-09-11 10:13:47'),
(2954, '070150.13', '070150', 'Roof Moisture Survey', NULL, 0, 0, 0, '2017-09-11 10:13:55', '2017-09-11 10:13:55'),
(2955, '070150.16', '070150', 'Roof Maintenance Program', NULL, 0, 0, 0, '2017-09-11 10:14:04', '2017-09-11 10:14:04'),
(2956, '070150.19', '070150', 'Preparation for Re-Roofing', NULL, 0, 0, 0, '2017-09-11 10:14:18', '2017-09-11 10:14:18'),
(2957, '070150.23', '070150', 'Roof Removal', NULL, 0, 0, 0, '2017-09-11 10:14:28', '2017-09-11 10:14:28'),
(2958, '070150.61', '070150', 'Roof Re-Coating', NULL, 0, 0, 0, '2017-09-11 10:14:37', '2017-09-11 10:14:37'),
(2959, '070150.81', '070150', 'Roof Replacement', NULL, 0, 0, 0, '2017-09-11 10:14:45', '2017-09-11 10:14:45'),
(2960, '070150.91', '070150', 'Roofing Restoration', NULL, 0, 0, 0, '2017-09-11 10:14:53', '2017-09-11 10:14:53'),
(2961, '070160', '070100', 'Maintenance of Flashing and Sheet Metal', NULL, 0, 0, 0, '2017-09-11 10:15:01', '2017-09-11 10:15:01'),
(2962, '07016071', '070160', 'Flashing and Sheet Metal Rehabilitation', NULL, 0, 0, 0, '2017-09-11 10:15:08', '2017-09-11 10:15:08'),
(2963, '07016091', '070160', 'Flashing and Sheet Metal Restoration', NULL, 0, 0, 0, '2017-09-11 10:15:13', '2017-09-11 10:15:13'),
(2964, '07016092', '070160', 'Flashing and Sheet Metal Preservation', NULL, 0, 0, 0, '2017-09-11 10:15:19', '2017-09-11 10:15:19'),
(2965, '070170', '070100', 'Operation and Maintenance of Roof Specialties and Accessories', NULL, 0, 0, 0, '2017-09-11 10:15:30', '2017-09-11 10:15:30'),
(2966, '070180', '070100', 'Maintenance of Fire and Smoke Protection', NULL, 0, 0, 0, '2017-09-11 10:15:42', '2017-09-11 10:15:42'),
(2967, '070190', '070100', 'Maintenance of Joint Protection', NULL, 0, 0, 0, '2017-09-11 10:15:47', '2017-09-11 10:15:47'),
(2968, '070190.71', '070190', 'Joint Sealant Rehabilitation', NULL, 0, 0, 0, '2017-09-11 10:15:55', '2017-09-11 10:15:55'),
(2969, '070190.81', '070190', 'Joint Sealant Replacement', NULL, 0, 0, 0, '2017-09-11 10:16:07', '2017-09-11 10:16:07'),
(2970, '070300', '070000', 'Conservation Treatment for Period Roofing', NULL, 0, 0, 0, '2017-09-11 10:16:23', '2017-09-11 10:16:23'),
(2971, '070330', '070300', 'Conservation Treatment for Period Steep Slope Roofing', NULL, 0, 0, 0, '2017-09-11 10:16:32', '2017-09-11 10:16:32'),
(2972, '070330.13', '070330', 'Conservation Treatment for Period Canvas Roofing', NULL, 0, 0, 0, '2017-09-11 10:16:44', '2017-09-11 10:16:44'),
(2973, '070330.16', '070330', 'Conservation Treatment for Period Board Roofing', NULL, 0, 0, 0, '2017-09-11 10:16:55', '2017-09-11 10:16:55'),
(2974, '070331', '070300', 'Conservation Treatment for Period Shingles and Shakes', NULL, 0, 0, 0, '2017-09-11 10:18:24', '2017-09-11 10:18:24'),
(2975, '070331.16', '070331', 'Conservation Treatment for Period Metal Shingles', NULL, 0, 0, 0, '2017-09-11 10:18:35', '2017-09-11 10:18:35'),
(2976, '070331.26', '070331', 'Conservation Treatment for Period Slate Shingles', NULL, 0, 0, 0, '2017-09-11 10:18:48', '2017-09-11 10:18:48'),
(2977, '070331.29', '070331', 'Conservation Treatment for Period Wood Shingles and Shakes', NULL, 0, 0, 0, '2017-09-11 10:18:58', '2017-09-11 10:18:58'),
(2978, '070332', '070300', 'Conservation Treatment for Period Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:19:07', '2017-09-11 10:19:07'),
(2979, '070332.13', '070332', 'Conservation Treatment for Period Clay Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:19:19', '2017-09-11 10:19:19'),
(2980, '070332.16', '070332', 'Conservation Treatment for Period Concrete Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:19:31', '2017-09-11 10:19:31'),
(2981, '070332.19', '070332', 'Conservation Treatment for Period Metal Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:19:45', '2017-09-11 10:19:45'),
(2982, '070333', '070300', 'Conservation Treatment for Period Natural Roof Coverings', NULL, 0, 0, 0, '2017-09-11 10:19:54', '2017-09-11 10:19:54'),
(2983, '070333.13', '070333', 'Conservation Treatment for Period Sod Roofing', NULL, 0, 0, 0, '2017-09-11 10:20:05', '2017-09-11 10:20:05'),
(2984, '070340', '070300', 'Conservation Treatment for Period Roofing and Siding Panels', NULL, 0, 0, 0, '2017-09-11 10:21:36', '2017-09-11 10:21:36'),
(2985, '070341', '070300', 'Conservative Treatment for Period Roof Panels', NULL, 0, 0, 0, '2017-09-11 10:21:44', '2017-09-11 10:21:44'),
(2986, '070341.13', '070341', 'Conservation Treatment for Period Metal Roof Panels', NULL, 0, 0, 0, '2017-09-11 10:21:55', '2017-09-11 10:21:55'),
(2987, '070341.23', '070341', 'Conservation Treatment for Period Wood Roof Panels', NULL, 0, 0, 0, '2017-09-11 10:22:06', '2017-09-11 10:22:06'),
(2988, '070346', '070300', 'Conservation Treatment for Period Wood Siding', NULL, 0, 0, 0, '2017-09-11 10:22:15', '2017-09-11 10:22:15'),
(2989, '070360', '070300', 'Conservation Treatment of Period Flashing and Sheet Metal', NULL, 0, 0, 0, '2017-09-11 10:22:26', '2017-09-11 10:22:26'),
(2990, '070361', '070300', 'Conservation Treatment for Period Sheet Metal Roofing', NULL, 0, 0, 0, '2017-09-11 10:22:42', '2017-09-11 10:22:42'),
(2991, '070361.13', '070361', 'Conservation Treatment for Pe riod Standing Seam Sheet Metal Roofing', NULL, 0, 0, 0, '2017-09-11 10:22:53', '2017-09-11 10:22:53'),
(2992, '070361.16', '070361', 'Conservation Treatment for Period Batten Seam Sheet Metal Roofing', NULL, 0, 0, 0, '2017-09-11 10:23:08', '2017-09-11 10:23:08'),
(2993, '070361.19', '070361', 'Conservation Treatment for Period Flat Seam Sheet Metal Roofing', NULL, 0, 0, 0, '2017-09-11 10:23:18', '2017-09-11 10:23:18'),
(2994, '070500', '070000', 'Common Work Results for Thermal and Moisture  Protection', NULL, 0, 0, 0, '2017-09-11 10:24:00', '2017-09-11 10:24:00'),
(2995, '070505', '070500', 'Selective Demolition for Thermal and Moisture Protection', NULL, 0, 0, 0, '2017-09-11 10:24:09', '2017-09-11 10:24:09'),
(2996, '070543', '070500', 'Cladding Support Systems', NULL, 0, 0, 0, '2017-09-11 10:24:17', '2017-09-11 10:24:17'),
(2997, '070553', '070500', 'Fire and Smoke Assembly Identification', NULL, 0, 0, 0, '2017-09-11 10:24:25', '2017-09-11 10:24:25'),
(2998, '070600', '070000', 'Schedules for Thermal and Moisture Protection', NULL, 0, 0, 0, '2017-09-11 10:24:36', '2017-09-11 10:24:36'),
(2999, '070610', '070600', 'Schedules for Dampproofing and Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:24:44', '2017-09-11 10:24:44'),
(3000, '070620', '070600', 'Schedules for Thermal Protection', NULL, 0, 0, 0, '2017-09-11 10:24:51', '2017-09-11 10:24:51'),
(3001, '070630', '070600', 'Schedules for Steep Slope Roofing', NULL, 0, 0, 0, '2017-09-11 10:24:59', '2017-09-11 10:24:59'),
(3002, '070640', '070600', 'Schedules for Roofing and Siding Panels', NULL, 0, 0, 0, '2017-09-11 10:25:06', '2017-09-11 10:25:06'),
(3003, '070650', '070600', 'Schedules for Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 10:25:51', '2017-09-11 10:25:51'),
(3004, '070660', '070600', 'Schedules for Flashing and Sheet Metal', NULL, 0, 0, 0, '2017-09-11 10:26:00', '2017-09-11 10:26:00'),
(3005, '070670', '070600', 'Schedules for Roof Specialties and Accessories', NULL, 0, 0, 0, '2017-09-11 10:26:08', '2017-09-11 10:26:08'),
(3008, '070680', '070600', 'Schedules for Fire and Smoke Protection', NULL, 0, 0, 0, '2017-09-11 10:27:45', '2017-09-11 10:27:45'),
(3009, '070680.13', '070680', 'Fireproofing Schedule', NULL, 0, 0, 0, '2017-09-11 10:27:54', '2017-09-11 10:27:54'),
(3010, '070680.16', '070680', 'Firestopping Schedule', NULL, 0, 0, 0, '2017-09-11 10:28:06', '2017-09-11 10:28:06'),
(3011, '070690', '070600', 'Schedules for Joint Protection', NULL, 0, 0, 0, '2017-09-11 10:28:15', '2017-09-11 10:28:15'),
(3012, '070690.13', '070690', 'Joint Sealant Schedule', NULL, 0, 0, 0, '2017-09-11 10:28:24', '2017-09-11 10:28:24'),
(3013, '070800', '070000', 'Commissioning of The rmal and Moisture Protection', NULL, 0, 0, 0, '2017-09-11 10:28:35', '2017-09-11 10:28:35'),
(3014, '071000', '070000', 'Damproofing and Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:28:46', '2017-09-11 10:28:46'),
(3015, '071100', '071000', 'Dampproofing', NULL, 0, 0, 0, '2017-09-11 10:28:54', '2017-09-11 10:28:54'),
(3016, '071113', '071100', 'Bituminous Dampproofing', NULL, 0, 0, 0, '2017-09-11 10:29:17', '2017-09-11 10:29:17'),
(3017, '071116', '071100', 'Cementitious Dampproofing', NULL, 0, 0, 0, '2017-09-11 10:29:26', '2017-09-11 10:29:26'),
(3018, '071119', '071100', 'Sheet Dampproofing', NULL, 0, 0, 0, '2017-09-11 10:29:33', '2017-09-11 10:29:33'),
(3019, '071300', '071000', 'Built-Up Bituminous Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:33:43', '2017-09-11 10:33:43'),
(3020, '071326', '071300', 'Self-Adhering Sheet Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:33:53', '2017-09-11 10:33:53'),
(3021, '071333', '071300', 'Bituminous Sheet Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:34:01', '2017-09-11 10:34:01'),
(3022, '071352', '071300', 'Elastomeric Sheet Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:34:11', '2017-09-11 10:34:11'),
(3023, '071354', '071300', 'Thermoplastic Sheet Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:34:19', '2017-09-11 10:34:19'),
(3024, '071400', '071000', 'Fluid-Applied Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:34:42', '2017-09-11 10:34:42'),
(3025, '071413', '071400', 'Hot Fluid-Applied Rubberized Asphalt Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:34:50', '2017-09-11 10:34:50'),
(3026, '071414', '071400', 'Hot Fluid-Applied Polyurea Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:34:57', '2017-09-11 10:34:57'),
(3027, '071416', '071400', 'Cold Fluid-Applied Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:35:06', '2017-09-11 10:35:06'),
(3028, '071500', '071000', 'Sheet Metal Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:36:07', '2017-09-11 10:36:07'),
(3029, '071513', '071500', 'Sheet Lead Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:36:18', '2017-09-11 10:36:18'),
(3030, '071600', '071000', 'Cementitious and Reactive Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:36:27', '2017-09-11 10:36:27'),
(3031, '071613', '071600', 'Polymer Modified Cement Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:36:35', '2017-09-11 10:36:35'),
(3032, '071616', '071600', 'Crystalline Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:36:42', '2017-09-11 10:36:42'),
(3033, '071619', '071600', 'Metal Oxide Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:36:50', '2017-09-11 10:36:50'),
(3034, '071700', '071000', 'Bentonite Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:37:01', '2017-09-11 10:37:01'),
(3035, '071713', '071700', 'Bentonite Panel Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:37:09', '2017-09-11 10:37:09'),
(3036, '071716', '071700', 'Bentonite Composite Sheet Waterproofing', NULL, 0, 0, 0, '2017-09-11 10:37:15', '2017-09-11 10:37:15'),
(3037, '071800', '071000', 'Traffic Coatings', NULL, 0, 0, 0, '2017-09-11 10:37:24', '2017-09-11 10:37:24'),
(3038, '071813', '071800', 'Pedestrian Traffic Coatings', NULL, 0, 0, 0, '2017-09-11 10:38:26', '2017-09-11 10:38:26'),
(3039, '071816', '071800', 'Vehicular Traffic Coatings', NULL, 0, 0, 0, '2017-09-11 10:38:34', '2017-09-11 10:38:34'),
(3040, '071900', '071000', 'Water Repellents', NULL, 0, 0, 0, '2017-09-11 10:42:02', '2017-09-11 10:42:02'),
(3041, '071913', '071900', 'Acrylic Water Repellents', NULL, 0, 0, 0, '2017-09-11 10:42:10', '2017-09-11 10:42:10'),
(3042, '071916', '071900', 'Silane Water Repellents', NULL, 0, 0, 0, '2017-09-11 10:42:18', '2017-09-11 10:42:18'),
(3043, '071919', '071900', 'Silicone Water Repellents', NULL, 0, 0, 0, '2017-09-11 10:42:28', '2017-09-11 10:42:28'),
(3044, '071923', '071900', 'Siloxane Water Repellents', NULL, 0, 0, 0, '2017-09-11 10:42:49', '2017-09-11 10:42:49'),
(3045, '071926', '071900', 'Stearate Water Repellents', NULL, 0, 0, 0, '2017-09-11 10:42:58', '2017-09-11 10:42:58'),
(3046, '071929', '071900', 'Penetrating Polyester Water Repellents', NULL, 0, 0, 0, '2017-09-11 10:43:06', '2017-09-11 10:43:06'),
(3047, '072000', '070000', 'Thermal Protection', NULL, 0, 0, 0, '2017-09-11 10:43:31', '2017-09-11 10:43:31'),
(3048, '072100', '072000', 'Thermal Insulation', NULL, 0, 0, 0, '2017-09-11 10:43:42', '2017-09-11 10:43:42'),
(3049, '072113', '072100', 'Board Insulation', NULL, 0, 0, 0, '2017-09-11 10:43:50', '2017-09-11 10:43:50'),
(3050, '072113.13', '072113', 'Foam Board Insulation', NULL, 0, 0, 0, '2017-09-11 10:44:01', '2017-09-11 10:44:01'),
(3051, '072113.16', '072113', 'Fibrous Board Insulation', NULL, 0, 0, 0, '2017-09-11 10:44:12', '2017-09-11 10:44:12'),
(3052, '072113.19', '072113', 'Mineral Board Insulation', NULL, 0, 0, 0, '2017-09-11 10:44:21', '2017-09-11 10:44:21'),
(3053, '072116', '072100', 'Blanket Insulation', NULL, 0, 0, 0, '2017-09-11 10:45:04', '2017-09-11 10:45:04'),
(3054, '072119', '072100', 'Foamed-In-Place Insulation', NULL, 0, 0, 0, '2017-09-11 10:45:09', '2017-09-11 10:45:09'),
(3055, '072123', '072100', 'Loose-Fill Insulation', NULL, 0, 0, 0, '2017-09-11 10:45:15', '2017-09-11 10:45:15'),
(3056, '072126', '072100', 'Blown Insulation', NULL, 0, 0, 0, '2017-09-11 10:45:20', '2017-09-11 10:45:20'),
(3057, '072129', '072100', 'Sprayed Insulation', NULL, 0, 0, 0, '2017-09-11 10:45:26', '2017-09-11 10:45:26'),
(3058, '072153', '072100', 'Reflective Insulation', NULL, 0, 0, 0, '2017-09-11 10:45:34', '2017-09-11 10:45:34'),
(3059, '072200', '072000', 'Roof and Deck Insulation', NULL, 0, 0, 0, '2017-09-11 10:45:47', '2017-09-11 10:45:47'),
(3060, '072213', '072200', 'Asphaltic Perlite Concrete Deck', NULL, 0, 0, 0, '2017-09-11 10:45:54', '2017-09-11 10:45:54'),
(3061, '072216', '072200', 'Roof Board Insulation', NULL, 0, 0, 0, '2017-09-11 10:46:01', '2017-09-11 10:46:01'),
(3062, '072400', '072000', 'Exterior Insulati on and Finish Systems', NULL, 0, 0, 0, '2017-09-11 10:46:09', '2017-09-11 10:46:09'),
(3063, '072413', '072400', 'Polymer-Based Exterior Insulation and Finish System', NULL, 0, 0, 0, '2017-09-11 10:46:19', '2017-09-11 10:46:19'),
(3064, '072416', '072400', 'Polymer-Modified Exterior Insulation and Finish System', NULL, 0, 0, 0, '2017-09-11 10:46:25', '2017-09-11 10:46:25'),
(3065, '072419', '072400', 'Water-Drainage Exterior Insulation and Finish System', NULL, 0, 0, 0, '2017-09-11 10:46:34', '2017-09-11 10:46:34'),
(3066, '072423', '072400', 'Direct-Applied Finish Systems', NULL, 0, 0, 0, '2017-09-11 10:46:41', '2017-09-11 10:46:41'),
(3067, '072500', '072000', 'Weather Barriers', NULL, 0, 0, 0, '2017-09-11 10:47:30', '2017-09-11 10:47:30'),
(3068, '072600', '072000', 'Vapor Retarders', NULL, 0, 0, 0, '2017-09-11 10:47:38', '2017-09-11 10:47:38'),
(3069, '072613', '072600', 'Above-Grade Vapor Retarders', NULL, 0, 0, 0, '2017-09-11 10:47:45', '2017-09-11 10:47:45'),
(3070, '072616', '072600', 'Below-Grade Vapor Retarders', NULL, 0, 0, 0, '2017-09-11 10:47:50', '2017-09-11 10:47:50'),
(3071, '072623', '072600', 'Below-Grade Gas Retarders', NULL, 0, 0, 0, '2017-09-11 10:47:55', '2017-09-11 10:47:55'),
(3072, '072700', '072000', 'Air Barriers', NULL, 0, 0, 0, '2017-09-11 10:48:02', '2017-09-11 10:48:02'),
(3073, '072713', '072700', 'Modified Bituminous Sheet Air Barriers', NULL, 0, 0, 0, '2017-09-11 10:48:08', '2017-09-11 10:48:08'),
(3074, '072716', '072700', 'Sheet Metal Membrane Air Barriers', NULL, 0, 0, 0, '2017-09-11 10:48:14', '2017-09-11 10:48:14'),
(3075, '072719', '072700', 'Plastic Sheet Air Barriers', NULL, 0, 0, 0, '2017-09-11 10:48:20', '2017-09-11 10:48:20'),
(3076, '072723', '072700', 'Board Product Air Barriers', NULL, 0, 0, 0, '2017-09-11 10:48:27', '2017-09-11 10:48:27'),
(3077, '072726', '072700', 'Fluid-Applied Membrane Air Barriers', NULL, 0, 0, 0, '2017-09-11 10:48:33', '2017-09-11 10:48:33'),
(3078, '072736', '072700', 'Sprayed Foam Air Barrier', NULL, 0, 0, 0, '2017-09-11 10:48:38', '2017-09-11 10:48:38'),
(3079, '073000', '070000', 'Shingles, Roof Tiles, and Roof Coverings', NULL, 0, 0, 0, '2017-09-11 10:48:49', '2017-09-11 10:48:49'),
(3080, '073091', '073000', 'Canvas Roofing', NULL, 0, 0, 0, '2017-09-11 10:48:56', '2017-09-11 10:48:56'),
(3081, '073100', '073000', 'Shingles and Shakes', NULL, 0, 0, 0, '2017-09-11 10:49:05', '2017-09-11 10:49:05'),
(3082, '073113', '073100', 'Asphalt Shingles', NULL, 0, 0, 0, '2017-09-11 10:50:23', '2017-09-11 10:50:23'),
(3083, '073113.13', '073113', 'Fiberglass-Reinforced Asphalt Shingles', NULL, 0, 0, 0, '2017-09-11 10:50:32', '2017-09-11 10:50:32'),
(3084, '073116', '073100', 'Metal Shingles', NULL, 0, 0, 0, '2017-09-11 10:50:38', '2017-09-11 10:50:38'),
(3085, '073119', '073100', 'Mineral-Fiber Cement Shingles', NULL, 0, 0, 0, '2017-09-11 10:50:43', '2017-09-11 10:50:43'),
(3086, '073123', '073100', 'Porcelain Enamel Shingles', NULL, 0, 0, 0, '2017-09-11 10:50:50', '2017-09-11 10:50:50'),
(3087, '073126', '073100', 'Slate Shingles', NULL, 0, 0, 0, '2017-09-11 10:50:57', '2017-09-11 10:50:57'),
(3088, '073129', '073100', 'Wood Shingles and Shakes', NULL, 0, 0, 0, '2017-09-11 10:51:06', '2017-09-11 10:51:06'),
(3089, '073129.13', '073129', 'Wood Shingles', NULL, 0, 0, 0, '2017-09-11 10:51:21', '2017-09-11 10:51:21'),
(3090, '073129.16', '073129', 'Wood Shakes', NULL, 0, 0, 0, '2017-09-11 10:51:32', '2017-09-11 10:51:32'),
(3091, '073133', '073100', 'Composite Rubber Shingles', NULL, 0, 0, 0, '2017-09-11 10:53:51', '2017-09-11 10:53:51'),
(3092, '073153', '073100', 'Plastic Shakes', NULL, 0, 0, 0, '2017-09-11 10:53:58', '2017-09-11 10:53:58'),
(3093, '073200', '073000', 'Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:54:06', '2017-09-11 10:54:06'),
(3094, '073213', '073200', 'Clay Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:54:13', '2017-09-11 10:54:13'),
(3095, '073214', '073200', 'Ceramic and Porcelain Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:54:19', '2017-09-11 10:54:19');
INSERT INTO `wbs` (`id`, `code`, `parent_code`, `name`, `description`, `extension`, `status`, `quantify`, `created_at`, `updated_at`) VALUES
(3096, '073216', '073200', 'Concrete Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:54:29', '2017-09-11 10:54:29'),
(3097, '073300', '073000', 'Natural Roof Coverings', NULL, 0, 0, 0, '2017-09-11 10:57:30', '2017-09-11 10:57:30'),
(3098, '073219', '073200', 'Metal Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:57:38', '2017-09-11 10:57:38'),
(3099, '073223', '073200', 'Mineral-Fiber Cement Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:57:46', '2017-09-11 10:57:46'),
(3100, '073226', '073200', 'Plastic Roof Tiles', NULL, 0, 0, 0, '2017-09-11 10:57:54', '2017-09-11 10:57:54'),
(3101, '073229', '073200', 'Rubber Tiles/Panels', NULL, 0, 0, 0, '2017-09-11 10:58:02', '2017-09-11 10:58:02'),
(3102, '073313', '073300', 'Sod Roofing', NULL, 0, 0, 0, '2017-09-11 10:58:13', '2017-09-11 10:58:13'),
(3103, '073316', '073300', 'Thatched Roofing', NULL, 0, 0, 0, '2017-09-11 10:58:22', '2017-09-11 10:58:22'),
(3104, '073363', '073300', 'Vegetated Steep-Slope Roofing', NULL, 0, 0, 0, '2017-09-11 10:58:28', '2017-09-11 10:58:28'),
(3105, '074000', '070000', 'Roofing and Siding Panels', NULL, 0, 0, 0, '2017-09-11 11:01:24', '2017-09-11 11:01:24'),
(3106, '074100', '074000', 'Roof Panels', NULL, 0, 0, 0, '2017-09-11 11:01:33', '2017-09-11 11:01:33'),
(3107, '074116', '074100', 'Insulated Metal Roof Panels', NULL, 0, 0, 0, '2017-09-11 11:02:46', '2017-09-11 11:02:46'),
(3108, '074123', '074100', 'Wood Roof Panels', NULL, 0, 0, 0, '2017-09-11 11:03:05', '2017-09-11 11:03:05'),
(3109, '074133', '074100', 'Plastic Roof Panels', NULL, 0, 0, 0, '2017-09-11 11:03:15', '2017-09-11 11:03:15'),
(3110, '074143', '074100', 'Composite Roof Panels', NULL, 0, 0, 0, '2017-09-11 11:03:24', '2017-09-11 11:03:24'),
(3111, '074163', '074100', 'Fabricated Roof Panel Assemblies', NULL, 0, 0, 0, '2017-09-11 11:03:33', '2017-09-11 11:03:33'),
(3112, '074200', '074000', 'Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:03:58', '2017-09-11 11:03:58'),
(3113, '074213', '074200', 'Metal Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:04:08', '2017-09-11 11:04:08'),
(3114, '074213.13', '074213', 'Formed Metal Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:04:20', '2017-09-11 11:04:20'),
(3115, '074213.16', '074213', 'Metal Plate Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:04:41', '2017-09-11 11:04:41'),
(3116, '074213.19', '074213', 'Insulated Metal Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:04:56', '2017-09-11 11:04:56'),
(3117, '074213.23', '074213', 'Metal Composite Material Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:05:08', '2017-09-11 11:05:08'),
(3118, '074223', '074200', 'Wood Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:06:20', '2017-09-11 11:06:20'),
(3119, '074226', '074200', 'Tile Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:06:28', '2017-09-11 11:06:28'),
(3120, '074229', '074200', 'Terra Cotta Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:06:35', '2017-09-11 11:06:35'),
(3121, '074233', '074200', 'Plastic Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:06:44', '2017-09-11 11:06:44'),
(3122, '074243', '074200', 'Composite Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:06:52', '2017-09-11 11:06:52'),
(3123, '074246', '074200', 'Cementitious Wall Panels', NULL, 0, 0, 0, '2017-09-11 11:07:00', '2017-09-11 11:07:00'),
(3124, '074263', '074200', 'Fabricated Wall Panel Assemblies', NULL, 0, 0, 0, '2017-09-11 11:07:07', '2017-09-11 11:07:07'),
(3125, '074293', '074200', 'Soffit Panels', NULL, 0, 0, 0, '2017-09-11 11:07:13', '2017-09-11 11:07:13'),
(3126, '074400', '074000', 'Faced Panels', NULL, 0, 0, 0, '2017-09-11 11:07:21', '2017-09-11 11:07:21'),
(3127, '074413', '074400', 'Aggregate Coated Panels', NULL, 0, 0, 0, '2017-09-11 11:07:56', '2017-09-11 11:07:56'),
(3128, '074416', '074400', 'Porcelain Enameled Faced Panels', NULL, 0, 0, 0, '2017-09-11 11:08:02', '2017-09-11 11:08:02'),
(3129, '074419', '074400', 'Tile-Faced Panels', NULL, 0, 0, 0, '2017-09-11 11:08:10', '2017-09-11 11:08:10'),
(3130, '074423', '074400', 'Ceramic-Tile-Faced Panels', NULL, 0, 0, 0, '2017-09-11 11:08:26', '2017-09-11 11:08:26'),
(3131, '074433', '074400', 'Metal Faced Panels', NULL, 0, 0, 0, '2017-09-11 11:08:37', '2017-09-11 11:08:37'),
(3132, '074453', '074400', 'Glass-Fiber-Reinforced Cementitious Panels', NULL, 0, 0, 0, '2017-09-11 11:08:59', '2017-09-11 11:08:59'),
(3133, '074456', '074400', 'Mineral-Fiber-Reinforced Cementitious Panels', NULL, 0, 0, 0, '2017-09-11 11:09:07', '2017-09-11 11:09:07'),
(3134, '074463', '074400', 'Fabricated Faced Panel Assemblies', NULL, 0, 0, 0, '2017-09-11 11:09:14', '2017-09-11 11:09:14'),
(3135, '074600', '074000', 'Siding', NULL, 0, 0, 0, '2017-09-11 11:09:27', '2017-09-11 11:09:27'),
(3136, '074616', '074600', 'Aluminum Siding', NULL, 0, 0, 0, '2017-09-11 11:11:44', '2017-09-11 11:11:44'),
(3137, '074619', '074600', 'Steel Siding', NULL, 0, 0, 0, '2017-09-11 11:11:52', '2017-09-11 11:11:52'),
(3138, '074621', '074600', 'Zinc Siding', NULL, 0, 0, 0, '2017-09-11 11:11:59', '2017-09-11 11:11:59'),
(3139, '074623', '074600', 'Wood Siding', NULL, 0, 0, 0, '2017-09-11 11:12:08', '2017-09-11 11:12:08'),
(3140, '074624', '074600', 'Wood Shingle and Shake Siding', NULL, 0, 0, 0, '2017-09-11 11:12:22', '2017-09-11 11:12:22'),
(3141, '074624.13', '074624', 'Wood Shingle Siding', NULL, 0, 0, 0, '2017-09-11 11:12:34', '2017-09-11 11:12:34'),
(3142, '074624.16', '074624', 'Wood Shake Siding', NULL, 0, 0, 0, '2017-09-11 11:12:46', '2017-09-11 11:12:46'),
(3143, '074626', '074600', 'Hardboard Siding', NULL, 0, 0, 0, '2017-09-11 11:12:57', '2017-09-11 11:12:57'),
(3144, '074629', '074600', 'Plywood Siding', NULL, 0, 0, 0, '2017-09-11 11:13:06', '2017-09-11 11:13:06'),
(3145, '074633', '074600', 'Plastic Siding', NULL, 0, 0, 0, '2017-09-11 11:13:14', '2017-09-11 11:13:14'),
(3146, '074643', '074600', 'Composition Siding', NULL, 0, 0, 0, '2017-09-11 11:13:21', '2017-09-11 11:13:21'),
(3147, '074646', '074600', 'Fiber-Cement Siding', NULL, 0, 0, 0, '2017-09-11 11:13:30', '2017-09-11 11:13:30'),
(3148, '074663', '074600', 'Fabricated Panel Assemblies with Siding', NULL, 0, 0, 0, '2017-09-11 11:13:38', '2017-09-11 11:13:38'),
(3149, '075000', '070000', 'Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 11:13:50', '2017-09-11 11:13:50'),
(3150, '075100', '075000', 'Built-Up Bituminous Roofing', NULL, 0, 0, 0, '2017-09-11 11:13:58', '2017-09-11 11:13:58'),
(3151, '075113', '075100', 'Built-Up Asphalt Roofing', NULL, 0, 0, 0, '2017-09-11 11:14:07', '2017-09-11 11:14:07'),
(3152, '075113.13', '075113', 'Cold-Applied Built-Up Asphalt Roofing', NULL, 0, 0, 0, '2017-09-11 11:14:17', '2017-09-11 11:14:17'),
(3153, '075116', '075100', 'Built-Up Coal Tar Roofing', NULL, 0, 0, 0, '2017-09-11 11:14:26', '2017-09-11 11:14:26'),
(3154, '075123', '075100', 'Glass-Fiber-Reinforced Asphalt Emulsion Roofing', NULL, 0, 0, 0, '2017-09-11 11:14:33', '2017-09-11 11:14:33'),
(3155, '075200', '075000', 'Modified Bituminous Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 11:14:55', '2017-09-11 11:14:55'),
(3156, '075213', '075200', 'Atactic-Polypropylene-Modified Bituminous Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 11:15:04', '2017-09-11 11:15:04'),
(3157, '075213.11', '075213', 'Cold Adhesive Applied Atactic-Polypropylene-Modified Bituminous Membrane  Roofing', NULL, 0, 0, 0, '2017-09-11 11:15:15', '2017-09-11 11:15:15'),
(3158, '075213.13', '075213', 'Torch-Applied Atactic-Polypropylene-Modified Bituminous Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 11:15:28', '2017-09-11 11:15:28'),
(3159, '075216', '075200', 'Styrene-Butadiene-Styrene Modified Bituminous Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 11:15:40', '2017-09-11 11:15:40'),
(3160, '075216.11', '075216', 'Cold Adhesive Styrene-Butadiene-Styrene Modified Bituminous Membrane  Roofing', NULL, 0, 0, 0, '2017-09-11 11:16:11', '2017-09-11 11:16:11'),
(3161, '075216.12', '075216', 'Hot-Mopped Styrene-Butadiene-Styrene Modified Bituminous Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 11:16:23', '2017-09-11 11:16:23'),
(3162, '075216.13', '075216', 'Torch-Applied Styrene-Butadiene-Styrene Modified Bituminous Membrane  Roofing', NULL, 0, 0, 0, '2017-09-11 11:16:38', '2017-09-11 11:16:38'),
(3163, '075216.14', '075216', 'Mechanically Fastened Styrene-Butadiene-Styrene Modified Bituminous  Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 11:16:49', '2017-09-11 11:16:49'),
(3164, '075300', '075000', 'Elastomeric Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 11:17:04', '2017-09-11 11:17:04'),
(3165, '075313', '075300', 'Chlorinated-Polyethylene Roofing', NULL, 0, 0, 0, '2017-09-11 11:17:12', '2017-09-11 11:17:12'),
(3166, '075316', '075300', 'Chlorosulfonate-Polyethylene Roofing', NULL, 0, 0, 0, '2017-09-11 11:17:24', '2017-09-11 11:17:24'),
(3167, '075323', '075300', 'Ethylene-Propylene-Diene-Monomer Roofing', NULL, 0, 0, 0, '2017-09-11 11:17:33', '2017-09-11 11:17:33'),
(3168, '075329', '075300', 'Polyisobutylene Roofing', NULL, 0, 0, 0, '2017-09-11 11:17:40', '2017-09-11 11:17:40'),
(3169, '075400', '075000', 'Thermoplastic Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 12:54:49', '2017-09-11 12:54:49'),
(3171, '075500', '075000', 'Protected Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 12:59:04', '2017-09-11 12:59:04'),
(3172, '075551', '075500', 'Built-Up Bituminous Protected Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 12:59:12', '2017-09-11 12:59:12'),
(3173, '075552', '075500', 'Modified Bituminous Protected Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 12:59:21', '2017-09-11 12:59:21'),
(3174, '075553', '075500', 'Elastomeric Protected Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 12:59:31', '2017-09-11 12:59:31'),
(3175, '075554', '075500', 'Thermoplastic Protected Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 12:59:38', '2017-09-11 12:59:38'),
(3176, '075556', '075500', 'Fluid-Applied Protected Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 12:59:46', '2017-09-11 12:59:46'),
(3177, '075556.13', '075556', 'Hot-Applied Rubberized Asphalt Protected Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 12:59:56', '2017-09-11 12:59:56'),
(3178, '075563', '075500', 'Vegetated Protected Membrane Roofing', NULL, 0, 0, 0, '2017-09-11 13:00:03', '2017-09-11 13:00:03'),
(3179, '075600', '075000', 'Fluid-Applied Roofing', NULL, 0, 0, 0, '2017-09-11 13:00:11', '2017-09-11 13:00:11'),
(3180, '075700', '075000', 'Coated Foamed Roofing', NULL, 0, 0, 0, '2017-09-11 13:00:20', '2017-09-11 13:00:20'),
(3181, '075713', '075700', 'Sprayed Polyurethane Foam Roofing', NULL, 0, 0, 0, '2017-09-11 13:00:27', '2017-09-11 13:00:27'),
(3182, '075800', '075000', 'Roll Roofing', NULL, 0, 0, 0, '2017-09-11 13:00:34', '2017-09-11 13:00:34'),
(3183, '076000', '070000', 'Flashing and Sheet Metal', NULL, 0, 0, 0, '2017-09-11 13:00:42', '2017-09-11 13:00:42'),
(3184, '076100', '076000', 'Sheet Metal Roofing', NULL, 0, 0, 0, '2017-09-11 13:00:49', '2017-09-11 13:00:49'),
(3185, '076113', '076100', 'Standing Seam Sheet Metal Roofing', NULL, 0, 0, 0, '2017-09-11 13:00:56', '2017-09-11 13:00:56'),
(3186, '076116', '076100', 'Batten Seam Sheet Metal Roofing', NULL, 0, 0, 0, '2017-09-11 13:01:03', '2017-09-11 13:01:03'),
(3187, '076119', '076100', 'Flat Seam Sheet Metal Roofing', NULL, 0, 0, 0, '2017-09-11 13:01:11', '2017-09-11 13:01:11'),
(3188, '076200', '076000', 'Sheet Metal Flashing and Trim', NULL, 0, 0, 0, '2017-09-11 13:01:47', '2017-09-11 13:01:47'),
(3189, '076300', '076000', 'Sheet Metal Roofing Specialties', NULL, 0, 0, 0, '2017-09-11 13:01:56', '2017-09-11 13:01:56'),
(3190, '076400', '076000', 'Sheet Metal Wall Cladding', NULL, 0, 0, 0, '2017-09-11 13:02:05', '2017-09-11 13:02:05'),
(3191, '076413', '076400', 'Standing Seam Sheet Metal Wall Cladding', NULL, 0, 0, 0, '2017-09-11 13:02:12', '2017-09-11 13:02:12'),
(3192, '076416', '076400', 'Batten Seam Sheet Metal Wall Cladding', NULL, 0, 0, 0, '2017-09-11 13:02:20', '2017-09-11 13:02:20'),
(3193, '076419', '076400', 'Flat Seam Sheet Metal Wall Cladding', NULL, 0, 0, 0, '2017-09-11 13:02:26', '2017-09-11 13:02:26'),
(3194, '076500', '076000', 'Flexible Flashing', NULL, 0, 0, 0, '2017-09-11 13:02:37', '2017-09-11 13:02:37'),
(3195, '076513', '076500', 'Laminated Sheet Flashing', NULL, 0, 0, 0, '2017-09-11 13:02:45', '2017-09-11 13:02:45'),
(3196, '076516', '076500', 'Modified Bituminous Sheet Flashing', NULL, 0, 0, 0, '2017-09-11 13:02:59', '2017-09-11 13:02:59'),
(3197, '076519', '076500', 'Plastic Sheet Flashing', NULL, 0, 0, 0, '2017-09-11 13:03:10', '2017-09-11 13:03:10'),
(3198, '076523', '076500', 'Rubber Sheet Flashing', NULL, 0, 0, 0, '2017-09-11 13:03:17', '2017-09-11 13:03:17'),
(3199, '076526', '076500', 'Self-Adhering Sheet Flashing', NULL, 0, 0, 0, '2017-09-11 13:04:59', '2017-09-11 13:04:59'),
(3200, '077000', '070000', 'Roof and Wall Specialties and  Accessories', NULL, 0, 0, 0, '2017-09-11 13:07:08', '2017-09-11 13:07:08'),
(3201, '077100', '077000', 'Roof Specialties', NULL, 0, 0, 0, '2017-09-11 13:07:15', '2017-09-11 13:07:15'),
(3202, '077113', '077100', 'Manufactured Copings', NULL, 0, 0, 0, '2017-09-11 13:07:22', '2017-09-11 13:07:22'),
(3203, '077116', '077100', 'Manufactured Counterflashing Systems', NULL, 0, 0, 0, '2017-09-11 13:07:28', '2017-09-11 13:07:28'),
(3204, '077119', '077100', 'Manufactured Gravel Stops and Fasciae', NULL, 0, 0, 0, '2017-09-11 13:07:35', '2017-09-11 13:07:35'),
(3205, '077123', '077100', 'Manufactured Gutters and Downspouts', NULL, 0, 0, 0, '2017-09-11 13:07:41', '2017-09-11 13:07:41'),
(3206, '077123.13', '077123', 'Gutter Debris Guards', NULL, 0, 0, 0, '2017-09-11 13:07:52', '2017-09-11 13:07:52'),
(3207, '077126', '077100', 'Reglets', NULL, 0, 0, 0, '2017-09-11 13:08:54', '2017-09-11 13:08:54'),
(3208, '077129', '077100', 'Manufactured Roof Expansion Joints', NULL, 0, 0, 0, '2017-09-11 13:09:01', '2017-09-11 13:09:01'),
(3209, '077133', '077100', 'Manufactured Scuppers', NULL, 0, 0, 0, '2017-09-11 13:09:07', '2017-09-11 13:09:07'),
(3210, '077200', '077000', 'Roof Accessories', NULL, 0, 0, 0, '2017-09-11 13:09:12', '2017-09-11 13:09:12'),
(3211, '077213', '077200', 'Manufactured Curbs', NULL, 0, 0, 0, '2017-09-11 13:09:18', '2017-09-11 13:09:18'),
(3212, '077223', '077200', 'Relief Vents', NULL, 0, 0, 0, '2017-09-11 13:09:23', '2017-09-11 13:09:23'),
(3213, '078000', '070000', 'Fire and Smoke Protection', NULL, 0, 0, 0, '2017-09-11 13:09:31', '2017-09-11 13:09:31'),
(3214, '077226', '077200', 'Roof Hatches', NULL, 0, 0, 0, '2017-09-11 13:09:39', '2017-09-11 13:09:39'),
(3215, '077236', '077200', 'Smoke Vents', NULL, 0, 0, 0, '2017-09-11 13:09:44', '2017-09-11 13:09:44'),
(3216, '077243', '077200', 'Roof Walk Boards', NULL, 0, 0, 0, '2017-09-11 13:09:50', '2017-09-11 13:09:50'),
(3217, '077239', '077200', 'Operable Roof Vents', NULL, 0, 0, 0, '2017-09-11 13:09:57', '2017-09-11 13:09:57'),
(3218, '077246', '077200', 'Roof Walkways', NULL, 0, 0, 0, '2017-09-11 13:10:02', '2017-09-11 13:10:02'),
(3219, '077253', '077200', 'Snow Guards', NULL, 0, 0, 0, '2017-09-11 13:10:09', '2017-09-11 13:10:09'),
(3220, '077263', '077200', 'Waste Containment Assemblies', NULL, 0, 0, 0, '2017-09-11 13:10:15', '2017-09-11 13:10:15'),
(3221, '077273', '077200', 'Vegetated Roof Systems', NULL, 0, 0, 0, '2017-09-11 13:10:21', '2017-09-11 13:10:21'),
(3222, '077600', '077000', 'Roof Pavers', NULL, 0, 0, 0, '2017-09-11 13:10:26', '2017-09-11 13:10:26'),
(3223, '077613', '077600', 'Roof Ballast Pavers', NULL, 0, 0, 0, '2017-09-11 13:10:31', '2017-09-11 13:10:31'),
(3224, '077616', '077600', 'Roof Decking Pavers', NULL, 0, 0, 0, '2017-09-11 13:10:37', '2017-09-11 13:10:37'),
(3225, '077700', '077000', 'Wall Specialties', NULL, 0, 0, 0, '2017-09-11 13:10:44', '2017-09-11 13:10:44'),
(3226, '078100', '078000', 'Applied Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:10:52', '2017-09-11 13:10:52'),
(3227, '078113', '078100', 'Cement Aggregate Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:10:58', '2017-09-11 13:10:58'),
(3228, '078116', '078100', 'Cementitious Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:11:02', '2017-09-11 13:11:02'),
(3229, '078119', '078100', 'Foamed Magnesium-Oxychloride Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:11:10', '2017-09-11 13:11:10'),
(3230, '078123', '078100', 'Intumescent Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:11:20', '2017-09-11 13:11:20'),
(3231, '078126', '078100', 'Magnesium Cement Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:11:30', '2017-09-11 13:11:30'),
(3232, '078129', '078100', 'Mineral-Fiber Cementitious Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:11:37', '2017-09-11 13:11:37'),
(3233, '078133', '078100', 'Mineral-Fiber Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:11:45', '2017-09-11 13:11:45'),
(3234, '078200', '078000', 'Board Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:11:53', '2017-09-11 13:11:53'),
(3235, '078213', '078200', 'Calcium-Silicate Board Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:12:00', '2017-09-11 13:12:00'),
(3236, '078216', '078200', 'Slag-Fiber Board Fireproofing', NULL, 0, 0, 0, '2017-09-11 13:12:06', '2017-09-11 13:12:06'),
(3237, '078400', '078000', 'Firestopping', NULL, 0, 0, 0, '2017-09-11 13:12:14', '2017-09-11 13:12:14'),
(3238, '078413', '078400', 'Penetration Firestopping', NULL, 0, 0, 0, '2017-09-11 13:12:47', '2017-09-11 13:12:47'),
(3239, '078413.13', '078413', 'Penetration Firestopping Mortars', NULL, 0, 0, 0, '2017-09-11 13:12:56', '2017-09-11 13:12:56'),
(3240, '078413.16', '078413', 'Penetration Firestopping Devices', NULL, 0, 0, 0, '2017-09-11 13:13:06', '2017-09-11 13:13:06'),
(3241, '078443', '078400', 'Joint Firestopping', NULL, 0, 0, 0, '2017-09-11 13:13:13', '2017-09-11 13:13:13'),
(3242, '078453', '078400', 'Building Perimeter Firestopping', NULL, 0, 0, 0, '2017-09-11 13:13:20', '2017-09-11 13:13:20'),
(3243, '078600', '078000', 'Smoke Seals', NULL, 0, 0, 0, '2017-09-11 13:18:08', '2017-09-11 13:18:08'),
(3244, '078700', '078000', 'Smoke Containment Barriers', NULL, 0, 0, 0, '2017-09-11 13:18:15', '2017-09-11 13:18:15'),
(3245, '079000', '070000', 'Joint Protection', NULL, 0, 0, 0, '2017-09-11 13:18:20', '2017-09-11 13:18:20'),
(3246, '079100', '079000', 'Preformed Joint Seals', NULL, 0, 0, 0, '2017-09-11 13:18:26', '2017-09-11 13:18:26'),
(3247, '079113', '079100', 'Compression Seals', NULL, 0, 0, 0, '2017-09-11 13:18:33', '2017-09-11 13:18:33'),
(3248, '079116', '079100', 'Joint Gaskets', NULL, 0, 0, 0, '2017-09-11 13:18:42', '2017-09-11 13:18:42'),
(3249, '079123', '079100', 'Backer Rods', NULL, 0, 0, 0, '2017-09-11 13:18:48', '2017-09-11 13:18:48'),
(3250, '079126', '079100', 'Joint Fillers', NULL, 0, 0, 0, '2017-09-11 13:18:54', '2017-09-11 13:18:54'),
(3251, '079200', '079000', 'Joint Sealants', NULL, 0, 0, 0, '2017-09-11 13:19:16', '2017-09-11 13:19:16'),
(3252, '079213', '079200', 'Elastomeric Joint Sealants', NULL, 0, 0, 0, '2017-09-11 13:19:22', '2017-09-11 13:19:22'),
(3253, '079216', '079200', 'Rigid Joint Sealants', NULL, 0, 0, 0, '2017-09-11 13:19:27', '2017-09-11 13:19:27'),
(3254, '079219', '079200', 'Acoustical Joint Sealants', NULL, 0, 0, 0, '2017-09-11 13:19:33', '2017-09-11 13:19:33'),
(3255, '079500', '079000', 'Expansion Control', NULL, 0, 0, 0, '2017-09-11 13:19:40', '2017-09-11 13:19:40'),
(3256, '075413', '075400', 'Copolymer-Alloy Roofing', NULL, 0, 0, 0, '2017-09-11 13:21:21', '2017-09-11 13:21:21'),
(3257, '075416', '075400', 'Ketone Ethylene Ester Roofing', NULL, 0, 0, 0, '2017-09-11 13:21:27', '2017-09-11 13:21:27'),
(3258, '075419', '075400', 'Polyvinyl-Chloride Roofing', NULL, 0, 0, 0, '2017-09-11 13:21:33', '2017-09-11 13:21:33'),
(3259, '075423', '075400', 'Thermoplastic-Polyolefin Roofing', NULL, 0, 0, 0, '2017-09-11 13:21:39', '2017-09-11 13:21:39'),
(3260, '075426', '075400', 'Nitrile-Butadiene-Polymer Roofing', NULL, 0, 0, 0, '2017-09-11 13:21:46', '2017-09-11 13:21:46'),
(3261, '079513.13', '079513', 'Interior Expansion Joint Cover Assemblies', NULL, 0, 0, 0, '2017-09-11 13:22:09', '2017-09-11 13:22:15'),
(3262, '079513', '079500', 'Expansion Joint Cover Assemblies', NULL, 0, 0, 0, '2017-09-11 13:22:15', '2017-09-11 13:22:15'),
(3263, '079513.16', '079513', 'Exterior Expansion Joint Cover Assemblies', NULL, 0, 0, 0, '2017-09-11 13:22:25', '2017-09-11 13:22:25'),
(3264, '079513.19', '079513', 'Parking Deck Expansion Joint Cover Assemblies', NULL, 0, 0, 0, '2017-09-11 13:22:35', '2017-09-11 13:22:35'),
(3265, '079553', '079000', 'Joint Slide Bearings', NULL, 0, 0, 0, '2017-09-11 13:22:42', '2017-09-11 13:22:42'),
(3266, '079563', '079000', 'Bridge Expansion Joint Cover Assemblies', NULL, 0, 0, 0, '2017-09-11 13:22:48', '2017-09-11 13:22:48'),
(3267, '080000', '0', 'Doors and Windows', NULL, 0, 0, 0, '2017-09-11 13:23:27', '2017-09-11 13:23:27'),
(3268, '080100', '080000', 'Operation and Maintenance of Openings', NULL, 0, 0, 0, '2017-09-11 13:23:38', '2017-09-11 13:23:38'),
(3269, '080110', '080100', 'Operation and Maintenance of Doors and Frames', NULL, 0, 0, 0, '2017-09-11 13:23:44', '2017-09-11 13:23:44'),
(3270, '080111', '080100', 'Operation and Maintenance of Metal Doors and Frames', NULL, 0, 0, 0, '2017-09-11 13:23:50', '2017-09-11 13:23:50'),
(3271, '080114', '080100', 'Operation and Maintenance of Wood Doors', NULL, 0, 0, 0, '2017-09-11 13:23:55', '2017-09-11 13:23:55'),
(3272, '080115', '080100', 'Operation and Maintenance of Plastic Doors', NULL, 0, 0, 0, '2017-09-11 13:24:03', '2017-09-11 13:24:03'),
(3273, '080300', '080000', 'Conservation Treatment for Period Openings', NULL, 0, 0, 0, '2017-09-11 13:24:11', '2017-09-11 13:24:11'),
(3274, '080311', '080300', 'Conservation Treatment for Period Metal Doors and Frames', NULL, 0, 0, 0, '2017-09-11 13:24:18', '2017-09-11 13:24:18'),
(3275, '080311.23', '080311', 'Conservation Treatment fo r Period Bronze Doors and Frames', NULL, 0, 0, 0, '2017-09-11 13:24:38', '2017-09-11 13:24:38'),
(3276, '080314', '080300', 'Conservation Treatment for Period Wood Doors', NULL, 0, 0, 0, '2017-09-11 13:24:45', '2017-09-11 13:24:45'),
(3277, '080314.23', '080314', 'Conservation Treatment for Period Stile and Rail Wood Doors', NULL, 0, 0, 0, '2017-09-11 13:24:54', '2017-09-11 13:24:54'),
(3278, '080330', '080300', 'Conservation Treatment for Period Specialty Doors and Frames', NULL, 0, 0, 0, '2017-09-11 13:25:01', '2017-09-11 13:25:01'),
(3279, '080334', '080300', 'Conservation Treatment for Period Special Function Doors', NULL, 0, 0, 0, '2017-09-11 13:25:10', '2017-09-11 13:25:10'),
(3280, '080334.59', '080334', 'Conservation Treatment for Period Vault Doors', NULL, 0, 0, 0, '2017-09-11 13:25:18', '2017-09-11 13:25:18'),
(3281, '080350', '080300', 'Conservation Treatment for Period Windows', NULL, 0, 0, 0, '2017-09-11 13:25:29', '2017-09-11 13:25:29'),
(3282, '080351', '080300', 'Conservation Treatment for Period Metal Windows', NULL, 0, 0, 0, '2017-09-11 13:25:34', '2017-09-11 13:25:34'),
(3283, '080351.16', '080351', 'Conservation Treatment for Period Bronze Windows', NULL, 0, 0, 0, '2017-09-11 13:25:42', '2017-09-11 13:25:42'),
(3284, '080351.23', '080351', 'Conservation Treatment for Period Steel Windows', NULL, 0, 0, 0, '2017-09-11 13:25:50', '2017-09-11 13:25:50'),
(3285, '080352', '080300', 'Conservation Treatment for Period Wood Windows', NULL, 0, 0, 0, '2017-09-11 13:25:59', '2017-09-11 13:25:59'),
(3286, '080370', '080300', 'Conservation Treatment for Period Hardware', NULL, 0, 0, 0, '2017-09-11 13:26:05', '2017-09-11 13:26:05'),
(3287, '080371', '080300', 'Conservation Treatment for Period Door Hardware', NULL, 0, 0, 0, '2017-09-11 13:26:10', '2017-09-11 13:26:10'),
(3288, '080375', '080300', 'Conservation Treatment for Period Window Hardware', NULL, 0, 0, 0, '2017-09-11 13:26:16', '2017-09-11 13:26:16'),
(3289, '080390', '080300', 'Conservation Treatment for Period Louvers and Vents', NULL, 0, 0, 0, '2017-09-11 13:26:26', '2017-09-11 13:26:26'),
(3290, '080391', '080300', 'Conservation Treatment for Period Louvers', NULL, 0, 0, 0, '2017-09-11 14:14:35', '2017-09-11 14:14:35'),
(3291, '080395', '080300', 'Conservation Treatment for Period Vents', NULL, 0, 0, 0, '2017-09-11 14:14:43', '2017-09-11 14:14:43'),
(3292, '080500', '080000', 'Common Work Results for Openings', NULL, 0, 0, 0, '2017-09-11 14:15:00', '2017-09-11 14:15:00'),
(3293, '080505', '080500', 'Selective Demolition for Openings', NULL, 0, 0, 0, '2017-09-11 14:15:07', '2017-09-11 14:15:07'),
(3294, '080600', '080000', 'Schedules for Openings', NULL, 0, 0, 0, '2017-09-11 14:15:14', '2017-09-11 14:15:14'),
(3295, '080610', '080600', 'Door Schedule', NULL, 0, 0, 0, '2017-09-11 14:15:19', '2017-09-11 14:15:19'),
(3297, '080610.16', '080610', 'Frame Type Schedule', NULL, 0, 0, 0, '2017-09-11 14:15:35', '2017-09-11 14:15:35'),
(3298, '080610.13', '080610', 'Door Type Schedule', NULL, 0, 0, 0, '2017-09-11 14:15:42', '2017-09-11 14:15:42'),
(3299, '080640', '080600', 'Schedules for Entrances, Storefronts, and Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:15:52', '2017-09-11 14:15:52'),
(3300, '080641', '080600', 'Entrance Schedule', NULL, 0, 0, 0, '2017-09-11 14:15:58', '2017-09-11 14:15:58'),
(3301, '080642', '080600', 'Storefront Schedule', NULL, 0, 0, 0, '2017-09-11 14:16:05', '2017-09-11 14:16:05'),
(3302, '080650', '080600', 'Window Schedule', NULL, 0, 0, 0, '2017-09-11 14:16:10', '2017-09-11 14:16:10'),
(3303, '080660', '080600', 'Skylight Schedule', NULL, 0, 0, 0, '2017-09-11 14:16:17', '2017-09-11 14:16:17'),
(3304, '080670', '080600', 'Hardware Schedule', NULL, 0, 0, 0, '2017-09-11 14:16:23', '2017-09-11 14:16:23'),
(3305, '080671', '080600', 'Door Hardware Schedule', NULL, 0, 0, 0, '2017-09-11 14:16:30', '2017-09-11 14:16:30'),
(3306, '080680', '080600', 'Glazing Schedule', NULL, 0, 0, 0, '2017-09-11 14:16:35', '2017-09-11 14:16:35'),
(3307, '080690', '080600', 'Louver and Vent Schedule', NULL, 0, 0, 0, '2017-09-11 14:16:41', '2017-09-11 14:16:41'),
(3308, '080800', '080000', 'Commissioning of Openings', NULL, 0, 0, 0, '2017-09-11 14:16:49', '2017-09-11 14:16:49'),
(3309, '081000', '080000', 'Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:16:56', '2017-09-11 14:16:56'),
(3310, '081100', '081000', 'Metal Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:17:03', '2017-09-11 14:17:03'),
(3311, '081113', '081100', 'Hollow Metal Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:17:09', '2017-09-11 14:17:09'),
(3312, '081113.13', '081113', 'Standard Hollow Metal Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:17:20', '2017-09-11 14:17:20'),
(3313, '081113.16', '081113', 'Custom Hollow Metal Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:17:28', '2017-09-11 14:17:28'),
(3314, '081116', '081100', 'Aluminum Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:17:35', '2017-09-11 14:17:35'),
(3315, '081119', '081100', 'Stainless-Steel Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:17:42', '2017-09-11 14:17:42'),
(3316, '081123', '081100', 'Bronze Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:17:48', '2017-09-11 14:17:48'),
(3317, '081163', '081100', 'Metal Screen and Storm Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:17:53', '2017-09-11 14:17:53'),
(3318, '081163.13', '081163', 'Steel Screen and Storm Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:18:02', '2017-09-11 14:18:02'),
(3319, '081163.23', '081163', 'Aluminum Screen and Storm Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:18:10', '2017-09-11 14:18:10'),
(3320, '081169', '081100', 'Metal Storm Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:18:16', '2017-09-11 14:18:16'),
(3321, '081169.13', '081169', 'Steel Storm Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:18:26', '2017-09-11 14:18:26'),
(3322, '081169.23', '081169', 'Aluminum Storm Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:18:40', '2017-09-11 14:18:40'),
(3323, '081173', '081100', 'Sliding Metal Fire Doors', NULL, 0, 0, 0, '2017-09-11 14:18:45', '2017-09-11 14:18:45'),
(3324, '081174', '081100', 'Sliding Metal Grilles', NULL, 0, 0, 0, '2017-09-11 14:18:51', '2017-09-11 14:18:51'),
(3325, '081200', '081000', 'Metal Frames', NULL, 0, 0, 0, '2017-09-11 14:18:58', '2017-09-11 14:18:58'),
(3326, '081213', '081200', 'Hollow Metal Frames', NULL, 0, 0, 0, '2017-09-11 14:19:05', '2017-09-11 14:19:05'),
(3327, '081213.13', '081213', 'Standard Hollow Metal Frames', NULL, 0, 0, 0, '2017-09-11 14:19:13', '2017-09-11 14:19:13'),
(3328, '081213.53', '081213', 'Custom Hollow Metal Frames', NULL, 0, 0, 0, '2017-09-11 14:19:21', '2017-09-11 14:19:21'),
(3329, '081216', '081200', 'Aluminum Frames', NULL, 0, 0, 0, '2017-09-11 14:19:27', '2017-09-11 14:19:27'),
(3330, '081219', '081200', 'Stainless-Steel Frames', NULL, 0, 0, 0, '2017-09-11 14:19:33', '2017-09-11 14:19:33'),
(3331, '081223', '081200', 'Bronze Frames', NULL, 0, 0, 0, '2017-09-11 14:19:39', '2017-09-11 14:19:39'),
(3332, '081400', '081000', 'Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:19:49', '2017-09-11 14:19:49'),
(3333, '081413', '081400', 'Carved Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:19:57', '2017-09-11 14:19:57'),
(3334, '081416', '081400', 'Flush Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:20:02', '2017-09-11 14:20:02'),
(3335, '081423', '081400', 'Clad Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:20:07', '2017-09-11 14:20:07'),
(3336, '081423.13', '081423', 'Metal-Faced Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:20:14', '2017-09-11 14:20:14'),
(3337, '081423.16', '081423', 'Plastic-Laminate-Faced Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:20:22', '2017-09-11 14:20:22'),
(3338, '081423.17', '081423', 'Plastic-Faced Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:20:29', '2017-09-11 14:20:29'),
(3339, '081423.19', '081423', 'Molded-Hardboard-Faced Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:20:38', '2017-09-11 14:20:38'),
(3340, '081429', '081400', 'Prefinished Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:20:44', '2017-09-11 14:20:44'),
(3341, '081433', '081400', 'Stile and Rail Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:20:50', '2017-09-11 14:20:50'),
(3342, '081433.13', '081433', 'Wood Terrace Doors', NULL, 0, 0, 0, '2017-09-11 14:20:58', '2017-09-11 14:20:58'),
(3343, '081466', '081400', 'Wood Screen Doors', NULL, 0, 0, 0, '2017-09-11 14:21:03', '2017-09-11 14:21:03'),
(3344, '081469', '081400', 'Wood Storm Doors', NULL, 0, 0, 0, '2017-09-11 14:21:08', '2017-09-11 14:21:08'),
(3345, '081473', '081400', 'Sliding Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:21:16', '2017-09-11 14:21:16'),
(3346, '081476', '081400', 'Bifolding Wood Doors', NULL, 0, 0, 0, '2017-09-11 14:21:22', '2017-09-11 14:21:22'),
(3347, '081300', '081000', 'Metal Doors', NULL, 0, 0, 0, '2017-09-11 14:21:29', '2017-09-11 14:21:29'),
(3348, '081500', '081000', 'Plastic Doors', NULL, 0, 0, 0, '2017-09-11 14:21:43', '2017-09-11 14:21:43'),
(3349, '081513', '081500', 'Laminated Plastic Doors', NULL, 0, 0, 0, '2017-09-11 14:21:50', '2017-09-11 14:21:50'),
(3350, '081516', '081500', 'Solid Plastic Doors', NULL, 0, 0, 0, '2017-09-11 14:21:55', '2017-09-11 14:21:55'),
(3351, '081566', '081500', 'Plastic Screen Doors', NULL, 0, 0, 0, '2017-09-11 14:22:01', '2017-09-11 14:22:01'),
(3352, '081569', '081500', 'Plastic Storm Doors', NULL, 0, 0, 0, '2017-09-11 14:22:08', '2017-09-11 14:22:08'),
(3353, '081573', '081500', 'Sliding Plastic Doors', NULL, 0, 0, 0, '2017-09-11 14:22:13', '2017-09-11 14:22:13'),
(3354, '081576', '081500', 'Bifolding Plastic Doors', NULL, 0, 0, 0, '2017-09-11 14:22:19', '2017-09-11 14:22:19'),
(3355, '081600', '081000', 'Sliding Metal Doors and Grille', NULL, 0, 0, 0, '2017-09-11 14:22:33', '2017-09-11 14:22:33'),
(3356, '081613', '081600', 'Fiberglass Doors', NULL, 0, 0, 0, '2017-09-11 14:22:39', '2017-09-11 14:22:39'),
(3357, '081673', '081600', 'Sliding Composite Doors', NULL, 0, 0, 0, '2017-09-11 14:22:45', '2017-09-11 14:22:45'),
(3358, '081676', '081600', 'Bifolding Composite Doors', NULL, 0, 0, 0, '2017-09-11 14:22:51', '2017-09-11 14:22:51'),
(3359, '081700', '081000', 'Integrated Door Opening Assemblies', NULL, 0, 0, 0, '2017-09-11 14:22:58', '2017-09-11 14:22:58'),
(3360, '081713', '081700', 'Integrated Metal Door Opening Assemblies', NULL, 0, 0, 0, '2017-09-11 14:23:03', '2017-09-11 14:23:03'),
(3361, '081723', '081700', 'Integrated Wood Door Opening Assemblies', NULL, 0, 0, 0, '2017-09-11 14:23:08', '2017-09-11 14:23:08'),
(3362, '081733', '081700', 'Integrated Plastic Door Opening Assemblies', NULL, 0, 0, 0, '2017-09-11 14:23:15', '2017-09-11 14:23:15'),
(3363, '081743', '081700', 'Integrated Composite Door Opening Assemblies', NULL, 0, 0, 0, '2017-09-11 14:23:21', '2017-09-11 14:23:21'),
(3364, '083000', '080000', 'Specialty Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:23:27', '2017-09-11 14:23:27'),
(3365, '083100', '083000', 'Access Doors and Panels', NULL, 0, 0, 0, '2017-09-11 14:23:33', '2017-09-11 14:23:33'),
(3366, '083113', '083100', 'Access Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:23:40', '2017-09-11 14:23:40'),
(3367, '083113.53', '083113', 'Security Access Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:23:48', '2017-09-11 14:23:48'),
(3368, '083116', '083100', 'Access Panels and Frames', NULL, 0, 0, 0, '2017-09-11 14:23:55', '2017-09-11 14:23:55'),
(3369, '083200', '083000', 'Sliding Glass Doors', NULL, 0, 0, 0, '2017-09-11 14:24:03', '2017-09-11 14:24:03'),
(3370, '083213', '083200', 'Sliding Aluminum-Framed Glass Doors', NULL, 0, 0, 0, '2017-09-11 14:24:09', '2017-09-11 14:24:09'),
(3371, '083216', '083200', 'Sliding Plastic-Framed Glass Doors', NULL, 0, 0, 0, '2017-09-11 14:24:16', '2017-09-11 14:24:16'),
(3372, '083219', '083200', 'Sliding Wood-Framed Glass Doors', NULL, 0, 0, 0, '2017-09-11 14:24:21', '2017-09-11 14:24:21'),
(3373, '083300', '083000', 'Coiling Doors and Grilles', NULL, 0, 0, 0, '2017-09-11 14:24:26', '2017-09-11 14:24:26'),
(3374, '083313', '083300', 'Coiling Counter Doors', NULL, 0, 0, 0, '2017-09-11 14:24:32', '2017-09-11 14:24:32'),
(3375, '083316', '083300', 'Coiling Counter Grilles', NULL, 0, 0, 0, '2017-09-11 14:24:40', '2017-09-11 14:24:40'),
(3376, '083323', '083300', 'Overhead Coiling Doors', NULL, 0, 0, 0, '2017-09-11 14:24:45', '2017-09-11 14:24:45'),
(3377, '083323.13', '083323', 'Overhead Rapid Coiling Doors', NULL, 0, 0, 0, '2017-09-11 14:24:53', '2017-09-11 14:24:53'),
(3378, '083326', '083300', 'Overhead Coiling Grilles', NULL, 0, 0, 0, '2017-09-11 14:24:59', '2017-09-11 14:24:59'),
(3379, '083333', '083300', 'Side Coiling Doors', NULL, 0, 0, 0, '2017-09-11 14:25:05', '2017-09-11 14:25:05'),
(3380, '083336', '083300', 'Side Coiling Grilles', NULL, 0, 0, 0, '2017-09-11 14:25:10', '2017-09-11 14:25:10'),
(3381, '083343', '083300', 'Overhead Coiling Smoke Curtains', NULL, 0, 0, 0, '2017-09-11 14:25:16', '2017-09-11 14:25:16'),
(3382, '083344', '083300', 'Overhead Coiling Fire Curtains', NULL, 0, 0, 0, '2017-09-11 14:25:22', '2017-09-11 14:25:22'),
(3383, '083400', '083000', 'Special Function Doors', NULL, 0, 0, 0, '2017-09-11 14:25:34', '2017-09-11 14:25:34'),
(3384, '083413', '083400', 'Cold Storage Doors', NULL, 0, 0, 0, '2017-09-11 14:25:39', '2017-09-11 14:25:39'),
(3385, '083416', '083400', 'Hangar Doors', NULL, 0, 0, 0, '2017-09-11 14:25:45', '2017-09-11 14:25:45'),
(3386, '083419', '083400', 'Industrial Doors', NULL, 0, 0, 0, '2017-09-11 14:25:51', '2017-09-11 14:25:51'),
(3387, '083433', '083400', 'Lightproof Doors', NULL, 0, 0, 0, '2017-09-11 14:25:58', '2017-09-11 14:25:58'),
(3388, '083436', '083400', 'Darkroom Doors', NULL, 0, 0, 0, '2017-09-11 14:26:04', '2017-09-11 14:26:04'),
(3389, '083446', '083400', 'Radio-Frequency-Interference Shielding Doors', NULL, 0, 0, 0, '2017-09-11 14:26:12', '2017-09-11 14:26:12'),
(3390, '083449', '083400', 'Radiation Shielding Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:26:18', '2017-09-11 14:26:18'),
(3391, '083449.13', '083449', 'Neutron Shielding Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:26:26', '2017-09-11 14:26:26'),
(3392, '083453', '083400', 'Security Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:26:39', '2017-09-11 14:26:39'),
(3393, '083456', '083400', 'Security Gates', NULL, 0, 0, 0, '2017-09-11 14:26:49', '2017-09-11 14:26:49'),
(3394, '083458', '083400', 'File Room Doors and Frames', NULL, 0, 0, 0, '2017-09-11 14:26:54', '2017-09-11 14:26:54'),
(3395, '083459', '083400', 'Vault Doors and Day Gates', NULL, 0, 0, 0, '2017-09-11 14:26:59', '2017-09-11 14:26:59'),
(3396, '083473', '083400', 'Sound Control Door Assemblies', NULL, 0, 0, 0, '2017-09-11 14:27:05', '2017-09-11 14:27:05'),
(3397, '083473.13', '083473', 'Metal Sound Control Door Assemblies', NULL, 0, 0, 0, '2017-09-11 14:27:12', '2017-09-11 14:27:12'),
(3398, '083473.16', '083473', 'Wood Sound Control Door Assemblies', NULL, 0, 0, 0, '2017-09-11 14:27:20', '2017-09-11 14:27:20'),
(3399, '081313', '081300', 'Hollow Metal Doors', NULL, 0, 0, 0, '2017-09-11 14:30:45', '2017-09-11 14:30:45'),
(3400, '081313.13', '081313', 'Standard Hollow Metal Doors', NULL, 0, 0, 0, '2017-09-11 14:30:55', '2017-09-11 14:30:55'),
(3401, '081313.53', '081313', 'Custom Hollow Metal Doors', NULL, 0, 0, 0, '2017-09-11 14:31:04', '2017-09-11 14:31:04'),
(3402, '081316', '081300', 'Aluminum Doors', NULL, 0, 0, 0, '2017-09-11 14:31:35', '2017-09-11 14:31:35'),
(3403, '081316.13', '081316', 'Aluminum Terrace Doors', NULL, 0, 0, 0, '2017-09-11 14:31:42', '2017-09-11 14:31:42'),
(3404, '081319', '081300', 'Stainless-Steel Doors', NULL, 0, 0, 0, '2017-09-11 14:31:47', '2017-09-11 14:31:47'),
(3405, '081323', '081300', 'Bronze Doors', NULL, 0, 0, 0, '2017-09-11 14:31:52', '2017-09-11 14:31:52'),
(3406, '081373', '081300', 'Sliding Metal Doors', NULL, 0, 0, 0, '2017-09-11 14:31:58', '2017-09-11 14:31:58'),
(3407, '081376', '081300', 'Bifolding Metal Doors', NULL, 0, 0, 0, '2017-09-11 14:32:03', '2017-09-11 14:32:03'),
(3408, '083500', '083000', 'Folding Doors and Grilles', NULL, 0, 0, 0, '2017-09-11 14:32:18', '2017-09-11 14:32:18'),
(3409, '083513', '083500', 'Folding Doors', NULL, 0, 0, 0, '2017-09-11 14:32:25', '2017-09-11 14:32:25'),
(3410, '083513.13', '083513', 'Accordion Folding Doors', NULL, 0, 0, 0, '2017-09-11 14:32:32', '2017-09-11 14:32:32'),
(3411, '083513.23', '083513', 'Accordion Folding Fire Doors', NULL, 0, 0, 0, '2017-09-11 14:32:39', '2017-09-11 14:32:39'),
(3412, '083513.33', '083513', 'Panel Folding Doors', NULL, 0, 0, 0, '2017-09-11 14:32:47', '2017-09-11 14:32:47'),
(3413, '083516', '083500', 'Folding Grilles', NULL, 0, 0, 0, '2017-09-11 14:32:56', '2017-09-11 14:32:56'),
(3414, '083516.13', '083516', 'Accordion Folding Grilles', NULL, 0, 0, 0, '2017-09-11 14:33:03', '2017-09-11 14:33:03'),
(3415, '083600', '083000', 'Panel Doors', NULL, 0, 0, 0, '2017-09-11 14:33:10', '2017-09-11 14:33:10'),
(3416, '083613', '083600', 'Sectional Doors', NULL, 0, 0, 0, '2017-09-11 14:33:16', '2017-09-11 14:33:16'),
(3417, '083616', '083600', 'Single-Panel Doors', NULL, 0, 0, 0, '2017-09-11 14:33:21', '2017-09-11 14:33:21'),
(3418, '083619', '083600', 'Multi-Leaf Vertical Lift Doors', NULL, 0, 0, 0, '2017-09-11 14:33:27', '2017-09-11 14:33:27'),
(3419, '083623', '083600', 'Telescoping Vertical Lift Doors', NULL, 0, 0, 0, '2017-09-11 14:33:32', '2017-09-11 14:33:32'),
(3420, '083800', '083000', 'Traffic Doors', NULL, 0, 0, 0, '2017-09-11 14:33:37', '2017-09-11 14:33:37'),
(3421, '083813', '083800', 'Flexible Strip Doors', NULL, 0, 0, 0, '2017-09-11 14:33:43', '2017-09-11 14:33:43'),
(3422, '083816', '083800', 'Flexible Traffic Doors', NULL, 0, 0, 0, '2017-09-11 14:33:49', '2017-09-11 14:33:49'),
(3423, '083819', '083800', 'Rigid Traffic Doors', NULL, 0, 0, 0, '2017-09-11 14:33:54', '2017-09-11 14:33:54'),
(3424, '083900', '083000', 'Pressure-Resistant Doors', NULL, 0, 0, 0, '2017-09-11 14:34:02', '2017-09-11 14:34:02'),
(3425, '083913', '083900', 'Airtight Doors', NULL, 0, 0, 0, '2017-09-11 14:34:10', '2017-09-11 14:34:10'),
(3426, '083919', '083900', 'Watertight Doors', NULL, 0, 0, 0, '2017-09-11 14:34:15', '2017-09-11 14:34:15'),
(3427, '083953', '083900', 'Blast-Resistant Doors', NULL, 0, 0, 0, '2017-09-11 14:34:20', '2017-09-11 14:34:20'),
(3428, '084000', '080000', 'Entrances, Storefronts, and Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:34:26', '2017-09-11 14:34:26'),
(3429, '084100', '084000', 'Entrances and Storefronts', NULL, 0, 0, 0, '2017-09-11 14:34:32', '2017-09-11 14:34:32'),
(3430, '084113', '084100', 'Aluminum-Framed Entrances and Storefronts', NULL, 0, 0, 0, '2017-09-11 14:34:37', '2017-09-11 14:34:37'),
(3431, '084113.13', '084113', 'Fire-Rated Aluminum-Framed Entrances and Storefronts', NULL, 0, 0, 0, '2017-09-11 14:34:45', '2017-09-11 14:34:45'),
(3432, '084116', '084100', 'Bronze-Framed Entrances and Storefronts', NULL, 0, 0, 0, '2017-09-11 14:35:00', '2017-09-11 14:35:00'),
(3433, '084119', '084100', 'Stainless-Steel-Framed Entrances and Storefronts', NULL, 0, 0, 0, '2017-09-11 14:35:07', '2017-09-11 14:35:07'),
(3434, '084123', '084100', 'Steel-Framed Entrances and Storefronts', NULL, 0, 0, 0, '2017-09-11 14:35:14', '2017-09-11 14:35:14'),
(3435, '084126', '084100', 'All-Glass Entrances and Storefronts', NULL, 0, 0, 0, '2017-09-11 14:35:20', '2017-09-11 14:35:20'),
(3436, '084126.13', '084126', 'Point Supported All-Glass Storefronts', NULL, 0, 0, 0, '2017-09-11 14:35:31', '2017-09-11 14:35:31'),
(3437, '084200', '084000', 'Entrances', NULL, 0, 0, 0, '2017-09-11 14:35:39', '2017-09-11 14:35:39'),
(3438, '084213', '084200', 'Aluminum-Framed Entrances', NULL, 0, 0, 0, '2017-09-11 14:35:44', '2017-09-11 14:35:44'),
(3439, '084226', '084200', 'All-Glass Entrances', NULL, 0, 0, 0, '2017-09-11 14:35:50', '2017-09-11 14:35:50'),
(3440, '084229', '084200', 'Automatic Entrances', NULL, 0, 0, 0, '2017-09-11 14:35:56', '2017-09-11 14:35:56'),
(3441, '084229.13', '084229', 'Folding Automatic Entrances', NULL, 0, 0, 0, '2017-09-11 14:36:03', '2017-09-11 14:36:03'),
(3442, '084229.23', '084229', 'Sliding Automatic Entrances', NULL, 0, 0, 0, '2017-09-11 14:36:12', '2017-09-11 14:36:12'),
(3443, '084229.33', '084229', 'Swinging Automatic Entrances', NULL, 0, 0, 0, '2017-09-11 14:36:24', '2017-09-11 14:36:24'),
(3444, '084233', '084200', 'Revolving Door Entrances', NULL, 0, 0, 0, '2017-09-11 14:36:34', '2017-09-11 14:36:34'),
(3445, '084233.13', '084233', 'Security Revolving Door Entrances', NULL, 0, 0, 0, '2017-09-11 14:36:42', '2017-09-11 14:36:42'),
(3446, '084236', '084200', 'Balanced Door Entrances', NULL, 0, 0, 0, '2017-09-11 14:36:48', '2017-09-11 14:36:48'),
(3447, '084239', '084200', 'Pressure-Resistant Entrances', NULL, 0, 0, 0, '2017-09-11 14:36:54', '2017-09-11 14:36:54'),
(3448, '084243', '084200', 'Intensive Care Unit/Critical Care Unit Entrances', NULL, 0, 0, 0, '2017-09-11 14:37:00', '2017-09-11 14:37:00'),
(3449, '084300', '084000', 'Storefronts', NULL, 0, 0, 0, '2017-09-11 14:37:06', '2017-09-11 14:37:06'),
(3450, '084311', '084300', 'Timber-Framed Storefronts', NULL, 0, 0, 0, '2017-09-11 14:37:11', '2017-09-11 14:37:11'),
(3451, '084313', '084300', 'Aluminum-Framed Storefronts', NULL, 0, 0, 0, '2017-09-11 14:37:18', '2017-09-11 14:37:18'),
(3452, '084313.13', '084313', 'Fire-Rated Aluminum Storefronts', NULL, 0, 0, 0, '2017-09-11 14:37:24', '2017-09-11 14:37:24'),
(3453, '084316', '084300', 'Bronze-Framed Storefronts', NULL, 0, 0, 0, '2017-09-11 14:37:35', '2017-09-11 14:37:35'),
(3454, '084319', '084300', 'Stainless-Steel-Framed Storefronts', NULL, 0, 0, 0, '2017-09-11 14:37:48', '2017-09-11 14:37:48'),
(3455, '084323', '084300', 'Steel-Framed Storefronts', NULL, 0, 0, 0, '2017-09-11 14:37:55', '2017-09-11 14:37:55'),
(3456, '084326', '084300', 'All-Glass Storefronts', NULL, 0, 0, 0, '2017-09-11 14:38:00', '2017-09-11 14:38:00'),
(3457, '084327', '084300', 'Channel Glass Storefronts', NULL, 0, 0, 0, '2017-09-11 14:38:05', '2017-09-11 14:38:05'),
(3458, '084329', '084300', 'Sliding Storefront', NULL, 0, 0, 0, '2017-09-11 14:38:10', '2017-09-11 14:38:10'),
(3459, '084400', '084000', 'Curtain Wall and Glazed Assemblies', NULL, 0, 0, 0, '2017-09-11 14:38:23', '2017-09-11 14:38:23'),
(3460, '084411', '084400', 'Glazed Timber Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:38:30', '2017-09-11 14:38:30'),
(3461, '084412', '084400', 'Glazed Composite Curtain Wall', NULL, 0, 0, 0, '2017-09-11 14:38:37', '2017-09-11 14:38:37'),
(3462, '084412.13', '084412', 'Glazed Fiberglass Curtain Wall', NULL, 0, 0, 0, '2017-09-11 14:38:45', '2017-09-11 14:38:45'),
(3463, '084413', '084400', 'Glazed Aluminum Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:43:07', '2017-09-11 14:43:07'),
(3464, '084416', '084400', 'Glazed Bronze Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:43:14', '2017-09-11 14:43:14'),
(3465, '084418', '084400', 'Glazed Steel Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:43:21', '2017-09-11 14:43:21'),
(3466, '084419', '084400', 'Glazed Stainless-Steel Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:43:27', '2017-09-11 14:43:27'),
(3467, '084423', '084400', 'Structural Sealant Glazed Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:43:32', '2017-09-11 14:43:32'),
(3468, '084426', '084400', 'Structural Glass Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:43:39', '2017-09-11 14:43:39'),
(3469, '084426.13', '084426', 'Glass Framed Point Supported Glass Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:44:00', '2017-09-11 14:44:00'),
(3470, '084426.16', '084426', 'Metal Framed Point Supported Glass Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:44:09', '2017-09-11 14:44:09'),
(3471, '084426.23', '084426', 'Cable Framed Point Supported Glass Curtain Walls', NULL, 0, 0, 0, '2017-09-11 14:44:18', '2017-09-11 14:44:18'),
(3472, '084433', '084400', 'Sloped Glazing Assemblies', NULL, 0, 0, 0, '2017-09-11 14:44:26', '2017-09-11 14:44:26'),
(3473, '084500', '084000', 'Translucent Wall and Roof Assemblies', NULL, 0, 0, 0, '2017-09-11 14:44:33', '2017-09-11 14:44:33'),
(3474, '084513', '084500', 'Structured-Polycarbonate-Panel Assemblies', NULL, 0, 0, 0, '2017-09-11 14:44:38', '2017-09-11 14:44:38'),
(3475, '084523', '084500', 'Fiberglass-Sandwich-Panel Assemblies', NULL, 0, 0, 0, '2017-09-11 14:44:44', '2017-09-11 14:44:44'),
(3476, '084600', '084000', 'Window Wall Assemblies', NULL, 0, 0, 0, '2017-09-11 14:44:51', '2017-09-11 14:44:51'),
(3477, '085000', '080000', 'Windows', NULL, 0, 0, 0, '2017-09-11 14:45:01', '2017-09-11 14:45:01'),
(3478, '085100', '085000', 'Metal Windows', NULL, 0, 0, 0, '2017-09-11 14:45:07', '2017-09-11 14:45:07'),
(3479, '085113', '085100', 'Aluminum Windows', NULL, 0, 0, 0, '2017-09-11 14:45:14', '2017-09-11 14:45:14'),
(3480, '085116', '085100', 'Bronze Windows', NULL, 0, 0, 0, '2017-09-11 14:45:20', '2017-09-11 14:45:20'),
(3481, '085119', '085100', 'Stainless-Steel Windows', NULL, 0, 0, 0, '2017-09-11 14:45:27', '2017-09-11 14:45:27'),
(3482, '085123', '085100', 'Steel Windows', NULL, 0, 0, 0, '2017-09-11 14:45:34', '2017-09-11 14:45:34'),
(3483, '085123.13', '085123', 'Hot-Rolled Steel Windows', NULL, 0, 0, 0, '2017-09-11 14:45:43', '2017-09-11 14:45:43'),
(3484, '085123.23', '085123', 'Cold-Rolled Steel Windows', NULL, 0, 0, 0, '2017-09-11 14:47:57', '2017-09-11 14:47:57'),
(3485, '085166', '085100', 'Metal Window Screens', NULL, 0, 0, 0, '2017-09-11 14:48:09', '2017-09-11 14:48:09'),
(3486, '085169', '085100', 'Metal Storm Windows', NULL, 0, 0, 0, '2017-09-11 14:48:16', '2017-09-11 14:48:16'),
(3487, '085200', '085000', 'Wood Windows', NULL, 0, 0, 0, '2017-09-11 14:48:24', '2017-09-11 14:48:24'),
(3488, '085213', '085200', 'Metal-Clad Wood Windows', NULL, 0, 0, 0, '2017-09-11 14:48:30', '2017-09-11 14:48:30'),
(3489, '085216', '085200', 'Plastic-Clad Wood Windows', NULL, 0, 0, 0, '2017-09-11 14:48:37', '2017-09-11 14:48:37'),
(3490, '085266', '085200', 'Wood Window Screens', NULL, 0, 0, 0, '2017-09-11 14:48:46', '2017-09-11 14:48:46'),
(3491, '085269', '085200', 'Wood Storm Windows', NULL, 0, 0, 0, '2017-09-11 14:49:57', '2017-09-11 14:49:57'),
(3492, '085300', '085000', 'Plastic Windows', NULL, 0, 0, 0, '2017-09-11 14:50:06', '2017-09-11 14:50:06'),
(3493, '085313', '085300', 'Vinyl Windows', NULL, 0, 0, 0, '2017-09-11 14:50:14', '2017-09-11 14:50:14'),
(3494, '085366', '085300', 'Vinyl Window Screens', NULL, 0, 0, 0, '2017-09-11 14:50:26', '2017-09-11 14:50:26'),
(3495, '085369', '085300', 'Vinyl Storm Windows', NULL, 0, 0, 0, '2017-09-11 14:50:34', '2017-09-11 14:50:34'),
(3496, '085400', '085000', 'Composite Windows', NULL, 0, 0, 0, '2017-09-11 14:50:40', '2017-09-11 14:50:40'),
(3497, '085413', '085400', 'Fiberglass Windows', NULL, 0, 0, 0, '2017-09-11 14:50:47', '2017-09-11 14:50:47'),
(3498, '085466', '085400', 'Fiberglass Window Screens', NULL, 0, 0, 0, '2017-09-11 14:50:55', '2017-09-11 14:50:55'),
(3499, '085469', '085400', 'Fiberglass Storm Windows', NULL, 0, 0, 0, '2017-09-11 14:51:05', '2017-09-11 14:51:05'),
(3500, '085500', '085000', 'Pressure-Resistant Windows', NULL, 0, 0, 0, '2017-09-11 14:51:11', '2017-09-11 14:51:11'),
(3501, '085513', '085500', 'Tornado-Resistant Windows', NULL, 0, 0, 0, '2017-09-11 14:51:18', '2017-09-11 14:51:18'),
(3502, '085523', '085500', 'Blast-Resistant Windows', NULL, 0, 0, 0, '2017-09-11 14:51:26', '2017-09-11 14:51:26'),
(3503, '085600', '085000', 'Special Function Windows', NULL, 0, 0, 0, '2017-09-11 14:51:31', '2017-09-11 14:51:31'),
(3504, '085619', '085600', 'Pass Windows', NULL, 0, 0, 0, '2017-09-11 14:51:38', '2017-09-11 14:51:38'),
(3505, '085646', '085600', 'Radio-Frequency-Interference Shielding Windows', NULL, 0, 0, 0, '2017-09-11 14:51:44', '2017-09-11 14:51:44'),
(3506, '085649', '085600', 'Radiation Shielding Windows', NULL, 0, 0, 0, '2017-09-11 14:51:54', '2017-09-11 14:51:54'),
(3507, '085653', '085600', 'Security Windows', NULL, 0, 0, 0, '2017-09-11 14:52:00', '2017-09-11 14:52:00'),
(3508, '085656', '085600', 'Security Window Screens', NULL, 0, 0, 0, '2017-09-11 14:52:05', '2017-09-11 14:52:05'),
(3509, '085659', '085600', 'Service and Teller Window Units', NULL, 0, 0, 0, '2017-09-11 14:52:15', '2017-09-11 14:52:15'),
(3510, '085673', '085600', 'Sound Control Windows', NULL, 0, 0, 0, '2017-09-11 14:52:22', '2017-09-11 14:52:22'),
(3511, '085688', '085600', 'Interior Insulating Windows', NULL, 0, 0, 0, '2017-09-11 14:52:29', '2017-09-11 14:52:29'),
(3512, '089543', '089500', 'Flood Vents', NULL, 0, 0, 0, '2017-09-11 15:02:25', '2017-09-11 15:51:12'),
(3513, '086000', '080000', 'Roof Windows and Skylights', NULL, 0, 0, 0, '2017-09-11 15:04:16', '2017-09-11 15:04:16'),
(3514, '086100', '086000', 'Roof Windows', NULL, 0, 0, 0, '2017-09-11 15:04:22', '2017-09-11 15:04:22'),
(3515, '086113', '086100', 'Metal Roof Windows', NULL, 0, 0, 0, '2017-09-11 15:04:29', '2017-09-11 15:04:29'),
(3516, '086116', '086100', 'Wood Roof Windows', NULL, 0, 0, 0, '2017-09-11 15:04:34', '2017-09-11 15:04:34'),
(3517, '086200', '086000', 'Unit Skylights', NULL, 0, 0, 0, '2017-09-11 15:05:23', '2017-09-11 15:05:23'),
(3518, '086213', '086200', 'Domed Unit Skylights', NULL, 0, 0, 0, '2017-09-11 15:05:29', '2017-09-11 15:05:29');
INSERT INTO `wbs` (`id`, `code`, `parent_code`, `name`, `description`, `extension`, `status`, `quantify`, `created_at`, `updated_at`) VALUES
(3519, '086216', '086200', 'Pyramidal Unit Skylights', NULL, 0, 0, 0, '2017-09-11 15:36:54', '2017-09-11 15:36:54'),
(3520, '086219', '086200', 'Vaulted Unit Skylights', NULL, 0, 0, 0, '2017-09-11 15:37:00', '2017-09-11 15:37:00'),
(3521, '086223', '086200', 'Tubular Skylights', NULL, 0, 0, 0, '2017-09-11 15:37:08', '2017-09-11 15:37:08'),
(3522, '086300', '086000', 'Metal-Framed Skylights', NULL, 0, 0, 0, '2017-09-11 15:37:19', '2017-09-11 15:37:19'),
(3523, '086313', '086300', 'Domed Metal-Framed Skylights', NULL, 0, 0, 0, '2017-09-11 15:37:26', '2017-09-11 15:37:26'),
(3524, '086316', '086300', 'Pyramidal Metal-Framed Skylights', NULL, 0, 0, 0, '2017-09-11 15:37:34', '2017-09-11 15:37:34'),
(3525, '086319', '086300', 'Vaulted Metal-Framed Skylights', NULL, 0, 0, 0, '2017-09-11 15:37:40', '2017-09-11 15:37:40'),
(3526, '086323', '086300', 'Ridge Metal-Framed Skylights', NULL, 0, 0, 0, '2017-09-11 15:37:46', '2017-09-11 15:37:46'),
(3527, '086353', '086300', 'Motorized Metal-Framed Skylights', NULL, 0, 0, 0, '2017-09-11 15:37:52', '2017-09-11 15:37:52'),
(3528, '086400', '086000', 'Plastic-Framed Skylights', NULL, 0, 0, 0, '2017-09-11 15:37:59', '2017-09-11 15:37:59'),
(3529, '086500', '086000', 'Glazed Canopies', NULL, 0, 0, 0, '2017-09-11 15:38:05', '2017-09-11 15:38:05'),
(3530, '086513', '086500', 'Suspended Glazed Canopies', NULL, 0, 0, 0, '2017-09-11 15:38:12', '2017-09-11 15:38:12'),
(3531, '086700', '086000', 'Skylight Protection and Screens', NULL, 0, 0, 0, '2017-09-11 15:38:22', '2017-09-11 15:38:22'),
(3532, '087000', '080000', 'Hardware', NULL, 0, 0, 0, '2017-09-11 15:38:31', '2017-09-11 15:38:31'),
(3533, '087100', '087000', 'Door Hardware', NULL, 0, 0, 0, '2017-09-11 15:38:38', '2017-09-11 15:38:38'),
(3534, '087113', '087100', 'Automatic Door Operators', NULL, 0, 0, 0, '2017-09-11 15:38:44', '2017-09-11 15:38:44'),
(3535, '087153', '087100', 'Security Door Hardware', NULL, 0, 0, 0, '2017-09-11 15:38:50', '2017-09-11 15:38:50'),
(3536, '087500', '087000', 'Window Hardware', NULL, 0, 0, 0, '2017-09-11 15:41:21', '2017-09-11 15:41:21'),
(3537, '087513', '087500', 'Automatic Window Equipment', NULL, 0, 0, 0, '2017-09-11 15:42:40', '2017-09-11 15:42:40'),
(3538, '087516', '087500', 'Window Operators', NULL, 0, 0, 0, '2017-09-11 15:42:46', '2017-09-11 15:42:46'),
(3539, '087800', '087000', 'Special Function Hardware', NULL, 0, 0, 0, '2017-09-11 15:42:53', '2017-09-11 15:42:53'),
(3540, '087900', '087000', 'Hardware Accessories', NULL, 0, 0, 0, '2017-09-11 15:42:59', '2017-09-11 15:42:59'),
(3541, '087913', '087900', 'Key Storage Equipment', NULL, 0, 0, 0, '2017-09-11 15:43:05', '2017-09-11 15:43:05'),
(3542, '088000', '080000', 'Glazing', NULL, 0, 0, 0, '2017-09-11 15:43:41', '2017-09-11 15:43:41'),
(3543, '088100', '088000', 'Glass Glazing', NULL, 0, 0, 0, '2017-09-11 15:43:47', '2017-09-11 15:43:47'),
(3544, '088113', '088100', 'Decorative Glass Glazing', NULL, 0, 0, 0, '2017-09-11 15:43:54', '2017-09-11 15:43:54'),
(3545, '088123', '088100', 'Exterior Glass Glazing', NULL, 0, 0, 0, '2017-09-11 15:44:05', '2017-09-11 15:44:05'),
(3546, '088126', '088100', 'Interior Glass Glazing', NULL, 0, 0, 0, '2017-09-11 15:44:12', '2017-09-11 15:44:12'),
(3547, '088300', '088000', 'Mirrors', NULL, 0, 0, 0, '2017-09-11 15:44:20', '2017-09-11 15:44:20'),
(3548, '088313', '088300', 'Mirrored Glass Glazing', NULL, 0, 0, 0, '2017-09-11 15:44:27', '2017-09-11 15:44:27'),
(3549, '088316', '088300', 'Mirrored Plastic Glazing', NULL, 0, 0, 0, '2017-09-11 15:44:35', '2017-09-11 15:44:35'),
(3550, '088400', '088000', 'Plastic Glazing', NULL, 0, 0, 0, '2017-09-11 15:45:57', '2017-09-11 15:45:57'),
(3551, '088413', '088400', 'Decorative Plastic Glazing', NULL, 0, 0, 0, '2017-09-11 15:46:03', '2017-09-11 15:46:03'),
(3552, '088500', '088000', 'Glazing Accessories', NULL, 0, 0, 0, '2017-09-11 15:46:08', '2017-09-11 15:46:08'),
(3553, '088700', '088000', 'Glazing Surface Films', NULL, 0, 0, 0, '2017-09-11 15:46:15', '2017-09-11 15:46:15'),
(3554, '088713', '088700', 'Solar Control Films', NULL, 0, 0, 0, '2017-09-11 15:46:20', '2017-09-11 15:46:20'),
(3555, '088723', '088700', 'Safety and Security Films', NULL, 0, 0, 0, '2017-09-11 15:46:26', '2017-09-11 15:46:26'),
(3556, '088723.13', '088723', 'Safety Films', NULL, 0, 0, 0, '2017-09-11 15:46:34', '2017-09-11 15:46:34'),
(3557, '088723.16', '088723', 'Security Films', NULL, 0, 0, 0, '2017-09-11 15:46:43', '2017-09-11 15:46:43'),
(3558, '088726', '088700', 'Bird Control Film', NULL, 0, 0, 0, '2017-09-11 15:46:50', '2017-09-11 15:46:50'),
(3559, '088733', '088700', 'Decorative Films', NULL, 0, 0, 0, '2017-09-11 15:46:56', '2017-09-11 15:46:56'),
(3560, '088800', '088000', 'Special Function Glazing', NULL, 0, 0, 0, '2017-09-11 15:47:01', '2017-09-11 15:47:01'),
(3561, '088813', '088800', 'Fire-Resistant Glazing', NULL, 0, 0, 0, '2017-09-11 15:47:06', '2017-09-11 15:47:06'),
(3562, '088819', '088800', 'Hurricane-Resistant Glazing', NULL, 0, 0, 0, '2017-09-11 15:47:12', '2017-09-11 15:47:12'),
(3563, '088823', '088800', 'Cable Suspended Glazing', NULL, 0, 0, 0, '2017-09-11 15:47:18', '2017-09-11 15:47:18'),
(3564, '088833', '088800', 'Transparent Mirrored Glazing', NULL, 0, 0, 0, '2017-09-11 15:47:54', '2017-09-11 15:47:54'),
(3565, '088836', '088800', 'Switchable Glass', NULL, 0, 0, 0, '2017-09-11 15:47:59', '2017-09-11 15:47:59'),
(3566, '088839', '088800', 'Pressure-Resistant Glazing', NULL, 0, 0, 0, '2017-09-11 15:48:05', '2017-09-11 15:48:05'),
(3567, '088849', '088800', 'Radiation-Resistant Glazing', NULL, 0, 0, 0, '2017-09-11 15:48:11', '2017-09-11 15:48:11'),
(3568, '088853', '088800', 'Security Glazing', NULL, 0, 0, 0, '2017-09-11 15:48:19', '2017-09-11 15:48:19'),
(3569, '088856', '088800', 'Ballistics-Resistant Glazing', NULL, 0, 0, 0, '2017-09-11 15:48:24', '2017-09-11 15:48:24'),
(3570, '089000', '080000', 'Louvers and Vents', NULL, 0, 0, 0, '2017-09-11 15:48:31', '2017-09-11 15:48:31'),
(3571, '089100', '089000', 'Louvers', NULL, 0, 0, 0, '2017-09-11 15:48:36', '2017-09-11 15:48:36'),
(3572, '089113', '089100', 'Motorized Wall Louvers', NULL, 0, 0, 0, '2017-09-11 15:48:44', '2017-09-11 15:48:44'),
(3573, '089116', '089100', 'Operable Wall Louvers', NULL, 0, 0, 0, '2017-09-11 15:48:51', '2017-09-11 15:48:51'),
(3574, '089119', '089100', 'Fixed Louvers', NULL, 0, 0, 0, '2017-09-11 15:48:58', '2017-09-11 15:48:58'),
(3575, '089126', '089100', 'Door Louvers', NULL, 0, 0, 0, '2017-09-11 15:49:03', '2017-09-11 15:49:03'),
(3576, '089200', '089000', 'Louvered Equipment Enclosures', NULL, 0, 0, 0, '2017-09-11 15:51:06', '2017-09-11 15:51:06'),
(3577, '089500', '089000', 'Vents', NULL, 0, 0, 0, '2017-09-11 15:51:12', '2017-09-11 15:51:12'),
(3578, '089513', '089500', 'Soffit Vents', NULL, 0, 0, 0, '2017-09-11 15:51:39', '2017-09-11 15:51:39'),
(3579, '089516', '089500', 'Wall Vents', NULL, 0, 0, 0, '2017-09-11 15:52:27', '2017-09-11 15:52:27'),
(3580, '089533', '089500', 'Explosion Vents', NULL, 0, 0, 0, '2017-09-11 15:52:33', '2017-09-11 15:52:33'),
(3581, '090000', '0', 'Finishes', NULL, 0, 0, 0, '2017-09-11 16:00:10', '2017-09-11 16:00:10'),
(3582, '040120.91', '040120', 'Unit Masonry Restoration', NULL, 0, 0, 0, '2017-09-12 08:04:15', '2017-09-12 08:04:15'),
(3583, '040120.93', '040120', 'Testing and Sampling Brick Units for Restoration', NULL, 0, 0, 0, '2017-09-12 08:04:23', '2017-09-12 08:04:23'),
(3584, '090100', '090000', 'Maintenance of Finishes', NULL, 0, 0, 0, '2017-09-12 11:19:06', '2017-09-12 11:19:06'),
(3585, '090120', '090100', 'Maintenance of Plaster and Gypsum Board', NULL, 0, 0, 0, '2017-09-12 11:19:15', '2017-09-12 11:19:15'),
(3586, '090120.91', '090120', 'Plaster Restoration', NULL, 0, 0, 0, '2017-09-12 11:19:24', '2017-09-12 11:19:24'),
(3587, '090130', '090100', 'Maintenance of Tiling', NULL, 0, 0, 0, '2017-09-12 11:19:32', '2017-09-12 11:19:32'),
(3588, '090130.91', '090130', 'Tile Restoration', NULL, 0, 0, 0, '2017-09-12 11:19:39', '2017-09-12 11:19:39'),
(3589, '090150', '090100', 'Maintenance of Ceilings', NULL, 0, 0, 0, '2017-09-12 11:19:48', '2017-09-12 11:19:48'),
(3590, '090150.91', '090150', 'Ceiling Restoration', NULL, 0, 0, 0, '2017-09-12 11:19:58', '2017-09-12 11:19:58'),
(3591, '090160', '090100', 'Maintenance of Flooring', NULL, 0, 0, 0, '2017-09-12 11:20:09', '2017-09-12 11:20:09'),
(3592, '090160.91', '090160', 'Flooring Restoration', NULL, 0, 0, 0, '2017-09-12 11:20:18', '2017-09-12 11:20:18'),
(3593, '090170', '090100', 'Maintenance of Wall Finishes', NULL, 0, 0, 0, '2017-09-12 11:20:30', '2017-09-12 11:20:30'),
(3594, '090170.91', '090170', 'Wall Finish Restoration', NULL, 0, 0, 0, '2017-09-12 11:20:40', '2017-09-12 11:20:40'),
(3595, '090180', '090100', 'Maintenance of Acoustic Treatment', NULL, 0, 0, 0, '2017-09-12 11:20:48', '2017-09-12 11:20:48'),
(3596, '090190', '090100', 'Maintenance of Painting and Coating', NULL, 0, 0, 0, '2017-09-12 11:22:44', '2017-09-12 11:22:44'),
(3597, '090190.51', '090190', 'Paint Cleaning', NULL, 0, 0, 0, '2017-09-12 11:22:54', '2017-09-12 11:22:54'),
(3598, '090190.52', '090190', 'Maintenance Repainting', NULL, 0, 0, 0, '2017-09-12 11:23:04', '2017-09-12 11:23:04'),
(3599, '090190.53', '090190', 'Maintenance Coatings', NULL, 0, 0, 0, '2017-09-12 11:23:13', '2017-09-12 11:23:13'),
(3600, '090190.91', '090190', 'Repainting', NULL, 0, 0, 0, '2017-09-12 11:24:23', '2017-09-12 11:24:23'),
(3601, '090190.92', '090190', 'Coating Restoration', NULL, 0, 0, 0, '2017-09-12 11:24:36', '2017-09-12 11:24:36'),
(3602, '090190.93', '090190', 'Paint Preservation', NULL, 0, 0, 0, '2017-09-12 11:24:44', '2017-09-12 11:24:44'),
(3603, '090300', '090000', 'Conservation Treatment of Period Finishes', NULL, 0, 0, 0, '2017-09-12 11:24:55', '2017-09-12 11:24:55'),
(3604, '090321', '090300', 'Conservation Treatment for Period Plaster Assemblies', NULL, 0, 0, 0, '2017-09-12 11:25:03', '2017-09-12 11:25:03'),
(3605, '090325', '090300', 'Conservation Treatment for Period Plastering', NULL, 0, 0, 0, '2017-09-12 11:25:11', '2017-09-12 11:25:11'),
(3606, '090325.23', '090325', 'Conservation Treatment for Period Lime-Based Plaster', NULL, 0, 0, 0, '2017-09-12 11:25:20', '2017-09-12 11:25:20'),
(3607, '090330', '090300', 'Conservation Treatment for Period Tile', NULL, 0, 0, 0, '2017-09-12 11:25:28', '2017-09-12 11:25:28'),
(3608, '090350', '090300', 'Conservation Treatment for Period Ceilings', NULL, 0, 0, 0, '2017-09-12 11:25:35', '2017-09-12 11:25:35'),
(3609, '090351', '090300', 'Conservation Treatment for Period Suspended Ceilings', NULL, 0, 0, 0, '2017-09-12 11:25:43', '2017-09-12 11:25:43'),
(3610, '090356', '090300', 'Conservation Treatment for Textured Ceilings', NULL, 0, 0, 0, '2017-09-12 11:25:50', '2017-09-12 11:25:50'),
(3611, '090356.16', '090356', 'Conservation Treatment for Period Metal-Panel Textured Ceilings', NULL, 0, 0, 0, '2017-09-12 11:26:02', '2017-09-12 11:26:02'),
(3612, '090360', '090300', 'Conservation Treatment for Period Flooring', NULL, 0, 0, 0, '2017-09-12 11:26:12', '2017-09-12 11:26:12'),
(3613, '090363', '090300', 'Conservation Treatment for Period Masonry Flooring', NULL, 0, 0, 0, '2017-09-12 11:26:22', '2017-09-12 11:26:22'),
(3614, '090363.13', '090363', 'Conservation Treatment for Period Brick Flooring', NULL, 0, 0, 0, '2017-09-12 11:26:31', '2017-09-12 11:26:31'),
(3615, '090363.40', '090363', 'Conservation Treatment for Period Stone Flooring', NULL, 0, 0, 0, '2017-09-12 11:26:40', '2017-09-12 11:26:40'),
(3616, '090364', '090300', 'Conservation Treatment for Period Wood Flooring', NULL, 0, 0, 0, '2017-09-12 11:27:19', '2017-09-12 11:27:19'),
(3617, '090364.29', '090364', 'Conservation Treatment for Period Wood Strip and Plank Flooring', NULL, 0, 0, 0, '2017-09-12 11:27:29', '2017-09-12 11:27:29'),
(3618, '090365', '090300', 'Conservation Treatment for Period Resilient Flooring', NULL, 0, 0, 0, '2017-09-12 11:27:36', '2017-09-12 11:27:36'),
(3619, '090365.16', '090365', 'Conservation Treatment for Period Resilient Sheet Flooring', NULL, 0, 0, 0, '2017-09-12 11:27:44', '2017-09-12 11:27:44'),
(3620, '090366', '090300', 'Conservation Treatment for Period Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 11:27:52', '2017-09-12 11:27:52'),
(3621, '090370', '090300', 'Conservation Treatment for Period Wall Finishes', NULL, 0, 0, 0, '2017-09-12 11:27:59', '2017-09-12 11:27:59'),
(3622, '090372', '090300', 'Conservation Treatment for Period Wall Coverings', NULL, 0, 0, 0, '2017-09-12 11:28:06', '2017-09-12 11:28:06'),
(3623, '090390', '090300', 'Conservation Treatment for Period Painting and Coating', NULL, 0, 0, 0, '2017-09-12 11:28:15', '2017-09-12 11:28:15'),
(3624, '090391', '090300', 'Conservation Treatment for Period Painted Surfaces', NULL, 0, 0, 0, '2017-09-12 11:28:22', '2017-09-12 11:28:22'),
(3625, '090391.13', '090391', 'Conservation Treatment for Period Exterior Painting', NULL, 0, 0, 0, '2017-09-12 11:28:32', '2017-09-12 11:28:32'),
(3626, '090391.23', '090391', 'Conservation Treatment for Period Interior Painting', NULL, 0, 0, 0, '2017-09-12 11:28:43', '2017-09-12 11:28:43'),
(3627, '090500', '090000', 'Common Work Results for Finishes', NULL, 0, 0, 0, '2017-09-12 11:28:54', '2017-09-12 11:28:54'),
(3628, '090505', '090500', 'Selective Demolition for Finishes', NULL, 0, 0, 0, '2017-09-12 11:29:01', '2017-09-12 11:29:01'),
(3629, '090513', '090500', 'Common Finishes', NULL, 0, 0, 0, '2017-09-12 11:29:10', '2017-09-12 11:29:10'),
(3630, '090561', '090500', 'Common Work Results for Flooring Preparation', NULL, 0, 0, 0, '2017-09-12 11:29:28', '2017-09-12 11:29:28'),
(3631, '090571', '090500', 'Acoustic Underlayment', NULL, 0, 0, 0, '2017-09-12 11:30:39', '2017-09-12 11:30:39'),
(3632, '90561.13', '090561', 'Moisture Vapor Emission Control', NULL, 0, 0, 0, '2017-09-12 11:30:46', '2017-09-12 11:30:46'),
(3633, '090600', '090000', 'Schedules for Finishes', NULL, 0, 0, 0, '2017-09-12 11:30:55', '2017-09-12 11:30:55'),
(3634, '090600.13', '090600', 'Room Finish Schedule', NULL, 0, 0, 0, '2017-09-12 11:31:04', '2017-09-12 11:31:04'),
(3635, '090620', '090600', 'Schedules for Plaster and Gypsum Board', NULL, 0, 0, 0, '2017-09-12 11:31:58', '2017-09-12 11:31:58'),
(3636, '090630', '090600', 'Schedules for Tiling', NULL, 0, 0, 0, '2017-09-12 11:32:06', '2017-09-12 11:32:06'),
(3637, '090650', '090600', 'Schedules for Ceilings', NULL, 0, 0, 0, '2017-09-12 11:32:15', '2017-09-12 11:32:15'),
(3638, '090660', '090600', 'Schedules for Flooring', NULL, 0, 0, 0, '2017-09-12 11:32:23', '2017-09-12 11:32:23'),
(3639, '090670', '090600', 'Schedules for Wall Finishes', NULL, 0, 0, 0, '2017-09-12 11:32:32', '2017-09-12 11:32:32'),
(3640, '090680', '090600', 'Schedules for Acoustical Treatment', NULL, 0, 0, 0, '2017-09-12 11:32:40', '2017-09-12 11:32:40'),
(3641, '090690', '090600', 'Schedules for Painting and Coating', NULL, 0, 0, 0, '2017-09-12 11:32:47', '2017-09-12 11:32:47'),
(3642, '090690.13', '090690', 'Paint Schedule', NULL, 0, 0, 0, '2017-09-12 11:32:56', '2017-09-12 11:32:56'),
(3643, '090800', '090000', 'Commissioning of Finishes', NULL, 0, 0, 0, '2017-09-12 11:33:15', '2017-09-12 11:33:15'),
(3644, '092000', '090000', 'Plaster and Gypsum Board', NULL, 0, 0, 0, '2017-09-12 11:33:23', '2017-09-12 11:33:23'),
(3645, '092100', '092000', 'Plaster and Gypsum Board Assemblies', NULL, 0, 0, 0, '2017-09-12 11:33:33', '2017-09-12 11:33:33'),
(3646, '092113', '092100', 'Plaster Assemblies', NULL, 0, 0, 0, '2017-09-12 11:33:41', '2017-09-12 11:33:41'),
(3647, '092116', '092100', 'Gypsum Board Assemblies', NULL, 0, 0, 0, '2017-09-12 11:33:48', '2017-09-12 11:33:48'),
(3649, '092116.33', '092116', 'Gypsum Board Area Separation Wall Assemblies', NULL, 0, 0, 0, '2017-09-12 11:34:02', '2017-09-12 11:34:02'),
(3650, '092116.23', '092116', 'Gypsum Board Shaft Wall Assemblies', NULL, 0, 0, 0, '2017-09-12 11:34:11', '2017-09-12 11:34:11'),
(3651, '092200', '092000', 'Supports for Plaster and Gypsum Board', NULL, 0, 0, 0, '2017-09-12 11:34:18', '2017-09-12 11:34:18'),
(3652, '092213', '092200', 'Metal Furring', NULL, 0, 0, 0, '2017-09-12 11:34:26', '2017-09-12 11:34:26'),
(3653, '092213.13', '092213', 'Metal Channel Furring', NULL, 0, 0, 0, '2017-09-12 11:34:36', '2017-09-12 11:34:36'),
(3654, '092213.23', '092213', 'Resilient Channel Furring', NULL, 0, 0, 0, '2017-09-12 11:34:44', '2017-09-12 11:34:44'),
(3655, '092216', '092200', 'Non-Structural Metal Framing', NULL, 0, 0, 0, '2017-09-12 11:34:55', '2017-09-12 11:34:55'),
(3656, '092216.13', '092216', 'Non-Structural Metal Stud Framing', NULL, 0, 0, 0, '2017-09-12 11:35:06', '2017-09-12 11:35:06'),
(3657, '092226', '092200', 'Suspension Systems', NULL, 0, 0, 0, '2017-09-12 11:35:13', '2017-09-12 11:35:13'),
(3658, '092226.23', '092226', 'Metal Suspension Systems', NULL, 0, 0, 0, '2017-09-12 11:35:22', '2017-09-12 11:35:22'),
(3659, '092226.33', '092226', 'Plastic Suspension Systems', NULL, 0, 0, 0, '2017-09-12 11:35:32', '2017-09-12 11:35:32'),
(3660, '092236', '092200', 'Lath', NULL, 0, 0, 0, '2017-09-12 11:35:51', '2017-09-12 11:35:51'),
(3662, '092236.13', '092236', 'Gypsum Lath', NULL, 0, 0, 0, '2017-09-12 11:36:08', '2017-09-12 11:36:08'),
(3663, '092236.23', '092236', 'Metal Lath', NULL, 0, 0, 0, '2017-09-12 11:36:18', '2017-09-12 11:36:18'),
(3664, '092239', '092200', 'Veneer Plaster Base', NULL, 0, 0, 0, '2017-09-12 11:36:45', '2017-09-12 11:36:45'),
(3665, '092300', '092000', 'Gypsum Plastering', NULL, 0, 0, 0, '2017-09-12 11:36:54', '2017-09-12 11:36:54'),
(3666, '092313', '092300', 'Acoustical Gypsum Plastering', NULL, 0, 0, 0, '2017-09-12 11:37:03', '2017-09-12 11:37:03'),
(3667, '092382', '092300', 'Fireproof Gypsum Plastering', NULL, 0, 0, 0, '2017-09-12 11:37:12', '2017-09-12 11:37:12'),
(3668, '092400', '092000', 'Cement Plastering', NULL, 0, 0, 0, '2017-09-12 11:37:24', '2017-09-12 11:37:24'),
(3669, '092413', '092400', 'Adobe Finish', NULL, 0, 0, 0, '2017-09-12 11:37:32', '2017-09-12 11:37:32'),
(3670, '092423', '092400', 'Cement Stucco', NULL, 0, 0, 0, '2017-09-12 11:37:41', '2017-09-12 11:37:41'),
(3671, '092433', '092400', 'Cement Parging', NULL, 0, 0, 0, '2017-09-12 11:37:47', '2017-09-12 11:37:47'),
(3672, '092500', '092000', 'Other Plastering', NULL, 0, 0, 0, '2017-09-12 11:37:55', '2017-09-12 11:37:55'),
(3673, '092513', '092500', 'Acrylic Plastering', NULL, 0, 0, 0, '2017-09-12 11:38:03', '2017-09-12 11:38:03'),
(3674, '092513.13', '092513', 'Acrylic Plaster Finish', NULL, 0, 0, 0, '2017-09-12 11:38:13', '2017-09-12 11:38:13'),
(3675, '092523', '092500', 'Lime Based Plastering', NULL, 0, 0, 0, '2017-09-12 11:38:21', '2017-09-12 11:38:21'),
(3676, '092526', '092500', 'Natural Clay Plastering', NULL, 0, 0, 0, '2017-09-12 11:38:31', '2017-09-12 11:38:31'),
(3677, '092600', '092000', 'Veneer Plastering', NULL, 0, 0, 0, '2017-09-12 11:38:38', '2017-09-12 11:38:38'),
(3678, '092613', '092600', 'Gypsum Veneer Plastering', NULL, 0, 0, 0, '2017-09-12 11:38:47', '2017-09-12 11:38:47'),
(3679, '092700', '092000', 'Plaster Fabrications', NULL, 0, 0, 0, '2017-09-12 11:38:54', '2017-09-12 11:38:54'),
(3680, '092713', '092700', 'Glass-Fiber-Reinforced Gypsum Fabrications', NULL, 0, 0, 0, '2017-09-12 11:39:18', '2017-09-12 11:39:18'),
(3681, '092723', '092700', 'Simulated Plaster Fabrications', NULL, 0, 0, 0, '2017-09-12 11:39:26', '2017-09-12 11:39:26'),
(3682, '092800', '092000', 'Backing Boards and Underlayments', NULL, 0, 0, 0, '2017-09-12 11:39:33', '2017-09-12 11:39:33'),
(3683, '092813', '092800', 'Cementitious Backing Boards', NULL, 0, 0, 0, '2017-09-12 11:39:42', '2017-09-12 11:39:42'),
(3684, '092816', '092800', 'Glass-Mat Faced Gypsum Backing Boards', NULL, 0, 0, 0, '2017-09-12 11:39:49', '2017-09-12 11:39:49'),
(3685, '092819', '092800', 'Fibered Gypsum Backing Boards', NULL, 0, 0, 0, '2017-09-12 11:39:55', '2017-09-12 11:39:55'),
(3686, '092900', '092000', 'Gypsum Board', NULL, 0, 0, 0, '2017-09-12 11:40:03', '2017-09-12 11:40:03'),
(3687, '092982', '092900', 'Gypsum Board Fireproofing', NULL, 0, 0, 0, '2017-09-12 11:40:08', '2017-09-12 11:40:08'),
(3688, '093000', '090000', 'Tile', NULL, 0, 0, 0, '2017-09-12 11:40:16', '2017-09-12 11:40:16'),
(3689, '093013', '093000', 'Ceramic Tiling', NULL, 0, 0, 0, '2017-09-12 11:40:23', '2017-09-12 11:40:23'),
(3690, '093016', '093000', 'Quarry Tiling', NULL, 0, 0, 0, '2017-09-12 11:40:28', '2017-09-12 11:40:28'),
(3691, '093019', '093000', 'Paver Tiling', NULL, 0, 0, 0, '2017-09-12 11:40:33', '2017-09-12 11:40:33'),
(3692, '093023', '093000', 'Glass Mosaic Tiling', NULL, 0, 0, 0, '2017-09-12 11:40:40', '2017-09-12 11:40:40'),
(3693, '093026', '093000', 'Plastic Tiling', NULL, 0, 0, 0, '2017-09-12 11:40:48', '2017-09-12 11:40:48'),
(3694, '093029', '093000', 'Metal Tiling', NULL, 0, 0, 0, '2017-09-12 11:40:53', '2017-09-12 11:40:53'),
(3695, '093033', '093000', 'Stone Tiling', NULL, 0, 0, 0, '2017-09-12 11:40:59', '2017-09-12 11:40:59'),
(3696, '093036', '093000', 'Concrete Tiling', NULL, 0, 0, 0, '2017-09-12 11:41:06', '2017-09-12 11:41:06'),
(3697, '093039', '093000', 'Brick Tiling', NULL, 0, 0, 0, '2017-09-12 11:41:12', '2017-09-12 11:41:12'),
(3698, '093100', '093000', 'Thin-Set Tiling', NULL, 0, 0, 0, '2017-09-12 11:41:18', '2017-09-12 11:41:18'),
(3699, '093113', '093100', 'Thin-Set Ceramic Tiling', NULL, 0, 0, 0, '2017-09-12 11:41:26', '2017-09-12 11:41:26'),
(3700, '093116', '093100', 'Thin-Set Quarry Tiling', NULL, 0, 0, 0, '2017-09-12 11:41:34', '2017-09-12 11:41:34'),
(3701, '093119', '093100', 'Thin-Set Paver Tiling', NULL, 0, 0, 0, '2017-09-12 11:41:41', '2017-09-12 11:41:41'),
(3702, '093123', '093100', 'Thin-Set Glass Mosaic Tiling', NULL, 0, 0, 0, '2017-09-12 11:41:49', '2017-09-12 11:41:49'),
(3703, '093126', '093100', 'Thin-Set Plastic Tiling', NULL, 0, 0, 0, '2017-09-12 11:41:57', '2017-09-12 11:41:57'),
(3704, '093129', '093100', 'Thin-Set Metal Tiling', NULL, 0, 0, 0, '2017-09-12 11:42:04', '2017-09-12 11:42:04'),
(3705, '093133', '093100', 'Thin-Set Stone Tiling', NULL, 0, 0, 0, '2017-09-12 11:42:10', '2017-09-12 11:42:10'),
(3706, '093136', '093100', 'Thin-Set Concrete Tiling', NULL, 0, 0, 0, '2017-09-12 11:42:17', '2017-09-12 11:42:17'),
(3707, '093200', '093000', 'Mortar-Bed Tiling', NULL, 0, 0, 0, '2017-09-12 11:42:26', '2017-09-12 11:42:26'),
(3708, '093213', '093200', 'Mortar-Bed Ceramic Tiling', NULL, 0, 0, 0, '2017-09-12 11:42:34', '2017-09-12 11:42:34'),
(3709, '093216', '093200', 'Mortar-Bed Quarry Tiling', NULL, 0, 0, 0, '2017-09-12 11:42:40', '2017-09-12 11:42:40'),
(3710, '093219', '093200', 'Mortar-Bed Paver Tiling', NULL, 0, 0, 0, '2017-09-12 11:42:46', '2017-09-12 11:42:46'),
(3711, '093223', '093200', 'Mortar-Bed Glass Mosaic Tiling', NULL, 0, 0, 0, '2017-09-12 11:42:54', '2017-09-12 11:42:54'),
(3712, '093226', '093200', 'Mortar-Bed Plastic Tiling', NULL, 0, 0, 0, '2017-09-12 11:43:00', '2017-09-12 11:43:00'),
(3713, '093229', '093200', 'Mortar-Bed Metal Tiling', NULL, 0, 0, 0, '2017-09-12 11:43:09', '2017-09-12 11:43:09'),
(3714, '093233', '093200', 'Mortar-Bed Stone Tiling', NULL, 0, 0, 0, '2017-09-12 11:43:15', '2017-09-12 11:43:15'),
(3715, '093236', '093200', 'Mortar-Bed Concrete Tiling', NULL, 0, 0, 0, '2017-09-12 11:43:22', '2017-09-12 11:43:22'),
(3716, '093300', '093000', 'Conductive Tiling', NULL, 0, 0, 0, '2017-09-12 11:43:30', '2017-09-12 11:43:30'),
(3717, '093313', '093300', 'Conductive Ceramic Tiling', NULL, 0, 0, 0, '2017-09-12 11:43:39', '2017-09-12 11:43:39'),
(3718, '093316', '093300', 'Conductive Quarry Tiling', NULL, 0, 0, 0, '2017-09-12 11:43:45', '2017-09-12 11:43:45'),
(3719, '093319', '093300', 'Conductive Paver Tiling', NULL, 0, 0, 0, '2017-09-12 11:43:52', '2017-09-12 11:43:52'),
(3720, '093323', '093300', 'Conductive Glass Mosaic Tiling', NULL, 0, 0, 0, '2017-09-12 11:43:58', '2017-09-12 11:43:58'),
(3721, '093326', '093300', 'Conductive Glass Mosaic Tiling', NULL, 0, 0, 0, '2017-09-12 11:44:04', '2017-09-12 11:44:04'),
(3722, '093329', '093300', 'Conductive Metal Tiling', NULL, 0, 0, 0, '2017-09-12 11:44:10', '2017-09-12 11:44:10'),
(3723, '093333', '093300', 'Conductive Stone Tiling', NULL, 0, 0, 0, '2017-09-12 11:44:16', '2017-09-12 11:44:16'),
(3724, '093336', '093300', 'Conductive Concrete Tiling', NULL, 0, 0, 0, '2017-09-12 11:44:24', '2017-09-12 11:44:24'),
(3725, '093400', '093000', 'Waterproofing-Membrane Tiling', NULL, 0, 0, 0, '2017-09-12 11:44:31', '2017-09-12 11:44:31'),
(3726, '093413', '093400', 'Waterproofing-Membrane Ceramic Tiling', NULL, 0, 0, 0, '2017-09-12 11:44:38', '2017-09-12 11:44:38'),
(3727, '093416', '093400', 'Waterproofing-Membrane Quarry Tiling', NULL, 0, 0, 0, '2017-09-12 11:44:46', '2017-09-12 11:44:46'),
(3728, '093419', '093400', 'Waterproofing-Membrane Paver Tiling', NULL, 0, 0, 0, '2017-09-12 11:44:54', '2017-09-12 11:44:54'),
(3729, '093423', '093400', 'Waterproofing-Membrane Glass Mosaic Tiling', NULL, 0, 0, 0, '2017-09-12 11:45:01', '2017-09-12 11:45:01'),
(3730, '093426', '093400', 'Waterproofing-Membrane Plastic Tiling', NULL, 0, 0, 0, '2017-09-12 11:45:07', '2017-09-12 11:45:07'),
(3731, '093429', '093400', 'Waterproofing-Membrane Metal Tiling', NULL, 0, 0, 0, '2017-09-12 11:45:15', '2017-09-12 11:45:15'),
(3732, '093433', '093400', 'Waterproofing-Membrane Stone Tiling', NULL, 0, 0, 0, '2017-09-12 11:45:22', '2017-09-12 11:45:22'),
(3733, '093436', '093400', 'Waterproofing-Membrane Concrete Tiling', NULL, 0, 0, 0, '2017-09-12 11:45:28', '2017-09-12 11:45:28'),
(3734, '093500', '093000', 'Chemical-Resistant Tiling', NULL, 0, 0, 0, '2017-09-12 11:45:33', '2017-09-12 11:45:33'),
(3735, '093513', '093500', 'Chemical-Resistant Ceramic Tiling', NULL, 0, 0, 0, '2017-09-12 11:45:46', '2017-09-12 11:45:46'),
(3736, '093516', '093500', 'Chemical-Resistant Quarry Tiling', NULL, 0, 0, 0, '2017-09-12 11:45:52', '2017-09-12 11:45:52'),
(3737, '093519', '093500', 'Chemical-Resistant Paver Tiling', NULL, 0, 0, 0, '2017-09-12 11:45:59', '2017-09-12 11:45:59'),
(3738, '093523', '093500', 'Chemical-Resistant Glass Mosaic Tiling', NULL, 0, 0, 0, '2017-09-12 11:46:06', '2017-09-12 11:46:06'),
(3739, '093526', '093500', 'Chemical-Resistant Plastic Tiling', NULL, 0, 0, 0, '2017-09-12 11:46:14', '2017-09-12 11:46:14'),
(3740, '093529', '093500', 'Chemical-Resistant Metal Tiling', NULL, 0, 0, 0, '2017-09-12 11:46:21', '2017-09-12 11:46:21'),
(3741, '093533', '093500', 'Chemical-Resistant Stone Tiling', NULL, 0, 0, 0, '2017-09-12 11:46:27', '2017-09-12 11:46:27'),
(3742, '093536', '093500', 'Chemical-Resistant Concrete Tiling', NULL, 0, 0, 0, '2017-09-12 11:46:35', '2017-09-12 11:46:35'),
(3743, '095000', '090000', 'Ceilings', NULL, 0, 0, 0, '2017-09-12 11:46:44', '2017-09-12 11:46:44'),
(3744, '095100', '095000', 'Acoustical Ceilings', NULL, 0, 0, 0, '2017-09-12 11:47:15', '2017-09-12 11:47:15'),
(3745, '095113', '095100', 'Acoustical Panel Ceilings', NULL, 0, 0, 0, '2017-09-12 11:47:21', '2017-09-12 11:47:21'),
(3746, '095114', '095100', 'Acoustical Fabric-Faced Panel Ceilings', NULL, 0, 0, 0, '2017-09-12 11:47:27', '2017-09-12 11:47:27'),
(3747, '095123', '095100', 'Acoustical Tile Ceilings', NULL, 0, 0, 0, '2017-09-12 11:47:34', '2017-09-12 11:47:34'),
(3748, '095126', '095100', 'Acoustical Wood Ceilings', NULL, 0, 0, 0, '2017-09-12 11:47:42', '2017-09-12 11:47:42'),
(3749, '095133', '095100', 'Acoustical Metal Pan Ceilings', NULL, 0, 0, 0, '2017-09-12 11:47:48', '2017-09-12 11:47:48'),
(3750, '095153', '095100', 'Direct-Applied Acoustical Ceilings', NULL, 0, 0, 0, '2017-09-12 11:48:41', '2017-09-12 11:48:41'),
(3751, '095300', '095000', 'Acoustical Ceiling Suspension Assemblies', NULL, 0, 0, 0, '2017-09-12 11:48:51', '2017-09-12 11:48:51'),
(3752, '095313', '095300', 'Curved Profile Ceiling Suspension Assemblies', NULL, 0, 0, 0, '2017-09-12 11:48:59', '2017-09-12 11:48:59'),
(3753, '095323', '095300', 'Metal Acoustical Ceiling Suspension Assemblies', NULL, 0, 0, 0, '2017-09-12 11:49:15', '2017-09-12 11:49:15'),
(3754, '095333', '095300', 'Plastic Acoustical Ceiling Suspension Assemblies', NULL, 0, 0, 0, '2017-09-12 11:49:22', '2017-09-12 11:49:22'),
(3755, '095400', '095000', 'Specialty Ceilings', NULL, 0, 0, 0, '2017-09-12 11:49:31', '2017-09-12 11:49:31'),
(3756, '095413', '095400', 'Open Metal Mesh Ceilings', NULL, 0, 0, 0, '2017-09-12 11:49:38', '2017-09-12 11:49:38'),
(3757, '095423', '095400', 'Linear Metal Ceilings', NULL, 0, 0, 0, '2017-09-12 11:49:46', '2017-09-12 11:49:46'),
(3758, '095426', '095400', 'Suspended Wood Ceilings', NULL, 0, 0, 0, '2017-09-12 11:49:56', '2017-09-12 11:49:56'),
(3759, '095429', '095400', 'Suspended Plastic Ceilings', NULL, 0, 0, 0, '2017-09-12 11:50:05', '2017-09-12 11:50:05'),
(3760, '095433', '095400', 'Decorative Panel Ceilings', NULL, 0, 0, 0, '2017-09-12 11:50:14', '2017-09-12 11:50:14'),
(3761, '095436', '095400', 'Suspended Decorative Grids', NULL, 0, 0, 0, '2017-09-12 11:50:22', '2017-09-12 11:50:22'),
(3762, '095443', '095400', 'Stretched-Fabric Ceiling Systems', NULL, 0, 0, 0, '2017-09-12 11:50:31', '2017-09-12 11:50:31'),
(3763, '095446', '095400', 'Fabric-Wrapped Ceiling Panels', NULL, 0, 0, 0, '2017-09-12 11:50:38', '2017-09-12 11:50:38'),
(3764, '095453', '095400', 'Fiberglass Reinforced Panel Ceilings', NULL, 0, 0, 0, '2017-09-12 11:50:45', '2017-09-12 11:50:45'),
(3765, '095600', '095000', 'Textured Ceilings', NULL, 0, 0, 0, '2017-09-12 11:50:55', '2017-09-12 11:50:55'),
(3766, '095613', '095600', 'Gypsum-Panel Textured Ceilings', NULL, 0, 0, 0, '2017-09-12 11:51:03', '2017-09-12 11:51:03'),
(3767, '095616', '095600', 'Metal-Panel Textured Ceilings', NULL, 0, 0, 0, '2017-09-12 11:51:12', '2017-09-12 11:51:12'),
(3768, '095700', '095000', 'Special Function Ceilings', NULL, 0, 0, 0, '2017-09-12 12:08:06', '2017-09-12 12:08:06'),
(3769, '095753', '095700', 'Security Ceiling Assemblies', NULL, 0, 0, 0, '2017-09-12 12:08:15', '2017-09-12 12:08:15'),
(3770, '095800', '095000', 'Integrated Ceiling Assemblies', NULL, 0, 0, 0, '2017-09-12 12:08:23', '2017-09-12 12:08:23'),
(3771, '096000', '090000', 'Flooring', NULL, 0, 0, 0, '2017-09-12 12:08:30', '2017-09-12 12:08:30'),
(3772, '096100', '096000', 'Flooring Treatment', NULL, 0, 0, 0, '2017-09-12 12:08:39', '2017-09-12 12:08:39'),
(3773, '096113', '096100', 'Slip-Resistant Flooring Treatment', NULL, 0, 0, 0, '2017-09-12 12:08:50', '2017-09-12 12:08:50'),
(3774, '096119', '096100', 'Concrete Floor Staining', NULL, 0, 0, 0, '2017-09-12 12:08:57', '2017-09-12 12:08:57'),
(3775, '096136', '096100', 'Static-Resistant Flooring Treatment', NULL, 0, 0, 0, '2017-09-12 12:09:04', '2017-09-12 12:09:04'),
(3776, '096200', '096000', 'Specialty Flooring', NULL, 0, 0, 0, '2017-09-12 12:09:12', '2017-09-12 12:09:12'),
(3777, '096213', '096200', 'Asphaltic Plank Flooring', NULL, 0, 0, 0, '2017-09-12 12:09:28', '2017-09-12 12:09:28'),
(3778, '096219', '096200', 'Laminate Flooring', NULL, 0, 0, 0, '2017-09-12 12:09:35', '2017-09-12 12:09:35'),
(3779, '096223', '096200', 'Bamboo Flooring', NULL, 0, 0, 0, '2017-09-12 12:09:43', '2017-09-12 12:09:43'),
(3780, '096226', '096200', 'Leather Flooring', NULL, 0, 0, 0, '2017-09-12 12:09:51', '2017-09-12 12:09:51'),
(3781, '096229', '096200', 'Cork Flooring', NULL, 0, 0, 0, '2017-09-12 12:09:59', '2017-09-12 12:09:59'),
(3782, '096235', '096200', 'Acid-Resistant Flooring', NULL, 0, 0, 0, '2017-09-12 12:10:07', '2017-09-12 12:10:07'),
(3783, '096248', '096200', 'Acoustic Flooring', NULL, 0, 0, 0, '2017-09-12 12:10:16', '2017-09-12 12:10:16'),
(3784, '096253', '096200', 'Synthetic Turf Flooring', NULL, 0, 0, 0, '2017-09-12 12:10:23', '2017-09-12 12:10:23'),
(3785, '096263', '096200', 'Metal Flooring', NULL, 0, 0, 0, '2017-09-12 12:10:31', '2017-09-12 12:10:31'),
(3786, '096263.13', '096263', 'Aluminum Flooring', NULL, 0, 0, 0, '2017-09-12 12:10:42', '2017-09-12 12:10:42'),
(3787, '096362.16', '096263', 'Stainless Steel Flooring', NULL, 0, 0, 0, '2017-09-12 12:10:52', '2017-09-12 12:10:52'),
(3788, '096283', '096200', 'Structural Glass Flooring', NULL, 0, 0, 0, '2017-09-12 12:10:59', '2017-09-12 12:10:59'),
(3789, '096300', '096000', 'Masonry Flooring', NULL, 0, 0, 0, '2017-09-12 12:11:06', '2017-09-12 12:11:06'),
(3790, '096313', '096300', 'Brick Flooring', NULL, 0, 0, 0, '2017-09-12 12:11:13', '2017-09-12 12:11:13'),
(3791, '096340', '096300', 'Stone Flooring', NULL, 0, 0, 0, '2017-09-12 12:11:22', '2017-09-12 12:11:22'),
(3792, '096343', '096300', 'Composition Stone Flooring', NULL, 0, 0, 0, '2017-09-12 12:11:31', '2017-09-12 12:11:31'),
(3793, '096400', '096000', 'Wood Flooring', NULL, 0, 0, 0, '2017-09-12 12:11:38', '2017-09-12 12:11:38'),
(3794, '096416', '096400', 'Wood Block Flooring', NULL, 0, 0, 0, '2017-09-12 12:11:45', '2017-09-12 12:11:45'),
(3795, '096419', '096400', 'Wood Composition Flooring', NULL, 0, 0, 0, '2017-09-12 12:11:53', '2017-09-12 12:11:53'),
(3796, '096423', '096400', 'Wood Parquet Flooring', NULL, 0, 0, 0, '2017-09-12 12:11:59', '2017-09-12 12:11:59'),
(3797, '096423.13', '096423', 'Acrylic-Impregnated Wood Parquet Flooring', NULL, 0, 0, 0, '2017-09-12 12:12:08', '2017-09-12 12:12:08'),
(3798, '096429', '096400', 'Wood Strip and Plank Flooring', NULL, 0, 0, 0, '2017-09-12 12:12:17', '2017-09-12 12:12:17'),
(3799, '096433', '096400', 'Laminated Wood Flooring', NULL, 0, 0, 0, '2017-09-12 12:12:24', '2017-09-12 12:12:24'),
(3800, '096453', '096400', 'Resilient Wood Flooring Assemblies', NULL, 0, 0, 0, '2017-09-12 12:12:30', '2017-09-12 12:12:30'),
(3801, '096466', '096400', 'Wood Athletic Flooring', NULL, 0, 0, 0, '2017-09-12 12:12:36', '2017-09-12 12:12:36'),
(3802, '096500', '096000', 'Resilient Flooring', NULL, 0, 0, 0, '2017-09-12 12:12:43', '2017-09-12 12:12:43'),
(3803, '096513', '096500', 'Resilient Base and Accessories', NULL, 0, 0, 0, '2017-09-12 12:12:51', '2017-09-12 12:12:51'),
(3804, '096513.13', '096513', 'Resilient Base', NULL, 0, 0, 0, '2017-09-12 12:13:00', '2017-09-12 12:13:00'),
(3805, '096513.23', '096513', 'Resilient Stair Treads and Risers', NULL, 0, 0, 0, '2017-09-12 12:13:08', '2017-09-12 12:13:08'),
(3806, '096513.26', '096513', 'Resilient Stair Nosings', NULL, 0, 0, 0, '2017-09-12 12:13:17', '2017-09-12 12:13:17'),
(3807, '096516', '096500', 'Resilient Sheet Flooring', NULL, 0, 0, 0, '2017-09-12 12:13:28', '2017-09-12 12:13:28'),
(3808, '096516.23', '096516', 'Vinyl Sheet Flooring', NULL, 0, 0, 0, '2017-09-12 12:13:37', '2017-09-12 12:13:37'),
(3809, '096516.33', '096516', 'Rubber Sheet Flooring', NULL, 0, 0, 0, '2017-09-12 12:13:45', '2017-09-12 12:13:45'),
(3810, '096516.43', '096516', 'PVC-Free Sheet Flooring', NULL, 0, 0, 0, '2017-09-12 12:13:54', '2017-09-12 12:13:54'),
(3811, '096600', '096000', 'Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:14:02', '2017-09-12 12:14:02'),
(3812, '096613', '096600', 'Portland Cement Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:14:09', '2017-09-12 12:14:09'),
(3813, '096613.13', '096613', 'Sand Cushion Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:14:18', '2017-09-12 12:14:18'),
(3815, '096613.16', '096613', 'Monolithic Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:14:33', '2017-09-12 12:14:33'),
(3816, '096613.19', '096613', 'Bonded Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:14:41', '2017-09-12 12:14:41'),
(3817, '096613.23', '096613', 'Palladina Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:14:52', '2017-09-12 12:14:52'),
(3818, '096613.26', '096613', 'Rustic Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:15:02', '2017-09-12 12:15:02'),
(3819, '096613.33', '096613', 'Structural Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:15:10', '2017-09-12 12:15:10'),
(3820, '096616', '096600', 'Terrazzo Floor Tile', NULL, 0, 0, 0, '2017-09-12 12:15:19', '2017-09-12 12:15:19'),
(3821, '096616.13', '096616', 'Portland Cement Terrazzo Floor Tile', NULL, 0, 0, 0, '2017-09-12 12:15:30', '2017-09-12 12:15:30'),
(3822, '096616.16', '096616', 'Plastic-Matrix Terrazzo Floor Tile', NULL, 0, 0, 0, '2017-09-12 12:15:39', '2017-09-12 12:15:39'),
(3823, '096623', '096600', 'Resinous Matrix Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:15:52', '2017-09-12 12:15:52'),
(3824, '096623.13', '096623', 'Polyacrylate Modified Cementitious Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:20:20', '2017-09-12 12:20:20'),
(3825, '096623.16', '096623', 'Epoxy-Resin Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:20:31', '2017-09-12 12:20:31'),
(3826, '096623.19', '096623', 'Polyester-Resin Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:20:42', '2017-09-12 12:20:42'),
(3827, '096633', '096600', 'Conductive Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:20:52', '2017-09-12 12:20:52'),
(3828, '096633.13', '096633', 'Conductive Epoxy-Resin Terrazzo', NULL, 0, 0, 0, '2017-09-12 12:21:02', '2017-09-12 12:21:02'),
(3829, '096633.16', '096633', 'Conductive Polyester-Resin Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:21:13', '2017-09-12 12:21:13'),
(3830, '096633.19', '096633', 'Conductive Plastic-Matrix Terrazzo Flooring', NULL, 0, 0, 0, '2017-09-12 12:21:24', '2017-09-12 12:21:24'),
(3831, '096700', '096000', 'Fluid-Applied Flooring', NULL, 0, 0, 0, '2017-09-12 12:21:35', '2017-09-12 12:21:35'),
(3832, '096713', '096700', 'Elastomeric Liquid Flooring', NULL, 0, 0, 0, '2017-09-12 12:21:43', '2017-09-12 12:21:43'),
(3833, '096713.33', '096713', 'Conductive Elastomeric Liquid Flooring', NULL, 0, 0, 0, '2017-09-12 12:21:53', '2017-09-12 12:21:53'),
(3834, '096716', '096700', 'Epoxy-Marble Chip Flooring', NULL, 0, 0, 0, '2017-09-12 12:22:03', '2017-09-12 12:22:03'),
(3835, '096719', '096700', 'Magnesium-Oxychloride Flooring', NULL, 0, 0, 0, '2017-09-12 12:22:13', '2017-09-12 12:22:13'),
(3836, '096723', '096700', 'Resinous Flooring', NULL, 0, 0, 0, '2017-09-12 12:22:21', '2017-09-12 12:22:21'),
(3837, '096726', '096700', 'Quartz Flooring', NULL, 0, 0, 0, '2017-09-12 12:22:30', '2017-09-12 12:22:30'),
(3838, '096766', '096700', 'Fluid-Applied Athletic Flooring', NULL, 0, 0, 0, '2017-09-12 12:22:39', '2017-09-12 12:22:39'),
(3839, '096800', '096000', 'Carpeting', NULL, 0, 0, 0, '2017-09-12 12:22:47', '2017-09-12 12:22:47'),
(3840, '096813', '096800', 'Tile Carpeting', NULL, 0, 0, 0, '2017-09-12 12:22:55', '2017-09-12 12:22:55'),
(3841, '096816', '096800', 'Sheet Carpeting', NULL, 0, 0, 0, '2017-09-12 12:23:04', '2017-09-12 12:23:04'),
(3842, '096900', '096000', 'Access Flooring', NULL, 0, 0, 0, '2017-09-12 12:23:12', '2017-09-12 12:23:12'),
(3843, '096913', '096900', 'Rigid-Grid Access Flooring', NULL, 0, 0, 0, '2017-09-12 12:23:20', '2017-09-12 12:23:20'),
(3844, '096916', '096900', 'Snap-on Stringer Access Flooring', NULL, 0, 0, 0, '2017-09-12 12:23:32', '2017-09-12 12:23:32'),
(3845, '096919', '096900', 'Stringerless Access Flooring', NULL, 0, 0, 0, '2017-09-12 12:23:40', '2017-09-12 12:23:40'),
(3846, '096933', '096900', 'Low-Profile Fixed Height Access Flooring', NULL, 0, 0, 0, '2017-09-12 12:23:49', '2017-09-12 12:23:49'),
(3847, '096953', '096900', 'Access Flooring Accessories', NULL, 0, 0, 0, '2017-09-12 12:23:56', '2017-09-12 12:23:56'),
(3848, '096956', '096900', 'Access Flooring Stairs and Stringers', NULL, 0, 0, 0, '2017-09-12 12:24:03', '2017-09-12 12:24:03'),
(3849, '097000', '090000', 'Wall Finishes', NULL, 0, 0, 0, '2017-09-12 12:24:12', '2017-09-12 12:24:12'),
(3850, '097200', '097000', 'Wall Coverings', NULL, 0, 0, 0, '2017-09-12 12:24:27', '2017-09-12 12:24:27'),
(3852, '097213', '097200', 'Cork Wall Coverings', NULL, 0, 0, 0, '2017-09-12 12:24:45', '2017-09-12 12:24:45'),
(3853, '097216', '097200', 'Vinyl-Coated Fabric Wall Coverings', NULL, 0, 0, 0, '2017-09-12 12:24:53', '2017-09-12 12:24:53'),
(3854, '097216.13', '097216', 'Flexible Vinyl Wall Coverings', NULL, 0, 0, 0, '2017-09-12 12:25:05', '2017-09-12 12:25:05'),
(3855, '097216.16', '097216', 'Rigid-Sheet Vinyl Wall Coverings', NULL, 0, 0, 0, '2017-09-12 12:25:17', '2017-09-12 12:25:17'),
(3856, '097219', '097200', 'Textile Wall Coverings', NULL, 0, 0, 0, '2017-09-12 12:25:41', '2017-09-12 12:25:41'),
(3857, '097223', '097200', 'Wallpapering', NULL, 0, 0, 0, '2017-09-12 12:25:48', '2017-09-12 12:25:48'),
(3858, '097300', '097000', 'Wall Carpeting', NULL, 0, 0, 0, '2017-09-12 12:25:56', '2017-09-12 12:25:56'),
(3859, '097400', '097000', 'Flexible Wood Sheets', NULL, 0, 0, 0, '2017-09-12 12:26:04', '2017-09-12 12:26:04'),
(3860, '097413', '097400', 'Wood Wall Coverings', NULL, 0, 0, 0, '2017-09-12 12:26:14', '2017-09-12 12:26:14'),
(3861, '097416', '097400', 'Flexible Wood Veneers', NULL, 0, 0, 0, '2017-09-12 12:26:22', '2017-09-12 12:26:22'),
(3862, '097500', '097000', 'Stone Facing', NULL, 0, 0, 0, '2017-09-12 12:26:30', '2017-09-12 12:26:30'),
(3863, '097513', '097500', 'Stone Wall Facing', NULL, 0, 0, 0, '2017-09-12 12:26:40', '2017-09-12 12:26:40'),
(3864, '097519', '097500', 'Stone Trim', NULL, 0, 0, 0, '2017-09-12 12:26:46', '2017-09-12 12:26:46'),
(3865, '097519.13', '097519', 'Stone Base', NULL, 0, 0, 0, '2017-09-12 12:26:56', '2017-09-12 12:26:56'),
(3866, '097519.23', '097519', 'Stone Window Stools', NULL, 0, 0, 0, '2017-09-12 12:27:04', '2017-09-12 12:27:04'),
(3867, '097523', '097500', 'Simulated Stone Wall Facing', NULL, 0, 0, 0, '2017-09-12 12:27:12', '2017-09-12 12:27:12'),
(3868, '097600', '097000', 'Plastic Blocks', NULL, 0, 0, 0, '2017-09-12 12:27:20', '2017-09-12 12:27:20'),
(3869, '097700', '097000', 'Special Wall Surfacing', NULL, 0, 0, 0, '2017-09-12 12:27:28', '2017-09-12 12:27:28'),
(3870, '097713', '097700', 'Stretched-Fabric Wall Systems', NULL, 0, 0, 0, '2017-09-12 12:27:38', '2017-09-12 12:27:38'),
(3871, '097723', '097700', 'Fabric-Wrapped Panels', NULL, 0, 0, 0, '2017-09-12 12:27:46', '2017-09-12 12:27:46'),
(3872, '097733', '097700', 'Terrazzo Wall Finish', NULL, 0, 0, 0, '2017-09-12 12:27:54', '2017-09-12 12:27:54'),
(3873, '097753', '097700', 'Vegetated Wall Systems', NULL, 0, 0, 0, '2017-09-12 12:28:01', '2017-09-12 12:28:01'),
(3874, '097800', '097000', 'Interior Wall Paneling', NULL, 0, 0, 0, '2017-09-12 12:28:10', '2017-09-12 12:28:10'),
(3875, '097813', '097800', 'Metal Interior Wall Paneling', NULL, 0, 0, 0, '2017-09-12 12:28:38', '2017-09-12 12:28:38'),
(3876, '097816', '097800', 'Stone-Faced Interior Wall Paneling', NULL, 0, 0, 0, '2017-09-12 12:28:45', '2017-09-12 12:28:45'),
(3877, '097819', '097800', 'Cementitious Interior Wall Paneling', NULL, 0, 0, 0, '2017-09-12 12:28:53', '2017-09-12 12:28:53'),
(3878, '097823', '097800', 'Phenolic Interior Wall Paneling', NULL, 0, 0, 0, '2017-09-12 12:29:00', '2017-09-12 12:29:00'),
(3879, '098000', '090000', 'Acoustical Treatment', NULL, 0, 0, 0, '2017-09-12 12:29:07', '2017-09-12 12:29:07'),
(3880, '098100', '098000', 'Acoustic Insulation', NULL, 0, 0, 0, '2017-09-12 12:29:14', '2017-09-12 12:29:14'),
(3881, '098113', '098100', 'Acoustic Board Insulation', NULL, 0, 0, 0, '2017-09-12 12:29:22', '2017-09-12 12:29:22'),
(3882, '098116', '098100', 'Acoustic Blanket Insulation', NULL, 0, 0, 0, '2017-09-12 12:29:28', '2017-09-12 12:29:28'),
(3883, '098129', '098100', 'Sprayed Acoustic Insulation', NULL, 0, 0, 0, '2017-09-12 12:29:35', '2017-09-12 12:29:35'),
(3884, '098300', '098000', 'Acoustic Finishes', NULL, 0, 0, 0, '2017-09-12 12:29:51', '2017-09-12 12:29:51'),
(3885, '098313', '098300', 'Acoustic Wall Coating', NULL, 0, 0, 0, '2017-09-12 12:29:58', '2017-09-12 12:29:58'),
(3886, '098316', '098300', 'Acoustic Ceiling Coating', NULL, 0, 0, 0, '2017-09-12 12:30:05', '2017-09-12 12:30:05'),
(3887, '098322', '098300', 'Acoustic Drapery', NULL, 0, 0, 0, '2017-09-12 12:30:12', '2017-09-12 12:30:12'),
(3888, '098400', '098000', 'Acoustic  Room Components', NULL, 0, 0, 0, '2017-09-12 13:35:18', '2017-09-12 13:35:18'),
(3889, '098413', '098400', 'Fixed Sound-Absorptive Panels', NULL, 0, 0, 0, '2017-09-12 13:35:27', '2017-09-12 13:35:27'),
(3890, '098414', '098400', 'Acoustic Stretched-Fabric Wall Systems', NULL, 0, 0, 0, '2017-09-12 13:35:34', '2017-09-12 13:35:34'),
(3891, '098416', '098400', 'Fixed Sound-Reflective Panels', NULL, 0, 0, 0, '2017-09-12 13:35:40', '2017-09-12 13:35:40'),
(3892, '098423', '098400', 'Moveable Sound-Absorptive Panels', NULL, 0, 0, 0, '2017-09-12 13:39:42', '2017-09-12 13:39:42'),
(3893, '098426', '098400', 'Moveable Sound-Reflective Panels', NULL, 0, 0, 0, '2017-09-12 13:39:51', '2017-09-12 13:39:51'),
(3894, '098433', '098400', 'Sound-Absorbing Wall Units', NULL, 0, 0, 0, '2017-09-12 13:39:58', '2017-09-12 13:39:58'),
(3895, '098436', '098400', 'Sound-Absorbing Ceiling Units', NULL, 0, 0, 0, '2017-09-12 13:40:05', '2017-09-12 13:40:05'),
(3896, '099000', '090000', 'Paints and Coatings', NULL, 0, 0, 0, '2017-09-12 13:40:12', '2017-09-12 13:40:12'),
(3897, '099100', '099000', 'Painting', NULL, 0, 0, 0, '2017-09-12 13:40:18', '2017-09-12 13:40:18'),
(3898, '099113', '099100', 'Exterior Painting', NULL, 0, 0, 0, '2017-09-12 13:40:26', '2017-09-12 13:40:26'),
(3899, '099123', '099100', 'Interior Painting', NULL, 0, 0, 0, '2017-09-12 13:40:32', '2017-09-12 13:40:32'),
(3900, '099300', '099000', 'Staining and Transparent Finishing', NULL, 0, 0, 0, '2017-09-12 13:40:40', '2017-09-12 13:40:40'),
(3901, '099313', '099300', 'Exterior Staining and Finishing', NULL, 0, 0, 0, '2017-09-12 13:40:46', '2017-09-12 13:40:46'),
(3902, '099313.13', '099313', 'Exterior Staining', NULL, 0, 0, 0, '2017-09-12 13:40:54', '2017-09-12 13:40:54'),
(3903, '099313.53', '099313', 'Exterior Finishing', NULL, 0, 0, 0, '2017-09-12 13:41:03', '2017-09-12 13:41:03'),
(3904, '099323', '099300', 'Interior Staining and Finishing', NULL, 0, 0, 0, '2017-09-12 13:41:12', '2017-09-12 13:41:12'),
(3905, '099323.13', '099323', 'Interior Staining', NULL, 0, 0, 0, '2017-09-12 13:41:22', '2017-09-12 13:41:22'),
(3906, '099323.53', '099323', 'Interior Finishing', NULL, 0, 0, 0, '2017-09-12 13:41:33', '2017-09-12 13:41:33'),
(3907, '099400', '099000', 'Decorative Finishing', NULL, 0, 0, 0, '2017-09-12 13:41:43', '2017-09-12 13:41:43'),
(3908, '099413', '099400', 'Textured Finishing', NULL, 0, 0, 0, '2017-09-12 13:41:49', '2017-09-12 13:41:49'),
(3909, '099416', '099400', 'Faux Finishing', NULL, 0, 0, 0, '2017-09-12 13:41:59', '2017-09-12 13:41:59'),
(3910, '099419', '099400', 'Multicolor Interior Finishing', NULL, 0, 0, 0, '2017-09-12 13:42:08', '2017-09-12 13:42:08'),
(3911, '099423', '099400', 'Gilding', NULL, 0, 0, 0, '2017-09-12 13:42:14', '2017-09-12 13:42:14'),
(3912, '099600', '099000', 'High-Performance Coatings', NULL, 0, 0, 0, '2017-09-12 13:42:21', '2017-09-12 13:42:21'),
(3913, '099613', '099600', 'Abrasion-Resistant Coatings', NULL, 0, 0, 0, '2017-09-12 13:42:29', '2017-09-12 13:42:29'),
(3914, '099623', '099600', 'Graffiti-Resistant Coatings', NULL, 0, 0, 0, '2017-09-12 13:42:36', '2017-09-12 13:42:36'),
(3915, '099626', '099600', 'Marine Coatings', NULL, 0, 0, 0, '2017-09-12 13:42:46', '2017-09-12 13:42:46'),
(3916, '099633', '099600', 'High-Temperature-Resistant Coatings', NULL, 0, 0, 0, '2017-09-12 13:42:53', '2017-09-12 13:42:53'),
(3917, '099635', '099600', 'Chemical-Resistant Coatings', NULL, 0, 0, 0, '2017-09-12 13:43:00', '2017-09-12 13:43:00'),
(3918, '099643', '099600', 'Fire-Retardant Coatings', NULL, 0, 0, 0, '2017-09-12 13:43:09', '2017-09-12 13:43:09'),
(3919, '099646', '099600', 'Intumescent Painting', NULL, 0, 0, 0, '2017-09-12 13:43:16', '2017-09-12 13:43:16'),
(3920, '099653', '099600', 'Elastomeric Coatings', NULL, 0, 0, 0, '2017-09-12 13:43:25', '2017-09-12 13:43:25'),
(3921, '099656', '099600', 'Epoxy Coatings', NULL, 0, 0, 0, '2017-09-12 13:43:32', '2017-09-12 13:43:32'),
(3922, '099659', '099600', 'High-Build Glazed Coatings', NULL, 0, 0, 0, '2017-09-12 13:43:39', '2017-09-12 13:43:39'),
(3923, '099663', '099600', 'Textured Plastic Coatings', NULL, 0, 0, 0, '2017-09-12 13:43:46', '2017-09-12 13:43:46'),
(3924, '099666', '099600', 'Aggregate Wall Coatings', NULL, 0, 0, 0, '2017-09-12 13:43:52', '2017-09-12 13:43:52'),
(3925, '099700', '099000', 'Special Coatings', NULL, 0, 0, 0, '2017-09-12 13:47:06', '2017-09-12 13:47:06'),
(3926, '099713', '099700', 'Steel Coatings', NULL, 0, 0, 0, '2017-09-12 13:47:16', '2017-09-12 13:47:16'),
(3927, '099713.13', '099713', 'Interior Steel Coatings', NULL, 0, 0, 0, '2017-09-12 13:47:26', '2017-09-12 13:47:26'),
(3928, '099713.23', '099713', 'Exterior Steel Coatings', NULL, 0, 0, 0, '2017-09-12 13:47:34', '2017-09-12 13:47:34'),
(3929, '099713.24', '099713', 'Steel Water Storage Tank Painting', NULL, 0, 0, 0, '2017-09-12 13:47:43', '2017-09-12 13:47:43'),
(3930, '099723', '099700', 'Concrete and Masonry Coatings', NULL, 0, 0, 0, '2017-09-12 13:47:52', '2017-09-12 13:47:52'),
(3931, '099723.24', '099723', 'Concrete Water Storage Tank Painting', NULL, 0, 0, 0, '2017-09-12 13:48:02', '2017-09-12 13:48:02'),
(3932, '099726', '099700', 'Cementitious Coatings', NULL, 0, 0, 0, '2017-09-12 13:48:09', '2017-09-12 13:48:09'),
(3933, '099726.13', '099726', 'Interior Cementitious Coatings', NULL, 0, 0, 0, '2017-09-12 13:48:18', '2017-09-12 13:48:18'),
(3934, '099726.23', '099726', 'Exterior Cementitious Coatings', NULL, 0, 0, 0, '2017-09-12 13:48:26', '2017-09-12 13:48:26'),
(3935, '099735', '099700', 'Dry Erase Coatings', NULL, 0, 0, 0, '2017-09-12 13:48:32', '2017-09-12 13:48:32');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `active_role`
--
ALTER TABLE `active_role`
  ADD CONSTRAINT `active_role_ibfk_1` FOREIGN KEY (`role_user_id`) REFERENCES `role_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `audit`
--
ALTER TABLE `audit`
  ADD CONSTRAINT `audit_ibfk_1` FOREIGN KEY (`quantity_id`) REFERENCES `quantity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `audit_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `audit_files`
--
ALTER TABLE `audit_files`
  ADD CONSTRAINT `audit_files_ibfk_1` FOREIGN KEY (`audit_id`) REFERENCES `audit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `audit_markdowns`
--
ALTER TABLE `audit_markdowns`
  ADD CONSTRAINT `audit_markdowns_ibfk_1` FOREIGN KEY (`audit_id`) REFERENCES `audit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `audit_markdowns_ibfk_2` FOREIGN KEY (`audit_id`) REFERENCES `audit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bids`
--
ALTER TABLE `bids`
  ADD CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_2` FOREIGN KEY (`folder_id`) REFERENCES `folders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `folders`
--
ALTER TABLE `folders`
  ADD CONSTRAINT `folders_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `gwbs`
--
ALTER TABLE `gwbs`
  ADD CONSTRAINT `gwbs_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gwbs_ibfk_2` FOREIGN KEY (`project_id`, `code`) REFERENCES `pwbs` (`project_id`, `code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `issues`
--
ALTER TABLE `issues`
  ADD CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `issues_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `issue_replies`
--
ALTER TABLE `issue_replies`
  ADD CONSTRAINT `issue_replies_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `issue_replies_ibfk_2` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `issue_replies_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `job_holders`
--
ALTER TABLE `job_holders`
  ADD CONSTRAINT `job_holders_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `job_holders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `job_holders_ibfk_3` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `job_holders_ibfk_4` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `job_message`
--
ALTER TABLE `job_message`
  ADD CONSTRAINT `job_message_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `job_message_ibfk_2` FOREIGN KEY (`from_job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `job_message_ibfk_3` FOREIGN KEY (`to_job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `leadMessage`
--
ALTER TABLE `leadMessage`
  ADD CONSTRAINT `leadMessage_ibfk_1` FOREIGN KEY (`leadId`) REFERENCES `leads` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `links`
--
ALTER TABLE `links`
  ADD CONSTRAINT `links_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nations`
--
ALTER TABLE `nations`
  ADD CONSTRAINT `nations_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `packages`
--
ALTER TABLE `packages`
  ADD CONSTRAINT `packages_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `projects_ibfk_2` FOREIGN KEY (`industry_id`) REFERENCES `industry` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `projects_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pwbs`
--
ALTER TABLE `pwbs`
  ADD CONSTRAINT `pwbs_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pwbs_ibfk_2` FOREIGN KEY (`project_id`, `parent_code`) REFERENCES `pwbs` (`project_id`, `code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quantity`
--
ALTER TABLE `quantity`
  ADD CONSTRAINT `quantity_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `quantity_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `quantity_files`
--
ALTER TABLE `quantity_files`
  ADD CONSTRAINT `quantity_files_ibfk_1` FOREIGN KEY (`quantity_id`) REFERENCES `quantity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quantity_markdowns`
--
ALTER TABLE `quantity_markdowns`
  ADD CONSTRAINT `quantity_markdowns_ibfk_1` FOREIGN KEY (`quantity_id`) REFERENCES `quantity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `role_user_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `unreads`
--
ALTER TABLE `unreads`
  ADD CONSTRAINT `unreads_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`nation_id`) REFERENCES `nations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wbs`
--
ALTER TABLE `wbs`
  ADD CONSTRAINT `wbs_ibfk_1` FOREIGN KEY (`parent_code`) REFERENCES `wbs` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
