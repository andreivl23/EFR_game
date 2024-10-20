/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.5.2-MariaDB, for osx10.19 (arm64)
--
-- Host: 127.0.0.1    Database: efr
-- ------------------------------------------------------
-- Server version	11.5.2-MariaDB

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
-- Table structure for table `connections`
--

DROP TABLE IF EXISTS `connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `connections` (
  `StationID1` int(11) NOT NULL,
  `StationID2` int(11) NOT NULL,
  KEY `FK_connections_stations` (`StationID1`),
  KEY `FK_connections_stations_2` (`StationID2`),
  CONSTRAINT `FK_connections_stations` FOREIGN KEY (`StationID1`) REFERENCES `stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_connections_stations_2` FOREIGN KEY (`StationID2`) REFERENCES `stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connections`
--

LOCK TABLES `connections` WRITE;
/*!40000 ALTER TABLE `connections` DISABLE KEYS */;
INSERT INTO `connections` VALUES
(1,2),
(1,6),
(1,7),
(2,1),
(2,3),
(3,2),
(3,6),
(4,6),
(4,5),
(5,4),
(6,3),
(6,13),
(6,4),
(6,1),
(6,7),
(7,1),
(7,6),
(7,8),
(7,12),
(7,15),
(8,7),
(8,10),
(8,9),
(9,10),
(9,8),
(10,8),
(10,9),
(10,11),
(10,15),
(11,10),
(12,7),
(12,13),
(12,14),
(13,6),
(13,12),
(13,14),
(14,12),
(14,13),
(14,16),
(14,17),
(14,20),
(15,7),
(15,10),
(15,16),
(15,18),
(16,15),
(16,14),
(17,14),
(17,23),
(18,15),
(18,19),
(19,18),
(20,14),
(20,21),
(20,23),
(21,20),
(21,22),
(22,21),
(23,17),
(23,20),
(23,24),
(24,23),
(24,25),
(25,24),
(25,30),
(25,26),
(26,25),
(26,27),
(27,26),
(27,28),
(28,27),
(28,29),
(28,25),
(29,28),
(30,25),
(31,28),
(31,32),
(32,31),
(32,33),
(33,32),
(25,28),
(28,31);
/*!40000 ALTER TABLE `connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emergency_landing`
--

DROP TABLE IF EXISTS `emergency_landing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emergency_landing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `story_text` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergency_landing`
--

LOCK TABLES `emergency_landing` WRITE;
/*!40000 ALTER TABLE `emergency_landing` DISABLE KEYS */;
/*!40000 ALTER TABLE `emergency_landing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `probability` int(11) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES
(1,'passport',0,1,'You found a passport.'),
(2,'bully',-1,3,'You met a bully. Now you are being bullied!!!!'),
(3,'finnish',1,6,'You met Finnish. You go to sauna now.'),
(4,'russian',-2,3,'You met a Russian, he took your coca-cola'),
(5,'american',2,7,'You met an AMERICAN, you are now free!'),
(6,'rival',3,8,'You met a rival. There was a mini game before but not anymore.');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_location`
--

DROP TABLE IF EXISTS `events_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events_location` (
  `id` int(11) DEFAULT NULL,
  `game` int(11) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `opened` tinyint(1) DEFAULT 0,
  KEY `FK_events_location_events` (`event`),
  CONSTRAINT `FK_events_location_events` FOREIGN KEY (`event`) REFERENCES `events` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_location`
--

LOCK TABLES `events_location` WRITE;
/*!40000 ALTER TABLE `events_location` DISABLE KEYS */;
INSERT INTO `events_location` VALUES
(4,1,1,1),
(9,1,2,1),
(22,1,2,0),
(32,1,2,1),
(15,1,3,1),
(30,1,3,0),
(5,1,3,1),
(27,1,3,0),
(16,1,3,1),
(8,1,3,1),
(7,1,4,1),
(2,1,4,0),
(31,1,4,1),
(20,1,5,1),
(26,1,5,0),
(14,1,5,1),
(18,1,5,1),
(12,1,5,0),
(1,1,5,1),
(28,1,5,1),
(17,1,6,0),
(3,1,6,0),
(25,1,6,1),
(13,1,6,0),
(6,1,6,1),
(29,1,6,1),
(33,1,6,0),
(23,1,6,1),
(28,2,1,1),
(24,2,2,1),
(18,2,2,1),
(27,2,2,0),
(12,2,3,0),
(25,2,3,1),
(5,2,3,1),
(26,2,3,0),
(10,2,3,1),
(31,2,3,1),
(1,2,4,1),
(30,2,4,0),
(9,2,4,1),
(29,2,5,1),
(2,2,5,0),
(11,2,5,0),
(7,2,5,1),
(23,2,5,1),
(17,2,5,0),
(4,2,5,1),
(32,2,6,1),
(16,2,6,1),
(15,2,6,1),
(14,2,6,1),
(33,2,6,0),
(20,2,6,1),
(22,2,6,0),
(3,2,6,0),
(28,3,1,1),
(20,3,2,1),
(30,3,2,0),
(21,3,2,0),
(7,3,3,1),
(22,3,3,0),
(8,3,3,1),
(27,3,3,0),
(24,3,3,1),
(15,3,3,1),
(32,3,4,1),
(33,3,4,0),
(13,3,4,0),
(12,3,5,0),
(5,3,5,1),
(10,3,5,1),
(25,3,5,1),
(18,3,5,1),
(29,3,5,1),
(31,3,5,1),
(19,3,6,0),
(14,3,6,1),
(9,3,6,1),
(23,3,6,1),
(17,3,6,0),
(2,3,6,0),
(16,3,6,1),
(3,3,6,0),
(19,4,1,0),
(32,4,2,1),
(13,4,2,0),
(29,4,2,1),
(5,4,3,1),
(22,4,3,0),
(23,4,3,1),
(1,4,3,1),
(10,4,3,1),
(27,4,3,0),
(11,4,4,0),
(30,4,4,0),
(33,4,4,0),
(7,4,5,1),
(26,4,5,0),
(6,4,5,1),
(18,4,5,1),
(21,4,5,0),
(25,4,5,1),
(15,4,5,1),
(14,4,6,1),
(24,4,6,1),
(3,4,6,0),
(8,4,6,1),
(4,4,6,1),
(16,4,6,1),
(31,4,6,1),
(9,4,6,1),
(16,5,1,1),
(5,5,2,1),
(23,5,2,1),
(9,5,2,1),
(10,5,3,1),
(26,5,3,0),
(18,5,3,1),
(29,5,3,1),
(6,5,3,1),
(30,5,3,0),
(27,5,4,0),
(19,5,4,0),
(13,5,4,0),
(25,5,5,1),
(4,5,5,1),
(12,5,5,0),
(17,5,5,0),
(31,5,5,1),
(8,5,5,1),
(32,5,5,1),
(33,5,6,0),
(3,5,6,0),
(21,5,6,0),
(2,5,6,0),
(22,5,6,0),
(20,5,6,1),
(7,5,6,1),
(1,5,6,1),
(12,6,1,0),
(23,6,2,1),
(33,6,2,0),
(24,6,2,1),
(11,6,3,0),
(1,6,3,1),
(15,6,3,1),
(22,6,3,0),
(7,6,3,1),
(14,6,3,1),
(3,6,4,0),
(4,6,4,1),
(29,6,4,1),
(28,6,5,1),
(6,6,5,1),
(21,6,5,0),
(8,6,5,1),
(19,6,5,0),
(9,6,5,1),
(26,6,5,0),
(32,6,6,1),
(2,6,6,0),
(10,6,6,1),
(30,6,6,0),
(27,6,6,0),
(16,6,6,1),
(31,6,6,1),
(18,6,6,1),
(33,7,1,0),
(31,7,2,1),
(21,7,2,0),
(25,7,2,1),
(18,7,3,1),
(26,7,3,0),
(23,7,3,1),
(16,7,3,1),
(13,7,3,0),
(28,7,3,1),
(22,7,4,0),
(11,7,4,0),
(5,7,4,1),
(8,7,5,1),
(10,7,5,1),
(30,7,5,0),
(6,7,5,1),
(20,7,5,1),
(9,7,5,1),
(4,7,5,1),
(19,7,6,0),
(17,7,6,0),
(1,7,6,1),
(12,7,6,0),
(7,7,6,1),
(24,7,6,1),
(15,7,6,1),
(14,7,6,1),
(8,8,1,0),
(25,8,2,0),
(14,8,2,0),
(30,8,2,0),
(5,8,3,0),
(11,8,3,0),
(20,8,3,0),
(29,8,3,1),
(27,8,3,0),
(21,8,3,0),
(26,8,4,0),
(15,8,4,1),
(9,8,4,1),
(24,8,5,0),
(23,8,5,0),
(33,8,5,0),
(2,8,5,0),
(10,8,5,1),
(28,8,5,1),
(17,8,5,0),
(7,8,6,0),
(16,8,6,1),
(1,8,6,0),
(18,8,6,0),
(4,8,6,0),
(6,8,6,0),
(3,8,6,0),
(22,8,6,0),
(28,9,1,1),
(17,9,2,0),
(5,9,2,0),
(25,9,2,0),
(4,9,3,0),
(1,9,3,0),
(31,9,3,0),
(10,9,3,1),
(33,9,3,0),
(27,9,3,0),
(9,9,4,1),
(14,9,4,0),
(8,9,4,0),
(24,9,5,0),
(22,9,5,0),
(7,9,5,0),
(26,9,5,0),
(6,9,5,0),
(2,9,5,0),
(12,9,5,0),
(16,9,6,1),
(23,9,6,0),
(21,9,6,0),
(3,9,6,0),
(13,9,6,0),
(19,9,6,0),
(30,9,6,0),
(15,9,6,1),
(7,10,1,0),
(31,10,2,0),
(20,10,2,0),
(11,10,2,0),
(32,10,3,1),
(12,10,3,0),
(30,10,3,0),
(22,10,3,0),
(4,10,3,0),
(5,10,3,0),
(24,10,4,0),
(6,10,4,0),
(3,10,4,0),
(8,10,5,0),
(13,10,5,0),
(26,10,5,0),
(19,10,5,0),
(9,10,5,1),
(15,10,5,1),
(17,10,5,0),
(1,10,6,0),
(2,10,6,0),
(33,10,6,0),
(28,10,6,1),
(25,10,6,0),
(18,10,6,0),
(21,10,6,0),
(27,10,6,0),
(10,11,1,1),
(18,11,2,0),
(25,11,2,0),
(33,11,2,0),
(11,11,3,0),
(3,11,3,0),
(7,11,3,0),
(14,11,3,0),
(27,11,3,0),
(23,11,3,0),
(31,11,4,0),
(17,11,4,0),
(20,11,4,0),
(13,11,5,0),
(5,11,5,0),
(26,11,5,0),
(28,11,5,1),
(24,11,5,0),
(4,11,5,0),
(21,11,5,0),
(9,11,6,1),
(8,11,6,0),
(22,11,6,0),
(2,11,6,0),
(15,11,6,1),
(29,11,6,1),
(16,11,6,1),
(1,11,6,0),
(20,12,1,0),
(5,12,2,0),
(27,12,2,0),
(19,12,2,0),
(22,12,3,0),
(21,12,3,0),
(7,12,3,0),
(30,12,3,0),
(6,12,3,0),
(1,12,3,0),
(25,12,4,0),
(24,12,4,0),
(9,12,4,1),
(32,12,5,1),
(29,12,5,1),
(14,12,5,0),
(13,12,5,0),
(11,12,5,0),
(18,12,5,0),
(15,12,5,1),
(8,12,6,0),
(31,12,6,0),
(16,12,6,1),
(12,12,6,0),
(2,12,6,0),
(26,12,6,0),
(4,12,6,0),
(3,12,6,0),
(27,13,1,0),
(6,13,2,0),
(15,13,2,1),
(21,13,2,0),
(25,13,3,0),
(24,13,3,0),
(22,13,3,0),
(1,13,3,0),
(19,13,3,0),
(3,13,3,0),
(17,13,4,0),
(9,13,4,1),
(7,13,4,0),
(26,13,5,0),
(12,13,5,0),
(2,13,5,0),
(29,13,5,1),
(32,13,5,1),
(28,13,5,1),
(20,13,5,0),
(30,13,6,0),
(4,13,6,0),
(23,13,6,0),
(18,13,6,0),
(33,13,6,0),
(8,13,6,0),
(13,13,6,0),
(10,13,6,1),
(18,14,1,0),
(15,14,2,1),
(16,14,2,1),
(30,14,2,0),
(10,14,3,1),
(29,14,3,1),
(8,14,3,0),
(23,14,3,0),
(22,14,3,0),
(33,14,3,0),
(32,14,4,0),
(28,14,4,1),
(7,14,4,0),
(11,14,5,0),
(19,14,5,0),
(24,14,5,0),
(4,14,5,0),
(27,14,5,0),
(13,14,5,0),
(25,14,5,0),
(12,14,6,0),
(21,14,6,0),
(2,14,6,0),
(26,14,6,0),
(31,14,6,0),
(17,14,6,0),
(20,14,6,0),
(6,14,6,0),
(15,15,1,1),
(6,15,2,0),
(21,15,2,0),
(28,15,2,1),
(27,15,3,0),
(25,15,3,0),
(3,15,3,0),
(7,15,3,0),
(33,15,3,0),
(8,15,3,0),
(16,15,4,1),
(13,15,4,0),
(18,15,4,0),
(1,15,5,0),
(31,15,5,0),
(24,15,5,0),
(19,15,5,0),
(4,15,5,0),
(17,15,5,0),
(20,15,5,0),
(5,15,6,0),
(22,15,6,0),
(29,15,6,1),
(10,15,6,1),
(12,15,6,0),
(23,15,6,0),
(2,15,6,0),
(9,15,6,1),
(24,16,1,0),
(11,16,2,0),
(26,16,2,0),
(2,16,2,0),
(20,16,3,0),
(13,16,3,0),
(32,16,3,0),
(30,16,3,0),
(27,16,3,0),
(14,16,3,0),
(5,16,4,0),
(1,16,4,0),
(19,16,4,0),
(18,16,5,0),
(29,16,5,1),
(28,16,5,1),
(8,16,5,0),
(15,16,5,1),
(21,16,5,0),
(10,16,5,1),
(16,16,6,0),
(33,16,6,0),
(9,16,6,1),
(23,16,6,0),
(17,16,6,0),
(6,16,6,0),
(3,16,6,0),
(22,16,6,0),
(21,17,1,0),
(26,17,2,0),
(2,17,2,0),
(10,17,2,1),
(13,17,3,0),
(6,17,3,0),
(31,17,3,0),
(22,17,3,0),
(9,17,3,1),
(33,17,3,0),
(18,17,4,0),
(23,17,4,0),
(29,17,4,1),
(25,17,5,0),
(14,17,5,0),
(16,17,5,0),
(15,17,5,1),
(30,17,5,0),
(17,17,5,0),
(19,17,5,0),
(24,17,6,0),
(1,17,6,0),
(5,17,6,0),
(12,17,6,0),
(8,17,6,0),
(20,17,6,0),
(11,17,6,0),
(27,17,6,0),
(24,18,1,0),
(10,18,2,1),
(33,18,2,0),
(25,18,2,0),
(5,18,3,0),
(30,18,3,0),
(17,18,3,0),
(22,18,3,0),
(2,18,3,0),
(16,18,3,0),
(20,18,4,0),
(32,18,4,0),
(1,18,4,0),
(9,18,5,1),
(8,18,5,0),
(14,18,5,0),
(28,18,5,1),
(13,18,5,0),
(29,18,5,1),
(3,18,5,0),
(27,18,6,0),
(15,18,6,1),
(31,18,6,0),
(26,18,6,0),
(7,18,6,0),
(6,18,6,0),
(11,18,6,0),
(12,18,6,0),
(20,19,1,0),
(4,19,2,0),
(23,19,2,0),
(26,19,2,0),
(32,19,3,0),
(15,19,3,1),
(22,19,3,0),
(17,19,3,0),
(29,19,3,1),
(19,19,3,0),
(30,19,4,0),
(25,19,4,0),
(3,19,4,0),
(13,19,5,0),
(12,19,5,0),
(18,19,5,0),
(2,19,5,0),
(1,19,5,0),
(21,19,5,0),
(28,19,5,1),
(14,19,6,0),
(10,19,6,1),
(27,19,6,0),
(9,19,6,1),
(8,19,6,0),
(7,19,6,0),
(31,19,6,0),
(11,19,6,0),
(3,20,1,0),
(11,20,2,0),
(33,20,2,0),
(5,20,2,0),
(31,20,3,0),
(14,20,3,0),
(28,20,3,1),
(30,20,3,0),
(12,20,3,0),
(29,20,3,1),
(23,20,4,0),
(16,20,4,0),
(22,20,4,0),
(27,20,5,0),
(19,20,5,0),
(25,20,5,0),
(2,20,5,0),
(10,20,5,1),
(32,20,5,0),
(6,20,5,0),
(18,20,6,0),
(17,20,6,0),
(26,20,6,0),
(7,20,6,0),
(24,20,6,0),
(13,20,6,0),
(4,20,6,0),
(20,20,6,0),
(28,21,1,1),
(13,21,2,0),
(27,21,2,0),
(30,21,2,0),
(7,21,3,0),
(14,21,3,0),
(22,21,3,0),
(15,21,3,1),
(29,21,3,1),
(4,21,3,0),
(31,21,4,0),
(21,21,4,0),
(6,21,4,0),
(8,21,5,0),
(23,21,5,0),
(10,21,5,1),
(11,21,5,0),
(5,21,5,0),
(1,21,5,0),
(17,21,5,0),
(18,21,6,0),
(16,21,6,0),
(33,21,6,0),
(32,21,6,0),
(2,21,6,0),
(12,21,6,0),
(26,21,6,0),
(20,21,6,0),
(21,22,1,0),
(20,22,2,0),
(3,22,2,0),
(23,22,2,0),
(9,22,3,1),
(25,22,3,0),
(32,22,3,0),
(18,22,3,0),
(24,22,3,0),
(29,22,3,1),
(13,22,4,0),
(8,22,4,0),
(33,22,4,0),
(1,22,5,0),
(28,22,5,1),
(22,22,5,0),
(12,22,5,0),
(26,22,5,0),
(19,22,5,0),
(6,22,5,0),
(7,22,6,0),
(15,22,6,1),
(27,22,6,0),
(10,22,6,1),
(14,22,6,0),
(4,22,6,0),
(16,22,6,0),
(17,22,6,0),
(18,23,1,0),
(8,23,2,0),
(30,23,2,0),
(12,23,2,0),
(15,23,3,0),
(24,23,3,0),
(17,23,3,0),
(25,23,3,0),
(1,23,3,0),
(11,23,3,0),
(21,23,4,0),
(19,23,4,0),
(26,23,4,0),
(2,23,5,0),
(14,23,5,0),
(9,23,5,0),
(10,23,5,0),
(33,23,5,0),
(27,23,5,0),
(6,23,5,0),
(20,23,6,0),
(31,23,6,0),
(3,23,6,0),
(5,23,6,0),
(29,23,6,1),
(22,23,6,0),
(16,23,6,0),
(28,23,6,1),
(33,24,1,0),
(19,24,2,0),
(4,24,2,0),
(5,24,2,0),
(14,24,3,0),
(9,24,3,0),
(16,24,3,0),
(20,24,3,0),
(32,24,3,0),
(10,24,3,0),
(21,24,4,0),
(30,24,4,0),
(6,24,4,0),
(2,24,5,0),
(7,24,5,0),
(31,24,5,0),
(8,24,5,0),
(3,24,5,0),
(26,24,5,0),
(23,24,5,0),
(15,24,6,0),
(17,24,6,0),
(24,24,6,0),
(13,24,6,0),
(11,24,6,0),
(12,24,6,0),
(22,24,6,0),
(18,24,6,0),
(8,25,1,0),
(7,25,2,0),
(17,25,2,0),
(1,25,2,0),
(25,25,3,0),
(18,25,3,0),
(22,25,3,0),
(20,25,3,0),
(29,25,3,0),
(6,25,3,0),
(27,25,4,0),
(19,25,4,0),
(21,25,4,0),
(31,25,5,0),
(28,25,5,0),
(13,25,5,0),
(9,25,5,0),
(11,25,5,0),
(26,25,5,0),
(33,25,5,0),
(2,25,6,0),
(3,25,6,0),
(10,25,6,0),
(23,25,6,0),
(15,25,6,0),
(24,25,6,0),
(16,25,6,0),
(32,25,6,0),
(3,26,1,0),
(28,26,2,0),
(14,26,2,0),
(13,26,2,0),
(2,26,3,0),
(19,26,3,0),
(22,26,3,0),
(7,26,3,0),
(24,26,3,0),
(8,26,3,0),
(32,26,4,0),
(12,26,4,0),
(6,26,4,0),
(33,26,5,0),
(18,26,5,0),
(29,26,5,0),
(26,26,5,0),
(17,26,5,0),
(9,26,5,0),
(23,26,5,0),
(10,26,6,0),
(20,26,6,0),
(15,26,6,0),
(27,26,6,0),
(1,26,6,0),
(30,26,6,0),
(5,26,6,0),
(16,26,6,0),
(23,27,1,0),
(29,27,2,0),
(7,27,2,0),
(1,27,2,0),
(25,27,3,0),
(18,27,3,0),
(26,27,3,0),
(19,27,3,0),
(22,27,3,0),
(6,27,3,0),
(21,27,4,0),
(8,27,4,0),
(27,27,4,0),
(12,27,5,0),
(15,27,5,0),
(30,27,5,0),
(3,27,5,0),
(5,27,5,0),
(31,27,5,0),
(4,27,5,0),
(2,27,6,0),
(11,27,6,0),
(10,27,6,0),
(13,27,6,0),
(33,27,6,0),
(20,27,6,0),
(28,27,6,0),
(14,27,6,0),
(18,28,1,0),
(28,28,2,0),
(9,28,2,0),
(31,28,2,0),
(17,28,3,0),
(22,28,3,0),
(24,28,3,0),
(3,28,3,0),
(10,28,3,0),
(20,28,3,0),
(23,28,4,0),
(25,28,4,0),
(13,28,4,0),
(26,28,5,0),
(19,28,5,0),
(2,28,5,0),
(32,28,5,0),
(15,28,5,0),
(30,28,5,0),
(21,28,5,0),
(16,28,6,0),
(33,28,6,0),
(7,28,6,0),
(8,28,6,0),
(6,28,6,0),
(11,28,6,0),
(29,28,6,0),
(5,28,6,0),
(11,29,1,0),
(7,29,2,0),
(19,29,2,0),
(29,29,2,0),
(1,29,3,0),
(12,29,3,0),
(3,29,3,0),
(15,29,3,0),
(16,29,3,0),
(23,29,3,0),
(26,29,4,0),
(13,29,4,0),
(9,29,4,0),
(5,29,5,0),
(14,29,5,0),
(30,29,5,0),
(6,29,5,0),
(10,29,5,0),
(25,29,5,0),
(22,29,5,0),
(18,29,6,0),
(31,29,6,0),
(28,29,6,0),
(27,29,6,0),
(33,29,6,0),
(4,29,6,0),
(17,29,6,0),
(2,29,6,0),
(30,30,1,0),
(19,30,2,0),
(28,30,2,0),
(9,30,2,0),
(20,30,3,0),
(26,30,3,0),
(10,30,3,0),
(22,30,3,0),
(15,30,3,0),
(11,30,3,0),
(8,30,4,0),
(12,30,4,0),
(13,30,4,0),
(27,30,5,0),
(4,30,5,0),
(21,30,5,0),
(14,30,5,0),
(25,30,5,0),
(18,30,5,0),
(23,30,5,0),
(24,30,6,0),
(1,30,6,0),
(33,30,6,0),
(2,30,6,0),
(29,30,6,0),
(6,30,6,0),
(32,30,6,0),
(7,30,6,0),
(26,31,1,0),
(4,31,2,0),
(25,31,2,0),
(21,31,2,0),
(30,31,3,0),
(10,31,3,0),
(7,31,3,0),
(31,31,3,0),
(11,31,3,0),
(17,31,3,0),
(23,31,4,0),
(18,31,4,0),
(1,31,4,0),
(2,31,5,0),
(32,31,5,0),
(12,31,5,0),
(9,31,5,0),
(6,31,5,0),
(22,31,5,0),
(19,31,5,0),
(20,31,6,0),
(27,31,6,0),
(14,31,6,0),
(15,31,6,0),
(3,31,6,0),
(28,31,6,0),
(29,31,6,0),
(5,31,6,0),
(6,32,1,0),
(27,32,2,0),
(5,32,2,0),
(29,32,2,0),
(13,32,3,0),
(23,32,3,0),
(8,32,3,0),
(10,32,3,0),
(33,32,3,0),
(32,32,3,0),
(2,32,4,0),
(20,32,4,0),
(24,32,4,0),
(21,32,5,0),
(17,32,5,0),
(14,32,5,0),
(1,32,5,0),
(28,32,5,0),
(15,32,5,0),
(30,32,5,0),
(31,32,6,0),
(3,32,6,0),
(19,32,6,0),
(26,32,6,0),
(12,32,6,0),
(4,32,6,0),
(22,32,6,0),
(18,32,6,0),
(24,33,1,0),
(21,33,2,0),
(18,33,2,0),
(28,33,2,0),
(22,33,3,0),
(16,33,3,0),
(2,33,3,0),
(12,33,3,0),
(7,33,3,0),
(6,33,3,0),
(13,33,4,0),
(26,33,4,0),
(9,33,4,0),
(17,33,5,0),
(11,33,5,0),
(19,33,5,0),
(1,33,5,0),
(33,33,5,0),
(5,33,5,0),
(32,33,5,0),
(31,33,6,0),
(25,33,6,0),
(4,33,6,0),
(15,33,6,0),
(29,33,6,0),
(27,33,6,0),
(23,33,6,0),
(3,33,6,0),
(1,34,1,0),
(20,34,2,0),
(19,34,2,0),
(4,34,2,0),
(9,34,3,0),
(7,34,3,0),
(11,34,3,0),
(33,34,3,0),
(8,34,3,0),
(28,34,3,0),
(13,34,4,0),
(27,34,4,0),
(31,34,4,0),
(6,34,5,0),
(22,34,5,0),
(21,34,5,0),
(25,34,5,0),
(29,34,5,0),
(26,34,5,0),
(30,34,5,0),
(14,34,6,0),
(24,34,6,0),
(18,34,6,0),
(32,34,6,0),
(12,34,6,0),
(10,34,6,0),
(3,34,6,0),
(5,34,6,0),
(13,35,1,1),
(25,35,2,0),
(7,35,2,0),
(9,35,2,0),
(12,35,3,0),
(23,35,3,0),
(33,35,3,0),
(18,35,3,0),
(20,35,3,0),
(19,35,3,0),
(4,35,4,0),
(22,35,4,0),
(21,35,4,0),
(2,35,5,1),
(17,35,5,0),
(8,35,5,0),
(5,35,5,0),
(3,35,5,1),
(31,35,5,0),
(26,35,5,0),
(24,35,6,0),
(16,35,6,0),
(6,35,6,1),
(28,35,6,0),
(14,35,6,0),
(1,35,6,1),
(29,35,6,0),
(10,35,6,0),
(33,36,1,0),
(19,36,2,0),
(26,36,2,0),
(24,36,2,0),
(5,36,3,0),
(4,36,3,0),
(25,36,3,0),
(16,36,3,0),
(14,36,3,0),
(2,36,3,0),
(12,36,4,0),
(13,36,4,0),
(18,36,4,0),
(11,36,5,0),
(22,36,5,0),
(9,36,5,0),
(21,36,5,0),
(6,36,5,0),
(17,36,5,0),
(30,36,5,0),
(15,36,6,1),
(1,36,6,0),
(32,36,6,0),
(27,36,6,0),
(10,36,6,0),
(28,36,6,0),
(7,36,6,1),
(31,36,6,0),
(9,37,1,0),
(25,37,2,0),
(31,37,2,0),
(18,37,2,0),
(12,37,3,0),
(3,37,3,0),
(32,37,3,0),
(7,37,3,0),
(30,37,3,0),
(20,37,3,0),
(22,37,4,0),
(19,37,4,0),
(21,37,4,0),
(14,37,5,0),
(27,37,5,0),
(5,37,5,0),
(6,37,5,0),
(1,37,5,0),
(29,37,5,0),
(15,37,5,0),
(4,37,6,0),
(2,37,6,0),
(10,37,6,0),
(23,37,6,0),
(26,37,6,0),
(24,37,6,0),
(33,37,6,0),
(16,37,6,0),
(26,38,1,0),
(15,38,2,0),
(2,38,2,1),
(32,38,2,0),
(22,38,3,0),
(4,38,3,0),
(8,38,3,0),
(21,38,3,0),
(18,38,3,0),
(6,38,3,1),
(3,38,4,1),
(23,38,4,0),
(17,38,4,0),
(11,38,5,0),
(24,38,5,0),
(16,38,5,0),
(1,38,5,1),
(10,38,5,0),
(19,38,5,0),
(28,38,5,0),
(7,38,6,0),
(30,38,6,0),
(13,38,6,1),
(33,38,6,0),
(27,38,6,0),
(14,38,6,0),
(29,38,6,0),
(31,38,6,0),
(15,39,1,1),
(27,39,2,0),
(26,39,2,0),
(32,39,2,0),
(17,39,3,0),
(7,39,3,0),
(29,39,3,0),
(14,39,3,0),
(25,39,3,0),
(3,39,3,0),
(5,39,4,0),
(13,39,4,0),
(1,39,4,0),
(30,39,5,0),
(12,39,5,0),
(28,39,5,0),
(6,39,5,0),
(22,39,5,0),
(18,39,5,0),
(16,39,5,0),
(8,39,6,0),
(24,39,6,0),
(33,39,6,0),
(9,39,6,0),
(23,39,6,0),
(21,39,6,0),
(20,39,6,0),
(11,39,6,0),
(19,40,1,0),
(14,40,2,0),
(23,40,2,0),
(17,40,2,0),
(32,40,3,0),
(10,40,3,0),
(24,40,3,0),
(16,40,3,0),
(12,40,3,0),
(11,40,3,0),
(3,40,4,1),
(21,40,4,0),
(8,40,4,0),
(18,40,5,0),
(20,40,5,0),
(7,40,5,1),
(25,40,5,0),
(2,40,5,1),
(28,40,5,0),
(5,40,5,0),
(26,40,6,0),
(9,40,6,0),
(31,40,6,0),
(13,40,6,1),
(15,40,6,1),
(30,40,6,0),
(1,40,6,1),
(29,40,6,0),
(30,41,1,0),
(19,41,2,0),
(1,41,2,0),
(13,41,2,0),
(25,41,3,0),
(28,41,3,0),
(18,41,3,0),
(29,41,3,0),
(26,41,3,0),
(22,41,3,0),
(4,41,4,0),
(23,41,4,0),
(32,41,4,0),
(24,41,5,0),
(2,41,5,0),
(31,41,5,0),
(10,41,5,0),
(12,41,5,0),
(33,41,5,0),
(17,41,5,0),
(20,41,6,0),
(27,41,6,0),
(5,41,6,0),
(14,41,6,0),
(7,41,6,0),
(6,41,6,0),
(21,41,6,0),
(15,41,6,0),
(15,42,1,0),
(12,42,2,0),
(11,42,2,0),
(26,42,2,0),
(28,42,3,0),
(14,42,3,0),
(18,42,3,0),
(29,42,3,0),
(19,42,3,0),
(22,42,3,0),
(3,42,4,0),
(23,42,4,0),
(32,42,4,0),
(4,42,5,0),
(30,42,5,0),
(8,42,5,0),
(33,42,5,0),
(16,42,5,0),
(25,42,5,0),
(20,42,5,0),
(24,42,6,0),
(5,42,6,0),
(7,42,6,0),
(31,42,6,0),
(6,42,6,0),
(17,42,6,0),
(1,42,6,0),
(10,42,6,0),
(4,43,1,0),
(28,43,2,0),
(23,43,2,0),
(8,43,2,0),
(25,43,3,0),
(21,43,3,0),
(31,43,3,0),
(6,43,3,0),
(30,43,3,0),
(18,43,3,0),
(10,43,4,0),
(12,43,4,0),
(20,43,4,0),
(3,43,5,0),
(7,43,5,0),
(19,43,5,0),
(1,43,5,0),
(17,43,5,0),
(33,43,5,0),
(2,43,5,0),
(11,43,6,0),
(16,43,6,0),
(9,43,6,0),
(13,43,6,0),
(15,43,6,0),
(14,43,6,0),
(26,43,6,0),
(22,43,6,0),
(22,44,1,0),
(16,44,2,0),
(15,44,2,0),
(32,44,2,0),
(23,44,3,0),
(4,44,3,0),
(2,44,3,0),
(14,44,3,0),
(12,44,3,0),
(1,44,3,0),
(17,44,4,0),
(5,44,4,0),
(7,44,4,0),
(28,44,5,0),
(9,44,5,0),
(8,44,5,0),
(13,44,5,0),
(31,44,5,0),
(3,44,5,0),
(19,44,5,0),
(29,44,6,0),
(24,44,6,0),
(26,44,6,0),
(33,44,6,0),
(27,44,6,0),
(11,44,6,0),
(21,44,6,0),
(20,44,6,0),
(1,45,1,0),
(15,45,2,0),
(25,45,2,0),
(23,45,2,0),
(6,45,3,0),
(11,45,3,0),
(29,45,3,0),
(22,45,3,0),
(28,45,3,0),
(2,45,3,0),
(26,45,4,0),
(3,45,4,0),
(21,45,4,0),
(31,45,5,0),
(16,45,5,0),
(12,45,5,0),
(27,45,5,0),
(18,45,5,0),
(19,45,5,0),
(14,45,5,0),
(9,45,6,0),
(17,45,6,0),
(7,45,6,1),
(5,45,6,0),
(32,45,6,0),
(33,45,6,0),
(10,45,6,0),
(30,45,6,0),
(4,46,1,0),
(29,46,2,0),
(9,46,2,0),
(31,46,2,0),
(33,46,3,0),
(15,46,3,0),
(14,46,3,0),
(16,46,3,0),
(28,46,3,0),
(12,46,3,0),
(27,46,4,0),
(13,46,4,0),
(8,46,4,0),
(3,46,5,0),
(30,46,5,0),
(17,46,5,0),
(24,46,5,0),
(18,46,5,0),
(1,46,5,0),
(10,46,5,0),
(26,46,6,0),
(20,46,6,0),
(22,46,6,0),
(11,46,6,0),
(7,46,6,0),
(21,46,6,0),
(25,46,6,0),
(2,46,6,0);
/*!40000 ALTER TABLE `events_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
  `GameID` int(11) NOT NULL AUTO_INCREMENT,
  `ScreenName` varchar(50) DEFAULT NULL,
  `Location` int(11) DEFAULT NULL,
  `Balance` int(11) DEFAULT NULL,
  PRIMARY KEY (`GameID`),
  KEY `FK_game_stations` (`Location`),
  CONSTRAINT `FK_game_stations` FOREIGN KEY (`Location`) REFERENCES `stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES
(1,'JStest',29,619),
(2,'JStest',29,612),
(3,'JStest',29,583),
(4,'JStest',29,617),
(5,'Andrei',29,999),
(6,'mel',29,5),
(7,'a',29,1),
(8,'a',29,15),
(9,'aa',29,15),
(10,'a',29,15),
(11,'a',29,15),
(12,'a',29,15),
(13,'Andrei',29,16),
(14,'a',29,5),
(15,'andrei',29,11),
(16,'a',29,15),
(17,'a',29,15),
(18,'a',29,15),
(19,'a',29,15),
(20,'A',29,15),
(21,'Andrei',29,15),
(22,'L',29,18),
(23,'Andrei',29,10),
(24,'a',7,15),
(25,'a',7,15),
(26,'a',7,15),
(27,'a',7,15),
(28,'a',7,15),
(29,'a',7,15),
(30,'a',7,15),
(31,'a',7,10),
(32,'a',7,15),
(33,'a',7,15),
(34,'a',7,15),
(35,'a',13,20),
(36,'A',7,18),
(37,'a',7,15),
(38,'a',2,-2),
(39,'b',15,14),
(40,'A',13,7),
(41,'a',7,15),
(42,'a',7,15),
(43,'a',7,15),
(44,'a',7,15),
(45,'a',7,15),
(46,'a',7,15);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stations` (
  `StationID` int(11) NOT NULL AUTO_INCREMENT,
  `StationName` varchar(255) NOT NULL,
  `lat` int(11) DEFAULT NULL,
  `lng` int(11) DEFAULT NULL,
  PRIMARY KEY (`StationID`),
  KEY `SECOND` (`StationName`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stations`
--

LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;
INSERT INTO `stations` VALUES
(1,'Saint Peterburg',50,50),
(2,'Murmansk',52,50),
(3,'Arkhangelsk',54,50),
(4,'Pechora',48,50),
(5,'Vorkuta',46,50),
(6,'Yaroslavl',50,52),
(7,'Moscow',50,54),
(8,'Voronezh',50,56),
(9,'Krasnodar',50,58),
(10,'Volgograd',60,62),
(11,'Astrakhan',60,62),
(12,'Kazan',60,62),
(13,'Perm',60,62),
(14,'Yekaterinburg',60,62),
(15,'Saratov',60,62),
(16,'Ufa',60,62),
(17,'Kurgan',60,62),
(18,'Orenburg',60,62),
(19,'Orsk',60,62),
(20,'Tyumen',60,62),
(21,'Surgut',60,62),
(22,'Novy Urengoy',60,62),
(23,'Omsk',60,62),
(24,'Krasnoyarsk',60,62),
(25,'Bratsk',60,62),
(26,'Irkutsk',60,62),
(27,'Chita',60,62),
(28,'Tynda',60,62),
(29,'Tommot',60,62),
(30,'Ust-Ilimsk',60,62),
(31,'Urgal',60,62),
(32,'Khabarovsk',60,62),
(33,'Vladivostok',60,62);
/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stories`
--

DROP TABLE IF EXISTS `stories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stories` (
  `storytext` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stories`
--

LOCK TABLES `stories` WRITE;
/*!40000 ALTER TABLE `stories` DISABLE KEYS */;
INSERT INTO `stories` VALUES
('Suspicious babushka is looking at you. Is she an undercover agent?... Probably not.'),
('A cat crosses your path, meowing softly as it goes. Luckily it wasn\'t black'),
('You smell the freshly baked piroshki. Hopefully this all is going to end soon.'),
('A passerby accidentally bumps into you, making you wonder if it was deliberate.'),
('A pigeon lands nearby and seems to be observing you. Is it just a bird, or something more?'),
('You hear footsteps echoing in a deserted alleyway, but when you turn, no one is there.'),
('A balalaika player on the street provides a haunting soundtrack to the tense atmosphere of the city.'),
('You pass by a dilapidated statue of Lenin, a symbol of the country\'s turbulent history.');
/*!40000 ALTER TABLE `stories` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-10-18  8:02:08
