-- Use Case 1: Archer views the ranges in a round
SET @roundName = 'WA70/1440';
SELECT
    rounds.roundName,
    round_ranges.rangeSequence,
    ranges.distance,
    ranges.endCount,
    ranges.targetFace
FROM rounds
JOIN round_ranges
    ON rounds.roundID = round_ranges.roundID
JOIN ranges
    ON round_ranges.rangeID = ranges.rangeID
WHERE rounds.roundName = @roundName
ORDER BY round_ranges.rangeSequence;

-- Use Case 2: Archer Views Their Own Scores Over Time
SET @archerID = 'AA001';
SET @roundID = 1;
SET @startDate = '2025-01-01';
SET @endDate = '2025-12-31';
SELECT
    individual_recorded_rounds.archerID,
    CONCAT(archers.firstName, ' ', archers.lastName) AS archerName,
    individual_recorded_rounds.recordedRoundID,
    rounds.roundName,
    individual_recorded_rounds.dateCompleted,
    individual_recorded_rounds.totalScore,
    individual_recorded_rounds.status
FROM individual_recorded_rounds
JOIN archers
    ON individual_recorded_rounds.archerID = archers.archeryAustraliaID
JOIN rounds
    ON individual_recorded_rounds.roundID = rounds.roundID
WHERE individual_recorded_rounds.archerID = @archerID
  AND individual_recorded_rounds.roundID = @roundID
  AND individual_recorded_rounds.dateCompleted BETWEEN @startDate AND @endDate
ORDER BY individual_recorded_rounds.dateCompleted ASC;

-- Use Case 3: Archer Finds Their Personal Best
SET @archerID = 'AA001';
SET @roundID = 1;
SELECT
    individual_recorded_rounds.archerID,
    CONCAT(archers.firstName, ' ', archers.lastName) AS archerName,
    rounds.roundName,
    individual_recorded_rounds.totalScore,
    individual_recorded_rounds.dateCompleted
FROM individual_recorded_rounds
JOIN archers
    ON individual_recorded_rounds.archerID = archers.archeryAustraliaID
JOIN rounds
    ON individual_recorded_rounds.roundID = rounds.roundID
WHERE individual_recorded_rounds.archerID = @archerID
  AND individual_recorded_rounds.roundID = @roundID
  AND individual_recorded_rounds.status = 'Approved'
ORDER BY individual_recorded_rounds.totalScore DESC
LIMIT 1;


-- Use Case 4: Archer Compares Their Score With Other Archers
SET @competitionID = 1;
SELECT
    competitions_entry.entryID,
    competitions_entry.archerID,
    CONCAT(archers.firstName, ' ', archers.lastName) AS archerName,
    competitions.competitionName,
    competitions.classID,
    competitions.roundID,
    competitions_entry.totalScore,
    competitions_entry.status
FROM competitions_entry
JOIN archers
    ON competitions_entry.archerID = archers.archeryAustraliaID
JOIN competitions
    ON competitions_entry.competitionID = competitions.competitionID
WHERE competitions_entry.competitionID = @competitionID
  AND competitions_entry.status = 'Approved'
ORDER BY competitions_entry.totalScore DESC;

-- Use Case 10: Club Recorder Checks Competition Results
SET @competitionID = 1;
SELECT
    competitions_entry.entryID,
    competitions_entry.archerID,
    CONCAT(archers.firstName, ' ', archers.lastName) AS archerName,
    competitions.competitionName,
    competitions_entry.totalScore,
    competitions_entry.status
FROM competitions_entry
JOIN archers
    ON competitions_entry.archerID = archers.archeryAustraliaID
JOIN competitions
    ON competitions_entry.competitionID = competitions.competitionID
WHERE competitions_entry.competitionID = @competitionID
  AND competitions_entry.status = 'Approved'
ORDER BY competitions_entry.totalScore DESC;

-- use Case 11 - Club recorder views championship results
SET @championship = 1;
SELECT 
    ch.championshipName,
    ch.championshipYear,
    a.archeryAustraliaID,
    a.firstName,
    a.lastName,
    SUM(ce.totalScore) AS totalChampionshipScore,
    COUNT(ce.entryID) AS competitionsParticipated,
    AVG(ce.totalScore) AS averageCompetitionScore,
    RANK() OVER (ORDER BY SUM(ce.totalScore) DESC) AS championshipRank

FROM championships ch
JOIN competitions c ON ch.championshipID = c.championshipID
JOIN competitions_entry ce ON c.competitionID = ce.competitionID
JOIN archers a ON ce.archerID = a.archeryAustraliaID
WHERE ch.championshipID = @championship
  AND ce.status = 'Approved'
GROUP BY ch.championshipName, ch.championshipYear, a.archeryAustraliaID, a.firstName, a.lastName
ORDER BY totalChampionshipScore DESC
-- optional: can limit here, such as to the top 5