CREATE EVENT IF NOT EXISTS closingdate1
ON SCHEDULE EVERY 1 second  
STARTS CURRENT_TIMESTAMP  
DO update es.petition set approval_state=5 where write_time <= now()-interval 3 month and approval_state=0;

CREATE EVENT IF NOT EXISTS closingdate2
ON SCHEDULE EVERY 1 second  
STARTS CURRENT_TIMESTAMP  
DO update es.petition set approval_state=2 where write_time <= now()-interval 3 month and approval_state=1;


select EVENT_SCHEMA,EVENT_NAME,INTERVAL_FIELD from information_schema.events; -- 이벤트 목록
SET GLOBAL event_scheduler = ON;
SET @@global.event_scheduler = ON;
SET GLOBAL event_scheduler = 1;
SET @@global.event_scheduler = 1;  -- 이벤트 설정
show variables like 'event%';      -- 이벤트 설정 확인

CREATE TABLE petition
(
    `petition_no`     INT              NOT NULL    AUTO_INCREMENT COMMENT '청원글번호', 
    `classification`  VARCHAR(50)      NOT NULL    COMMENT '분류', 
    `title`           VARCHAR(300)     NOT NULL    COMMENT '제목', 
    `content`         VARCHAR(2000)    NOT NULL    COMMENT '내용', 
    `writer`          VARCHAR(45)      NOT NULL    COMMENT '작성자', 
    `write_time`      TIMESTAMP        NULL        COMMENT '작성시간', 
    `closing_date`    TIMESTAMP        NULL        COMMENT '만료시간', 
    `file_path`       VARCHAR(500)     NULL        COMMENT '첨부파일경로', 
    `file_save_name`  VARCHAR(500)     NULL        COMMENT '첨부파일저장이름', 
    `file_ori_name`   VARCHAR(500)     NULL        COMMENT '첨부파일원래이름', 
    `approval_state`  INT              NULL        COMMENT '0 - 진행 중, 1 - 심사중, 2 - 심사중(마감), 3 - 청원채택, 4-청원거부, 5 - 기간만료', 
    `agree`           INT              NULL        COMMENT '청원찬성', 
    `comment`         varchar(1000)    NULL        COMMENT '청원답변글',
    PRIMARY KEY (petition_no)
);

CREATE TABLE petition_like
(
    `no`           INT            NOT NULL    AUTO_INCREMENT COMMENT 'pk번호', 
    `petition_no`  INT            NOT NULL    COMMENT '글번호', 
    `emp_no`       VARCHAR(13)    NOT NULL    COMMENT '사번', 
    PRIMARY KEY (no)
);