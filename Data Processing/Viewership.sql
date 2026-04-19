select * from `workspace`.`default`.`viewership` 
limit 100;

---Channels columns
--1) Check the number different types of channels available. Theres 21 different channels
SELECT DISTINCT Channels
FROM Default. viewership;

---I will fix the RecordDate column and Duration colum on the saved JOINED table.


---Finally I had to Join both tables into one table
SELECT
    v.UserID,
    v.Channels,
    v.RecordDate,
    v.Duration,
    
    u.Gender,
    u.Race,
    u.Age,
    u.Province

FROM workspace.default.viewership AS v
LEFT JOIN workspace.default.user_profile AS u
    ON v.UserID = u.UserID;
