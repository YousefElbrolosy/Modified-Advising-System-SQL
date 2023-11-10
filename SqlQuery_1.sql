CREATE DATABASE Advising_Team_61;

Go
Create Proc CreateAllTables 
	As
	Create Table Advisor(
		advisor_id int PRIMARY KEY IDENTITY, 
		name varchar(40) NOT NULL, 
		email varchar(40) NOT NULL, 
		office varchar(40) NOT NULL, 
		password varchar(40) NOT NULL
	);
	Create Table Student(
		student_id int Primary key IDENTITY,
		f_name varchar(40) NOT NULL,
		l_name varchar(40) NOT NULL,
		gpa decimal(3,2) NOT NULL,
		faculty varchar(40) NOT NULL,
		email varchar(40) NOT NULL,
		major varchar(40) NOT NULL,
		password varchar(40) NOT NULL,
		financial_status BIT DEFAULT 1, -- DA SA7??
		semester int NOT NULL,
		acquired_hours int NOT NULL,
		assigned_hours int NOT NULL,
		advisor_id int Foreign Key references Advisor NOT NULL -- or????
	);
	Create Table Student_Phone (
		student_id int Foreign Key references Student, 
		phone_number varchar(40),
		Primary Key(student_id,phone_number)
	);

	Create Table Course (
		course_id int Primary Key Identity, --INT?? and Identity 
		name varchar(40) NOT NULL, 
		major varchar(40) NOT NULL, 
		is_offered BIT NOT NULL, 
		credit_hours int NOT NULL, 
		semester int NOT NULL
	); 
	Create Table PreqCourse_course (
		prerequisite_course_id int FOREIGN KEY references Course, 
		course_id int FOREIGN KEY references Course,
		Primary Key (prerequisite_course_id, course_id),
	); 
	Create Table Instructor (
		instructor_id int PRIMARY KEY IDENTITY, 
		name varchar(40) NOT NULL, 
		email varchar(40) NOT NULL, 
		faculty varchar(40) NOT NULL, 
		office varchar(40) NOT NULL
	);
	Create Table Instructor_Course (
		course_id int FOREIGN KEY references Course, 
		instructor_id int FOREIGN KEY references Instructor,
		Primary Key (course_id,instructor_id)
	); 
	Create Table Student_Instructor_Course_Take (
		student_id int Foreign Key references Student, 
		course_id int Foreign Key references Course, 
		instructor_id int Foreign Key references Instructor, 
		semester_code varchar(40) NOT NULL, 
		exam_type varchar(40) DEFAULT 'Normal', 
		grade varchar(40) --A,B,C or %
		Primary Key(student_id,course_id,instructor_id)
	);
	Create Table Semester (
		semester_code varchar(40) PRIMARY KEY, 
		start_date DATE NOT NULL, 
		end_date DATE NOT NULL
	);
	Create Table Course_Semester (
		course_id int FOREIGN KEY references Course, 
		semester_code varchar(40) Foreign Key references Semester,
		Primary Key(course_id,semester_code)
	);
	Create Table Slot (
		slot_id int Primary Key, 
		day varchar(40) NOT NULL, 
		time varchar(40) NOT NULL, 
		location varchar(40) NOT NULL, 
		course_id int Foreign Key references Course, 
		instructor_id int Foreign Key references Instructor
	);
	
	Create Table Graduation_Plan (
		plan_id int, 
		semester_code varchar(40), 
		semester_credit_hours int NOT NULL,
		expected_grad_semester int NOT NULL, --sem or sem code
		advisor_id int FOREIGN KEY references Advisor NOT NULL, 
		student_id int FOREIGN KEY references Student NOT NULL,
		PRIMARY KEY (plan_id , semester_code)
	);
	Create Table GradPlan_Course (
		plan_id int, 
		semester_code varchar(40), 
		course_id int FOREIGN KEY references Course,
		PRIMARY KEY(plan_id, semester_code, course_id),
		FOREIGN KEY(plan_id,semester_code) references Graduation_Plan
	);
	Create Table Request (    -- NOT NULL
		request_id int PRIMARY KEY, 
		type varchar(40) NOT NULL, 
		comment varchar(40), 
		status varchar(40) DEFAULT 'pending', 
		credit_hours int, 
		student_id int FOREIGN KEY references Student NOT NULL, 
		advisor_id int FOREIGN KEY references Advisor NOT NULL, 
		course_id int
	);
	Create Table MakeUp_Exam (
		exam_id int PRIMARY KEY IDENTITY, 
		date DATETIME NOT NULL, 
		type varchar(40) NOT NULL, 
		course_id int FOREIGN KEY references Course NOT NULL
	);
	Create Table Exam_Student (
		exam_id int FOREIGN KEY references MakeUp_Exam, 
		student_id int FOREIGN KEY references Student, 
		course_id int NOT NULL, -- not foreign key leh?? notnull leh??
		PRIMARY KEY(exam_id,student_id)
	);
	Create Table Payment(
		payment_id int PRIMARY KEY, 
		amount int NOT NULL, -- decimal or int
		deadline DATE NOT NULL, 
		n_installments int NOT NULL, --as MONTH(deadline) - MONTH(start_date) 
		status varchar(40) DEFAULT 'notPaid', 
		fund_percentage decimal(5,2) NOT NULL, 
		student_id int FOREIGN KEY references Student NOT NULL, 
		semester_code varchar(40) references Semester NOT NULL, 
		start_date DATE NOT NULL
	);
	Create Table Installment (
		payment_id int FOREIGN KEY references Payment, 
		deadline int, --as start_date + Month(0000/01/00, 
		amount int NOT NULL, -- int?? 
		status varchar(40) DEFAULT 'notPaid', -- not Paid or not NULL 
		start_date DATE NOT NULL,
		PRIMARY KEY(payment_id,deadline)
	);
GO
------------------------------------------------------------------------------------
Create PROC DropAllTables
	As
	Drop table Student_instructor_course_take
	Drop table Slot
	Drop Table PreqCourse_course
	Drop Table Instructor_Course
	Drop Table GradPlan_Course
	Drop Table Graduation_Plan
	Drop Table Course_semester
	Drop Table Request
	Drop Table Exam_Student
	Drop Table MakeUp_Exam
	Drop Table Installment
	Drop TABLE Payment
	Drop TABLE Instructor
	Drop TABLE Course
	Drop Table Semester
	Drop TABLE Student_Phone
	Drop table Student
	Drop table Advisor
GO
---------------------------------------------------------------------------------------
CREATE PROCEDURE clearAllTables
AS
    TRUNCATE table Student_instructor_course_take
    TRUNCATE table Slot
    TRUNCATE Table PreqCourse_course
    TRUNCATE Table Instructor_Course
    TRUNCATE Table GradPlan_Course
    TRUNCATE Table Graduation_Plan
    TRUNCATE Table Course_semester
    TRUNCATE Table Request
    TRUNCATE Table Exam_Student
    TRUNCATE Table MakeUp_Exam
    TRUNCATE Table Installment
    TRUNCATE TABLE Payment
    TRUNCATE TABLE Instructor
    TRUNCATE TABLE Course
    TRUNCATE Table Semester
    TRUNCATE TABLE Student_Phone
    TRUNCATE table Student
    TRUNCATE table Advisor
GO
---------------------------------------------------------------------------------------
--2.2 (A)
CREATE View view_Students
	AS
	SELECT *
		FROM Student
		WHERE financial_status=1;

GO
--2.2 (B)
CREATE view  view_Course_prerequisites
	AS
	SELECT c.*,pre.prerequisite_course_id
		FROM Course c
			LEFT  JOIN PreqCourse_course pre ON c.course_id = pre.course_id 

GO
--2.2 (C)
CREATE view Instructors_AssignedCourses
	AS
	SELECT Ins.*,Cou.course_id,Cou.name
		FROM Instructor Ins
			LEFT JOIN Instructor_Course InsCou ON Ins.instructor_id = InsCou.instructor_id
			INNER JOIN Course Cou ON InsCou.course_id = Cou.course_id
GO
--2.2 (D)
CREATE view Student_Payment
	AS 
	SELECT P.*,s.name
		FROM Payment P 
			INNER JOIN Student s ON P.student_id = s.student_id
			--INNER JOIN Installment I ON P.payment_id = I.payment_id
GO

--2.2 (E)
CREATE view Courses_Slots_Instructor
	AS
	SELECT c.course_id as CourseID , c.name as 'Course.name' , s.slot_id as 'Slot ID' , s.day as 'Slot Day' , 
            s.time as 'Slot Time', s.location as 'Slot Location' , I.name as 'Slot’s Instructor name'
		FROM Course c 
			LEFT JOIN Slot s ON c.course_id = s.course_id
			INNER JOIN Instructor I ON I.instructor_id = s.instructor_id

GO

------------
Helloo guyss