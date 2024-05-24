CREATE database Final_Duc_Anh;
use Final_Duc_Anh;

--1. Create Table:

CREATE TABLE Teachers (
    TeacherID int primary key identity (1,1),
    FirstName varchar(250),
    LastName varchar(250),
    Subject varchar(250)
);

CREATE TABLE Classes (
    ClassID int primary key identity (1,1),
    ClassName varchar(250),
    TeacherID int,
    CONSTRAINT FK_Teachers FOREIGN KEY (TeacherID)
	REFERENCES Teachers(TeacherID)
);

CREATE TABLE Students (
    StudentID int primary key identity (1,1),
    FirstName varchar(250),
    LastName varchar(250),
    ClassID int,
    BirthDate date,
    CONSTRAINT Fk_Clasees FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);


--2. More Data:
	-- Insert data Teachers
insert into Teachers (FirstName, LastName, Subject) values
('Ho', 'Chi Minh', 'Lich Su'),
('Le', 'Van Luong', 'Toan Hoc'),
('Tran', 'Quoc Toan', 'Vat Ly');

	-- Insert data Classes
insert into Classes ( ClassName, TeacherID) values
('Lich su A', 1),
('Toan Hoc B', 2),
('Vat Ly C', 3),
('The Duc D', 1),
('Khoa Hoc E', 2);

	-- Insert data Students
insert into Students (FirstName, LastName, ClassID, BirthDate) values
('Le', 'Duc Anh', 1, '2001-12-08'),
('Vu', 'Dinh Quy', 2, '2003-10-11'),
('Dang', 'Minh Duc', 3, '2005-12-12'),
('Tran', 'Duc Thuan', 1, '2005-02-28'),
('Mai', 'Hong Anh', 2, '2002-12-14'),
('Phan', 'Tien Anh', 4, '2004-01-24'),
('Nguyen Thi', 'A', 5, '2002-02-18'),
('Nguyen Van', 'B', 4, '2001-08-30'),
('Nguyen Xuan', 'C', 5, '2000-10-05'),
('Ngo Quyen', 'D', 3, '2006-12-20'),
('Tran Van', 'E', 3, '1999-01-11');

select * from Students

--3. Data Query:
Select s.StudentID, s.FirstName, s.LastName, s.BirthDate ,c.ClassName ,t.FirstName as TeacherFirstName, t.LastName as TeacherLastName from Students as s
	JOIN Classes as c ON s.ClassID = c.ClassID
	JOIN Teachers t ON c.TeacherID = t.TeacherID;

--4. Query Conditions:
Select * from Students where year(BirthDate) >= 2000

--5. JOIN Query:
Select s.StudentID, s.FirstName, s.LastName, s.BirthDate ,c.ClassName ,t.FirstName as TeacherFirstName, t.LastName as TeacherLastName from Students as s
	JOIN Classes as c ON s.ClassID = c.ClassID
	JOIN Teachers t ON c.TeacherID = t.TeacherID
	ORDER by s.FirstName, s.LastName;

--6. Updating data: Update the name of the student whose StudentID is 3 to "John Doe".
update students set FirstName = 'John', LastName = 'Doe'
	where StudentID = 3;

--check data again
select * from Students

--7. Delete data: Delete students whose StudentID is 7
delete from students where StudentID = 7;
--8. Procedure:Create a stored procedure named GetStudentsByClassAndSubject that takes ClassID and Subject, and returns a list of students belonging to that class and subject.
CREATE PROCEDURE GetStudentsByClassAndSubject @p_ClassID int ,@p_Subject varchar(250) as

Select s.StudentID, s.Firstname, s.Lastname, s.Birthdate, c.ClassName, t.Firstname as TeacherFirstname, t.Lastname as TeacherLastname, t.Subject
    FROM Students s
    JOIN Classes c ON s.ClassID = c.ClassID
    JOIN Teachers t ON c.TeacherID = t.TeacherID
    WHERE s.ClassID = @p_ClassID AND t.Subject = @p_Subject
go 

EXEC GetStudentsByClassAndSubject;

--9 View:Create a view named StudentsWithClassAndTeacher that displays information about students along with the class name and teacher in charge.
Create view StudentsWithClassAndTeacher as

Select s.StudentID, s.FirstName, s.LastName ,s.BirthDate, c.ClassName ,t.FirstName as TeacherFirstName, t.LastName as TeacherLastName from Students as s
	JOIN Classes as c ON s.ClassID = c.ClassID
	JOIN Teachers t ON c.TeacherID = t.TeacherID

Select * from StudentsWithClassAndTeacher