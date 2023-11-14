﻿

--2.1 (2)
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
		gpa decimal(3,2), -- GPA NULL
		faculty varchar(40) NOT NULL,
		email varchar(40) NOT NULL,
		major varchar(40) NOT NULL,
		password varchar(40) NOT NULL,
		financial_status BIT DEFAULT 1, -- DA SA7??
		semester int NOT NULL,
		acquired_hours int,-- NULL OR NOT NULL???? They are not stated in the milestone
		assigned_hours int,-- NULL OR NOT NULL????  They are not stated in the milestone
		advisor_id int Foreign Key references Advisor, -- NULL OR NOT NULL????
		CHECK (gpa BETWEEN 0.7 AND 5)
		CHECK ()
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
	Create Table Request (-- NOT NULL
		request_id int PRIMARY KEY, 
		type varchar(40) NOT NULL, 
		comment varchar(40), 
		status varchar(40) DEFAULT 'pending', 
		credit_hours int, 
		student_id int FOREIGN KEY references Student NOT NULL, 
		advisor_id int FOREIGN KEY references Advisor NOT NULL, 
		course_id int,
		CHECK(status in ('accepted','pending','rejected'))
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
--2.1 (3)
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
--2.1 (4)
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
CREATE view view_Course_prerequisites
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
	SELECT P.*,s.f_name,s.l_name
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

--2.2 (F)
CREATE VIEW Courses_MakeupExams
	AS
	SELECT c.name, c.semester, m.*
		FROM Course c LEFT OUTER JOIN MakeUp_Exam m ON c.course_id = m.course_id
GO

--2.2 (G)
CREATE VIEW Students_Courses_transcript
	AS
	SELECT s.student_id,s.f_name + s.l_name AS 'student name',c.course_id,c.name AS 'course name',r.exam_type,r.grade,r.semester_code,i.name AS 'instructor name'
		FROM Student s, Course c, Instructor i, Student_Instructor_Course_Take r
		WHERE s.student_id=r.student_id AND
			  c.course_id=r.course_id AND
			  i.instructor_id=r.instructor_id
GO

--BROLOSY PART HERE
--2.2 (H)

CREATE VIEW Semster_offered_Courses
	AS
	SELECT c.course_id, c.name AS 'course_name', s.semester_code
		FROM Semester s 
		LEFT JOIN Course_Semester cs ON s.semester_code = cs.semester_code
		LEFT JOIN Course c ON cs.course_id = c.course_id
GO

--2.2 (I)
-- advisor_id is included in g.*	
CREATE VIEW Advisors_Graduation_Plan
	AS
	SELECT g.*, a.name AS 'advisor_name'
		FROM Graduation_Plan g , Advisor a
		WHERE g.advisor_id = a.advisor_id
GO
---------------------------------------------------------------------------------------
--2.3 (A) MAKE SURE OF NULL VALUES AND FINANCIAL STATUS
CREATE PROC Procedures_StudentRegistration
	@first_name varchar(40), 
	@last_name varchar(40), 
	@password varchar(40), 
	@faculty varchar(40), 
	@email varchar(40), 
	@major varchar(40), 
	@Semester int,
	@StudentID int OUTPUT
	As
	Insert Into Student(f_name,l_name,faculty,email,major,password,semester)
		values(@first_name,@last_name,@faculty,@email,@major,@password,@Semester)
	Select @StudentID = MAX(student_id)
		FROM Student
GO
--2.3(B)
	--Farah and Brolosy
	-- Brolosy
CREATE PROCEDURE Procedures_AdvisorRegistration
	@advisor_name varchar(40),
	@password varchar(40),
	@email varchar(40),
	@office varchar(40),
	@advisor_id int	OUTPUT
	AS 
	INSERT INTO Advisor(name, email, office, password)
	VALUES(@advisor_name, @email, @office, @password)
	SELECT @advisor_id = MAX(advisor.advisor_id)
	From Advisor advisor

-- Are we sure that this will select after the column is added?
-- Or should we select last
GO
--2.3(C) TOO SIMPLE??
CREATE PROC Procedures_AdminListStudents
	As
	Select *
		From Student
GO
--2.3(D)
	--Farah and Brolosy
CREATE PROCEDURE Procedures_AdminListAdvisors
	AS 
	SELECT * 
	FROM Advisor
	-- does he want names? or all data
GO


--2.3(E)
	Create PROC AdminListStudentsWithAdvisors
	AS
		SELECT s.f_name,s.l_name,A.name --should i get all info wla names bs?
		From Student s 	LEFT Join Advisor A --should i get all students with left outer join wla inner 3ashan 2al with their advisor so he is expecting an advisor not a null value?
		 ON a.advisor_id = A.advisor_id
	GO

-- 2.3(E)
-- Brolosy
CREATE PROCEDURE AdminListStudentsWithAdvisors
	AS
	SELECT * 
	-- I THINK LEFT OUTER JOIN HERE IS TRIVIAL BECAUSE THERE WONT
	--BE ANY REGISTERED STUDENTS WITH NO ADVISORS
	FROM Student s LEFT OUTER JOIN Advisor a
	ON s.advisor_id = a.advisor_id

	GO

--2.3(F)
Create Procedure AdminAddingSemester
	@start_date date,
	@end_date date,
	@semester_code VARCHAR(40)
	AS
		Insert Into Semester
			VALUES(@semester_code,@start_date,@end_date)
GO
--2.3(G)
	--Farah and Brolosy
CREATE PROCEDURE Procedures_AdminAddingCourse
	@major varchar(40),
	@semester int,
	@credit_hours int,
	@course_name varchar(40),
	@offered bit
	AS
	INSERT INTO Course(name, major, is_offered, credit_hours, semester)
	VALUES(@course_name, @major, @offered, @credit_hours, @semester)

GO

--2.3(H)
	CREATE PROC Procedures_AdminLinkInstructor
		@InstructorId int, 
		@courseId int, 
		@slotID int
		As	
			UPDATE Slot
				Set instructor_id = @InstructorId,course_id = @courseId
				Where slot_id = @slotID
	GO
--2.3(I)
	--Farah and Brolosy
CREATE PROCEDURE Procedures_AdminLinkStudent
	@instructor_id int,
	@student_id int,
	@course_id int,
	@semester_code varchar(40)
	AS
	-- I think I first need to make sure that the inputs are in fact in the other tables
	-- Also need to check if they aren't already existing in the relation take table
	-- in just/nanna implementation of H they are considering that the record of student is already there 
	-- with null values for the rest?
	-- why?
	/*
	**INSERT INTO Student_Instructor_Course_Take(student_id, course_id, instructor_id, semester_code)
	**VALUES(@student_id, @course_id, @instructor_id, @semester_code)
	*/
/*
	**SELECT i.instructor_id, s.student_id, c.course_id
	**FROM Instructor i, Student s, Course c
	**WHERE i.instructor_id = @instructor_id AND 
	**	  s.student_id = @student_id AND
	**	  c.course_id = @course_id 

*/
	-- WHY NOT JUST INSERT?
	UPDATE Student_Instructor_Course_Take
		SET course_id = @course_id, semester_code = @semester_code , student_id = @student_id
		WHERE instructor_id = @instructor_id

	-- DOESNT THAT MEAN THAT THERE THERE ARE MULTIPLE ROWS OF INSTRUCTORS WITH THE SAME ID
	-- SO IF WE CHANGE ONE ALL ELSE CHANGE?
		
	-- and what if there already existing students in that row

GO
--2.3(J)
Create PROCEDURE Procedures_AdminLinkStudentToAdvisor
	@studentID int,
	@advisorId int
	AS
	Update Student 
		Set advisor_id = @advisorID
		WHERE student_id = @studentID
GO
--2.3(K)
Create PROC Procedures_AdminAddExam
	@Type varchar (40),
	@date datetime, 
	@courseID int
	As
		INSERT INTO MakeUp_Exam (date,type,course_id)
			VALUES(@date,@Type,@courseID)

GO
--2.3(J) Brolosy
CREATE PROCEDURE Procedures_AdminLinkStudentToAdvisor
	@student_id int,
	@advisor_id int
	AS
	UPDATE Student
	SET advisor_id = @advisor_id 
	WHERE student_id = @student_id
	-- I think here update is okay because student_id is unique
GO

--2.3(K) Brolosy
CREATE PROCEDURE Procedures_AdminAddExam
	@type varchar(40),
	@date datetime,
	@course_id int
	AS 
	INSERT INTO MakeUp_Exam(date, type, course_id)
	VALUES(@date,@type,@course_id)
GO