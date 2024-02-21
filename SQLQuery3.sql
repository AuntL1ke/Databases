create database Academy2
use Academy2

create table Departments
(
	[Id] int not null identity(1, 1) primary key,
	[Financing] money not null check ([Financing] >= 0.0),
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
)

create table Faculties
(
	[Id] int not null identity(1, 1) primary key,
	[Dean] nvarchar(max) not null check ([Dean] <> N''),
	[Name] nvarchar(100) not null unique check ([Name] <> N''),
)


create table Groups
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(10) not null unique check ([Name] <> N''),
	[Rating] float not null check ([Rating] between 0 and 5),
	[Year] int not null check ([Year] between 1 and 5)
)


create table Teachers
(
	[Id] int not null identity(1, 1) primary key,
	[EmploymentDate] date not null check ([EmploymentDate] >= '1990-01-01'),
	[IsAssistant] bit not null default 0,
	[IsProfessor] bit not null default 0,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Position] nvarchar(max) not null check ([Position] <> N''),
	[Premium] money not null check ([Premium] >= 0.0) default 0.0,
	[Salary] money not null check ([Salary] > 0.0),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
)



INSERT INTO Departments (Financing, Name)
VALUES (10000, 'Department of Mathematics'),
       (15000, 'Department of Physics'),
       (12000, 'Department of Chemistry');


INSERT INTO Faculties (Dean, Name)
VALUES ('John Doe', 'Faculty of Science'),
       ('Jane Smith', 'Faculty of Arts');

INSERT INTO Groups (Name, Rating, Year)
VALUES ('Group A', 4, 3),
       ('Group B', 5, 4),
       ('Group C', 3, 2);


INSERT INTO Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
VALUES ('2005-08-20', 0, 1, 'Alice', 'Professor', 2000, 5000, 'Smith'),
       ('2010-03-15', 1, 0, 'Bob', 'Assistant Professor', 500, 3000, 'Johnson');




select [Name], Financing, Id  from Departments

select [Name] as 'Group Name', Rating as 'Group Rating' from Groups

select 
    Surname,
    Premium * 100.0 / Salary as Premium_Percentage,
    (Salary + Premium) * 100.0 / Salary as Total_Salary_Percentage
from
    Teachers;

select 'The dean of faculty ' + [Name] + 'is' + Dean from Faculties

select Surname
from Teachers
where IsProfessor = 1 and Salary>1050

select [Name]
from Departments
where Financing < 11000 or Financing >= 25000;


select [Name]
from Faculties
where [Name] <> 'Computer Science';

select Surname, Position
from Teachers
where IsProfessor = 0;

select Surname, Position, Salary, Premium
from Teachers
where IsAssistant = 1 and Premium between 160 and 550;

select Surname, Salary
from Teachers
where IsAssistant = 1;

select Surname, Position
from Teachers
where EmploymentDate < '2000-01-01';

select [Name] as "Name of Department"
from Departments
where [Name] < 'Software Development';

select Surname
from Teachers
where Salary + Premium <= 1200;

select [Name]
from Groups
where Rating between 2 and 4 and Year = 5;

select Surname
from Teachers
where IsAssistant = 1 and (Salary < 550 or Premium < 200);
