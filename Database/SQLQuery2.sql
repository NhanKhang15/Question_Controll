USE master;
GO

CREATE DATABASE Floria;
GO

USE Floria;
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

BEGIN TRAN;
SET NOCOUNT ON;

-- === question_sets (keep CSV IDs) ===
SET IDENTITY_INSERT dbo.question_sets ON;
INSERT INTO dbo.question_sets (id, name, description, is_active, created_at, updated_at) VALUES (1, N'Bộ câu hỏi sàng lọc', N'Sàng lọc ban đầu', 1, '2025-08-21 10:00:00', '2025-08-21 10:00:00');
INSERT INTO dbo.question_sets (id, name, description, is_active, created_at, updated_at) VALUES (2, N'Theo dõi chu kỳ', N'Theo dõi chu kỳ kinh nguyệt', 1, '2025-08-21 10:00:00', '2025-08-21 10:00:00');
INSERT INTO dbo.question_sets (id, name, description, is_active, created_at, updated_at) VALUES (3, N'Tư vấn sau sinh / mang thai', N'Dùng cho thai kỳ hoặc sau sinh', 1, '2025-08-21 10:00:00', '2025-08-21 10:00:00');
SET IDENTITY_INSERT dbo.question_sets OFF;

-- === Questions ===
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Chu kỳ kinh nguyệt của bạn thường kéo dài bao nhiêu ngày?', N'single', 1, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Tình trạng thai kỳ hiện tại của bạn là gì?', N'single', 2, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có đang sử dụng biện pháp tránh thai nào không?', N'single', 3, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Ngày đầu tiên của kỳ kinh gần nhất là khi nào?', N'single', 4, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn thường bị đau bụng kinh không?', N'single', 5, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Màu sắc máu kinh nguyệt của bạn thường là gì?', N'single', 6, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Lượng máu kinh của bạn như thế nào?', N'single', 7, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn thường có những triệu chứng nào trước hoặc trong kỳ kinh?', N'single', 8, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn đã từng bị rong kinh chưa?', N'single', 9, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có từng được chẩn đoán mắc các bệnh phụ khoa nào sau đây?', N'single', 10, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có bị rối loạn kinh nguyệt không?', N'single', 11, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn thường bị chuột rút trong kỳ kinh không?', N'single', 12, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có từng bị trễ kinh quá 7 ngày không?', N'single', 13, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Tâm trạng của bạn thường thay đổi như thế nào quanh kỳ kinh?', N'single', 14, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có nhu cầu theo dõi những gì trong chu kỳ?', N'single', 15, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có theo dõi chu kỳ kinh nguyệt hằng tháng không?', N'single', 16, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Chu kỳ của bạn thường kéo dài bao nhiêu ngày?', N'single', 17, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có hay bị rối loạn kinh nguyệt không?', N'single', 18, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có thường gặp triệu chứng tiền kinh nguyệt (PMS) không?', N'single', 19, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có ghi chú lại ngày rụng trứng không?', N'single', 20, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có dùng app hoặc sổ để theo dõi chu kỳ không?', N'single', 21, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có từng bỏ lỡ kỳ kinh nào trong 6 tháng gần đây không?', N'single', 22, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có gặp vấn đề về chu kỳ sau khi thay đổi chế độ ăn không?', N'single', 23, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có bị đau bụng hoặc khó chịu trong chu kỳ không?', N'single', 24, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (1, N'Bạn có muốn dự đoán ngày rụng trứng để mang thai hoặc tránh thai không?', N'single', 25, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Bạn đã từng khám sức khỏe tổng quát trong năm nay chưa?', N'single', 1, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Bạn có tiền sử bệnh mãn tính nào không?', N'single', 2, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Bạn có hút thuốc hoặc uống rượu thường xuyên không?', N'single', 3, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Bạn có bị dị ứng với loại thuốc hoặc thực phẩm nào không?', N'single', 4, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Gia đình bạn có ai mắc bệnh di truyền không?', N'single', 5, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Bạn có thường xuyên tập thể dục không?', N'single', 6, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Bạn có gặp vấn đề về giấc ngủ trong thời gian dài không?', N'single', 7, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Bạn có đang sử dụng thuốc theo toa không?', N'single', 8, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Bạn có từng phẫu thuật trong vòng 5 năm qua không?', N'single', 9, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (2, N'Bạn có cảm thấy căng thẳng hoặc áp lực kéo dài không?', N'single', 10, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có gặp khó khăn khi cho con bú không?', N'single', 1, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có đang cảm thấy mệt mỏi sau sinh không?', N'single', 2, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có nhận được sự hỗ trợ từ gia đình sau sinh không?', N'single', 3, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có đang gặp các triệu chứng trầm cảm sau sinh không?', N'single', 4, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có gặp khó khăn trong việc cân bằng chăm sóc con và bản thân không?', N'single', 5, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có muốn được tư vấn về chế độ dinh dưỡng sau sinh không?', N'single', 6, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có gặp vấn đề về giấc ngủ do chăm con không?', N'single', 7, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có đang sử dụng biện pháp tránh thai sau sinh không?', N'single', 8, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có muốn tư vấn về việc phục hồi sức khỏe sau sinh không?', N'single', 9, 1);
INSERT INTO dbo.Questions (question_set_id, [text], [type], order_in_set, is_active) VALUES (3, N'Bạn có câu hỏi nào liên quan đến việc mang thai lần sau không?', N'single', 10, 1);

-- === Answers ===
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (1, N'A', N'Dưới 21 ngày', N'Chu kỳ ngắn', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (1, N'B', N'21-25 ngày', N'Chu kỳ ngắn', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (1, N'C', N'26-30 ngày', N'Chu kỳ dài', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (1, N'D', N'Trên 30 ngày', N'Chu kỳ dài', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (2, N'A', N'Không có thai', N'Liên quan đến tình trạng mang thai', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (2, N'B', N'Đang mang thai', N'Liên quan đến tình trạng mang thai', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (2, N'C', N'Đang cho con bú', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (2, N'D', N'Đang cố gắng có thai', N'Liên quan đến tình trạng mang thai', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (3, N'A', N'Không sử dụng', N'Không áp dụng hoặc không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (3, N'B', N'Bao cao su', N'Biện pháp tránh thai - bao cao su', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (3, N'C', N'Thuốc tránh thai', N'Liên quan đến tình trạng mang thai', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (3, N'D', N'Vòng tránh thai', N'Liên quan đến tình trạng mang thai', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (3, N'E', N'Khác', N'Khác/không có', 5);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (4, N'A', N'Dưới 7 ngày trước', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (4, N'B', N'7-14 ngày trước', N'Khác/không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (4, N'C', N'15-21 ngày trước', N'Chu kỳ ngắn', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (4, N'D', N'Hơn 21 ngày trước', N'Chu kỳ ngắn', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (5, N'A', N'Không đau', N'Không áp dụng hoặc không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (5, N'B', N'Đau nhẹ', N'Khác/không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (5, N'C', N'Đau vừa', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (5, N'D', N'Đau dữ dội', N'Khác/không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (6, N'A', N'Đỏ tươi', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (6, N'B', N'Đỏ sẫm', N'Khác/không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (6, N'C', N'Nâu', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (6, N'D', N'Đen', N'Khác/không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (7, N'A', N'Ít', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (7, N'B', N'Trung bình', N'Khác/không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (7, N'C', N'Nhiều', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (7, N'D', N'Rất nhiều', N'Khác/không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (8, N'A', N'Đau bụng', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (8, N'B', N'Đau lưng', N'Khác/không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (8, N'C', N'Mệt mỏi', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (8, N'D', N'Tâm trạng thay đổi', N'Khác/không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (8, N'E', N'Mụn', N'Khác/không có', 5);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (8, N'F', N'Không có triệu chứng', N'Khác/không có', 6);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (9, N'A', N'Chưa từng', N'Không áp dụng hoặc không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (9, N'B', N'Thỉnh thoảng', N'Khác/không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (9, N'C', N'Thường xuyên', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (10, N'A', N'Không có', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (10, N'B', N'U xơ tử cung', N'Không áp dụng hoặc không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (10, N'C', N'Lạc nội mạc tử cung', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (10, N'D', N'Viêm âm đạo', N'Khác/không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (10, N'E', N'Khác', N'Khác/không có', 5);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (11, N'A', N'Không', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (11, N'B', N'Thỉnh thoảng', N'Không áp dụng hoặc không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (11, N'C', N'Thường xuyên', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (12, N'A', N'Không', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (12, N'B', N'Ít khi', N'Không áp dụng hoặc không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (12, N'C', N'Thường xuyên', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (12, N'D', N'Rất thường xuyên', N'Khác/không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (13, N'A', N'Chưa từng', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (13, N'B', N'Thỉnh thoảng', N'Khác/không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (13, N'C', N'Thường xuyên', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (14, N'A', N'Không thay đổi', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (14, N'B', N'Tăng lo âu', N'Không áp dụng hoặc không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (14, N'C', N'Buồn bã', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (14, N'D', N'Cáu gắt', N'Khác/không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (14, N'E', N'Thay đổi thất thường', N'Khác/không có', 5);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (15, N'A', N'Ngày bắt đầu & kết thúc', N'Khác/không có', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (15, N'B', N'Tâm trạng', N'Khác/không có', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (15, N'C', N'Triệu chứng', N'Khác/không có', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (15, N'D', N'Lượng máu', N'Khác/không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (15, N'E', N'Tất cả các mục trên', N'Khác/không có', 5);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (16, N'A', N'Luôn luôn', N'Theo dõi đều đặn', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (16, N'B', N'Thỉnh thoảng', N'Không đều', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (16, N'C', N'Hiếm khi', N'Ít theo dõi', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (16, N'D', N'Không bao giờ', N'Không theo dõi', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (17, N'A', N'Dưới 21 ngày', N'Chu kỳ ngắn', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (17, N'B', N'21–25 ngày', N'Chu kỳ ngắn', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (17, N'C', N'26–30 ngày', N'Chu kỳ điển hình', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (17, N'D', N'Trên 30 ngày', N'Chu kỳ dài', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (18, N'A', N'Không bao giờ', N'Ổn định', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (18, N'B', N'1–2 lần', N'Thỉnh thoảng', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (18, N'C', N'3–4 lần', N'Tương đối thường', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (18, N'D', N'Trên 4 lần', N'Thường xuyên', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (19, N'A', N'Nặng', N'Ảnh hưởng sinh hoạt', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (19, N'B', N'Vừa', N'Gây khó chịu', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (19, N'C', N'Nhẹ', N'Ảnh hưởng ít', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (19, N'D', N'Không có', N'Không triệu chứng', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (20, N'A', N'Luôn luôn', N'Theo dõi đều đặn', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (20, N'B', N'Thỉnh thoảng', N'Không đều', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (20, N'C', N'Hiếm khi', N'Ít theo dõi', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (20, N'D', N'Không bao giờ', N'Không theo dõi', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (21, N'A', N'Luôn luôn', N'Theo dõi đều đặn', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (21, N'B', N'Thỉnh thoảng', N'Không đều', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (21, N'C', N'Hiếm khi', N'Ít theo dõi', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (21, N'D', N'Không bao giờ', N'Không theo dõi', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (22, N'A', N'Không bao giờ', N'Ổn định', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (22, N'B', N'1–2 lần', N'Thỉnh thoảng', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (22, N'C', N'3–4 lần', N'Tương đối thường', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (22, N'D', N'Trên 4 lần', N'Thường xuyên', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (23, N'A', N'Có', N'Trả lời khẳng định', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (23, N'B', N'Không', N'Trả lời phủ định', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (23, N'C', N'Đôi khi', N'Không thường xuyên', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (23, N'D', N'Không rõ', N'Chưa chắc chắn', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (24, N'A', N'Nặng', N'Cần tư vấn thêm', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (24, N'B', N'Vừa', N'Theo dõi thêm', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (24, N'C', N'Nhẹ', N'Tự chăm sóc', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (24, N'D', N'Không có', N'Bình thường', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (25, N'A', N'Muốn dự đoán để mang thai', N'Lập kế hoạch có thai', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (25, N'B', N'Muốn dự đoán để tránh thai', N'Kế hoạch tránh thai', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (25, N'C', N'Chỉ để theo dõi sức khỏe', N'Theo dõi thông tin', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (25, N'D', N'Chưa có nhu cầu', N'Không áp dụng', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (26, N'A', N'Có, trong 6 tháng gần đây', N'Gần đây', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (26, N'B', N'Có, trong 1 năm', N'Trong năm', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (26, N'C', N'Có, trên 1 năm', N'Đã lâu', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (26, N'D', N'Chưa từng/Không', N'Không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (33, N'A', N'Có, trong 6 tháng gần đây', N'Gần đây', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (33, N'B', N'Có, trong 1 năm', N'Trong năm', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (33, N'C', N'Có, trên 1 năm', N'Đã lâu', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (33, N'D', N'Chưa từng/Không', N'Không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (34, N'A', N'Có, trong 6 tháng gần đây', N'Gần đây', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (34, N'B', N'Có, trong 1 năm', N'Trong năm', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (34, N'C', N'Có, trên 1 năm', N'Đã lâu', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (34, N'D', N'Chưa từng/Không', N'Không có', 4);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (35, N'A', N'Cao', N'Ảnh hưởng sinh hoạt', 1);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (35, N'B', N'Vừa', N'Đáng chú ý', 2);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (35, N'C', N'Nhẹ', N'Ít ảnh hưởng', 3);
INSERT INTO dbo.Answers (question_id, label, [text], hint, order_in_question) VALUES (35, N'D', N'Không', N'Ổn định', 4);

-- === answer_combinations ===
INSERT INTO dbo.answer_combinations (question_id, combination, next_question_set_id) VALUES (1, N'A', 2);
INSERT INTO dbo.answer_combinations (question_id, combination, next_question_set_id) VALUES (1, N'D', 2);
INSERT INTO dbo.answer_combinations (question_id, combination, next_question_set_id) VALUES (1, N'B', 3);
INSERT INTO dbo.answer_combinations (question_id, combination, next_question_set_id) VALUES (1, N'C', 3);
INSERT INTO dbo.answer_combinations (question_id, combination, next_question_set_id) VALUES (1, N'E', 3);
INSERT INTO dbo.answer_combinations (question_id, combination, next_question_set_id) VALUES (2, N'A', 2);
INSERT INTO dbo.answer_combinations (question_id, combination, next_question_set_id) VALUES (2, N'B,C,D,E', 2);

COMMIT;
