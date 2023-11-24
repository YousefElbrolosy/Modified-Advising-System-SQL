--TODO:
--CALCULATE deadline in the installment proc as i removed it from createAllTables
--------------------------------------------------------------------------------------
--RECHECK (hagat momken nes2l 3aleha keda keda hantest kolo men el awl): 
-- (*-->NOT THAT IMPORTANT // **-->MABEN EL ETNEN // ***-->VERY VERY IMPORTANT)
--ALL 2.2*
--2.3(A)**
--2.3(C)*
--2.3(D)*
--2.3(E)*
--2.3(L)**
--2.3(N)***
--2.3(O)*
--2.3(P)***
--2.3(V)* <--we2ft hena
---------------------------------------------------------------------------------------
--2.1 (1) NO PROBLEMS HERE
CREATE DATABASE Advising_Team_61
Go
--2.1 (2)
--TODO:
--1)THINK OF MORE CONSTRAINTS
--2)THINK OF UPDATE/DELETE OPTIONS IN FOREIGN KEY
Create Proc CreateAllTables 
	As
	--INSERT VALUES IN (2.3-B)
	Create Table Advisor( --NO PROBLEMS HERE BUT WE CAN THINK OF MORE CONSTRAINTS
		advisor_id int PRIMARY KEY IDENTITY NOT NULL,--IDENTITY BASED ON (2.3-B) 
		name varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-B) 
		email varchar(40) NOT NULL, --NOT NULL BASED ON (2.3-B) // We can add further Constraints 'LIKE (%@%.com)' 
		office varchar(40) NOT NULL, --NOT NULL BASED ON (2.3-B) 
		password varchar(40) NOT NULL--NOT NULL BASED ON (2.3-B)
	);
	--INSERT VALUES IN (2.3-A)
	Create Table Student(--FINANCIAL STATUS default value or should we make it a derived attribute? // WE CAN ALSO THINK OF MORE CONSTRAINTS
		student_id int Primary key IDENTITY,--IDENTITY BASED ON (2.3-A)
		f_name varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-A)
		l_name varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-A)
		gpa decimal(3,2), -- GPA NULL BASED ON (2.3-A) // GPA SHOULD WE Assign the decimal size
		faculty varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-A)
		email varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-A) // We can add further Constraints 'LIKE (%@%.com)' 
		major varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-A)
		password varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-A)
		financial_status BIT DEFAULT 1,--NULL BASED ON (2.3-A) (or default value?) // SKIP THE DERIVATION IN THE SCHEMA?
		semester int NOT NULL,--NOT NULL BASED ON (2.3-A)
		acquired_hours int,--NULL BASED ON (2.3-A)
		assigned_hours int,--NULL BASED ON (2.3-A) and Ashan mawgouda f M1
		advisor_id int CONSTRAINT fk4 Foreign Key references Advisor, --NULL BASED ON (2.3-A)
		CHECK (gpa BETWEEN 0.7 AND 5)--GPA CONSTRAINT BASED ON LOGIC
	);
	--INSERT VALUES IN (2.3-BB)
	Create Table Student_Phone (--NO PROBLEMS HERE
		student_id int CONSTRAINT fk5 Foreign Key references Student, 
		phone_number varchar(40),
		Primary Key(student_id,phone_number)
	);
	--INSERT VALUES IN (2.3-G)
	Create Table Course (--NO PROBLEMS HERE BUT WE CAN THINK OF MORE CONSTRAINTS
		course_id int Primary Key Identity,--IDENTITY BASED ON (2.3-G)
		name varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-G)
		major varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-G) // CONSTRAINTS ON MAJOR ?? CHECK (major in ('ENG',....))
		is_offered BIT NOT NULL,--NOT NULL BASED ON (2.3-G) 
		credit_hours int NOT NULL,--NOT NULL BASED ON (2.3-G) // CONSTRAINT ON CREDIT HOURS?? CHECK (credit_hours BETWEEN 1 AND 8)
		semester int NOT NULL--NOT NULL BASED ON (2.3-G)
	);
	--INSERT VALUES IN (NO IDEA)
	Create Table PreqCourse_course (-- NO PROBLEMS HERE
		prerequisite_course_id int CONSTRAINT fk6 FOREIGN KEY references Course, 
		course_id int CONSTRAINT fk7 FOREIGN KEY references Course,
		Primary Key (prerequisite_course_id, course_id),
	);
	--INSERT VALUES IN (NO IDEA)
	Create Table Instructor ( -- NOT NULL BASED ON SIMILARITY BETWEEN INSTRUCTOR ATTRIBUTES AND ADVISOR ATTRIBUTES
		instructor_id int PRIMARY KEY IDENTITY, 
		name varchar(40) NOT NULL, 
		email varchar(40) NOT NULL, 
		faculty varchar(40) NOT NULL, 
		office varchar(40) NOT NULL
	);
	--INSERT VALUES IN (NO IDEA)
	Create Table Instructor_Course (--NO PROBLEMS HERE
		course_id int CONSTRAINT fk8 FOREIGN KEY references Course, 
		instructor_id int CONSTRAINT fk9 FOREIGN KEY references Instructor,
		Primary Key (course_id,instructor_id)
	);
	--INSERT VALUES IN (2.3-I)
	Create Table Student_Instructor_Course_Take (--NO PROBLEMS HERE
		student_id int CONSTRAINT fk10 Foreign Key references Student, 
		course_id int CONSTRAINT fk11 Foreign Key references Course, 
		instructor_id int CONSTRAINT fk12 Foreign Key references Instructor, 
		semester_code varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-I)
		exam_type varchar(40) DEFAULT 'Normal',--DEFAULT VALUE BASED ON M2 DESC 
		grade varchar(40),--NULL BASED ON (2.3-I) 
		Primary Key(student_id,course_id,semester_code),
		CHECK (exam_type IN('Normal','First_makeup','Second_makeup'))--CONSTRAINT BASED ON M2 DESC	
	);
	--INSERT VALUES IN (2.3-F)
	Create Table Semester (--NO PROBLEMS HERE
		semester_code varchar(40) PRIMARY KEY, 
		start_date DATE NOT NULL,--NOT NULL BASED ON (2.3-F)
		end_date DATE NOT NULL--NOT NULL BASED ON (2.3-F)
	);
	--INSERT VALUES IN (NO IDEA)
	Create Table Course_Semester (--NO PROBLEMS HERE
		course_id int CONSTRAINT fk13 FOREIGN KEY references Course, 
		semester_code varchar(40) CONSTRAINT fk14 Foreign Key references Semester,
		Primary Key(course_id,semester_code)
	);
	--INSERT VALUES IN (NO IDEA) // INSTRUCTOR/COURSE In (2.3-H)
	Create Table Slot (--NOT NULLS BASED ON THE ASSUMPTION THAT EVERY SLOT THAT EXISTS IS ALREADY STORED AND YOU JUST UPDATE THE INSTRUCTOR/COURSE THAT IS ASSIGNED TO THIS SLOT // WE CAN THINK OF MORE CONSTRAINTS
		slot_id int Primary Key, 
		day varchar(40) NOT NULL,--IN(Sunday,Monday,...) 
		time varchar(40) NOT NULL,--IN(1st,2nd,3rd,...) 
		location varchar(40) NOT NULL, 
		course_id int CONSTRAINT fk15 Foreign Key references Course,-- NULL BASED ON (2.3-H) 
		instructor_id int CONSTRAINT fk16 Foreign Key references Instructor -- NULL BASED ON (2.3-H)
	);
	--INSERT VALUES IN (2.3-R)
	Create Table Graduation_Plan (--NO PROBLEMS HERE
		plan_id int IDENTITY,--IDENTITY BASED ON (2.3-R) 
		semester_code varchar(40), 
		semester_credit_hours int NOT NULL,--NOT NULL BASED ON (2.3-R) 
		expected_grad_date date NOT NULL,--NOT NULL BASED ON (2.3-R)
		advisor_id int CONSTRAINT fk17 FOREIGN KEY references Advisor NOT NULL,--NOT NULL BASED ON (2.3-R)
		student_id int CONSTRAINT fk18 FOREIGN KEY references Student NOT NULL,--NOT NULL BASED ON (2.3-R)
		PRIMARY KEY (plan_id , semester_code)
	);
	--INSERT VALUES IN (2.3-S) // DELETE VALUES (2.3-U)
	Create Table GradPlan_Course (--NO PROBLEMS HERE
		plan_id int, 
		semester_code varchar(40), 
		course_id int CONSTRAINT fk25 FOREIGN KEY references Course,
		PRIMARY KEY(plan_id, semester_code, course_id),
		CONSTRAINT fk1 FOREIGN KEY(plan_id,semester_code) references Graduation_Plan
	);
	--INSERT VALUES IN (2.3-DD // 2.3-EE)
	Create Table Request (--ADVISOR --> NULL/NOT NULL
		request_id int PRIMARY KEY IDENTITY,--IDENTITY BASED ON (2.3-DD // 2.3-EE)
		type varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-DD // 2.3-EE)
		comment varchar(40) NOT NULL,-- NOT NULL BASED ON  (2.3-DD // 2.3-EE)
		status varchar(40) DEFAULT 'pending',--DEFAULT VALUE BASED ON M2 DESC 
		credit_hours int,--NULL BASED ON (2.3-DD // 2.3-EE)
		student_id int CONSTRAINT fk19 FOREIGN KEY references Student NOT NULL,--NOT NULL BASED ON  (2.3-DD // 2.3-EE) 
		advisor_id int CONSTRAINT fk20 FOREIGN KEY references Advisor NOT NULL,--NULL UNTIL ADVISOR RESPONDS? OR PUT THE CURRENT STUDENT'S ADVISOR 
		course_id int,--NULL BASED ON (2.3-DD // 2.3-EE)
		CHECK (status IN ('pending','accepted','rejected'))--BASED ON M2 DESC 
	);
	--INSERT VALUES IN (2.3-K)
	Create Table MakeUp_Exam (--date datatype
		exam_id int PRIMARY KEY IDENTITY,--IDENTITY BASED ON (2.3-K)
		date DATETIME NOT NULL,--DATETIME IN 2.3-K // DATE IN UPDATED SCHEMA // NOT NULL BASED ON (2.3-K) 
		type varchar(40) NOT NULL,--NOT NULL BASED ON (2.3-K) 
		course_id int CONSTRAINT fk21 FOREIGN KEY references Course NOT NULL,--NOT NULL BASED ON (2.3-K) 
		CHECK(type in('First_makeup','Second_makeup'))--BASED ON M2 DESC
	);
	--INSERT VALUES IN (2.3-II // 2.3-KK)
	Create Table Exam_Student (--NO PROBLEMS HERE
		exam_id int CONSTRAINT fk2 FOREIGN KEY references MakeUp_Exam, 
		student_id int CONSTRAINT fk22 FOREIGN KEY references Student, 
		course_id int NOT NULL,--NOT NULL BASED ON (2.3-II // 2.3-KK) 
		PRIMARY KEY(exam_id,student_id)
	);
	--INSERT VALUES IN (NO IDEA)
	Create Table Payment(--NULL/NOT NULL BASED ON NOTHING // DERIVED ATTRIBUTE IS NOT DERIVED IN THE SCHEMA
		payment_id int PRIMARY KEY, 
		amount int NOT NULL,
		deadline DATETIME NOT NULL, 
		n_installments as DATEDIFF(month,start_date,deadline), 
		status varchar(40) DEFAULT 'notPaid',--DEFAULT VALUE BASED ON M2 DESC 
		fund_percentage decimal(5,2) NOT NULL,
		start_date DATETIME NOT NULL,
		student_id int CONSTRAINT fk23 FOREIGN KEY references Student NOT NULL, 
		semester_code varchar(40) CONSTRAINT fk24 FOREIGN KEY references Semester NOT NULL, 
		CHECK(status IN ('notPaid','Paid'))--BASED ON M2 DESC
	);
	--INSERT VALUES IN (2.3-L)
	Create Table Installment (
		payment_id int CONSTRAINT fk3 FOREIGN KEY references Payment, 
		deadline datetime,--AS DATEADD(month, 1, start_date),--JUST COMMENT: heya sa7 bas it is not explicitly stated fel schema fa can we assume enaha derived?
		amount int NOT NULL,
		status varchar(40) DEFAULT 'notPaid', --DEFAULT VALUE BASED ON M2 DESC 
		start_date DATETIME NOT NULL,
		PRIMARY KEY(payment_id,deadline),
		CHECK(status IN ('notPaid','Paid'))--BASED ON M2 DESC

	);
GO
------------------------------------------------------------------------------------
--2.1 (3) NO PROBLEMS HERE
Create PROC DropAllTables
	As
	DROP TABLE Student_instructor_course_take
	DROP TABLE Slot
	DROP TABLE PreqCourse_course
	DROP TABLE Instructor_Course
	DROP TABLE GradPlan_Course
	DROP TABLE Graduation_Plan
	DROP TABLE Course_semester
	DROP TABLE Request
	DROP TABLE Exam_Student
	DROP TABLE MakeUp_Exam
	DROP TABLE Installment
	DROP TABLE Payment
	DROP TABLE Instructor
	DROP TABLE Course
	DROP TABLE Semester
	DROP TABLE Student_Phone
	DROP TABLE Student
	DROP TABLE Advisor
GO
---------------------------------------------------------------------------------------
--2.1 (4) NO PROBLEMS HERE
CREATE PROCEDURE clearAllTables
AS	

	ALTER TABLE GradPlan_Course
	Drop fk1,fk25

	ALTER TABLE Exam_Student
	DROP fk2,fk22

	ALTER TABLE Installment
	DROP fk3

	ALTER TABLE Student
	DROP fk4

	ALTER TABLE Student_Phone
	DROP fk5

	ALTER TABLE PreqCourse_course
	DROP fk6,fk7

	ALTER TABLE Instructor_Course
	DROP fk8,fk9

	ALTER TABLE Student_Instructor_Course_Take
	DROP fk10,fk11,fk12

	ALTER TABLE Course_Semester
	DROP fk13,fk14

	ALTER TABLE Slot
	DROP fk15,fk16

	ALTER TABLE Graduation_Plan
	DROP fk17,fk18

	ALTER TABLE Request
	DROP fk19,fk20
	
	ALTER TABLE MakeUp_Exam
	DROP fk21

	ALTER TABLE Payment
	DROP fk23,fk24

    TRUNCATE TABLE Student_instructor_course_take
    TRUNCATE TABLE Slot
    TRUNCATE TABLE PreqCourse_course
    TRUNCATE TABLE Instructor_Course
    TRUNCATE TABLE GradPlan_Course
    TRUNCATE TABLE Graduation_Plan
    TRUNCATE TABLE Course_semester
    TRUNCATE TABLE Request
    TRUNCATE TABLE Exam_Student
    TRUNCATE TABLE MakeUp_Exam
    TRUNCATE TABLE Installment
    TRUNCATE TABLE Payment
    TRUNCATE TABLE Instructor
    TRUNCATE TABLE Course
    TRUNCATE TABLE Semester
    TRUNCATE TABLE Student_Phone
    TRUNCATE TABLE Student
    TRUNCATE TABLE Advisor

	ALTER TABLE GradPlan_Course
	ADD CONSTRAINT fk1 FOREIGN KEY(plan_id,semester_code) references Graduation_Plan,
		CONSTRAINT fk25 FOREIGN KEY(course_id) references Course

	ALTER TABLE Exam_Student
	ADD CONSTRAINT fk2  FOREIGN KEY(exam_id) references MakeUp_Exam,
		CONSTRAINT fk22 FOREIGN KEY(student_id) references Student 

	ALTER TABLE Installment
	ADD CONSTRAINT fk3 FOREIGN KEY(payment_id) references Payment

	ALTER TABLE Student
	ADD CONSTRAINT fk4 FOREIGN KEY(advisor_id) references Advisor

	ALTER TABLE Student_Phone
	ADD CONSTRAINT fk5 FOREIGN KEY(student_id) references Student

	ALTER TABLE PreqCourse_course
	ADD CONSTRAINT fk6 FOREIGN KEY(prerequisite_course_id) references Course,
		CONSTRAINT fk7 FOREIGN KEY(course_id) references Course

	ALTER TABLE Instructor_Course
	ADD CONSTRAINT fk8 FOREIGN KEY(course_id) references Course,
		CONSTRAINT fk9 FOREIGN KEY(instructor_id) references Instructor

	ALTER TABLE Student_Instructor_Course_Take
	ADD CONSTRAINT fk10 FOREIGN KEY(student_id) references Student,
		CONSTRAINT fk11 FOREIGN KEY(course_id) references Course,
		CONSTRAINT fk12 FOREIGN KEY(instructor_id) references Instructor

	ALTER TABLE Course_Semester
	ADD CONSTRAINT fk13 FOREIGN KEY(course_id) references Course,
		CONSTRAINT fk14 FOREIGN KEY(semester_code) references Semester
	
	ALTER TABLE Slot
	ADD CONSTRAINT fk15 FOREIGN KEY(course_id) references Course, 
		CONSTRAINT fk16 FOREIGN KEY(instructor_id) references Instructor 

	ALTER TABLE Graduation_Plan
	ADD CONSTRAINT fk17 FOREIGN KEY(advisor_id) references Advisor,
		CONSTRAINT fk18 FOREIGN KEY(student_id) references Student

	ALTER TABLE Request
	ADD	CONSTRAINT fk19 FOREIGN KEY(student_id) references Student,
		CONSTRAINT fk20 FOREIGN KEY(advisor_id) references Advisor

	ALTER TABLE MakeUp_Exam
	ADD CONSTRAINT fk21 FOREIGN KEY(course_id) references Course

	ALTER TABLE Payment
	ADD	CONSTRAINT fk23 FOREIGN KEY(student_id) references Student,
		CONSTRAINT fk24 FOREIGN KEY(semester_code) references Semester
		
GO
---------------------------------------------------------------------------------------
--ALL VIEWS COLUMNS NAME
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
			LEFT OUTER JOIN PreqCourse_course pre ON c.course_id = pre.course_id 

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
			LEFT OUTER JOIN Slot s ON c.course_id = s.course_id
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
		LEFT OUTER JOIN Course_Semester cs ON s.semester_code = cs.semester_code
		LEFT OUTER JOIN Course c ON cs.course_id = c.course_id
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
--2.3 (A) SHOULD WE CALL THE UPDATE FINANCIAL STATUS HERE?? / SHOULD WE CALCULATE AQH,ASH,GPA
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
		INSERT INTO Student(f_name,l_name,faculty,email,major,password,semester)
		VALUES(@first_name,@last_name,@faculty,@email,@major,@password,@Semester)
		
		SELECT @StudentID = MAX(student_id)
		FROM Student
GO
--2.3(B) NO PROBLEMS HERE
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
		FROM Advisor 

GO
--2.3(C) COLUMNS??
CREATE PROC Procedures_AdminListStudents
	As
		SELECT *
		FROM Student
GO

--2.3(D) COLUMNS
CREATE PROCEDURE Procedures_AdminListAdvisors
	AS 
		SELECT * 
		FROM Advisor
	-- does he want names? or all data
GO

-- 2.3(E) LIST ALL STUDENTS or Students w Advisors (in other words inner or outer)/COLUMNS
CREATE PROCEDURE AdminListStudentsWithAdvisors
	AS
		SELECT s.f_name+' '+s.l_name AS student_name ,A.name as advisor_name--should i get all info wla names bs?
		-- I THINK LEFT OUTER JOIN HERE IS TRIVIAL BECAUSE THERE WONT
		FROM Student s LEFT OUTER JOIN Advisor a ON s.advisor_id = a.advisor_id

GO

--2.3(F) NO PROBLEM HERE
Create Procedure AdminAddingSemester
	@start_date date,
	@end_date date,
	@semester_code VARCHAR(40)
	AS
		Insert Into Semester
		VALUES(@semester_code,@start_date,@end_date)
GO

--2.3(G) NO PROBLEM HERE
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

--2.3(H) NO PROBLEM HERE
CREATE PROC Procedures_AdminLinkInstructor
	@InstructorId int, 
	@courseId int, 
	@slotID int
	As	
		UPDATE Slot
		SET instructor_id = @InstructorId,
			course_id = @courseId
		WHERE slot_id = @slotID
GO

--2.3(I) NO PROBLEM HERE
CREATE PROCEDURE Procedures_AdminLinkStudent
	@instructor_id int,
	@student_id int,
	@course_id int,
	@semester_code varchar(40)
	AS
		INSERT INTO Student_Instructor_Course_Take(student_id, course_id, instructor_id, semester_code)
		VALUES(@student_id, @course_id, @instructor_id, @semester_code)
GO

--2.3(J) NO PROBLEM HERE
Create PROCEDURE Procedures_AdminLinkStudentToAdvisor
	@studentID int,
	@advisorId int
	AS
		Update Student 
		Set advisor_id = @advisorID
		WHERE student_id = @studentID
GO

--2.3(K) NO PROBLEM HERE
CREATE PROCEDURE Procedures_AdminAddExam
	@type varchar(40),
	@date datetime,
	@course_id int
	AS 
		INSERT INTO MakeUp_Exam(date, type, course_id)
		VALUES(@date,@type,@course_id)
GO

--2.3(L) NO PROBLEM HERE/ recheck the deadline insertion
CREATE PROC Procedures_AdminIssueInstallment
	@payment_ID int
	AS
		DECLARE @n int,
				@start_date date,
			    @amount int

		SELECT @n=n_installments ,@amount=amount/n_installments, @start_date=start_date
		FROM Payment
		WHERE payment_id=@payment_ID

		WHILE @n>0
			BEGIN
				INSERT INTO Installment(payment_id,amount,start_date,deadline)
				VALUES (@payment_ID,@amount,@start_date,DATEADD(month, 1, @start_date))

				SET @start_date = DATEADD(month, 1, @start_date)
				SET @n = @n-1
			END
GO
--2.3(M) NO PROBLEM HERE
CREATE PROC Procedures_AdminDeleteCourse
	@courseID int
	AS
		DELETE FROM Course
		WHERE course_id=@courseID

		UPDATE Slot
		SET course_id=NULL, 
			instructor_id=NULL
		WHERE course_id=@courseID
GO

--2.3(N) HEYA MESH EL MAFROOD TOBAA 1 LAW EL TABLE NOT EXISTS?? W 0 OTHERWISE
CREATE PROC  Procedure_AdminUpdateStudentStatus
	@StudentID int
	AS
	UPDATE Student
	SET financial_status =
	CASE WHEN (
		NOT EXISTS (
					SELECT *
					FROM Installment i
					WHERE i.payment_id IN 
							(SELECT payment_id
							 FROM Payment
							 WHERE student_id=@StudentID AND CURRENT_TIMESTAMP > i.deadline AND i.status='notPaid')
				)) THEN 0 ELSE 1 END
				
	WHERE student_id=@StudentID
GO

--2.3(O) COLUMNS
CREATE VIEW all_Pending_Requests
	AS
		SELECT r.request_id,r.type,r.comment,r.credit_hours,r.course_id, s.f_name+' '+s.l_name AS Student_name,a.name
		FROM Request r INNER JOIN Student s ON r.student_id=s.student_id 
					   INNER JOIN Advisor a ON r.advisor_id=a.advisor_id
		WHERE r.status='pending'
GO

--2.3(P) DIFFERENCE BETWEEN THIS AND (2.3-H) // SHOULD WE DELETE THE SLOT?? ANA FAKER EL TA ALET KEDA
CREATE PROC Procedures_AdminDeleteSlots
	@current_semester varchar(40)
	AS
		UPDATE Slot
		SET course_id=NULL,
			instructor_id=NULL
		WHERE EXISTS(
			SELECT *
			FROM Course_Semester cs INNER JOIN Course c ON cs.course_id=c.course_id
			WHERE c.is_offered=0 AND cs.semester_code=@current_semester AND Slot.course_id=cs.course_id)
GO

--2.3(Q) NO PROBLEM HERE
CREATE FUNCTION FN_AdvisorLogin (@ID int, @password varchar(40))
	RETURNS BIT 
	AS
		BEGIN
			DECLARE @count int

			SELECT @count = count(*)
			FROM Advisor
			Where advisor_id = @ID and @password = password

			RETURN @count
		END
GO

--2.3(R) NO PROBLEM HERE
CREATE PROC Procedures_AdvisorCreateGP
	@Semester_code varchar(40),
	@expected_graduation_date date,
	@sem_credit_hours int,
	@advisor_id int,
	@student_id int
	AS
		INSERT INTO Graduation_Plan
		VALUES(@Semester_code,@sem_credit_hours,@expected_graduation_date,@advisor_id,@student_id)
GO
--2.3(S) NO PROBLEM HERE
CREATE PROC Procedures_AdvisorAddCourseGP
	@student_id int,
	@Semester_code varchar(40),
	@course_name varchar(40)
	AS
		DECLARE @plan_id INT,
			    @course_id INT

		SELECT @plan_id=plan_id
		FROM Graduation_Plan
		WHERE student_id=@student_id AND semester_code=@Semester_code
		
		SELECT @course_id=course_id
		FROM Course
		WHERE name=@course_name
		
		INSERT INTO GradPlan_Course
		VALUES(@plan_id,@Semester_code,@course_id)
GO

--2.3(T) NO PROBLEM HERE
CREATE PROC Procedures_AdvisorUpdateGP
	@expected_grad_semster varchar(40),
	@studentID int
	AS 
		UPDATE Graduation_Plan
		SET expected_grad_semester=@expected_grad_semster
		WHERE student_id=@studentID
GO

--2.3(U) NO PROBLEM HERE
CREATE PROC Procedures_AdvisorDeleteFromGP
	@studentID int, 
	@semester_code varchar(40),
	@course_ID INT
	AS
		DECLARE @plan_id INT
		
		SELECT @plan_id=plan_id
		FROM Graduation_Plan
		WHERE student_id=@student_id AND semester_code=@semester_code

		DELETE FROM GradPlan_Course 
		WHERE (plan_id=@plan_id AND semester_code=@semester_code AND course_id=@course_ID)
GO

--2.3(V) COLUMNS
CREATE FUNCTION FN_Advisors_Requests(@advisorID int)
	RETURNS TABLE
	AS
		RETURN(
			SELECT *
			FROM Request r
			WHERE r.advisor_id = @advsorID
		)
GO

--Output: Table (Requests details related to this advisor)
-- thats why I wrote SELECT *


--2.3(W)
CREATE PROC Procedures_AdvisorApproveRejectCHRequest
	@RequestID int, 
	@Current_semester_code varchar(40)
	AS
	DECLARE 
	@credit_hrs INT,
	@studentID INT,
	@gpa decimal(3,2),
	@assignedhrs INT,
	@tot_hours_curr_sem INT

	SELECT @credit_hrs=credit_hours, @student_ID=r.student_id, @gpa=s.gpa,@assignedhrs=s.assigned_hours
	FROM Request r INNER JOIN student s ON r.student_id=s.student_id
	WHERE r.request_id=@RequestID

	SELECT @tot_hours_curr_sem= SUM(c.credit_hours)
	FROM Student_Instructor_Course_Take st INNER JOIN Course c ON st.course_id=c.course_id
	WHERE st.student_id=@studentID AND
		  st.semester_code=@Current_semester_code
		
	IF (@gpa<=3.7 AND @credit_hrs<=3 AND (@tot_hours_curr_sem+@assigned_hours+@credit_hrs<=34))
		BEGIN 
			UPDATE Request
			SET status='accepted'
			WHERE request_id=@RequestID

			UPDATE Student
			SET assigned_hours=@assignedhrs+@credit_hrs
			WHERE student_id=@studentID
		END
	ELSE
		BEGIN
			UPDATE Request
				SET status='rejected'
				WHERE request_id=@RequestID
		END 

GO
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
CREATE PROC Procedures_AdvisorApproveRejectCourseRequest
	@RequestID int, 
	@studentID int, 
	@advisorID int
	AS
	DECLARE @crs_id int,
	@not_taken_prereq int,
	@assigned_hours int,
	@credit_hours int,
	@semesterCode VARCHAR(40)

	SELECT @assigned_hours=assigned_hours
	FROM Student
	WHERE student_id=@studentID
	
	SELECT @credit_hours=c.credit_hours,@crs_id=r.crs_id,@semesterCode=cs.semester_code
	FROM Request r 
		 INNER JOIN Course c ON r.course_id=c.course_id
		 INNER JOIN  Course_Semester cs on cs.course_id=c.course_id
	WHERE r.request_id=@RequestID AND
		  r.student_id=@studentID AND
		  r.advisor_id=@advisorID

	SELECT @not_taken_prereq=count(*)
	FROM PreqCourse_course pre
	WHERE course_id=@crs_id AND NOT EXISTS (
		SELECT *
		FROM Student_Instructor_Course_Take
		WHERE student_id=@studentID AND 
			  course_id=pre.prerequisite_course_id AND
			  semester_code <> @semesterCode AND --to ensure that the student is not taking the prereq now
			  grade is not null and grade not in ('F','FF','FA') --to ensure that the prerequisite is taken AND PASSED (tha is not null is extra,I've already checked eno msh byakhod el course delwaaty)
	)

	IF (@not_taken_prereq=0 AND @assigned_hours>=@credit_hours)
		BEGIN
		UPDATE Request
		SET status='accepted'
		WHERE request_id=@RequestID AND
			student_id=@studentID AND
			advisor_id=@advisorID
		UPDATE Student
		SET assigned_hours=@assigned_hours-@credit_hours
		WHERE student_id=@studentID
		INSERT INTO Student_Instructor_Course_Take(student_id,course_id,semester_code)
		VALUES (@studentID,@crs_id,@semesterCode);
		END
	ELSE
		BEGIN
		UPDATE Request
		SET status='rejected'
		WHERE request_id=@RequestID AND
			student_id=@studentID AND
			advisor_id=@advisorID
		END
		
	
GO

--2.3(Z)
CREATE PROC Procedures_AdvisorViewPendingRequests
	@Advisor_ID int
	AS 
	SELECT request_id, type,comment,credit_hours,student_id,course_id ---student_id abayeno or no?
	FROM request 
	WHERE advisor_id=@advisor_id AND status='pending'
GO

--2.3(AA)
CREATE FUNCTION FN_StudentLogin (@StudentID int, @password varchar(40))
	RETURNS BIT AS

		BEGIN
			DECLARE @count int

			SELECT @count = count(*)
			FROM Student
			Where student_id = @StudentID and @password = password

			RETURN @count
		END
GO

--2.3(BB)
CREATE PROC Procedures_StudentaddMobile
	@StudentID int,
	@mobile_number varchar(40)
	AS
	INSERT INTO Student_Phone
	VALUES(@StudentID,@mobile_number)

GO

--2.3(CC)

CREATE FUNCTION FN_SemsterAvailableCourses
(@semester_code varchar(40))
RETURNS TABLE
AS 
RETURN
(
	SELECT c.course_id as 'CourseID', c.name as 'Course Name', c.credit_hours as 'Credit Hours'
	FROM Course c, Course_Semester r
	WHERE c.course_id = r.course_id AND r.semester_code = @semester_code
			AND c.is_offered = 1
)

GO

--2.3(DD)
CREATE PROC Procedures_StudentSendingCourseRequest
	@Student_ID int, 
	@course_ID int, 
	@type varchar (40),
	@comment varchar(40)
	AS
	DECLARE @advisor_id INT
	SELECT @advisor_id=advisor_id
	FROM Student 
	WHERE student_ID=@Student_ID
	INSERT INTO Request(type,comment,student_id,advisor_id,course_id)
	VALUES(@type,@comment,@Student_ID,@advisor_id,@course_ID)

GO

--2.3(EE)
CREATE PROC  Procedures_StudentSendingCHRequest
	@Student_ID int, 
	@credit_hours int, 
	@type varchar (40),
	@comment varchar (40)
	AS
	DECLARE @advisor_id INT
		SELECT @advisor_id=advisor_id
		FROM Student 
		WHERE student_ID=@Student_ID
		INSERT INTO Request(type,comment,student_id,advisor_id,credit_hours)
		VALUES(@type,@comment,@Student_ID,@advisor_id,@credit_hours)
GO

--2.3(FF)
CREATE FUNCTION FN_StudentViewGP(@student_ID INT)
RETURNS TABLE
AS
RETURN (
	SELECT s.student_id,s.f_name+' '+s.l_name AS 'Student name',gp.plan_id,c.course_id,c.name AS 'Course name',
	 gp.semester_code,gp.expected_grad_date,gp.semester_credit_hours,gp.advisor_id
    FROM Student s INNER JOIN Graduation_Plan gp ON gp.student_id = s.student_id
			INNER JOIN GradPlan_Course gpc ON gp.plan_id = gpc.plan_id AND gp.semester_code=gpc.semester_code
            INNER JOIN Course c ON gpc.course_id = c.course_id
    where gp.student_ID = @student_ID 
)
GO

--2.3(GG)
create FUNCTION FN_StudentUpcoming_installment(@StudentID int)
RETURNS DATETIME
AS
BEGIN
Declare @FIRST_DEADLINE_DATE DATETIME

SELECT @FIRST_DEADLINE_DATE = MIN(I.deadline) --first not paid, asdo beha a2rb deadline of installment wla awl intallment nzlt?
											  --momken installment tnzl b3d installment we deadline bt3ha ykon abl el ableha
FROM Payment p INNER JOIN Installment I on p.payment_id = I.payment_id
WHERE p.student_id = @StudentID and I.STATUS = 'notPaid'

return @FIRST_DEADLINE_DATE
END
GO

--2.3(HH)

Create Function FN_StudentViewSlot(@CourseID int, @InstructorID int)
Returns TABLE
AS
Return 
	(SELECT s.slot_id,s.location,s.time,s.day,c.name as 'Course name',i.name as 'Instructor name'
	FROM Instructor i INNER JOIN Slot s  on s.instructor_id = i.instructor_id
				Inner JOIN Course c on s.course_id = c.course_id
	WHERE s.course_id = @CourseID and s.instructor_id = @InstructorID)
GO


--2.3(II)
CREATE PROC Procedures_StudentRegisterFirstMakeup
	@StudentID int,
	@courseID int, 
	@studentCurrent_semester varchar(40) --Eh lazmet semester code? Whilst in JJ we got the grade without having it
	AS
	DECLARE 
	@grade varchar(40),
	@examID int
	SELECT @grade=grade
	FROM Student_Instructor_Course_Take
	WHERE student_id=@StudentID AND course_id=@courseID AND semester_code=@studentCurrent_semester AND exam_type='Normal'

	SELECT @examID=exam_id
	FROM MakeUp_Exam
	WHERE course_id=@courseID AND type='First_makeup'

	IF (@grade in ('F','FF','FA'))--ADD ABS
	BEGIN
		INSERT INTO Exam_Student
		VALUES(@examID,@studentID,@course_id)
		UPDATE Student_Instructor_Course_Take
		SET exam_type='First_makeup'
		WHERE student_id=@StudentID AND course_id=@courseID AND semester_code=@studentCurrent_semester 
	END
GO

--2.3(JJ)
-- CREATE FUNCTION FN_StudentCheckSMEligiability (@CourseID int, @Student_ID int)
-- RETURNS BIT AS
-- 	BEGIN
-- 	DECLARE @failed_courses INT,
-- 	@grade varchar(40),
-- 	@counteven INT,
-- 	@countodd INT

-- 	SELECT @grade=grade
-- 	FROM Student_Instructor_Course_Take
-- 	WHERE student_id=@StudentID AND course_id=@courseID AND exam_type='First_makeup'

-- 	IF @grade NOT IN ('F','FF','FA')--Add Abs
-- 		BEGIN
-- 		RETURN 0
-- 		END

-- 	SELECT @countodd=count(*)
-- 	FROM Student_Instructor_Course_Take
-- 	WHERE student_id=@StudentID AND course_id=@courseID AND grade in ('F','FF','FA') AND semester_code LIKE 'W__'

-- 	SELECT @counteven=count(*)
-- 	FROM Student_Instructor_Course_Take
-- 	WHERE student_id=@StudentID AND course_id=@courseID AND grade in ('F','FF','FA') AND semester_code LIKE 'S__'

-- 	IF @countodd>2 OR @counteven>2
-- 		BEGIN
-- 		RETURN 0
-- 		END

	
-- 	RETURN 1 -- Can u attend 2nd makeup if u failed the course 'F'
-- 	END --WHAT TO DO ABOUT REQUIRED COURSES
--I didn't delete it because there's comments written here nes'alhom and then n delete it

GO
create function FN_StudentCheckSMEligiability (@CourseID int, @StudentID int)
	RETURNS BIT
	AS
	BEGIN
	Declare 
	@count INT,
	@count2 INT,
	@isElig BIT,
	@grade VARCHAR(40)

	SELECT @grade=grade
		FROM Student_Instructor_Course_Take
		WHERE student_id=@StudentID AND course_id=@courseID AND exam_type='First_makeup'

	IF @grade NOT IN ('F','FF','FA')--Add Abs
		BEGIN
		RETURN 0
		END

	SELECT @count = count(*)
	from Student_Instructor_Course_Take
	WHERE semester_code like ('W__') AND student_id = @studentID and grade in ('F','FF','FA') and exam_type = 'first_makeup'

	SELECT @count2 = count(*)
	from Student_Instructor_Course_Take
	WHERE semester_code like ('S__') AND student_id = @studentID and grade in ('F','FF','FA') and exam_type = 'first_makeup'

	if @count<=2 and @count<=2
		BEGIN
		set @isElig = 1
		END
	ELSE
		BEGIN
		set @isElig = 0
		END
	return @isElig
	END

GO

--2.3(KK)
CREATE PROC Procedures_StudentRegisterSecondMakeup
	@StudentID int, 
	@courseID int, 
	@Student_Current_Semester Varchar(40) --this input variable is used in what in this procedure
	AS
	DECLARE @elig_bit BIT,
	@examID INT

	SELECT @examID=exam_id
	FROM MakeUp_Exam
	WHERE course_id=@courseID AND type='Second_makeup'

	SET @elig_bit= dbo.FN_StudentCheckSMEligiability(@courseID,@StudentID)

	if (@elig_bit=1)
	BEGIN
	INSERT INTO Exam_Student
		VALUES(@examID,@StudentID,@courseID)
		UPDATE Student_Instructor_Course_Take
		SET exam_type='Second_makeup'
		WHERE student_id=@StudentID AND course_id=@courseID AND semester_code=@Student_Current_Semester 
	END

GO

--2.3(LL)
CREATE PROC Procedures_ViewRequiredCourses
@StudentID int, 
@Current_semester_code Varchar(40)--me7tagenha fe eh
AS
	SELECT c.* --rename column
	FROM Course c INNER JOIN Student_Instructor_Course_Take s ON c.course_id=s.course_id AND s.studentID=@StudentID
	WHERE  (dbo.FN_StudentCheckSMEligiability(c.course_id,@StudentID) = 0) and s.grade in('F','FF','FA') 
	
	UNION

	SELECT c.*
	FROM Course c , Student s
	Where c.major = s.major and s.student_id = @StudentID and s.semester >c.semester and not exists( SELECT ce.*
																				 FROM Course ce INNER JOIN Student_Instructor_Course_Take se ON ce.course_id=se.course_id AND se.studentID=@StudentID
																				 WHERE ce.course_id = c.course_id
																				)


GO
--2.3(MM)
CREATE PROC Procedures_ViewOptionalCourse
@StudentID int, 
@Currentsemestercode Varchar(40)--me7tagenha fe eh
AS
	
	SELECT c.*
	FROM Course c , Student s
	where  c.major = s.major and s.student_id = @StudentID and s.semester<=c.semester and 
	NOT EXISTS( SELECT ce.*
	FROM Course ce INNER JOIN Student_Instructor_Course_Take se ON ce.course_id=se.course_id AND se.studentID=@StudentID
	WHERE ce.course_id = c.course_id AND NOT EXISTS(
		SELECT p.prerequisite_course_id
		FROM PreqCourse_course
		WHERE ce.course_id=p.course_id
		EXCEPT 
		SELECT pr.prerequisite_course_id
		FROM PreqCourse_course pr INNER JOIN Student_Instructor_Course_Take sct ON pr.prerequisite_course_id=sct.course_id
		WHERE ce.course_id=pre.course_id
	)
	)
	
GO

--2.3(NN)
CREATE PROC Procedures_ViewMS 
@StudentID int
AS
	-- SELECT c.*
	-- FROM Course c , Student s
	-- where  c.major = s.major and s.student_id = @StudentID and s.semester<=c.semester and 
	-- NOT EXISTS( SELECT ce.*
	-- FROM Course ce INNER JOIN Student_Instructor_Course_Take se ON ce.course_id=se.course_id AND se.studentID=@StudentID
	-- WHERE ce.course_id = c.course_id AND EXISTS(
	-- 	SELECT p.prerequisite_course_id
	-- 	FROM PreqCourse_course
	-- 	WHERE ce.course_id=p.course_id
	-- 	EXCEPT 
	-- 	SELECT pr.prerequisite_course_id
	-- 	FROM PreqCourse_course pr INNER JOIN Student_Instructor_Course_Take sct ON pr.prerequisite_course_id=sct.course_id
	-- 	WHERE ce.course_id=pre.course_id
	-- )
	--)
	SELECT c.*
	FROM Course 
	EXCEPT 
	(
		SELECT c.*
	FROM Course c , Student s
	where  c.major = s.major and s.student_id = @StudentID and @Currentsemestercode<=c.semester and 
	NOT EXISTS( SELECT ce.*
	FROM Course ce INNER JOIN Student_Instructor_Course_Take se ON ce.course_id=se.course_id AND se.studentID=@StudentID
	WHERE ce.course_id = c.course_id AND NOT EXISTS(
		SELECT p.prerequisite_course_id
		FROM PreqCourse_course
		WHERE ce.course_id=p.course_id
		EXCEPT 
		SELECT pr.prerequisite_course_id
		FROM PreqCourse_course pr INNER JOIN Student_Instructor_Course_Take sct ON pr.prerequisite_course_id=sct.course_id
		WHERE ce.course_id=pre.course_id
	)
	)
	UNION
	(
		SELECT c.* --rename column
	FROM Course c INNER JOIN Student_Instructor_Course_Take s ON c.course_id=s.course_id AND s.studentID=@StudentID
	WHERE  (dbo.FN_StudentCheckSMEligiability(c.course_id,@StudentID) = 0) and s.grade in('F','FF','FA') 
	
	UNION

	SELECT c.*
	FROM Course c , Student s
	Where c.major = s.major and s.student_id = @StudentID and @Current_semester_code >c.semester and not exists( SELECT ce.*
																				 FROM Course ce INNER JOIN Student_Instructor_Course_Take se ON ce.course_id=se.course_id AND se.studentID=@StudentID
																				 WHERE ce.course_id = c.course_id
																				)
	)
	)
GO

--2.3(OO)
CREATE PROC Procedures_ChooseInstructor
	@Student_ID int, 
	@Instructor_ID int,
	@Course_ID int
	AS
	UPDATE Student_Instructor_Course_Take
	SET instructor_id=@Instructor_ID
	WHERE student_id=@Student_ID AND course_id=@Course_ID



--Farahh