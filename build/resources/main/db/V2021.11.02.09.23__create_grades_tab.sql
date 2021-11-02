CREATE TABLE grades_for_homework
(
    task_id INT NOT NULL REFERENCES homework_assignments(id) ON UPDATE CASCADE ON DELETE CASCADE,
    student_id INT NOT NULL REFERENCES students (id) ON UPDATE CASCADE ON DELETE CASCADE,
    grade INT DEFAULT NULL,
    CONSTRAINT grade_pk PRIMARY KEY (task_id, student_id),
    CHECK (grade >= 0)
);