create database	Music_Collection
use Music_Collection

create table Styles
(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name <> ' ')
)

create table Artists
(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name <> ' ') unique
)

create table Publishers
(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name <> ' '),
	Country nvarchar(100)
)
create table Disks
(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name <> ''),
	ArtistId int references Artists(Id),
	Date date ,
	StyleId int references Styles(Id),
	PublisherId int references Publishers(Id)
	
)

create table Songs
(
	Id int primary key identity,
	Name nvarchar(100) not null check(Name <> ''),
	DiskId int references Disks(Id),
	Duration int,
	StyleId int references Styles(Id),
	ArtistId int references Artists(Id)

)


create view Show_Artists
as
	select Name 
	from Artists
	
create view Show_Song
as 
	select *
	from Songs


create view Show_Groups
as 
	select d.Name
	from Disks as d
	join Artists as a on d.ArtistId=a.Id

create view Show_Popular
as 
	select top 1 a.Name
	from Artists as a
	join Disks as d on a.Id=d.ArtistId
	group by a.Name
	order by COUNT(d.Id) desc


create view Show_Collections
as 
	select top 3 a.Name, COUNT(d.Id)
	from Artists as a
	join Disks as d on a.Id=d.ArtistId
	group by a.Name
	order by COUNT(d.Id) desc

create view Show_longest
as 
	select top 1 d.Name, SUM(s.Duration) as TotalDuration
	from Disks as d
	join Songs as s on d.Id=s.DiskId
	group by d.Name
	order by TotalDuration desc





create function GetDisks(@year int)
returns table
as
return 
(
	select * 
	from Disks
	where YEAR(Date) = @year
)


create fucntion DiskReturn()
returns int
as
begin
	declare @count int
	select @count = COUNT(*)
	from Disks
	where StyleId in (select StyleId from Styles where Styles.Name in ('hard rock', 'heavy metal'))
	return @count
end

create function GetSong(@keyword nvarchar(max))
returns table
as
return
(
	select * 
	from Songs
	where Songs.Name like '%' + @keyword + '%'
)

create function AverageSong(@artist nvarchar(max))
returns Decimal(18,2)
as
begin
	declare @avg decimal(18,2)
	select @avg = AVG(s.Duration)

	from Songs as s
	join Artists as a on s.ArtistId=a.Id
	where a.Name=@artist
	return @avg
end


create function LongestAndShortesSong()
returns table
as 
	
return 
(
	select top 1 s.Name as Longest
	from Songs as s 
	order by s.Duration desc
	union all
	select top 1 s.Name as Shortest
	from Songs as s
	order by s.Duration asc
)

create function MultiStyle()
returns table
as 
return
(
	select a.Name
	from Artists as a
	join Disks as d on a.Id=d.ArtistId
	having COUNT(d.Id)>=2
)





create function DiffArtists()
returns table
as
return
(
	select d.Name as Albom, a1.Name as Artist1, a2.Name as Artist2
	from Disks as d
	join Artists as a1 on d.ArtistId=a1.Id
	join Artists as a2 on d.ArtistId=a2.Id
	where exists
	(
		select 1
		from Disks as d2
		where d2.Name=d.Name
		
		having COUNT(d.ArtistId)>1
	)
)
