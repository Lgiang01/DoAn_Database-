-- 1. Kích hoạt tính năng Vector và UUID tự động cho hệ thống
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Tạo bảng Users (Quản lý tài khoản thành viên)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tạo bảng Notebooks (Quản lý các Sổ tay tri thức)
CREATE TABLE notebooks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tạo bảng Documents (Lưu văn bản sau khi Nhật Tú chạy xong OCR hoặc Đọc File)
CREATE TABLE documents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    notebook_id UUID REFERENCES notebooks(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) NOT NULL, -- pdf, txt, docx, youtube_link, web_url
    file_url TEXT,                  -- Đường dẫn lưu file trên server/cloud
    status VARCHAR(50) DEFAULT 'PENDING', -- PENDING, PROCESSING, COMPLETED, FAILED (Để Tú và AI bắt trạng thái)
    raw_content TEXT,               -- Toàn bộ văn bản thô sau khi đọc file
    file_size INT,                  -- Dung lượng file (bổ sung để quản lý)
    metadata JSONB DEFAULT '{}',    -- Lưu thông tin phụ như tác giả, ngày xuất bản...
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Tạo bảng Document_Chunks (Lưu mảnh cắt text + Vector của Khuê & Diệu)
CREATE TABLE document_chunks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    content TEXT NOT NULL,          -- Đoạn text nhỏ đã cắt
    page_number INT,                -- Trang số mấy trong file PDF (rất quan trọng để làm tính năng trích dẫn)
    chunk_index INT,                -- Thứ tự của đoạn cắt trong file
    embedding vector(1024),         -- Kích thước 1024 cho model BGE-m3 hoặc 1536 nếu dùng OpenAI
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Tạo bảng Chat Sessions (Lịch sử các phiên chat trong từng Notebook)
CREATE TABLE chat_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    notebook_id UUID REFERENCES notebooks(id) ON DELETE CASCADE,
    title VARCHAR(255) DEFAULT 'Cuộc trò chuyện mới',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. Tạo bảng Chat Messages (Chi tiết các câu hỏi - câu trả lời)
CREATE TABLE chat_messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id UUID REFERENCES chat_sessions(id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL,      -- 'user' hoặc 'assistant'
    content TEXT NOT NULL,          -- Nội dung chat
    -- [Mẹo từ Open-Notebook]: Lưu danh sách các Chunk ID đã dùng làm ngữ cảnh để AI trả lời.
    -- Từ đây Frontend có thể bấm vào nguồn trích dẫn để nhảy tới đúng số trang PDF!
    context_sources JSONB DEFAULT '[]', 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Đánh Index HNSW để thuật toán AI tìm kiếm Vector siêu tốc
CREATE INDEX idx_chunks_embedding ON document_chunks USING hnsw (embedding vector_cosine_ops);
