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
EXEC Procedures_AdminLinkInstructor


