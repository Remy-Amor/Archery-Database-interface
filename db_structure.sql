-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: ictstu-db1.cc.swin.edu.au
-- Generation Time: Apr 28, 2026 at 12:32 PM
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
  `defaultDivision` enum('B, C, R, L') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

--
-- Table structure for table `round_ranges`
--

DROP TABLE IF EXISTS `round_ranges`;
CREATE TABLE `round_ranges` (
  `roundID` int(11) NOT NULL,
  `rangeID` int(11) NOT NULL,
  `rangeSequence` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `score_staging`
--

DROP TABLE IF EXISTS `score_staging`;
CREATE TABLE `score_staging` (
  `stagingID` int(11) NOT NULL,
  `archerID` varchar(20) NOT NULL,
  `roundID` int(11) NOT NULL,
  `divisionID` varchar(10) NOT NULL,
  `scoreDate` date NOT NULL,
  `scoreTime` time NOT NULL,
  `submittedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

--
-- Indexes for table `round_ranges`
--
ALTER TABLE `round_ranges`
  ADD PRIMARY KEY (`roundID`,`rangeSequence`),
  ADD KEY `rangeID` (`rangeID`);

--
-- Indexes for table `score_staging`
--
ALTER TABLE `score_staging`
  ADD PRIMARY KEY (`stagingID`),
  ADD KEY `archerID` (`archerID`),
  ADD KEY `roundID` (`roundID`),
  ADD KEY `divisionID` (`divisionID`);

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
-- AUTO_INCREMENT for table `score_staging`
--
ALTER TABLE `score_staging`
  MODIFY `stagingID` int(11) NOT NULL AUTO_INCREMENT;

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

--
-- Constraints for table `score_staging`
--
ALTER TABLE `score_staging`
  ADD CONSTRAINT `score_staging_ibfk_1` FOREIGN KEY (`archerID`) REFERENCES `archers` (`archeryAustraliaID`),
  ADD CONSTRAINT `score_staging_ibfk_2` FOREIGN KEY (`roundID`) REFERENCES `rounds` (`roundID`),
  ADD CONSTRAINT `score_staging_ibfk_3` FOREIGN KEY (`divisionID`) REFERENCES `divisions` (`divisionID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
