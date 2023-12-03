
DROP PROC CreateAllTables
DROP PROC clearAllTables
EXEC CreateAllTables

EXEC DropAllTables

EXEC clearAllTables

--2.3(A)
DECLARE @sid INT
EXEC Procedures_StudentRegistration 'Ziad', 'Abdelrahman','pass','ENG','ziad@gmail.com','MET',5,@sid OUTPUT
EXEC Procedures_StudentRegistration 'Abdallah', 'Ahmed','pass','ENG','nana@gmail.com','MET',5,@sid OUTPUT
EXEC Procedures_StudentRegistration 'Farah', 'Faisal','pass','ENG','Farahh@gmail.com','MET',5,@sid OUTPUT
EXEC Procedures_StudentRegistration 'Youssef', 'Brolosy','pass','ENG','Brolosy@gmail.com','MET',5,@sid OUTPUT

--2.3(B)
DECLARE @aid INT
EXEC Procedures_AdvisorRegistration 'Ahmed','pass','ahmed@gmail.com','c5-130',@aid OUTPUT
EXEC Procedures_AdvisorRegistration 'Mohamed','pass','mohamed@gmail.com','c3-120',@aid OUTPUT
EXEC Procedures_AdvisorRegistration 'Hassan','pass','Hassan@gmail.com','c4-130',@aid OUTPUT

--2.3(C) eshm3na hena bndisplay all data
EXEC Procedures_AdminListStudents

--2.3(D) w hena bndisplay all data
EXEC Procedures_AdminListAdvisors

--2.3(E) w hena la
INSERT INTO Student
VALUES('ali','ahmed',2.4,'ENG','ay','MET','pass',1,5,40,30,1),
	  ('fatma','ahmed',3.8,'ENG','ay','MET','pass',1,5,45,27,1),
	  ('nour','ashraf',2.8,'ENG','ay','MET','pass',1,5,140,33,2),
	  ('samy','amr',2.1,'ENG','ay','MET','pass',1,5,40,31,3),
	  ('mario','ahmed',1.4,'ENG','ay','MET','pass',1,5,90,34,2)
EXEC AdminListStudentsWithAdvisors

--2.3(F)
EXEC AdminAddingSemester '2022-10-20' , '2023-01-20','W23'
EXEC AdminAddingSemester '2023-02-20' , '2023-05-20','S23'
EXEC AdminAddingSemester '2023-06-20' , '2023-07-20','S23R1'
EXEC AdminAddingSemester '2023-07-20' , '2023-08-20','S23R2'
EXEC AdminAddingSemester '2023-10-20' , '2024-01-20','W24'
EXEC AdminAddingSemester '2024-02-20' , '2024-05-20','S24'
EXEC AdminAddingSemester '2024-06-20' , '2024-07-20','S24R1'
EXEC AdminAddingSemester '2024-07-20' , '2024-08-20','S24R2'

--2.3(G)
EXEC Procedures_AdminAddingCourse 'MET',1,6,'CSEN 101', 1 
EXEC Procedures_AdminAddingCourse 'MET',2,6,'CSEN 201', 0 
EXEC Procedures_AdminAddingCourse 'MET',3,6,'CSEN 301', 1 
EXEC Procedures_AdminAddingCourse 'MET',4,6,'CSEN 401', 0 
EXEC Procedures_AdminAddingCourse 'MET',1,8,'MATH 101', 1
EXEC Procedures_AdminAddingCourse 'MET',2,8,'MATH 201', 0 
EXEC Procedures_AdminAddingCourse 'MET',3,8,'MATH 301', 1
EXEC Procedures_AdminAddingCourse 'MET',5,6,'DATABASE I', 1
EXEC Procedures_AdminAddingCourse 'MET',6,6,'DATABASE II', 0 
EXEC Procedures_AdminAddingCourse 'MET',7,5,'ACL', 1

INSERT INTO PreqCourse_course 
VALUES(1,2),
	  (1,3),
	  (1,4),
	  (2,3),
	  (2,4),
	  (5,6),
	  (5,7),
	  (6,7),
	  (8,9)

INSERT INTO Course_Semester
VALUES(1,'W23'),
	  (3,'W23'),
	  (5,'W23'),
	  (7,'W23'),
	  (8,'W23'),
	  (10,'W23'),
	  (2,'S23'),
	  (4,'S23'),
	  (6,'S23'),
	  (9,'S23'),
	  (1,'W24'),
	  (3,'W24'),
	  (5,'W24'),
	  (7,'W24'),
	  (8,'W24'),
	  (10,'W24'),
	  (2,'S24'),
	  (4,'S24'),
	  (6,'S24'),
	  (9,'S24'),
	  (1,'S23R1'),
	  (2,'S23R2'),
	  (7,'S24R1'),
	  (6,'S24R2')

--2.3(H)
INSERT INTO Slot
	VALUES('Saturday','FIRST','C5-120',NULL,NULL),
		  ('Sunday','FIRST','C5-120',NULL,NULL),
		  ('Monday','FIRST','C5-120',NULL,NULL),
		  ('Thursday','FIRST','C5-120',NULL,NULL),
		  ('Saturday','SECOND','C5-120',NULL,NULL),
		  ('Sunday','SECOND','C5-120',NULL,NULL),
		  ('Monday','SECOND','C5-120',NULL,NULL),
		  ('Thursday','SECOND','C5-120',NULL,NULL),
		  ('Saturday','THIRD','C5-120',NULL,NULL),
		  ('Sunday','THIRD','C5-120',NULL,NULL),
		  ('Monday','THIRD','C5-120',NULL,NULL),
		  ('Thursday','THIRD','C5-120',NULL,NULL),
		  ('Saturday','FOURTH','C5-120',NULL,NULL),
		  ('Sunday','FOURTH','C5-120',NULL,NULL),
		  ('Monday','FOURTH','C5-120',NULL,NULL),
		  ('Thursday','FOURTH','C5-120',NULL,NULL),
		  ('Saturday','FIFTH','C5-120',NULL,NULL),
		  ('Sunday','FIFTH','C5-120',NULL,NULL),
		  ('Monday','FIFTH','C5-120',NULL,NULL),
		  ('Thursday','FIFTH','C5-120',NULL,NULL)

INSERT INTO Instructor
	VALUES('SLIM','E','ENG','O'),
		  ('MERVAT','E','ENG','O'),
		  ('RAMY','E','ENG','O'),
		  ('HANY','E','ENG','O')

INSERT INTO Instructor_Course
	VALUES(1,1),
		  (2,1),
		  (3,1),
		  (4,1),
		  (5,4),
		  (6,3),
		  (7,3),
		  (8,2),
		  (9,2),
		  (10,1)

EXEC Procedures_AdminLinkInstructor 1,1,1
EXEC Procedures_AdminLinkInstructor 1,2,2
EXEC Procedures_AdminLinkInstructor 1,3,3

--2.3(I)
EXEC Procedures_AdminLinkStudent 1,1,1,'W23'
EXEC Procedures_AdminLinkStudent 1,1,3,'W23'


--2.3(J)
EXEC Procedures_AdminLinkStudentToAdvisor 1,1

--2.3(K)

--2.3(L)
insert into Payment VALUES (10000,'2024-06-12',4,'notPaid',20,'2023-12-3',5,'W24') 
insert into Payment VALUES (5000,'2024-01-12',2,'notPaid',20,'2023-12-3',2,'W24') 
insert into Payment VALUES (5000,'2024-04-12',3,'notPaid',50,'2024-1-12',4,'W24') 
insert into Payment VALUES (50000,'2024-04-12',3,'notPaid',50,'2024-1-12',3,'W24') 
insert into Payment VALUES (50000,'2024-04-12',3,'Paid',50,'2024-1-12',1,'W24')
EXEC Procedures_AdminIssueInstallment 5
EXEC Procedures_AdminIssueInstallment 4
select * From Payment
SELECT * FROM Installment

--2.3(M)

EXEC Procedures_AdminDeleteCourse 3

--------------------------------------------------------------------------------------
--RECHECK (hagat momken nes2l 3aleha keda keda hantest kolo men el awl): 
-- (*-->NOT THAT IMPORTANT // **-->MABEN EL ETNEN // ***-->VERY VERY IMPORTANT)
--ALL 2.2* (Makeup details masln show them in different columns 3ady , omar mas3dneesh awy feeha bas aal mafeesh 1 answer shoof eh el yenaseb t7oto)
--2.3(A)** (Students registeration da bykoon hoa alr student 3ando attributes w by register le advising fa mesh ha calculate el gpa/ash/aq 3alshan malhash lazma ana el dakhely advising fa ignore it w kaman el FAQ aligns m3 kalam omar)
--2.3(C)* (Same as 2.2)
--2.3(D)* (Same as 2.2)
--2.3(E)* (nseit as2al de)
--2.3(L)** (7ad yet2kd men el 3amlto w 3ayzeen nzwd el number of installments w nshelha men el derived attributes)
--2.3(N)*** (tamam zabtanaha)
--2.3(O)* (Same as 2.2)
--2.3(P)*** (de Mariam kanet ayla delete el slot omar aal la zy manto 3amleen momken nes2l tany BAS el FAQ bey2olk mat3mlsh check be is offered w check be TABLE Course_Semster fa hanghayr feeha bardo)
--2.3(V)* (nafs kalam 2.2) <--we2ft hena
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

--An advising student must have at least one missed course. A course is considered missed if the student failed/didn’t attend the course
--^^DO I HAVE TO CHECK THE ABOVE POINT