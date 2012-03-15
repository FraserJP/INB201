-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.61-0ubuntu0.11.10.1


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema INB201
--

CREATE DATABASE IF NOT EXISTS INB201;
USE INB201;
CREATE TABLE  `INB201`.`ASSESSMENT` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto incremented (no duplicate) value used to identify the assessment item',
  `unitID` char(12) NOT NULL,
  `isgroup` tinyint(1) NOT NULL,
  `duedate` datetime NOT NULL,
  `maxmarks` double unsigned NOT NULL,
  `name` varchar(30) NOT NULL COMMENT 'the human readable name of the assignment',
  `markinginfofile` varchar(100) NOT NULL COMMENT 'file location on disk of xml file containing the marking sheet generated from code to allow for flexibility',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Storing assessment items and information pertaining to all u';
CREATE TABLE  `INB201`.`ASSESSMENT_USERS` (
  `submitterid` char(8) NOT NULL COMMENT 'person submitting the assignment',
  `assessmentid` int(10) unsigned NOT NULL,
  `markerid` char(8) NOT NULL COMMENT 'Person marking the assignment, \nimportant for peer reviews so that there are no double entries',
  `lastsubmit` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'on an update of the row, this value will update to the current system time',
  `givenmarks` double unsigned DEFAULT NULL COMMENT 'The marks given my the marker',
  `submissionlocation` varchar(100) NOT NULL COMMENT 'location on disk of the actual submission',
  PRIMARY KEY (`submitterid`,`assessmentid`,`markerid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='keeping track of the marks for each assessment piece from ea';
CREATE TABLE  `INB201`.`CLASSES` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto-incremented id',
  `unitID` char(12) NOT NULL,
  `dayofweek` tinyint(3) unsigned NOT NULL COMMENT 'day 0 is sunday\nday 6 is saturday',
  `timeofday` time NOT NULL,
  `room` varchar(10) NOT NULL COMMENT 'Has enough space for a room in the form CC-BBxxxx\nCC - two letter camus code\nBB - Building Letter\nxxxx - room number',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='details of classes, based on unit, day, time and room inform';
CREATE TABLE  `INB201`.`GROUPS` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT 'human readable name',
  `classID` char(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `GROUPNAME` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='information about specific groups';
CREATE TABLE  `INB201`.`UNITS` (
  `id` char(12) NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Keeps human readable name of the unit';
CREATE TABLE  `INB201`.`USERS` (
  `id` char(8) NOT NULL,
  `namelast` varchar(20) NOT NULL,
  `namefirst` varchar(20) NOT NULL,
  `login` varchar(25) NOT NULL COMMENT 'does this actually belong in this table?',
  `email` varchar(40) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `LOGIN` (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='general information about users';
CREATE TABLE  `INB201`.`USERS_CLASSES` (
  `personID` char(8) NOT NULL,
  `classID` int(10) unsigned NOT NULL,
  `isstudent` tinyint(1) NOT NULL,
  PRIMARY KEY (`personID`,`classID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Is a particular user in a class and are they a student there';
CREATE TABLE  `INB201`.`USERS_GROUPS` (
  `userID` char(8) NOT NULL,
  `groupID` int(11) NOT NULL,
  PRIMARY KEY (`userID`,`groupID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='is a user in a particular group';



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
