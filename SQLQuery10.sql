create database Academy6

use Academy6

create table Faculties
(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name <> '') unique,
)

create table Departments
(
	Id int primary key identity,
	Financing money not null check(Financing >=0) default(0),
	Name nvarchar(100) not null check(Name <> '') unique,
	FacultyId int not null references Faculties(Id)
)

create table Groups
(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name <> '') unique,
	Year int not null check(Year between 1 and 5),
	DepartmentId int not null references Departments(Id)
)

create table Subject
(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name <> '') unique
)
create table Teachers
(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name <> '') unique,
	Salary money not null check(Salary > 0),
	Surname nvarchar(100) not null check(Surname <> '')
)

create table Lectures
(
	Id int primary key identity,

	LectureRoom nvarchar(max) not null check(LectureRoom <> ''),
	SubjectId int not null references Subject(Id),
	TeacherId int not null references Teachers(Id)

)

create table GroupsLectures
(
	Id int primary key identity,
	DayOfWeek int not null check(DayOfWeek between 1 and 7),
	GroupId int not null references Groups(Id),
	LectureId int not null references Lectures(Id)
)


INSERT INTO Faculties (Name) VALUES ('Computer Science');
INSERT INTO Faculties (Name) VALUES ('Math');
INSERT INTO Faculties (Name) VALUES ('Science');


INSERT INTO Departments (Financing, Name, FacultyId) VALUES (270.80, 'Software Development', 1);
INSERT INTO Departments (Financing, Name, FacultyId) VALUES (614.27, 'Front-end', 1);
INSERT INTO Departments (Financing, Name, FacultyId) VALUES (549.72, 'Cybersecurity', 1);
INSERT INTO Departments (Financing, Name, FacultyId) VALUES (759.20, 'Physics', 2);
INSERT INTO Departments (Financing, Name, FacultyId) VALUES (73.66, 'Biology', 3);

INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_1', 4, 1);
INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_2', 1, 1);
INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_3', 4, 2);
INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_4', 1, 2);
INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_5', 3, 3);
INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_6', 3, 3);
INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_7', 4, 4);
INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_8', 2, 4);
INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_9', 5, 5);
INSERT INTO Groups (Name, Year, DepartmentId) VALUES ('G_10', 5, 1); -- Додамо додаткову групу для "Software Development"


INSERT INTO Subject (Name) VALUES ('Koenraad');
INSERT INTO Subject (Name) VALUES ('Abbi');
INSERT INTO Subject (Name) VALUES ('Annie');


INSERT INTO Teachers (Name, Salary, Surname) VALUES ('Valentine', 218.85, 'Burtenshaw');
INSERT INTO Teachers (Name, Salary, Surname) VALUES ('Dave', 385.52, 'McQueen');
INSERT INTO Teachers (Name, Salary, Surname) VALUES ('Ferguson', 225.02, 'Shillom');
INSERT INTO Teachers (Name, Salary, Surname) VALUES ('Bordie', 150.45, 'Donhardt');
INSERT INTO Teachers (Name, Salary, Surname) VALUES ('Jack', 301.46, 'Underhill');


INSERT INTO Lectures (LectureRoom, SubjectId, TeacherId) VALUES ('D201', 1, 1);
INSERT INTO Lectures (LectureRoom, SubjectId, TeacherId) VALUES ('D202', 2, 2);
INSERT INTO Lectures (LectureRoom, SubjectId, TeacherId) VALUES ('D203', 3, 3);
INSERT INTO Lectures (LectureRoom, SubjectId, TeacherId) VALUES ('D204', 1, 4);
INSERT INTO Lectures (LectureRoom, SubjectId, TeacherId) VALUES ('D205', 2, 5); -- Додамо ще одну лекцію для викладача Jack Underhill


INSERT INTO GroupsLectures (DayOfWeek, GroupId, LectureId) VALUES (1, 1, 1);
INSERT INTO GroupsLectures (DayOfWeek, GroupId, LectureId) VALUES (2, 2, 2);
INSERT INTO GroupsLectures (DayOfWeek, GroupId, LectureId) VALUES (3, 3, 3);
INSERT INTO GroupsLectures (DayOfWeek, GroupId, LectureId) VALUES (4, 4, 4);
INSERT INTO GroupsLectures (DayOfWeek, GroupId, LectureId) VALUES (5, 5, 5);


select COUNT(Teachers.Id) from Teachers
join Lectures as l on Teachers.Id = l.TeacherId
join GroupsLectures as gl on l.Id = gl.LectureId
join Groups as g on gl.GroupId = g.Id
join Departments as d on g.DepartmentId = d.Id
where d.Name = 'Software Development'

select COUNT(l.Id) from Lectures as l
join Teachers as t on l.TeacherId = t.Id
where t.Name = 'Jack'and t.Surname = 'McQueen'

select COUNT(gl.Id) 
from GroupsLectures as gl
join Lectures as l on gl.LectureId = l.Id
where l.LectureRoom = 'D201'

select COUNT(gl.GroupId)
from Groups as g 
join GroupsLectures as gl on g.Id = gl.GroupId
join Lectures as l on gl.LectureId = l.Id
join Teachers as t on l.Id = t.Id
where t.Name = 'Jack' and t.Surname = 'Underhill'


select AVG(t.Salary)
from Teachers as t
join Lectures as l on t.Id=l.TeacherId
join GroupsLectures as gl on l.Id = gl.LectureId
join Groups as g on gl.GroupId = g.Id
join Departments as d on g.DepartmentId = d.Id
where d.Name = 'Computer Science'

select AVG(d.Financing) from Departments as d

select t.Name + ' ' + t.Surname
from Teachers as t
join Lectures as l on t.Id = l.TeacherId
join Subject as s on l.SubjectId = s.Id



select DayOfWeek, COUNT(*)
from GroupsLectures
group by DayOfWeek
Order by DayOfWeek

select l.LectureRoom, COUNT(d.Id)
from Lectures as l
join GroupsLectures as gl on l.Id = gl.LectureId
join Groups as g on gl.GroupId = g.Id
join Departments as d on g.DepartmentId = d.Id


select d.Name, COUNT(s.Id)
from Departments as d
join Groups as g on d.Id = g.DepartmentId
join GroupsLectures as gl on g.Id = gl.GroupId
join Lectures as l on gl.LectureId = l.Id
join Subject as s on l.SubjectId = s.Id


select t.Name + ' ' + t.Surname
from Teachers as t
join Lectures as l on t.Id = l.TeacherId
join GroupsLectures as gl on l.Id=gl.LectureId
group by CONCAT(t.Name,' ',t.Surname),l.LectureRoom
