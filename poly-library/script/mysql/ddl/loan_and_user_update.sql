-- ============================================================
-- 폴리 도서관 - DB 추가 설정 SQL
-- 실행 순서: 1→2→3
-- ============================================================

-- [1] USER_INFO 테이블에 PHONE 컬럼 추가
--     (이미 있으면 생략)
ALTER TABLE USER_INFO ADD COLUMN IF NOT EXISTS PHONE VARCHAR(20) DEFAULT NULL COMMENT '전화번호';

-- [2] LOAN 테이블 생성
CREATE TABLE IF NOT EXISTS LOAN (
    LOAN_ID     INT           NOT NULL AUTO_INCREMENT COMMENT '대출번호',
    BOOK_ID     INT           NOT NULL                COMMENT '도서번호',
    MEMBER_ID   VARCHAR(50)   NOT NULL                COMMENT '회원아이디',
    LOAN_DATE   VARCHAR(20)   NOT NULL                COMMENT '대출일(YYYY-MM-DD)',
    RETURN_DATE VARCHAR(20)   DEFAULT NULL            COMMENT '반납일',
    STATUS      VARCHAR(20)   NOT NULL DEFAULT 'ACTIVE' COMMENT '상태(ACTIVE/RETURNED)',
    PRIMARY KEY (LOAN_ID),
    FOREIGN KEY (BOOK_ID)   REFERENCES BOOK(BOOK_ID),
    FOREIGN KEY (MEMBER_ID) REFERENCES USER_INFO(MEMBER_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='도서 대출 이력';

-- [3] 테스트 데이터 (선택)
-- INSERT INTO USER_INFO (MEMBER_ID, PASSWORD, NAME, ROLE, PHONE) VALUES ('park', '1234', '박준수', 'ADMIN', '010-1234-4542');
-- INSERT INTO USER_INFO (MEMBER_ID, PASSWORD, NAME, ROLE, PHONE) VALUES ('user1', '1234', '테스트회원', 'USER', '010-5678-1234');
