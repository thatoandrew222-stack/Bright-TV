SELECT *
FROM `workspace`.`default`.`user_viewership`;

-----------------------------------------------------------------

SELECT 
    UserID,

    -- Channels
    CASE 
        WHEN Channels = 'None' OR Channels IS NULL THEN 'No Channel'
        ELSE Channels
    END AS Channels,

    -- Convert UTC → SAST
    FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg') AS SouthAfrica_Timezone,

    -- Date & Time (SAST)
    TO_DATE(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg')) AS Date,
    DATE_FORMAT(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg'), 'HH:mm:ss') AS Time,
    DATE_FORMAT(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg'), 'EEEE') AS DayName,
    DATE_FORMAT(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg'), 'MMMM') AS MonthName,

    -- Viewing Period 
    CASE 
        WHEN HOUR(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg')) BETWEEN 0 AND 3 THEN 'Midnight'
        WHEN HOUR(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg')) BETWEEN 4 AND 7 THEN 'Early Morning'
        WHEN HOUR(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg')) BETWEEN 8 AND 11 THEN 'Morning'
        WHEN HOUR(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg')) BETWEEN 12 AND 15 THEN 'Day Time'
        WHEN HOUR(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg')) BETWEEN 16 AND 17 THEN 'Afternoon'
        WHEN HOUR(FROM_UTC_TIMESTAMP(RecordDate, 'Africa/Johannesburg')) BETWEEN 18 AND 23 THEN 'Night Time'
    END AS Viewing_Period,

    -- Gender
    CASE 
        WHEN Gender = 'None' OR Gender IS NULL THEN 'No Gender'
        ELSE Gender
    END AS Gender,

    -- Race
    CASE 
        WHEN Race = 'None' OR Race IS NULL THEN 'No Race'
        ELSE Race
    END AS Race,

    -- Age 
    CASE 
        WHEN Age IS NULL OR Age = 0 THEN 'No Age'
        ELSE CAST(Age AS STRING)
    END AS Age,

    -- Age Category
    CASE 
        WHEN Age IS NULL OR Age = 0 THEN 'Unknown'
        WHEN Age BETWEEN 1 AND 12 THEN 'Child'
        WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
        WHEN Age BETWEEN 20 AND 30 THEN 'Young Adult'
        WHEN Age BETWEEN 31 AND 50 THEN 'Adult'
        WHEN Age BETWEEN 51 AND 65 THEN 'Senior'
        WHEN Age > 65 THEN 'Elderly'
        ELSE 'No Age'
    END AS Age_Category,

    -- Province
    CASE 
        WHEN Province = 'None' OR Province IS NULL THEN 'No Province'
        ELSE Province
    END AS Province,

    -- Duration 
    DATE_FORMAT(Duration, 'HH:mm:ss') AS Duration,

    -- Duration in seconds for bucketing
    (HOUR(Duration)*3600 + MINUTE(Duration)*60 + SECOND(Duration)) AS Duration_Per_Seconds,

    -- Duration Buckets
    CASE 
        WHEN (HOUR(Duration)*3600 + MINUTE(Duration)*60 + SECOND(Duration)) < 300 THEN 'Snack (<5 min)'
        WHEN (HOUR(Duration)*3600 + MINUTE(Duration)*60 + SECOND(Duration)) BETWEEN 300 AND 900 THEN 'Quick Watch (5-15 min)'
        WHEN (HOUR(Duration)*3600 + MINUTE(Duration)*60 + SECOND(Duration)) BETWEEN 901 AND 1800 THEN 'Casual Viewing (15-30 min)'
        WHEN (HOUR(Duration)*3600 + MINUTE(Duration)*60 + SECOND(Duration)) BETWEEN 1801 AND 3600 THEN 'Engaged (30-60 min)'
        WHEN (HOUR(Duration)*3600 + MINUTE(Duration)*60 + SECOND(Duration)) BETWEEN 3601 AND 7200 THEN 'Long Watch (1-2 hrs)'
        WHEN (HOUR(Duration)*3600 + MINUTE(Duration)*60 + SECOND(Duration)) > 7200 THEN 'Binge Watch (2+ hrs)'
    END AS Duration_Category

FROM workspace.default.user_viewership;
