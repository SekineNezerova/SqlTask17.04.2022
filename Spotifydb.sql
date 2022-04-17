create database SpotifyDb
use SpotifyDb

create table Artists(
Id int primary key identity,
Name nvarchar(100),
Surname nvarchar(100)
)
alter table Artists drop column Surname
Insert into Artists(Name) values('Eminem')

create table Albums(
Id int primary key identity,
Name nvarchar(100),
MusicCount int,
ArtistId int references Artists(Id)
)
Insert into Albums(Name,MusicCount,ArtistId) values('MusicToBeMurderedBy',20,1)																)

create table Musics(
Id int primary key identity,
Name nvarchar(100),
IsDeleted bit,
ListenerCount int,
ArtistId int references Artists(Id),
AlbumId int references Albums(Id)
)


Insert into Musics(Name,IsDeleted,ListenerCount,ArtistId,AlbumId) values('Without Me','false',100,1,1),('The Real SLim Shady','false',100,1,1),('Till I Collapse','false',200,1,1),('Godzilla','false',500,1,1),('Stan','false',300,1,1),('Darkness','false',1000,1,1)	,('Alfred','false',600,1,1),('No Regrets','false',700,1,1),('I Will','false',600,1,1)

create table Players(
Id int primary key identity,
ArtistId int references Artists(Id),
AlbumId int references Albums(Id),
MusicId int references Musics(Id)
)
Insert into Players(ArtistId,AlbumId,MusicId)values(1,1,4),(1,1,7),(1,1,9),(1,1,8),(1,1,6)
---------------Query1
create view GetMusicInfo
as
Select m.Name 'Music Name',art.Name 'Artist Name',a.Name 'AlbumName' from Musics as m
join Artists as art
on m.ArtistId=art.Id
join Albums as a
on m.AlbumId=a.Id
select * from GetMusicInfo
------------Query2
create view GetAlbumsInfo
as
select Albums.Name,Albums.MusicCount from Albums
select * from GetAlbumsInfo

------------Query3
create procedure GetAlbumInfoByName(@AlbumName nvarchar(100))
as
Select Name from Musics where AlbumId=(Select Id from Albums where Name=@AlbumName)
exec  GetAlbumInfoByName 'MusicToBeMurderedBy'
create procedure GetAlbumInfoByNamelistenerCount( @listenerCount int,@MusicsName nvarchar(100))
as
Select * from Albums
where Name=@MusicsName And ListenerCount>@listenerCount
exec  GetAlbumInfoByListenerCountAndMusicsName 700,'Darkness'

------------Query4
create procedure MusicIsDeleted 
as
Delete from Musics where IsDeleted='true'
exec MusicIsDeleted


