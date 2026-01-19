USE MenstrualCyclePredictor;

-- Users
INSERT INTO Users (name, age, email) VALUES
('Alice Johnson', 28, 'alice@example.com'),
('Mary Smith', 32, 'mary@example.com'),
('Priya Sharma', 25, 'priya@example.com'),
('Sofia Martinez', 30, 'sofia@example.com');

-- Menstrual cycle data for each user (mixed regular/irregular)
INSERT INTO Menstrual_Cycles (user_id, cycle_start_date, cycle_end_date, cycle_length) VALUES
-- Alice
(1, '2024-01-01', '2024-01-06', 28),
(1, '2024-01-29', '2024-02-03', 29),
(1, '2024-02-27', '2024-03-03', 28),
(1, '2024-03-26', '2024-03-31', 28),
(1, '2024-04-23', '2024-04-28', 27),

-- Mary
(2, '2024-01-05', '2024-01-10', 30),
(2, '2024-02-04', '2024-02-09', 28),
(2, '2024-03-04', '2024-03-09', 29),
(2, '2024-04-02', '2024-04-07', 31),

-- Priya
(3, '2024-01-10', '2024-01-15', 26),
(3, '2024-02-05', '2024-02-10', 27),
(3, '2024-03-03', '2024-03-08', 26),
(3, '2024-03-29', '2024-04-03', 27),

-- Sofia
(4, '2024-01-20', '2024-01-25', 30),
(4, '2024-02-19', '2024-02-24', 30),
(4, '2024-03-20', '2024-03-25', 29);

-- Symptoms
INSERT INTO Symptoms (symptom_name) VALUES
('Cramps'),('Headache'),('Mood Swings'),('Bloating'),
('Fatigue'),('Back Pain'),('Nausea'),('Acne');

-- Alice’s symptoms
INSERT INTO Cycle_Symptoms (cycle_id, symptom_id, severity) VALUES
(1,1,'moderate'),(1,3,'mild'),(2,1,'moderate'),
(3,2,'mild'),(3,4,'mild'),(4,1,'severe'),(5,5,'mild');

-- Mary’s symptoms
INSERT INTO Cycle_Symptoms VALUES
(NULL,6, 'moderate'),(NULL,2,'mild');

-- Priya’s symptoms
INSERT INTO Cycle_Symptoms VALUES
(NULL,1, 'mild'),(NULL,7,'moderate');

-- Sofia’s symptoms
INSERT INTO Cycle_Symptoms VALUES
(NULL,4,'mild'),(NULL,3,'moderate');

-- Lifestyle factors
INSERT INTO Lifestyle_Factors (user_id, factor_date, stress_level, sleep_hours, exercise_minutes) VALUES
(1,'2024-01-01',5,7.5,30),
(1,'2024-01-29',6,6.0,20),
(2,'2024-01-05',8,5.5,10),
(3,'2024-01-10',4,8.0,40),
(4,'2024-01-20',5,7.0,25);
