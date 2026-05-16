# Student Performance Analysis System using MySQL

## Project Overview
This project is a Student Performance Analysis System developed using MySQL. It manages student records, course enrollments, faculty details, and examination marks. The project demonstrates practical SQL concepts including joins, subqueries, views, stored procedures, triggers, indexing, and transactions.

---

## Features
- Student record management
- Course and faculty management
- Enrollment tracking
- Marks and grade analysis
- Performance reporting
- SQL joins and aggregate functions
- Stored procedures and triggers

---

## Technologies Used
- MySQL
- SQL
- MySQL Workbench / XAMPP / phpMyAdmin

---

## Database Tables
1. Departments
2. Students
3. Faculty
4. Courses
5. Enrollments
6. Marks

---

## SQL Concepts Used
- CREATE DATABASE
- CREATE TABLE
- INSERT INTO
- SELECT Queries
- JOIN Operations
- Aggregate Functions
- GROUP BY and HAVING
- Subqueries
- Views
- Stored Procedures
- Triggers
- Indexes
- Transactions

---

## Sample Queries
```sql
SELECT * FROM Students;
```

```sql
SELECT AVG(marks) FROM Marks;
```

```sql
SELECT s.first_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;
```

---

## Project Purpose
The system helps educational institutions digitally manage student academic data and analyze student performance efficiently.

---

## Future Enhancements
- Login authentication
- Attendance management
- Fee management
- Web application integration
- Dashboard analytics

---

## Author
Developed as a MySQL Mini Project for academic and placement purposes.
