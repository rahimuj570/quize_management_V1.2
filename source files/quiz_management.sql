--this is orginal



CREATE TABLE users (
  user_id NUMBER(19,0) NOT NULL,
  user_first_name VARCHAR2(100) NOT NULL,
  user_last_name VARCHAR2(20) NOT NULL,
  user_email VARCHAR2(50) NOT NULL,
  user_password VARCHAR2(20) NOT NULL,
  user_is_teacher NUMBER(1,0) NOT NULL,
  user_is_admin NUMBER(1,0) NOT NULL,
  user_is_approved NUMBER(1,0) DEFAULT 0 NOT NULL,
  user_is_verify NUMBER(1,0) DEFAULT 0,
  PRIMARY KEY (user_id),
  UNIQUE (user_email),
  CHECK (user_is_teacher BETWEEN 0 AND 1),
  CHECK (user_is_admin BETWEEN 0 AND 1),
  CHECK (user_is_approved BETWEEN 0 AND 1)
);




CREATE TABLE verify_pins (
  user_id NUMBER(19,0) DEFAULT NULL,
  pin_code VARCHAR2(6) NOT NULL,
  expire_date TIMESTAMP NOT NULL,
  is_for_reset_password NUMBER(1,0) DEFAULT 0
);



CREATE TABLE batch_class (
  id NUMBER(10,0) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  batch_class VARCHAR2(20) DEFAULT NULL,
  UNIQUE (batch_class)
);




CREATE TABLE course (
  course_id NUMBER(10,0) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  course_name VARCHAR2(50) DEFAULT NULL
);


CREATE TABLE sections (
  id NUMBER(10,0) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  section_name VARCHAR2(5) NOT NULL,
  UNIQUE (section_name)
);


CREATE TABLE exams (
  exam_id NUMBER(10,0) GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1 PRIMARY KEY,
  exam_name VARCHAR2(100 CHAR) NOT NULL,
  exam_teacher NUMBER(19,0) NOT NULL,
  exam_batch NUMBER(10,0) NOT NULL,
  exam_section NUMBER(10,0) NOT NULL,
  exam_course NUMBER(10,0) NOT NULL,
  exam_privacy NUMBER(1,0) NOT NULL,
  exam_duration NUMBER(10,0) NOT NULL,
  exam_question_amount NUMBER(10,0) NOT NULL,
  exam_mark NUMBER(10,0) NOT NULL,
  exam_start TIMESTAMP NOT NULL,
  exam_end TIMESTAMP NOT NULL,
  exam_isOver NUMBER(1,0) NOT NULL,
  exam_isApproved NUMBER(1,0) NOT NULL,

  CONSTRAINT fk_exam_teacher FOREIGN KEY (exam_teacher) REFERENCES users (user_id),
  CONSTRAINT fk_exam_course FOREIGN KEY (exam_course) REFERENCES course (course_id) ON DELETE CASCADE,
  CONSTRAINT fk_exam_batch FOREIGN KEY (exam_batch) REFERENCES batch_class (id) ON DELETE CASCADE,
  CONSTRAINT fk_exam_section FOREIGN KEY (exam_section) REFERENCES sections (id) ON DELETE CASCADE,

  CONSTRAINT chk_exam_privacy CHECK (exam_privacy BETWEEN 0 AND 1),
  CONSTRAINT chk_exam_isOver CHECK (exam_isOver BETWEEN 0 AND 1),
  CONSTRAINT chk_exam_isApproved CHECK (exam_isApproved BETWEEN 0 AND 1)
);


CREATE TABLE tmp_exam_entry (
  student_id NUMBER(19,0) NOT NULL,
  exam_id NUMBER(10,0) NOT NULL,
  entry_delete TIMESTAMP DEFAULT (SYSDATE + INTERVAL '1' DAY),
  PRIMARY KEY (student_id, exam_id),
  CONSTRAINT FK_Exam_id_tmp_exam_entry FOREIGN KEY (exam_id) REFERENCES exams (exam_id) on delete cascade,
  CONSTRAINT FK_Student_id_tmp_exam_entry FOREIGN KEY (student_id) REFERENCES users (user_id)on delete cascade
);


CREATE TABLE questions (
  q_id NUMBER(10,0) GENERATED ALWAYS AS IDENTITY,
  q_statement CLOB NOT NULL,
  q_img VARCHAR2(30) ,
  q_batch NUMBER(10,0) NOT NULL,
  q_subject NUMBER(10,0) NOT NULL,
  q_privacy NUMBER(1,0) NOT NULL,
  q_section NUMBER(10,0) NOT NULL,
  q_teacher NUMBER(19,0) NOT NULL,
  q_difficulty NUMBER(1,0) DEFAULT NULL,
  PRIMARY KEY (q_id),
  CONSTRAINT FK_Q_teacher_users FOREIGN KEY (q_teacher) REFERENCES users (user_id) ON DELETE CASCADE,
  CONSTRAINT FK_Q_subject FOREIGN KEY (q_subject) REFERENCES course (course_id) ON DELETE CASCADE,
  CONSTRAINT FK_Q_batch FOREIGN KEY (q_batch) REFERENCES batch_class (id) ON DELETE CASCADE,
  CONSTRAINT FK_Q_section FOREIGN KEY (q_section) REFERENCES sections (id),
  CHECK (q_difficulty BETWEEN 1 AND 3)
);

--
--alter table questions
--modify q_img null;
--commit;
select * from questions;
select * from options;


--CREATE SEQUENCE questions_seq START WITH 1 INCREMENT BY 1;
--DROP TRIGGER TRG_QUESTIONS_ID;
commit;


CREATE TABLE question_sets (
  qs_id NUMBER(10,0) GENERATED ALWAYS AS IDENTITY,
  qs_name VARCHAR2(50) NOT NULL,
  qs_created TIMESTAMP NOT NULL,
  qs_teacher NUMBER(19,0) NOT NULL,
  qs_course NUMBER(10,0) NOT NULL,
  qs_batch NUMBER(10,0) NOT NULL,
  qs_section NUMBER(10,0) NOT NULL,
  PRIMARY KEY (qs_id),
  CONSTRAINT FK_Qs_teacher_users FOREIGN KEY (qs_teacher) REFERENCES users (user_id) ON DELETE CASCADE,
  CONSTRAINT FK_Qs_course FOREIGN KEY (qs_course) REFERENCES course (course_id) ON DELETE CASCADE,
  CONSTRAINT FK_Qs_batch FOREIGN KEY (qs_batch) REFERENCES batch_class (id) ON DELETE CASCADE,
  CONSTRAINT FK_Qs_section FOREIGN KEY (qs_section) REFERENCES sections (id)
);



CREATE TABLE question_set_to_question_relation (
  q_id NUMBER(10,0) DEFAULT NULL,
  qs_id NUMBER(10,0) DEFAULT NULL,
  CONSTRAINT FK_Q_id FOREIGN KEY (q_id) REFERENCES questions (q_id) ON DELETE CASCADE,
  CONSTRAINT FK_Qs_id FOREIGN KEY (qs_id) REFERENCES question_sets (qs_id) ON DELETE CASCADE
);



CREATE TABLE options (
  opt_id NUMBER(10,0) GENERATED ALWAYS AS IDENTITY,
  opt_question NUMBER(10,0) NOT NULL,
  opt_text CLOB NOT NULL,
  opt_isAnswer NUMBER(1,0) NOT NULL,
  PRIMARY KEY (opt_id),
  CONSTRAINT FK_Opt_question_Question FOREIGN KEY (opt_question) REFERENCES questions (q_id) ON DELETE CASCADE
);


CREATE TABLE exams_permission (
  exam_id NUMBER(10,0) NOT NULL,
  student_id NUMBER(19,0) NOT NULL,
  deleted_date TIMESTAMP NOT NULL,
  CONSTRAINT FK_Exam_id_Exams_permission FOREIGN KEY (exam_id) REFERENCES exams (exam_id) ON DELETE CASCADE,
  CONSTRAINT FK_Student_id_Exams_permission FOREIGN KEY (student_id) REFERENCES users (user_id) ON DELETE CASCADE
);



CREATE TABLE exams_evaluation (
  student_id NUMBER(19,0) NOT NULL,
  exam_id NUMBER(10,0) NOT NULL,
  correct_answer NUMBER(10,0) NOT NULL,
  wrong_answer NUMBER(10,0) NOT NULL,
  pass_question NUMBER(10,0) NOT NULL,
  isExpelled NUMBER(1,0) NOT NULL,
  CONSTRAINT FK_Exam_id_Exams_evaluation FOREIGN KEY (exam_id) REFERENCES exams (exam_id) ON DELETE CASCADE,
  CONSTRAINT FK_Student_id_Exams_evaluation FOREIGN KEY (student_id) REFERENCES users (user_id) ON DELETE CASCADE,
  CHECK (isExpelled BETWEEN 0 AND 1)
);


CREATE TABLE exam_to_question_set_relation (
  exam_id NUMBER(10,0) NOT NULL,
  qs_id NUMBER(10,0) NOT NULL,
  CONSTRAINT FK_exam_to_question_set_relation_exam_id FOREIGN KEY (exam_id) REFERENCES exams (exam_id) ON DELETE CASCADE,
  CONSTRAINT FK_exam_to_question_set_relation_qs_id FOREIGN KEY (qs_id) REFERENCES question_sets (qs_id) ON DELETE CASCADE
);



CREATE TABLE batch_section_user_relation (
  user_id NUMBER(19,0) NOT NULL,
  batch_id NUMBER(10,0) DEFAULT NULL,
  section_id NUMBER(10,0) DEFAULT NULL,
  PRIMARY KEY (user_id),
  CONSTRAINT FK_batch_section_user_relation_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
  CONSTRAINT FK_batch_section_user_relation_batch FOREIGN KEY (batch_id) REFERENCES batch_class (id) ON DELETE CASCADE,
  CONSTRAINT FK_batch_section_user_relation_section FOREIGN KEY (section_id) REFERENCES sections (id) ON DELETE CASCADE
);


commit;



BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'JOB_DELETE_EXPIRED_TMP_EXAM',
        job_type        => 'PLSQL_BLOCK',
        job_action      => q'[
            BEGIN
                DELETE FROM tmp_exam_entry
                WHERE entry_delete < SYSDATE;
                COMMIT;
            END;
        ]',
        start_date      => TO_TIMESTAMP_TZ('2025-08-08 02:00:00', 'YYYY-MM-DD HH24:MI:SS TZR'),
        repeat_interval => 'FREQ=DAILY;BYHOUR=2;BYMINUTE=0;BYSECOND=0',
        enabled         => TRUE,
        comments        => 'Deletes expired tmp_exam_entry rows daily at 2 AM'
    );
END;
/





select * from verify_pins;
select * from users;

select * from batch_class;
desc batch_class;
insert into batch_class (batch_class) values('1');
insert into batch_class (batch_class) values('2');

select * from sections;
insert into sections (section_name) values('All');
insert into sections (section_name) values('A');
insert into sections (section_name) values('B');
insert into sections (section_name) values('C');
insert into sections (section_name) values('D');
commit;

--delete from batch_class;

desc users;
--delete from users;
commit;
select * from users;
select * from batch_section_user_relation;

select * from verify_pins;

update users set user_is_approved=1;
commit;

select * from users where user_id=221010020;

select * from course;
insert into course (course_name) values ('English');
commit;
select * from sections;
--delete from sections;
--delete from question_sets;
commit;



SELECT * FROM exams ;
--WHERE exam_teacher = 1001 
--  AND sysdate < exam_end;
  select * from batch_section_user_relation;
  select * from batch_class;
  
  select * from users;
insert into users values(0,'mr','admin', 'a@a.a','1234',0,1,1,1);
commit;
update users set user_is_approved=0 where user_first_name='pending ';


select * from exams_permission;
update users set user_is_verify=1;
commit;

select * from tmp_exam_entry;
delete from tmp_exam_entry;
commit;


select * from exams;
update exams set exam_end='16-AUG-25 12.34.00.000000000 PM' where exam_id=12;
commit;

update exams set exam_isOver='0' where exam_id=12;
commit;


select * from questions;
select * from options;

select * from users;
delete from users where user_id='123456';
select * from batch_section_user_relation where user_id='221010020';

select * from exams_evaluation;
delete from exams_evaluation;
commit;

SELECT * FROM dba_scheduler_jobs;
