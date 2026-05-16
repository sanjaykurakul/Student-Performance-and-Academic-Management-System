CREATE DATABASE StudentManagementSystem;
USE StudentManagementSystem;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(200),
    department_id INT,
    admission_date DATE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    credits INT,
    department_id INT,
    faculty_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    marks INT,
    grade VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Departments (department_name)
VALUES
('Computer Science'),
('Information Technology'),
('Electronics'),
('Mechanical');

INSERT INTO Students
(first_name, last_name, gender, date_of_birth, email, phone, address, department_id, admission_date)
VALUES
('Sanjay', 'K', 'Male', '2004-02-10', 'sanjay@gmail.com', '9876543210', 'Chennai', 1, '2023-06-15'),
('Rahul', 'M', 'Male', '2003-08-20', 'rahul@gmail.com', '9876501234', 'Bangalore', 2, '2023-06-15'),
('Priya', 'S', 'Female', '2004-01-18', 'priya@gmail.com', '9876511111', 'Hyderabad', 1, '2023-06-15'),
('Anjali', 'R', 'Female', '2003-12-12', 'anjali@gmail.com', '9876522222', 'Chennai', 3, '2023-06-15');

INSERT INTO Faculty
(faculty_name, email, phone, department_id)
VALUES
('Dr. Kumar', 'kumar@gmail.com', '9999911111', 1),
('Dr. Ravi', 'ravi@gmail.com', '9999922222', 2),
('Dr. Meena', 'meena@gmail.com', '9999933333', 3);

INSERT INTO Courses
(course_name, credits, department_id, faculty_id)
VALUES
('Database Management System', 4, 1, 1),
('Java Programming', 3, 1, 1),
('Computer Networks', 4, 2, 2),
('Digital Electronics', 3, 3, 3);

INSERT INTO Enrollments
(student_id, course_id, enrollment_date)
VALUES
(1, 1, '2024-01-10'),
(1, 2, '2024-01-10'),
(2, 3, '2024-01-10'),
(3, 1, '2024-01-10'),
(4, 4, '2024-01-10');

INSERT INTO Marks
(student_id, course_id, marks, grade)
VALUES
(1, 1, 92, 'A+'),
(1, 2, 88, 'A'),
(2, 3, 75, 'B'),
(3, 1, 95, 'A+'),
(4, 4, 81, 'A');

SELECT * FROM Students;

SELECT s.first_name, s.last_name, d.department_name
FROM Students s
JOIN Departments d
ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';

SELECT * FROM Courses;

SELECT COUNT(*) AS total_students
FROM Students;

SELECT AVG(marks) AS average_marks
FROM Marks;

SELECT MAX(marks) AS highest_marks
FROM Marks;

SELECT s.first_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

SELECT s.first_name, c.course_name, m.marks, m.grade
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Courses c ON m.course_id = c.course_id;

SELECT student_id, marks
FROM Marks
WHERE marks > (
    SELECT AVG(marks)
    FROM Marks
);

SELECT d.department_name,
COUNT(s.student_id) AS total_students
FROM Departments d
LEFT JOIN Students s
ON d.department_id = s.department_id
GROUP BY d.department_name;

SELECT s.first_name, m.marks
FROM Students s
JOIN Marks m
ON s.student_id = m.student_id
WHERE m.marks = (
    SELECT MAX(marks)
    FROM Marks
);

SELECT f.faculty_name, c.course_name
FROM Faculty f
JOIN Courses c
ON f.faculty_id = c.faculty_id;

SELECT student_id, COUNT(course_id) AS total_courses
FROM Enrollments
GROUP BY student_id
HAVING COUNT(course_id) > 1;

CREATE VIEW Student_Report AS
SELECT
s.student_id,
s.first_name,
s.last_name,
d.department_name,
c.course_name,
m.marks,
m.grade
FROM Students s
JOIN Departments d
ON s.department_id = d.department_id
JOIN Marks m
ON s.student_id = m.student_id
JOIN Courses c
ON m.course_id = c.course_id;

SELECT * FROM Student_Report;

DELIMITER //

CREATE PROCEDURE GetStudentDetails()
BEGIN
    SELECT * FROM Students;
END //

DELIMITER ;

CALL GetStudentDetails();

DELIMITER //

CREATE TRIGGER CheckMarks
BEFORE INSERT ON Marks
FOR EACH ROW
BEGIN
    IF NEW.marks < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks cannot be negative';
    END IF;
END //

DELIMITER ;

CREATE INDEX idx_student_name
ON Students(first_name);

START TRANSACTION;

UPDATE Marks
SET marks = 90
WHERE student_id = 2;

COMMIT;
