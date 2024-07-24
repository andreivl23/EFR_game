-- --------------------------------------------------------
-- Verkkotietokone:              172.232.129.9
-- Palvelinversio:               11.1.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Versio:              12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for taulu efr_mini.connections
CREATE TABLE IF NOT EXISTS `connections` (
  `StationID1` int(11) NOT NULL,
  `StationID2` int(11) NOT NULL,
  KEY `FK_connections_stations` (`StationID1`),
  KEY `FK_connections_stations_2` (`StationID2`),
  CONSTRAINT `FK_connections_stations` FOREIGN KEY (`StationID1`) REFERENCES `stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_connections_stations_2` FOREIGN KEY (`StationID2`) REFERENCES `stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table efr_mini.connections: ~82 rows (suunnilleen)
INSERT INTO `connections` (`StationID1`, `StationID2`) VALUES
	(1, 2),
	(1, 6),
	(1, 7),
	(2, 1),
	(2, 3),
	(3, 2),
	(3, 6),
	(4, 6),
	(4, 5),
	(5, 4),
	(6, 3),
	(6, 13),
	(6, 4),
	(6, 1),
	(6, 7),
	(7, 1),
	(7, 6),
	(7, 8),
	(7, 12),
	(7, 15),
	(8, 7),
	(8, 10),
	(8, 9),
	(9, 10),
	(9, 8),
	(10, 8),
	(10, 9),
	(10, 11),
	(10, 15),
	(11, 10),
	(12, 7),
	(12, 13),
	(12, 14),
	(13, 6),
	(13, 12),
	(13, 14),
	(14, 12),
	(14, 13),
	(14, 16),
	(14, 17),
	(14, 20),
	(15, 7),
	(15, 10),
	(15, 16),
	(15, 18),
	(16, 15),
	(16, 14),
	(17, 14),
	(17, 23),
	(18, 15),
	(18, 19),
	(19, 18),
	(20, 14),
	(20, 21),
	(20, 23),
	(21, 20),
	(21, 22),
	(22, 21),
	(23, 17),
	(23, 20),
	(23, 24),
	(24, 23),
	(24, 25),
	(25, 24),
	(25, 30),
	(25, 26),
	(26, 25),
	(26, 27),
	(27, 26),
	(27, 28),
	(28, 27),
	(28, 29),
	(28, 25),
	(29, 28),
	(30, 25),
	(31, 28),
	(31, 32),
	(32, 31),
	(32, 33),
	(33, 32),
	(25, 28),
	(28, 31);

-- Dumping structure for taulu efr_mini.events
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `probability` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table efr_mini.events: ~6 rows (suunnilleen)
INSERT INTO `events` (`id`, `name`, `balance`, `probability`) VALUES
	(1, 'passport', 0, 1),
	(2, 'bully', -1, 3),
	(3, 'finnish', 1, 6),
	(4, 'russian', -2, 3),
	(5, 'american', 2, 7),
	(6, 'rival', 3, 8);

-- Dumping structure for taulu efr_mini.events_location
CREATE TABLE IF NOT EXISTS `events_location` (
  `id` int(11) DEFAULT NULL,
  `game` int(11) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `opened` tinyint(1) DEFAULT 0,
  KEY `FK_events_location_events` (`event`),
  CONSTRAINT `FK_events_location_events` FOREIGN KEY (`event`) REFERENCES `events` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table efr_mini.events_location: ~112 rows (suunnilleen)
INSERT INTO `events_location` (`id`, `game`, `event`, `opened`) VALUES
	(4, 1, 1, 0),
	(9, 1, 2, 0),
	(22, 1, 2, 0),
	(32, 1, 2, 0),
	(15, 1, 3, 0),
	(30, 1, 3, 0),
	(5, 1, 3, 0),
	(27, 1, 3, 0),
	(16, 1, 3, 0),
	(8, 1, 3, 0),
	(7, 1, 4, 0),
	(2, 1, 4, 0),
	(31, 1, 4, 0),
	(20, 1, 5, 0),
	(26, 1, 5, 0),
	(14, 1, 5, 0),
	(18, 1, 5, 0),
	(12, 1, 5, 0),
	(1, 1, 5, 0),
	(28, 1, 5, 0),
	(17, 1, 6, 0),
	(3, 1, 6, 0),
	(25, 1, 6, 0),
	(13, 1, 6, 0),
	(6, 1, 6, 0),
	(29, 1, 6, 0),
	(33, 1, 6, 0),
	(23, 1, 6, 0),
	(28, 2, 1, 0),
	(24, 2, 2, 0),
	(18, 2, 2, 0),
	(27, 2, 2, 0),
	(12, 2, 3, 0),
	(25, 2, 3, 0),
	(5, 2, 3, 0),
	(26, 2, 3, 0),
	(10, 2, 3, 0),
	(31, 2, 3, 0),
	(1, 2, 4, 0),
	(30, 2, 4, 0),
	(9, 2, 4, 0),
	(29, 2, 5, 0),
	(2, 2, 5, 0),
	(11, 2, 5, 0),
	(7, 2, 5, 0),
	(23, 2, 5, 0),
	(17, 2, 5, 0),
	(4, 2, 5, 0),
	(32, 2, 6, 0),
	(16, 2, 6, 0),
	(15, 2, 6, 0),
	(14, 2, 6, 0),
	(33, 2, 6, 0),
	(20, 2, 6, 0),
	(22, 2, 6, 0),
	(3, 2, 6, 0),
	(28, 3, 1, 0),
	(20, 3, 2, 0),
	(30, 3, 2, 0),
	(21, 3, 2, 0),
	(7, 3, 3, 0),
	(22, 3, 3, 0),
	(8, 3, 3, 0),
	(27, 3, 3, 0),
	(24, 3, 3, 0),
	(15, 3, 3, 0),
	(32, 3, 4, 0),
	(33, 3, 4, 0),
	(13, 3, 4, 0),
	(12, 3, 5, 0),
	(5, 3, 5, 0),
	(10, 3, 5, 0),
	(25, 3, 5, 0),
	(18, 3, 5, 0),
	(29, 3, 5, 0),
	(31, 3, 5, 0),
	(19, 3, 6, 0),
	(14, 3, 6, 0),
	(9, 3, 6, 0),
	(23, 3, 6, 0),
	(17, 3, 6, 0),
	(2, 3, 6, 0),
	(16, 3, 6, 0),
	(3, 3, 6, 0),
	(19, 4, 1, 0),
	(32, 4, 2, 0),
	(13, 4, 2, 0),
	(29, 4, 2, 0),
	(5, 4, 3, 0),
	(22, 4, 3, 0),
	(23, 4, 3, 0),
	(1, 4, 3, 0),
	(10, 4, 3, 0),
	(27, 4, 3, 0),
	(11, 4, 4, 0),
	(30, 4, 4, 0),
	(33, 4, 4, 0),
	(7, 4, 5, 0),
	(26, 4, 5, 0),
	(6, 4, 5, 0),
	(18, 4, 5, 0),
	(21, 4, 5, 0),
	(25, 4, 5, 0),
	(15, 4, 5, 0),
	(14, 4, 6, 0),
	(24, 4, 6, 0),
	(3, 4, 6, 0),
	(8, 4, 6, 0),
	(4, 4, 6, 0),
	(16, 4, 6, 0),
	(31, 4, 6, 0),
	(9, 4, 6, 0),
	(16, 5, 1, 0),
	(5, 5, 2, 0),
	(23, 5, 2, 0),
	(9, 5, 2, 0),
	(10, 5, 3, 0),
	(26, 5, 3, 0),
	(18, 5, 3, 0),
	(29, 5, 3, 0),
	(6, 5, 3, 0),
	(30, 5, 3, 0),
	(27, 5, 4, 0),
	(19, 5, 4, 0),
	(13, 5, 4, 0),
	(25, 5, 5, 0),
	(4, 5, 5, 0),
	(12, 5, 5, 0),
	(17, 5, 5, 0),
	(31, 5, 5, 0),
	(8, 5, 5, 0),
	(32, 5, 5, 0),
	(33, 5, 6, 0),
	(3, 5, 6, 0),
	(21, 5, 6, 0),
	(2, 5, 6, 0),
	(22, 5, 6, 0),
	(20, 5, 6, 0),
	(7, 5, 6, 0),
	(1, 5, 6, 0);

-- Dumping structure for taulu efr_mini.game
CREATE TABLE IF NOT EXISTS `game` (
  `GameID` int(11) NOT NULL AUTO_INCREMENT,
  `ScreenName` varchar(50) DEFAULT NULL,
  `Location` int(11) DEFAULT NULL,
  `Balance` int(11) DEFAULT NULL,
  PRIMARY KEY (`GameID`),
  KEY `FK_game_stations` (`Location`),
  CONSTRAINT `FK_game_stations` FOREIGN KEY (`Location`) REFERENCES `stations` (`StationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table efr_mini.game: ~3 rows (suunnilleen)
INSERT INTO `game` (`GameID`, `ScreenName`, `Location`, `Balance`) VALUES
	(1, 'JStest', 6, 619),
	(2, 'JStest', 28, 612),
	(3, 'JStest', 28, 583),
	(4, 'JStest', 19, 617),
	(5, 'Andrei', 1, 999);

-- Dumping structure for taulu efr_mini.stations
CREATE TABLE IF NOT EXISTS `stations` (
  `StationID` int(11) NOT NULL AUTO_INCREMENT,
  `StationName` varchar(255) NOT NULL,
  PRIMARY KEY (`StationID`),
  KEY `SECOND` (`StationName`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table efr_mini.stations: ~33 rows (suunnilleen)
INSERT INTO `stations` (`StationID`, `StationName`) VALUES
	(3, 'Arkhangelsk'),
	(11, 'Astrakhan'),
	(25, 'Bratsk'),
	(27, 'Chita'),
	(26, 'Irkutsk'),
	(12, 'Kazan'),
	(32, 'Khabarovsk'),
	(9, 'Krasnodar'),
	(24, 'Krasnoyarsk'),
	(17, 'Kurgan'),
	(7, 'Moscow'),
	(2, 'Murmansk'),
	(22, 'Novy Urengoy'),
	(23, 'Omsk'),
	(18, 'Orenburg'),
	(19, 'Orsk'),
	(4, 'Pechora'),
	(13, 'Perm'),
	(1, 'Saint Peterburg'),
	(15, 'Saratov'),
	(21, 'Surgut'),
	(29, 'Tommot'),
	(28, 'Tynda'),
	(20, 'Tyumen'),
	(16, 'Ufa'),
	(31, 'Urgal'),
	(30, 'Ust-Ilimsk'),
	(33, 'Vladivostok'),
	(10, 'Volgograd'),
	(5, 'Vorkuta'),
	(8, 'Voronezh'),
	(6, 'Yaroslavl'),
	(14, 'Yekaterinburg');

-- Dumping structure for taulu efr_mini.stories
CREATE TABLE IF NOT EXISTS `stories` (
  `storytext` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table efr_mini.stories: ~8 rows (suunnilleen)
INSERT INTO `stories` (`storytext`) VALUES
	('Suspicious babushka is looking at you. Is she an undercover agent?... Probably not.'),
	('A cat crosses your path, meowing softly as it goes. Luckily it wasn\'t black'),
	('You smell the freshly baked piroshki. Hopefully this all is going to end soon.'),
	('A passerby accidentally bumps into you, making you wonder if it was deliberate.'),
	('A pigeon lands nearby and seems to be observing you. Is it just a bird, or something more?'),
	('You hear footsteps echoing in a deserted alleyway, but when you turn, no one is there.'),
	('A balalaika player on the street provides a haunting soundtrack to the tense atmosphere of the city.'),
	('You pass by a dilapidated statue of Lenin, a symbol of the country\'s turbulent history.');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
