CREATE DATABASE IF NOT EXISTS MenstrualCyclePredictor;
USE MenstrualCyclePredictor;

-- Users table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    email VARCHAR(100)
);

-- Menstrual Cycles table
CREATE TABLE Menstrual_Cycles (
    cycle_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    cycle_start_date DATE,
    cycle_end_date DATE,
    cycle_length INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Symptoms list table
CREATE TABLE Symptoms (
    symptom_id INT AUTO_INCREMENT PRIMARY KEY,
    symptom_name VARCHAR(100) UNIQUE
);

-- Symptoms reported for each cycle
CREATE TABLE Cycle_Symptoms (
    cycle_symptom_id INT AUTO_INCREMENT PRIMARY KEY,
    cycle_id INT,
    symptom_id INT,
    severity VARCHAR(20), -- mild, moderate, severe
    FOREIGN KEY (cycle_id) REFERENCES Menstrual_Cycles(cycle_id),
    FOREIGN KEY (symptom_id) REFERENCES Symptoms(symptom_id)
);

-- Lifestyle factors table (optional advanced feature)
CREATE TABLE Lifestyle_Factors (
    factor_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    factor_date DATE,
    stress_level INT,        -- Scale 1-10
    sleep_hours DECIMAL(4,2),
    exercise_minutes INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
