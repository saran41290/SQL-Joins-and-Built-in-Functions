/*
-- 1CREATE DATABASE 
CREATE DATABASE StudentsDB; 
USE StudentsDB; 
-- CREATE TABLES 
CREATE TABLE Students ( 
StudentID INT PRIMARY KEY, 
StudentName VARCHAR(50), 
Age INT, 
City VARCHAR(50) 
); 
CREATE TABLE Courses ( 
CourseID INT PRIMARY KEY, 
CourseName VARCHAR(50), 
Duration VARCHAR(20) 
); 
CREATE TABLE Enrollments ( 
EnrollmentID INT PRIMARY KEY, 
StudentID INT, 
CourseID INT, 
EnrollmentDate DATE, 
FOREIGN KEY (StudentID) REFERENCES Students(StudentID), 
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) 
);
-- INSERT SAMPLE DATA 
INSERT INTO Students VALUES 
(1, 'Aarav', 21, 'Chennai'), 
(2, 'Meera', 22, 'Bangalore'), 
(3, 'Karthik', 23, 'Hyderabad'), 
(4, 'Divya', 21, 'Delhi'); 
INSERT INTO Courses VALUES 
(101, 'Data Analytics', '3 Months'), 
(102, 'Python Programming', '2 Months'), 
(103, 'SQL Basics', '1 Month'); 
INSERT INTO Enrollments VALUES 
(1001, 1, 101, '2025-05-10'), 
(1002, 2, 102, '2025-06-01'), 
(1003, 3, 103, '2025-06-15');*/
/*Question 1 – INNER JOIN - Show students with their enrolled course names. 
Expected Output: Only students who have valid enrollments (common in both tables) */
select s.studentid Student_ID,studentname Student_Name,e.courseid Course_ID ,c.coursename Course_Name
from students s join enrollments e on s.studentid=e.studentid
join courses c on c.courseid=e.courseid;
-- ------------------------------------------------------------------------------
/*Question 2 – LEFT JOIN and RIGHT JOIN - List all students and their courses, including those without matches. 
Task: 
Use both LEFT JOIN and RIGHT JOIN between Students and Enrollments. 
Expected Output: 
All students/courses are shown, with NULL where no match exists. 
*/
select s.studentname StudentName,c.coursename Course_Name from 
students s left join enrollments e on s.studentid=e.studentid
left join courses c on c.courseid=e.courseid #Keeps all students
union
select s.studentname StudentName,c.coursename Course_Name from 
students s right join enrollments e on s.studentid=e.studentid
right join courses c on c.courseid=e.courseid ;# keeps all courses
 -- ------------------------------------------------------------------------------
/* Question 3 – ROUND() - While preparing numeric reports, analysts need to round off decimal values. 
Task: Round the value 123.4567 to two decimal places using the ROUND() function. 
Expected Output: Display a single column showing 123.46 */
select round(123.4567,2);
-- ------------------------------------------------------------------------------
/* Question 4 – ABS() & MOD() - The HR team wants to calculate absolute values and remainders for data validation. 
Task: Use ABS() to convert negative numbers to positive and MOD() to find the remainder when 25 is divided by 4. 
Expected Output: Display absolute value and remainder results. */
select abs(-25) as ABS_Result,mod(abs(-25),4) as MOD_Result;
-- ------------------------------------------------------------------------------
/* Question 5 – CONCAT() - The placement cell wants a full description combining each student’s name and city. 
Task: Use CONCAT() to merge StudentName and City into one column like “Aarav from Chennai.” 
Expected Output: Full_Description showing combined values. */
select studentID,concat(studentname,' from ',city) as StudentName_City from students;
-- ------------------------------------------------------------------------------
/* Question 6 – LENGTH() - The admin wants to find names with length greater than a certain value for formatting. 
Task: Use LENGTH() to display each student’s name along with its character count. 
Expected Output: StudentName | Name_Length */
select studentname StudentName,length(studentname) Name_Length from students;
-- ------------------------------------------------------------------------------
/* Question 7 – REPLACE() - Course titles need updating — every occurrence of “SQL” should be replaced with “Database.” 
Task: Use REPLACE() to modify course names in the Courses table. 
Expected Output: CourseName | Updated_CourseName */
select coursename CourseName ,replace(coursename,'SQL','Database') as Updated_CourseName from courses;
-- ------------------------------------------------------------------------------
/* Question 8 – SUBSTRING() - For generating student codes, you need the first 3 letters of each name. 
Task: Use SUBSTRING() to extract the first 3 characters from StudentName. 
Expected Output: StudentName | Code_Prefix */
select studentname StudentName,substring(studentname,1,3) Code_Prefix from students;
-- ------------------------------------------------------------------------------
/* Question 9 – UPPER() & LOWER() - Standardize name formatting for email IDs and certificates. 
Task: Use UPPER() and LOWER() to show each name in uppercase and lowercase. 
Expected Output: StudentName | UPPER_Name | LOWER_Name */
select studentname StudentName,upper(studentname) UPPER_Name,lower(studentname) LOWER_Name from students;
-- ------------------------------------------------------------------------------
/* Question 10 – DATE FUNCTIONS (NOW, DATEDIFF, DATE_ADD) - The enrollment team needs to calculate report time, duration, and follow-up dates. 
Task: 1. Use NOW() to display the current date and time. 
2. Use DATEDIFF() to find the number of days between '2025-06-01' and 
'2025-05-10'. 
3. Use DATE_ADD() to add 10 days to each student’s EnrollmentDate. 
Expected Output: 
StudentName | EnrollmentDate | FollowUp_Date | Days_Difference | Current_DateTime */
select studentname StudentName,enrollmentdate EnrollmentDate,
now()  Current_DateTime,
datediff(curdate(),enrollmentdate) Days_Difference,
date_add(enrollmentdate,interval 10 day) FollowUp_Date
from enrollments e join students s on e.studentid=s.studentid;