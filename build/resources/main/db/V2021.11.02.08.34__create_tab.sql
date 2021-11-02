CREATE TABLE mentors
(
    id                  SERIAL  NOT NULL,
    name                VARCHAR NOT NULL,
    surname             VARCHAR NOT NULL,
    patronymic          VARCHAR,
    teaching_experience INT NOT NULL,
    email_contact       VARCHAR NOT NULL,
    phone_contact       VARCHAR NOT NULL,
    CONSTRAINT  mentors_pk PRIMARY KEY (id),
    CHECK (teaching_experience >= 0)
);

CREATE TABLE students
(
    id            SERIAL  NOT NULL,
    name          VARCHAR NOT NULL,
    surname       VARCHAR NOT NULL,
    patronymic    VARCHAR,
    age           INT NOT NULL,
    university    VARCHAR NOT NULL,
    email_contact VARCHAR NOT NULL,
    phone_contact VARCHAR NOT NULL,
    CONSTRAINT  students_pk PRIMARY KEY (id),
    CHECK (age >= 0)
);

CREATE TABLE courses
(
    id          SERIAL  NOT NULL,
    name        VARCHAR NOT NULL,
    required_knowledge_for_course TEXT,
    CONSTRAINT  courses_pk PRIMARY KEY (id)
);


CREATE TABLE courses_mentors
(
    course_id   INT NOT NULL REFERENCES courses (id) ON UPDATE CASCADE ON DELETE CASCADE,
    mentor_id  INT NOT NULL REFERENCES mentors (id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT  courses_mentors_pk PRIMARY KEY (course_id, mentor_id)
);

CREATE TABLE students_selected_on_course
(
    course_id   INT NOT NULL REFERENCES courses (id) ON UPDATE CASCADE ON DELETE CASCADE,
    student_id  INT NOT NULL REFERENCES students (id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT  students_selected_on_course_pk PRIMARY KEY (course_id, student_id)
);

CREATE TABLE courses_schedule
(
    id SERIAL       NOT NULL,
    course_id       INT NOT NULL REFERENCES courses (id) ON UPDATE CASCADE ON DELETE CASCADE,
    lesson_number   INT NOT NULL,
    date            TIMESTAMP,
    lesson_description TEXT,
    CONSTRAINT  courses_schedule_pk PRIMARY KEY (id)
);

CREATE TABLE students_attendance
(
    schedule_id INT NOT NULL REFERENCES courses_schedule (id) ON UPDATE CASCADE ON DELETE CASCADE,
    student_id  INT NOT NULL REFERENCES students (id) ON UPDATE CASCADE ON DELETE CASCADE,
    attended    BOOLEAN DEFAULT FALSE,
    CONSTRAINT attendance_pk PRIMARY KEY (student_id, schedule_id)
);


CREATE TABLE homework_assignments
(
    id SERIAL NOT NULL,
    schedule_id INT NOT NULL REFERENCES courses_schedule (id) ON UPDATE CASCADE ON DELETE CASCADE,
    deadline TIMESTAMP,
    max_grade INT NOT NULL,
    num_attempts_to_pass INT NOT NULL DEFAULT 1,
    CONSTRAINT task_pk PRIMARY KEY (id),
    CHECK(max_grade >= 0 AND num_attempts_to_pass >= 0)
);
