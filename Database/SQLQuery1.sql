USE master;
GO

CREATE DATABASE Floria;
GO

USE Floria;
GO

-- Bảng Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    email NVARCHAR(255) UNIQUE NOT NULL,
    password_hashed NVARCHAR(255) NOT NULL,
    name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Bảng UserProfiles
CREATE TABLE UserProfiles (
    profile_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT UNIQUE NOT NULL,
    date_of_birth DATE,
    height FLOAT,
    weight FLOAT,
    medical_history NVARCHAR(MAX),
    blood_type NVARCHAR(10),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- Bảng MenstrualCycles
CREATE TABLE MenstrualCycles (
    cycle_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    cycle_length INT,
    recorded_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- Bảng Symptoms
CREATE TABLE Symptoms (
    symptom_id INT PRIMARY KEY IDENTITY(1,1),
    symptom_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX)
);
GO

-- Bảng trung gian CycleSymptoms
CREATE TABLE CycleSymptoms (
    cycle_symptom_id INT PRIMARY KEY IDENTITY(1,1),
    cycle_id INT NOT NULL,
    symptom_id INT NOT NULL,
    severity NVARCHAR(50),
    FOREIGN KEY (cycle_id) REFERENCES MenstrualCycles(cycle_id),
    FOREIGN KEY (symptom_id) REFERENCES Symptoms(symptom_id)
);
GO

-- Bảng CyclePredictions
CREATE TABLE CyclePredictions (
    prediction_id INT PRIMARY KEY IDENTITY(1,1),
    cycle_id INT NOT NULL,
    predicted_ovulation DATE,
    predicted_period DATE,
    confidence_score FLOAT,
    FOREIGN KEY (cycle_id) REFERENCES MenstrualCycles(cycle_id)
);
GO

-- Bảng Experts
CREATE TABLE Experts (
    expert_id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(100) NOT NULL,
    specialization NVARCHAR(100),
    contact_info NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Bảng Consultations
CREATE TABLE Consultations (
    consultation_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    expert_id INT NOT NULL,
    consultation_time DATETIME NOT NULL,
    status NVARCHAR(50) NOT NULL,
    notes NVARCHAR(MAX),
    consultation_duration INT CHECK (consultation_duration IN (15, 30, 45)),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (expert_id) REFERENCES Experts(expert_id)
);
GO

-- Bảng Messages
CREATE TABLE Messages (
    message_id INT PRIMARY KEY IDENTITY(1,1),
    consultation_id INT NOT NULL,
    sender_id INT NOT NULL,
    message_content NVARCHAR(MAX) NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (consultation_id) REFERENCES Consultations(consultation_id)
);
GO

-- Bảng Notifications
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    message NVARCHAR(MAX) NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

-- Bảng: question_sets – Bộ câu hỏi
CREATE TABLE question_sets (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX) NULL,
    is_active BIT NOT NULL DEFAULT 1,
    created_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME2(0) NOT NULL DEFAULT GETDATE()
);
GO

-- Bảng: Questions – Câu hỏi
CREATE TABLE Questions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    question_set_id INT NOT NULL,
    [text] NVARCHAR(MAX) NOT NULL,
    [type] NVARCHAR(20) NOT NULL CHECK ([type] IN (N'single', N'multiple', N'text')),
    order_in_set INT NOT NULL,
    is_active BIT NOT NULL DEFAULT 1,
    created_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (question_set_id) REFERENCES question_sets(id)
);
GO

-- Bảng: Answers – Danh sách đáp án
CREATE TABLE Answers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    question_id INT NOT NULL,
    label NCHAR(1) NOT NULL,
    [text] NVARCHAR(MAX) NOT NULL,
    hint NVARCHAR(MAX) NULL,
    order_in_question INT NULL,
    created_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (question_id) REFERENCES Questions(id)
);
GO

-- Bảng: answer_combinations – Rẽ nhánh theo tổ hợp đáp án
CREATE TABLE answer_combinations (
    id INT IDENTITY(1,1) PRIMARY KEY,
    question_id INT NOT NULL,
    combination NVARCHAR(255) NOT NULL,
    next_question_set_id INT NULL,
    created_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (question_id) REFERENCES Questions(id),
    FOREIGN KEY (next_question_set_id) REFERENCES question_sets(id)
);
GO

-- Bảng: UserAnswers – Lưu câu trả lời người dùng
CREATE TABLE UserAnswers (
    user_answer_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    question_id INT NOT NULL,
    answer_id INT NOT NULL,
    cycle_id INT NULL,
    created_at DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES Questions(id),
    FOREIGN KEY (answer_id) REFERENCES Answers(id),
    FOREIGN KEY (cycle_id) REFERENCES MenstrualCycles(cycle_id) ON DELETE SET NULL
);
GO
