select * from `workspace`.`default`.`user_profile`
limit 100;

---1) Checking the number of Province (there is 10th province of none)
SELECT DISTINCT Province
FROM Default.user_profile;

---a) GROUP Users by Province (THERES 9 Province, none and Null ((BLANK))
SELECT COUNT (UserID) AS Numberof_Province, Province
FROM Default.user_profile
GROUP BY Province;


--2) Gender has male, female, None and blank(null)...4 IN TOTAL
SELECT COUNT (UserID) AS Numberof_Gender, Gender
FROM Default.user_profile
GROUP BY Gender;

--3) Identified race. There is White, Black, Coloured, Other, None and Blank(Null)
SELECT COUNT (UserID) AS Types_of_race, Race
FROM Default.user_profile
GROUP BY Race;

--4) Count the number of users in this dataset
SELECT COUNT (UserID) AS Number_of_users
FROM Default.user_profile;


--5) Classify age into different groups for easier identification
SELECT 
    CASE 
        WHEN Age IS NULL THEN 'Unknown'
        WHEN Age < 13 THEN 'Child'
        WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
        WHEN Age BETWEEN 20 AND 30 THEN 'Young Adult'
        WHEN Age BETWEEN 31 AND 50 THEN 'Adult'
        WHEN Age BETWEEN 51 AND 65 THEN 'Senior'
        WHEN Age > 65 THEN 'Elderly'
        ELSE 'No Age'
    END AS Age_Group,
    
    COUNT(UserID) AS Number_of_users

FROM Default.user_profile

GROUP BY 
    CASE 
        WHEN Age IS NULL THEN 'Unknown'
        WHEN Age < 13 THEN 'Child'
        WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
        WHEN Age BETWEEN 20 AND 30 THEN 'Young Adult'
        WHEN Age BETWEEN 31 AND 50 THEN 'Adult'
        WHEN Age BETWEEN 51 AND 65 THEN 'Senior'
        WHEN Age > 65 THEN 'Elderly'
        ELSE 'No Age'
    END;


--I cannot really do much with the Name, Surname, and Social Media Handles of csutomers.
