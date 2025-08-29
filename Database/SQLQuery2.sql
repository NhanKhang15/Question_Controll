USE master;
GO

CREATE DATABASE Luna;
GO

USE Luna;
GO

-- 1. Bảng: question_sets – Bộ câu hỏi
CREATE TABLE question_sets (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    description TEXT NULL,
    is_active BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE()
);

-- 2. Bảng: questions – Câu hỏi
CREATE TABLE questions (
    id INT PRIMARY KEY IDENTITY(1,1),
    question_set_id INT NOT NULL,
    text TEXT NOT NULL,
    type VARCHAR(20) CHECK (type IN ('single', 'multiple', 'text')),
    order_in_set INT NOT NULL,
    is_active BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (question_set_id) REFERENCES question_sets(id)
);

-- 3. Bảng: answers – Danh sách đáp án
CREATE TABLE answers (
    id INT PRIMARY KEY IDENTITY(1,1),
    question_id INT NOT NULL,
    label CHAR(1) NOT NULL,
    text TEXT NOT NULL,
    hint TEXT NULL,
    [order] INT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- 4. Bảng: answer_combinations – Rẽ nhánh theo tổ hợp đáp án
CREATE TABLE answer_combinations (
    id INT PRIMARY KEY IDENTITY(1,1),
    question_id INT NOT NULL,
    combination VARCHAR(255) NOT NULL,
    next_question_set_id INT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (next_question_set_id) REFERENCES question_sets(id)
);
