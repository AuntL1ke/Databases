use Academy7

select lr.Name
from LectureRooms as lr
join Schedules as sh on lr.Id = sh.LectureRoomId
join Lectures as l on sh.LectureId = l.Id
join Teachers as t on l.TeacherId = t.Id
where t.Name = 'Edward' and t.Surname = 'Hopper'


select t.Surname
from Teachers as t
join Assistants as a on t.Id = a.TeacherId
join Lectures as l on t.Id=l.TeacherId
join GroupsLectures as gl on l.Id = gl.LectureId
join Groups as g on gl.GroupId = g.Id
where g.Name = 'F505'

select s.Name 
from Subjects as s
join Lectures as l on s.Id=l.SubjectId
join GroupsLectures as gl on l.Id = gl.LectureId
join Groups as g on gl.GroupId=g.Id
join Teachers as t on l.TeacherId=t.Id
where t.Name = 'Alex' and t.Surname='Carmack' and .Year=5

select t.Surname 
from Teachers as t
left join Lectures as l on t.Id=l.TeacherId
left join Schedules as sh on l.Id=sh.LectureId
where sh.DayOfWeek!=1 or sh.DayOfWeek is null


select lr.Name,lr.Building
from LectureRooms as lr
left join Schedules as sh on lr.Id=sh.LectureRoomId
where sh.Week!=2 or sh.DayOfWeek!=3 or sh.Class!=3 or sh.LectureId is null


select t.Name + ' ' + t.Surname
from Teachers as t 
join Heads as h on t.Id=h.TeacherId
join Departments as d on h.Id=d.HeadId
join Faculties as f on d.FacultyId=f.Id
left join Curators as c on t.Id=c.TeacherId
left join GroupsCurators as gc on c.Id=gc.CuratorId
left join Groups as g on d.Id=g.DepartmentId
where f.Name='Computer Science'
and d.Name is null or d.Name != 'Software development'
and gc.CuratorId is null


select Building 
from Faculties
union
select Building
from Departments
union select Building
from LEctureRooms



select t.Name + ' ' + t.Surname
from Teachers as t
left join Deans as d on t.Id=d.TeacherId
left join Heads as h on t.Id = h.TeacherId
left join Curators a c on t.Id=c.TeacherId
left join Assistants as a  on t.Id = a.TeacherId
order by d.Id desc, h.Id desc, c.Id desc, a.Id desc


select sh.DayOfWeek
from Schedules as sh
join LectureRooms as lr on sh.LectureRoomId=lr.Id
where lr.Name in ('A311','A104')
order by sh.DayOfWeek