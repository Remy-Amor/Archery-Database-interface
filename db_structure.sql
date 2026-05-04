-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: ictstu-db1.cc.swin.edu.au
-- Generation Time: Apr 28, 2026 at 12:51 PM
-- Server version: 5.5.68-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `s105914423_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `archers`
--

DROP TABLE IF EXISTS `archers`;
CREATE TABLE `archers` (
  `archeryAustraliaID` varchar(20) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `defaultDivision` enum('B','C','R','L') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `archers`
--

INSERT INTO `archers` (`archeryAustraliaID`, `firstName`, `lastName`, `dateOfBirth`, `gender`, `defaultDivision`) VALUES
('AA001', 'Spike', 'Gronw', '1998-04-12', 'Male', 'R'),
('AA002', 'Bridget', 'Toner', '2001-09-03', 'Female', 'C'),
('AA003', 'Lelia', 'Pringour', '2003-06-21', 'Female', 'R'),
('AA004', 'Jarred', 'Dorbin', '1995-11-15', 'Male', 'C'),
('AA005', 'Sherrie', 'Charlet', '1988-02-09', 'Female', 'B'),
('AA006', 'Dyanna', 'Hehnke', '1990-07-30', 'Female', 'R'),
('AA007', 'Wolfgang', 'Noore', '1985-01-18', 'Male', 'L'),
('AA008', 'Brandon', 'Guerin', '1999-12-05', 'Male', 'R'),
('AA009', 'Clareta', 'Barnsdall', '2004-03-27', 'Female', 'C'),
('AA010', 'Cherida', 'Veque', '1997-08-14', 'Female', 'R'),
('AA011', 'Tannie', 'Dunniom', '2002-05-19', 'Male', 'B'),
('AA012', 'Demetris', 'McNeil', '1996-10-22', 'Male', 'C'),
('AA013', 'Martie', 'Lumsdaine', '2000-06-11', 'Female', 'R'),
('AA014', 'Brocky', 'Gogay', '1993-03-08', 'Male', 'L'),
('AA015', 'Adolph', 'Frodsham', '1987-12-29', 'Male', 'C');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `archers`
--
ALTER TABLE `archers`
  ADD PRIMARY KEY (`archeryAustraliaID`),
  ADD KEY `idx_archer_name` (`lastName`,`firstName`),
  ADD KEY `idx_archer_dob` (`dateOfBirth`);
COMMIT;


-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `classID` varchar(10) NOT NULL,
  `ageGroupMin` int(11) DEFAULT NULL,
  `ageGroupMax` int(11) DEFAULT NULL,
  `gender` enum('Male','Female') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`classID`, `ageGroupMin`, `ageGroupMax`, `gender`) VALUES
('F50+', 50, 59, 'Female'),
('F60+', 60, 69, 'Female'),
('F70+', 70, NULL, 'Female'),
('FOPEN', 21, NULL, 'Female'),
('FU14', 0, 13, 'Female'),
('FU16', 14, 15, 'Female'),
('FU18', 16, 17, 'Female'),
('FU21', 18, 20, 'Female'),
('M50+', 50, 59, 'Male'),
('M60+', 60, 69, 'Male'),
('M70+', 70, NULL, 'Male'),
('MOPEN', 21, NULL, 'Male'),
('MU14', 0, 13, 'Male'),
('MU16', 14, 15, 'Male'),
('MU18', 16, 17, 'Male'),
('MU21', 18, 20, 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `competitions`
--

DROP TABLE IF EXISTS `competitions`;
CREATE TABLE `competitions` (
  `competitionID` int(11) NOT NULL,
  `competitionName` varchar(255) NOT NULL,
  `dateCompleted` date NOT NULL,
  `archeryClub` varchar(255) DEFAULT NULL,
  `roundID` int(11) NOT NULL,
  `classID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
INSERT INTO `competitions` (`competitionID`, `competitionName`, `dateCompleted`, `archeryClub`, `roundID`, `classID`) VALUES
(1, 'WA90 Open Championship', '2025-01-05', 'Melbourne Archery Club', 1, 'MOPEN'),
(2, 'WA70 Open Championship', '2025-01-12', 'Melbourne Archery Club', 2, 'FOPEN'),
(3, 'WA60 Invitational', '2025-01-20', 'Melbourne Archery Club', 3, 'MU21'),
(4, 'AA50 Championship', '2025-02-01', 'Melbourne Archery Club', 4, 'FU21'),
(5, 'AA40 Classic', '2025-02-10', 'Melbourne Archery Club', 5, 'M50+'),
(6, 'Long Sydney Tournament', '2025-02-25', 'Melbourne Archery Club', 6, 'F50+'),
(7, 'Sydney Open', '2025-03-05', 'Melbourne Archery Club', 7, 'M60+'),
(8, 'Long Brisbane Challenge', '2025-03-20', 'Melbourne Archery Club', 8, 'F60+'),
(9, 'Brisbane Ranking Event', '2025-04-01', 'Melbourne Archery Club', 9, 'M70+'),
(10, 'Adelaide Cup', '2025-04-15', 'Melbourne Archery Club', 10, 'F70+'),
(11, 'Short Adelaide Shoot', '2025-05-01', 'Melbourne Archery Club', 11, 'MU18'),
(12, 'Hobart Junior Event', '2025-05-20', 'Melbourne Archery Club', 12, 'FU18'),
(13, 'Perth Championship', '2025-06-05', 'Melbourne Archery Club', 13, 'MU16');
--
-- Table structure for table `competitions_entry`
--

DROP TABLE IF EXISTS `competitions_entry`;
CREATE TABLE `competitions_entry` (
  `entryID` int(11) NOT NULL,
  `archerID` varchar(20) NOT NULL,
  `competitionID` int(11) NOT NULL,
  `totalScore` int(11) NOT NULL DEFAULT '0',
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
INSERT INTO `competitions_entry` (`entryID`, `archerID`, `competitionID`, `totalScore`, `status`, `notes`) VALUES
(1, 'AA001', 1, 1320, 'Approved', 'Strong finish'),
(2, 'AA002', 2, 1285, 'Approved', 'Great Consistency'),
(3, 'AA003', 3, 1340, 'Approved', 'Strong finish'),
(4, 'AA004', 4, 1295, 'Approved', 'Great start'),
(5, 'AA005', 5, 1250, 'Approved', 'Solid performance'),
(6, 'AA006', 6, 1310, 'Approved', 'Personal record'),
(7, 'AA007', 7, 870, 'Pending', 'Waiting for score confirmation'),
(8, 'AA008', 8, 1335, 'Approved', 'Quite consistent'),
(9, 'AA009', 9, 860, 'Approved', 'Consistant'),
(10, 'AA010', 10, 845, 'Approved', 'Great Performance'),
(11, 'AA011', 11, 690, 'Pending', 'Waiting for score confirmation'),
(12, 'AA012', 12, 710, 'Approved', 'Great performance'),
(13, 'AA013', 13, 880, 'Approved', 'Strong finish'),
(14, 'AA014', 1, 1290, 'Approved', 'Consistant'),
(15, 'AA015', 2, 1265, 'Approved', 'Stong finish');
--
-- Table structure for table `competition_round_ranges`
--

DROP TABLE IF EXISTS `competition_round_ranges`;
CREATE TABLE `competition_round_ranges` (
  `entryID` int(11) NOT NULL,
  `recordedRangeID` int(11) NOT NULL,
  `rangePositionNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
INSERT INTO `competition_round_ranges` (`entryID`, `recordedRangeID`, `rangePositionNumber`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1);
--
-- Table structure for table `ends`
--

DROP TABLE IF EXISTS `ends`;
CREATE TABLE `ends` (
  `endID` int(11) NOT NULL,
  `arrow1` int(11) NOT NULL,
  `arrow2` int(11) NOT NULL,
  `arrow3` int(11) NOT NULL,
  `arrow4` int(11) NOT NULL,
  `arrow5` int(11) NOT NULL,
  `arrow6` int(11) NOT NULL,
  `bullseyeCount` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
INSERT INTO `ends` (`endID`, `arrow1`, `arrow2`, `arrow3`, `arrow4`, `arrow5`, `arrow6`, `bullseyeCount`) VALUES
(1, 8, 8, 9, 9, 10, 10, 2),
(2, 10, 7, 9, 8, 8, 9, 1),
(3, 9, 9, 8, 10, 10, 10, 3),
(4, 9, 9, 8, 8, 7, 7, 0),
(5, 10, 10, 9, 8, 8, 8, 2),
(6, 9, 9, 9, 8, 7, 6, 0),
(7, 10, 10, 10, 10, 9, 8, 4),
(8, 8, 8, 8, 7, 7, 6, 0),
(9, 10, 9, 9, 9, 8, 8, 1),
(10, 10, 10, 9, 9, 9, 9, 2),
(11, 9, 8, 8, 8, 7, 7, 0),
(12, 10, 10, 10, 9, 8, 8, 3),
(13, 7, 9, 8, 8, 8, 9, 0),
(14, 10, 9, 9, 8, 8, 8, 1),
(15, 7, 8, 9, 9, 10, 10, 2);
--
-- Table structure for table `individual_recorded_rounds`
--

DROP TABLE IF EXISTS `individual_recorded_rounds`;
CREATE TABLE `individual_recorded_rounds` (
  `recordedRoundID` int(11) NOT NULL,
  `archerID` varchar(20) NOT NULL,
  `roundID` int(11) NOT NULL,
  `dateCompleted` date NOT NULL,
  `totalScore` int(11) NOT NULL DEFAULT '0',
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Insert data for table `individual_recorded_rounds`
--

INSERT INTO `individual_recorded_rounds` (`recordedRoundID`, `archerID`, `roundID`, `dateCompleted`, `totalScore`, `status`, `notes`) VALUES
(1, 'AA001', 1, '2025-10-15', 1400, 'Approved', 'Great performance!'),
(2, 'AA002', 2, '2025-11-20', 1350, 'Approved', 'Well done!'),
(3, 'AA003', 3, '2025-12-05', 680, 'Pending', 'Score under review.'),
(4, 'AA004', 4, '2025-10-30', 850, 'Rejected', 'Score does not meet criteria.'),
(5, 'AA005', 5, '2025-11-10', 1420, 'Approved', 'Excellent shot placement.'),
(6, 'AA006', 6, '2025-12-01', 700, 'Pending', 'Awaiting further evaluation.'),
(7, 'AA007', 7, '2025-10-25', 880, 'Approved', 'Strong start but needs improvement.'),
(8, 'AA008', 8, '2025-11-15', 640, 'Approved', 'Strong start to the season.'),
(9, 'AA009', 9, '2025-12-10', 750, 'Pending', 'Awaiting score finalization.'),
(10, 'AA010', 10, '2025-10-20', 480, 'Pending', 'Needs improvement.'),
(11, 'AA011', 11, '2025-11-05', 860, 'Approved', 'Decent performance.'),
(12, 'AA012', 12, '2025-12-15', 600, 'Approved', 'Decent performance.'),
(13, 'AA013', 1, '2025-10-28', 1200, 'Pending', 'Awaiting further evaluation.'),
(14, 'AA014', 2, '2025-11-18', 1150, 'Approved', 'Consistent performance.'),
(15, 'AA015', 3, '2025-12-20', 420, 'Approved', 'Decent performance.');

-- --------------------------------------------------------

--
-- Table structure for table `individual_round_ranges`
--

DROP TABLE IF EXISTS `individual_round_ranges`;
CREATE TABLE `individual_round_ranges` (
  `recordedRoundID` int(11) NOT NULL,
  `recordedRangeID` int(11) NOT NULL,
  `rangePositionNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
--Insert data for table `individual_round_ranges`
--


-- --------------------------------------------------------

--
-- Table structure for table `ranges`
--

DROP TABLE IF EXISTS `ranges`;
CREATE TABLE `ranges` (
  `rangeID` int(11) NOT NULL,
  `distance` enum('20','30','40','50','60','70','90') NOT NULL,
  `endCount` int(11) NOT NULL,
  `targetFace` enum('80','122') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Insert data for table `ranges`
--

INSERT INTO `ranges` (`rangeID`, `distance`, `endCount`, `targetFace`) VALUES
(1, '20', 6, '80'),
(2, '30', 6, '80'),
(3, '40', 6, '122'),
(4, '50', 6, '122'),
(5, '60', 6, '122'),
(6, '70', 6, '122'),
(7, '90', 6, '122');

-- --------------------------------------------------------

--
-- Table structure for table `range_ends`
--

DROP TABLE IF EXISTS `range_ends`;
CREATE TABLE `range_ends` (
  `recordedRangeID` int(11) NOT NULL,
  `endID` int(11) NOT NULL,
  `endPositionNumber` int(11) NOT NULL,
  `rangeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Insert data for table `range_ends`
--

INSERT INTO `range_ends` (`recordedRangeID`, `endID`, `endPositionNumber`, `rangeID`) VALUES
(1, 1, 1, 1),
(1, 2, 2, 1),
(1, 3, 3, 1),
(1, 4, 4, 1),
(1, 5, 5, 1),
(1, 6, 6, 1),
(2, 7, 1, 2),
(2, 8, 2, 2),
(2, 9, 3, 2),
(2, 10, 4, 2),
(2, 11, 5, 2),
(2, 12, 6, 2),
(3, 13, 1, 3),
(3, 14, 2, 3),
(3, 15, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `rounds`
--

DROP TABLE IF EXISTS `rounds`;
CREATE TABLE `rounds` (
  `roundID` int(11) NOT NULL,
  `roundName` varchar(100) NOT NULL,
  `arrowCount` int(11) NOT NULL,
  `maxScore` int(11) NOT NULL,
  `activeStartDate` date NOT NULL,
  `activeEndDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
INSERT INTO `rounds` (`roundID`, `roundName`, `arrowCount`, `maxScore`, `activeStartDate`, `activeEndDate`) VALUES
(1, 'WA90/1440', 144, 1440, '2025-01-01', NULL),
(2, 'WA70/1440', 144, 1440, '2025-01-01', NULL),
(3, 'WA60/1440', 144, 1440, '2025-01-01', NULL),
(4, 'AA50/1440', 144, 1440, '2025-01-01', NULL),
(5, 'AA40/1440', 144, 1440, '2025-01-01', NULL),
(6, 'Long Sydney', 120, 1200, '2025-01-01', NULL),
(7, 'Sydney', 120, 1200, '2025-01-01', NULL),
(8, 'Long Brisbane', 120, 1200, '2025-01-01', NULL),
(9, 'Brisbane', 120, 1200, '2025-01-01', NULL),
(10, 'Adelaide', 120, 1200, '2025-01-01', NULL),
(11, 'Short Adelaide', 120, 1200, '2025-01-01', NULL),
(12, 'Hobart', 90, 900, '2025-01-01', NULL),
(13, 'Perth', 90, 900, '2025-01-01', NULL);
--
-- Table structure for table `round_ranges`
--

DROP TABLE IF EXISTS `round_ranges`;
CREATE TABLE `round_ranges` (
  `roundID` int(11) NOT NULL,
  `rangeID` int(11) NOT NULL,
  `rangeSequence` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Insert data for table `round_ranges`
--

INSERT INTO `round_ranges` (`roundID`, `rangeID`, `rangeSequence`) VALUES
(1, 7, 1),
(1, 6, 2),
(1, 5, 3),
(2, 7, 1),
(2, 6, 2),
(2, 5, 3),
(3, 5, 1),
(3, 4, 2),
(3, 3, 3),
(4, 7, 1),
(4, 6, 2),
(4, 5, 3),
(5, 7, 1),
(5, 6, 2),
(5, 5, 3),
(6, 7, 1),
(6, 6, 2),
(6, 1, 3),
(7, 7, 1),
(7, 6, 2),
(7, 5, 3),
(8, 7, 1),
(8, 6, 2),
(8, 1, 3),
(9, 7, 1),
(9, 6, 2),
(9, 5, 3),
(10, 7, 1),
(10, 6, 2),
(10, 1, 3),
(11, 7, 1),
(11, 6, 2),
(11, 5, 3),
(12, 7, 1),
(12, 6, 2),
(12, 5, 3);

--
-- Indexes for dumped tables
--



--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`classID`);

--
-- Indexes for table `competitions`
--
ALTER TABLE `competitions`
  ADD PRIMARY KEY (`competitionID`),
  ADD KEY `roundID` (`roundID`),
  ADD KEY `classID` (`classID`);

--
-- Indexes for table `competitions_entry`
--
ALTER TABLE `competitions_entry`
  ADD PRIMARY KEY (`entryID`),
  ADD UNIQUE KEY `uk_archer_comp` (`archerID`,`competitionID`),
  ADD KEY `competitionID` (`competitionID`),
  ADD KEY `idx_comp_entry_archer` (`archerID`,`competitionID`),
  ADD KEY `idx_comp_entry_status` (`status`);

--
-- Indexes for table `competition_round_ranges`
--
ALTER TABLE `competition_round_ranges`
  ADD PRIMARY KEY (`recordedRangeID`),
  ADD UNIQUE KEY `uk_comp_position` (`entryID`,`rangePositionNumber`);

--
-- Indexes for table `ends`
--
ALTER TABLE `ends`
  ADD PRIMARY KEY (`endID`);

--
-- Indexes for table `individual_recorded_rounds`
--
ALTER TABLE `individual_recorded_rounds`
  ADD PRIMARY KEY (`recordedRoundID`),
  ADD KEY `roundID` (`roundID`),
  ADD KEY `idx_individual_archer_date` (`archerID`,`dateCompleted`),
  ADD KEY `idx_individual_status` (`status`);

--
-- Indexes for table `individual_round_ranges`
--
ALTER TABLE `individual_round_ranges`
  ADD PRIMARY KEY (`recordedRangeID`),
  ADD KEY `recordedRoundID` (`recordedRoundID`);

--
-- Indexes for table `ranges`
--
ALTER TABLE `ranges`
  ADD PRIMARY KEY (`rangeID`);

--
-- Indexes for table `range_ends`
--
ALTER TABLE `range_ends`
  ADD PRIMARY KEY (`recordedRangeID`,`endID`),
  ADD UNIQUE KEY `uk_range_end_position` (`recordedRangeID`,`endPositionNumber`),
  ADD KEY `endID` (`endID`),
  ADD KEY `rangeID` (`rangeID`);

--
-- Indexes for table `rounds`
--
ALTER TABLE `rounds`
  ADD PRIMARY KEY (`roundID`);
INSERT INTO `rounds` (`roundID`, `roundName`, `arrowCount`, `maxScore`, `activeStartDate`, `activeEndDate`) VALUES
(1, 'WA90/1440', 144, 1440, '2025-10-01', NULL),
(2, 'WA70/1440', 144, 1440, '0000-00-00', NULL),
(3, 'WA720', 72, 720, '2025-01-02', NULL),
(4, 'WA900', 90, 900, '0000-00-00', NULL),
(5, 'Canberra Round', 144, 1440, '2025-04-03', NULL),
(6, 'Short Canberra Round', 72, 720, '0000-00-00', NULL),
(7, 'Sydney Round', 144, 1440, '0000-00-00', NULL),
(8, 'Short Sydney Round', 72, 720, '0000-00-00', NULL),
(9, 'Adelaide Round', 90, 900, '2025-08-05', NULL),
(10, 'Brisbane Round', 72, 720, '2025-01-06', NULL),
(11, 'Melbourne Round', 144, 1440, '2025-10-08', NULL),
(12, 'Perth Round', 90, 900, '2025-12-09', NULL);
--
-- Indexes for dumped tables
--

--
-- Indexes for table `rounds`
--
ALTER TABLE `rounds`
  ADD PRIMARY KEY (`roundID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rounds`
--
ALTER TABLE `rounds`
  MODIFY `roundID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;
--
-- Indexes for table `round_ranges`
--
ALTER TABLE `round_ranges`
  ADD PRIMARY KEY (`roundID`,`rangeSequence`),
  ADD KEY `rangeID` (`rangeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `competitions`
--
ALTER TABLE `competitions`
  MODIFY `competitionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `competitions_entry`
--
ALTER TABLE `competitions_entry`
  MODIFY `entryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `competition_round_ranges`
--
ALTER TABLE `competition_round_ranges`
  MODIFY `recordedRangeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ends`
--
ALTER TABLE `ends`
  MODIFY `endID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `individual_recorded_rounds`
--
ALTER TABLE `individual_recorded_rounds`
  MODIFY `recordedRoundID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `individual_round_ranges`
--
ALTER TABLE `individual_round_ranges`
  MODIFY `recordedRangeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ranges`
--
ALTER TABLE `ranges`
  MODIFY `rangeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rounds`
--
ALTER TABLE `rounds`
  MODIFY `roundID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `competitions`
--
ALTER TABLE `competitions`
  ADD CONSTRAINT `competitions_ibfk_1` FOREIGN KEY (`roundID`) REFERENCES `rounds` (`roundID`),
  ADD CONSTRAINT `competitions_ibfk_2` FOREIGN KEY (`classID`) REFERENCES `classes` (`classID`);

--
-- Constraints for table `competitions_entry`
--
ALTER TABLE `competitions_entry`
  ADD CONSTRAINT `competitions_entry_ibfk_1` FOREIGN KEY (`archerID`) REFERENCES `archers` (`archeryAustraliaID`),
  ADD CONSTRAINT `competitions_entry_ibfk_2` FOREIGN KEY (`competitionID`) REFERENCES `competitions` (`competitionID`);

--
-- Constraints for table `competition_round_ranges`
--
ALTER TABLE `competition_round_ranges`
  ADD CONSTRAINT `competition_round_ranges_ibfk_1` FOREIGN KEY (`entryID`) REFERENCES `competitions_entry` (`entryID`);

--
-- Constraints for table `individual_recorded_rounds`
--
ALTER TABLE `individual_recorded_rounds`
  ADD CONSTRAINT `individual_recorded_rounds_ibfk_1` FOREIGN KEY (`archerID`) REFERENCES `archers` (`archeryAustraliaID`),
  ADD CONSTRAINT `individual_recorded_rounds_ibfk_2` FOREIGN KEY (`roundID`) REFERENCES `rounds` (`roundID`);

--
-- Constraints for table `individual_round_ranges`
--
ALTER TABLE `individual_round_ranges`
  ADD CONSTRAINT `individual_round_ranges_ibfk_1` FOREIGN KEY (`recordedRoundID`) REFERENCES `individual_recorded_rounds` (`recordedRoundID`);

--
-- Constraints for table `range_ends`
--
ALTER TABLE `range_ends`
  ADD CONSTRAINT `range_ends_ibfk_1` FOREIGN KEY (`endID`) REFERENCES `ends` (`endID`),
  ADD CONSTRAINT `range_ends_ibfk_2` FOREIGN KEY (`rangeID`) REFERENCES `ranges` (`rangeID`);

--
-- Constraints for table `round_ranges`
--
ALTER TABLE `round_ranges`
  ADD CONSTRAINT `round_ranges_ibfk_1` FOREIGN KEY (`roundID`) REFERENCES `rounds` (`roundID`),
  ADD CONSTRAINT `round_ranges_ibfk_2` FOREIGN KEY (`rangeID`) REFERENCES `ranges` (`rangeID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
