create database Academy4
use Academy4

create table Curators
(
	Id int primary key not null identity,
	Name nvarchar(max) not null check(Name <> ''),
	Surname nvarchar(max) not null check(Surname <> '')
)

create table Faculty
(
	Id int primary key not null identity,
	Financing money not null check(Financing >= 0) default(0),
	Name nvarchar(100) not null check(Name <> '') unique
)

create table Departments
(
	Id int primary key not null identity,
	Financing money not null check(Financing >= 0) default(0),
	Name nvarchar(100) not null check(Name <> '') unique,
	FacultyId int not null references Faculty(Id)
)

create table Groups
(
	Id int primary key not null identity,
	Name nvarchar(10) not null check(Name <> '') unique,
	[Year] int not null check([Year] between 1 and 5),
	DepartmentId int not null references Departments(Id)	
)


create table Subjects
(
	Id int primary key not null identity,
	[Name] nvarchar(100) not null check([Name] <> '') unique,

)

create table Teachers
(
	Id int primary key not null identity,
	Name nvarchar(max) not null check(Name <> ''),
	Salary money not null check(Salary > 0),
	Surname nvarchar(max) not null check(Surname <> '')
)

create table Lectures
(
	Id int primary key not null identity,
	LectureRoom nvarchar(max) not null check(LectureRoom <> ''),
	SubjectId int not null references Subjects(Id),
	TeacherId int not null references Teachers(Id)
)

create table GroupsCurators
(
	Id int primary key not null identity,
	CuratorId int not null references Curators(Id),
	GrouId int not null references Groups(Id),

)



create table GroupsLectures
(
	Id int primary key not null identity,
	GrouId int not null references Groups(Id),
	LectureId int not null references Lectures(Id)
)



select t.Name, t.Surname, g.Name
from Teachers as t, Groups as g

select f.Name
from Faculty as f
join Departments as d on f.Id = d.FacultyId
where f.Financing > d.Financing


select c.Surname, g.Name
from Curators as c
join GroupsCurators as gc on c.Id = gc.CuratorId
join Groups as g on g.Id = gc.GrouId

select t.Name, t.Surname
from Teachers as t
join Lectures as l on t.Id = l.Id
join GroupsLectures as gl on l.Id = gl.LectureId
join Groups as g on gl.GrouId = g.Id
where g.Name = 'P107'

select t.Surname
from Teachers as t
join Lectures as l on t.Id = l.TeacherId
join GroupsLectures as gl on l.Id = gl.LectureId
join Groups as g on gl.GrouId = g.Id
join Departments as d on g.DepartmentId = d.Id
join Faculty as f on d.FacultyId = f.Id


select d.Name, g.Name
from Departments as d
join Groups as g on d.Id = g.DepartmentId

select s.Name
from Subjects as s
join Lectures as l on s.Id = l.SubjectId
join Teachers as t on l.TeacherId = t.Id
where t.Name = 'Samantha Adams'


select d.Name
from Departments as d
join Groups as g on d.Id = g.DepartmentId
join GroupsLectures as gl on g.Id = gl.GrouId
join Lectures as l on gl.LectureId = l.Id
join Subjects as s on l.SubjectId = s.Id
where s.Name = 'Database Theory'


select g.Name
from Groups as g
join Departments as d on g.DepartmentId = d.Id
join Faculty as f on d.FacultyId = f.Id
where f.Name = 'Computer Science'



select g.Name, f.Name
from Groups as g
join Departments as d on g.DepartmentId = d.Id
join Faculty as f on d.FacultyId = f.Id
where g.Year = 5


select t.Name + ' ' + t.Surname, s.Name, g.Name
from Teachers as t
join Lectures as l on t.Id = l.TeacherId
join GroupsLectures as gl on l.Id = gl.LectureId
join Groups as g on gl.GrouId = g.Id
join Subjects as s on l.SubjectId = s.Id
where l.LectureRoom = 'B103'