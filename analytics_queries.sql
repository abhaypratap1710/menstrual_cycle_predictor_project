USE MenstrualCyclePredictor;

-- 1. Predict next cycle start date
WITH AvgLen AS (
    SELECT user_id, ROUND(AVG(cycle_length)) AS avg_len
    FROM Menstrual_Cycles GROUP BY user_id
),
LastDate AS (
    SELECT user_id, MAX(cycle_start_date) AS last_start
    FROM Menstrual_Cycles GROUP BY user_id
)
SELECT l.user_id, DATE_ADD(l.last_start, INTERVAL a.avg_len DAY) AS predicted_start
FROM AvgLen a JOIN LastDate l ON a.user_id = l.user_id;

-- 2. Predict fertile window (typ. ovulation 14 days before period)
WITH Pred AS (
    SELECT user_id, DATE_ADD(MAX(cycle_start_date), INTERVAL ROUND(AVG(cycle_length)) DAY) AS next_start
    FROM Menstrual_Cycles GROUP BY user_id
)
SELECT user_id, DATE_SUB(next_start, INTERVAL 20 DAY) AS fertile_start, DATE_SUB(next_start, INTERVAL 14 DAY) AS fertile_end
FROM Pred;

-- 3. Most common symptom per user
SELECT u.name, s.symptom_name, COUNT(*) AS freq
FROM Cycle_Symptoms cs
JOIN Menstrual_Cycles mc ON mc.cycle_id=cs.cycle_id
JOIN Users u ON mc.user_id = u.user_id
JOIN Symptoms s ON s.symptom_id=cs.symptom_id
GROUP BY u.name, s.symptom_name
ORDER BY u.name, freq DESC;

-- 4. Average cycle length per user
SELECT user_id, AVG(cycle_length) avg_len FROM Menstrual_Cycles GROUP BY user_id;

-- 5. Regularity score (STDDEV of lengths)
SELECT user_id, STDDEV_POP(cycle_length) AS variability FROM Menstrual_Cycles GROUP BY user_id;

-- 6. Longest recorded cycle per user
SELECT user_id, MAX(cycle_length) AS longest FROM Menstrual_Cycles GROUP BY user_id;

-- 7. Shortest recorded cycle per user
SELECT user_id, MIN(cycle_length) AS shortest FROM Menstrual_Cycles GROUP BY user_id;

-- 8. Avg symptoms per cycle
SELECT u.name, ROUND(AVG(symptom_count),2) AS avg_symptoms
FROM (
    SELECT mc.user_id, mc.cycle_id, COUNT(cs.symptom_id) AS symptom_count
    FROM Menstrual_Cycles mc
    LEFT JOIN Cycle_Symptoms cs ON mc.cycle_id = cs.cycle_id
    GROUP BY mc.cycle_id
) t
JOIN Users u ON t.user_id = u.user_id
GROUP BY u.name;

-- 9. Correlation check: Avg stress vs cycle length (basic)
SELECT u.name, ROUND(AVG(lf.stress_level),1) avg_stress, ROUND(AVG(mc.cycle_length),1) avg_cycle_length
FROM Lifestyle_Factors lf
JOIN Users u ON u.user_id=lf.user_id
JOIN Menstrual_Cycles mc ON mc.user_id=u.user_id
GROUP BY u.name;

-- 10. Symptom severity distribution per user
SELECT u.name, cs.severity, COUNT(*) AS occurrences
FROM Cycle_Symptoms cs
JOIN Menstrual_Cycles mc ON mc.cycle_id=cs.cycle_id
JOIN Users u ON mc.user_id = u.user_id
GROUP BY u.name, cs.severity
ORDER BY u.name, occurrences DESC;

-- 11. Monthly cycle start count per user
SELECT u.name, MONTH(mc.cycle_start_date) AS month_num, COUNT(*) AS starts
FROM Menstrual_Cycles mc
JOIN Users u ON u.user_id=mc.user_id
GROUP BY u.name, month_num
ORDER BY u.name, month_num;
