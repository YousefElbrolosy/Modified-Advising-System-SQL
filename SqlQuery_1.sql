--2.1 (1)
CREATE DATABASE Advising_Team_61;
Go
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
		acquired_hours int,-- NULL OR NOT NULL????
		assigned_hours int,-- NULL OR NOT NULL???? NULL Ashan mawgouda f M1
		advisor_id int Foreign Key references Advisor, -- NULL OR NOT NULL????
		CHECK (gpa BETWEEN 0.7 AND 5)
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
		grade varchar(40), --A,B,C or %
		Primary Key(student_id,course_id,instructor_id),
		CHECK (exam_type IN('Normal','First_makeup','Second_makeup'))	
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
		course_id int Foreign Key references Course
		ON UPDATE CASCADE
		ON DELETE CASCADE, 
		instructor_id int Foreign Key references Instructor
	);
	
	Create Table Graduation_Plan (
		plan_id int IDENTITY, 
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
		course_id int,
		CHECK (status IN ('pending','accepted','rejected'))
	);
	Create Table MakeUp_Exam (
		exam_id int PRIMARY KEY IDENTITY, 
		date DATETIME NOT NULL, 
		type varchar(40) NOT NULL, 
		course_id int FOREIGN KEY references Course NOT NULL,
		CHECK(type in('First_makeup','Second_makeup'))
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
		deadline DATETIME NOT NULL, 
		n_installments as CASE WHEN (year(deadline)=year(start_date)) THEN (MONTH(deadline) - MONTH(start_date)) ELSE ((12-MONTH(start_date))+MONTH(deadline)) END, 
		status varchar(40) DEFAULT 'notPaid', 
		fund_percentage decimal(5,2) NOT NULL, 
		student_id int FOREIGN KEY references Student NOT NULL, 
		semester_code varchar(40) references Semester NOT NULL, 
		start_date DATETIME NOT NULL,
		CHECK(status IN ('notPaid','Paid'))
	);
	Create Table Installment (
		payment_id int FOREIGN KEY references Payment, 
		deadline AS DATEADD(month, 1, start_date),
		amount int NOT NULL, -- int?? 
		status varchar(40) DEFAULT 'notPaid', -- not Paid or not NULL 
		start_date DATETIME NOT NULL,
		PRIMARY KEY(payment_id,deadline),
		CHECK(status IN ('notPaid','Paid'))

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
-- do I need student_ID or no?		
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
	SELECT @advisor_id = MAX(advisor_id)
	From Advisor 

-- Are we sure that this will select after the column is added? Yes these statements are excuted sequentially
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
		SELECT s.f_name+' '+s.l_name AS student_name ,A.name as advisor_name--should i get all info wla names bs?
		From Student s INNER JOIN Advisor A --should i get all students with left outer join wla inner 3ashan 2al with their advisor so he is expecting an advisor not a null value?
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
	INSERT INTO Student_Instructor_Course_Take(student_id, course_id, instructor_id, semester_code)
	VALUES(@student_id, @course_id, @instructor_id, @semester_code)
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

--2.3(L)
CREATE PROC Procedures_AdminIssueInstallment
	@payment_ID int
	AS
	DECLARE @n int
	DECLARE @start_date date
	DECLARE @amount int

	SELECT @n=n_installments ,@amount=amount/n_installments, @start_date=start_date
	FROM Payment
	WHERE payment_id=@payment_ID

	WHILE @n>0
		BEGIN
			INSERT INTO Installment(payment_id,amount,start_date)
			VALUES (@payment_ID,@amount,@start_date)
			SET @start_date = DATEADD(month, 1, @start_date)
			SET @n= @n-1
		END
GO
--2.3(M)
CREATE PROC Procedures_AdminDeleteCourse
	@courseID int
	AS
	DELETE FROM Course
	WHERE course_id=@courseID

GO
--2.3(N)
CREATE PROC  Procedure_AdminUpdateStudentStatus
	@StudentID int
	AS
	UPDATE Student
	SET financial_status =
				CASE WHEN (NOT EXISTS (
								SELECT *
								FROM Installment i
								WHERE (
									(i.payment_id IN (SELECT payment_id
									FROM Payment
									WHERE student_id=@StudentID) AND CURRENT_TIMESTAMP > i.deadline AND i.status='notPaid'
								)))) THEN 0 ELSE 1 END
				
	WHERE student_id=@StudentID
GO
--2.3(O)
CREATE VIEW all_Pending_Requests
AS
SELECT r.request_id,r.type,r.comment,r.credit_hours,r.course_id, s.f_name+' '+s.l_name AS Student_name,a.name
		FROM Request r INNER JOIN Student s ON r.student_id=s.student_id 
					   INNER JOIN Advisor a ON r.advisor_id=a.advisor_id
		WHERE r.status='pending'
GO
--2.3(P)
CREATE PROC Procedures_AdminDeleteSlots
	@current_semester varchar(40)
	AS
	UPDATE Slot
	SET course_id=NULL,instructor_id=NULL
	WHERE EXISTS(
	SELECT *
	FROM Course_Semester cs INNER JOIN Course ON cs.course_id=c.course_id
	WHERE c.is_offered=0 AND cs.semester_code=@current_semester AND Slot.course_id=cs.course_id)
GO
--2.3(Q)


--2.3(R)
CREATE PROC Procedures_AdvisorCreateGP
	@Semester_code varchar(40),
	@expected_graduation_date date,
	@sem_credit_hours int,
	@advisor_id int,
	@student_id int
	AS
	DECLARE @expected_grad_semester VARCHAR(40)
	SELECT @expected_grad_semester=semester_code
	FROM Semester
	WHERE @expected_graduation_date BETWEEN start_date AND end_date
	INSERT INTO Graduation_Plan
	Values(@Semester_code,@sem_credit_hours,@expected_grad_semester,@advisor_id,@student_id)
GO
--2.3(S)
CREATE PROC Procedures_AdvisorAddCourseGP
	@student_id int,
	@Semester_code varchar(40),
	@course_name varchar(40)
	AS
	DECLARE @plan_id INT
	DECLARE @course_id INT
	SELECT @plan_id=plan_id
	FROM Graduation_Plan
	WHERE student_id=@student_id AND semester_code=@Semester_code
	SELECT @course_id=course_id
	FROM Course
	WHERE name=@course_name
	INSERT INTO GradPlan_Course
	VALUES(@plan_id,@Semester_code,@course_id)
GO
--2.3(T)
-- How would I update grad sem whilst I don't have such an attribute in gradPlan

--2.3(U)
CREATE PROC Procedures_AdvisorDeleteFromGP
	@studentID int, 
	@semester_code varchar(40),
	@course_ID INT
	AS

	DECLARE @plan_id INT
	SELECT @plan_id=plan_id
	FROM Graduation_Plan
	WHERE student_id=@student_id AND semester_code=@semester_code

	DELETE FROM GradPlan_Course WHERE (plan_id=@plan_id AND semester_code=@semester_code AND course_id=@course_ID)
GO

--2.3(V)
--What is the meaning of "assigned hours"? In order to implement the 34 ch threshhold

--2.3(W)

--2.3(X)
CREATE PROC Procedures_AdvisorViewAssignedStudents
	@AdvisorID int, 
	@major varchar(40)
	AS
	SELECT s.student_id,s.f_name+' '+s.l_name AS Student_Name,s.major,c.name AS course_name
	FROM Student s, Student_Instructor_Course_Take r, Course c
	WHERE s.advisor_id=@AdvisorID AND 
		  s.major=@major AND 
		  s.student_id=r.student_id AND 
		  s.course_id=c.course_id
GO
--2.3(Y)



--2.3(Z)
CREATE PROC Procedures_AdvisorViewPendingRequests
	@Advisor_ID int
	AS 
	SELECT request_id, type,comment,credit_hours,student_id,course_id ---student_id abayeno or no?
	FROM request 
	WHERE advisor_id=@advisor_id AND status='pending'
GO
--Farahh