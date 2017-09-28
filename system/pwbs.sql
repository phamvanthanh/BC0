-- phpMyAdmin SQL Dump
-- version 4.0.10.18
-- https://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Sep 13, 2017 at 10:29 AM
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

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pwbs`
--
ALTER TABLE `pwbs`
  ADD CONSTRAINT `pwbs_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pwbs_ibfk_2` FOREIGN KEY (`project_id`, `parent_code`) REFERENCES `pwbs` (`project_id`, `code`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
