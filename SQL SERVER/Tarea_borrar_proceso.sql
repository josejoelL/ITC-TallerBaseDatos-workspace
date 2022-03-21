use NORTHWIND
-- Equipo:
-- <Gamez Sanchez Angel Edgardo>
-- <Guzman Gomez Jesus Ernesto>
-- Taller de base de datos (17:00 - 18:00)
create proc sp_orden as
create table #tablax (clave int identity, id bigint, nombre varchar(50), orden int )
create table #repetidos(id int,  nombre varchar(200), c int)

insert into #repetidos
select rkeyid, OBJECT_NAME(rkeyid), COUNT(rkeyid) from sysforeignkeys where rkeyid != fkeyid group by rkeyid having COUNT(rkeyid) > 1

insert #tablax
select id, name, 0 f
from sysobjects where id not in(select rkeyid from sysforeignkeys)
and xtype='u'
and name not like 'sys%' and name not like 'ms%'
 
declare @c int, @count int
select @c = MIN(clave) from #tablax
select @count = 1
while @c is not null
begin
	insert #tablax
	select rkeyid, padre=object_name(rkeyid), @count
	from sysforeignkeys
	where object_name(fkeyid) in (select object_name(id) from #tablax) and object_name(rkeyid) not in (select object_name(id) from #tablax) 
	and object_name(rkeyid) not in  (select object_name(id) from #repetidos)
	select @c = MIN(id) from #tablax where @c<id
	select @count = @count + 1
end
create table #hijosP (id int, idN varchar(200), padre int, padreN varchar(200), orden int)
insert into #hijosP select T.id, OBJECT_NAME(T.id), S.rkeyid, OBJECT_NAME(S.rkeyid), T.orden from #tablax T inner join sysforeignkeys S on T.id = S.fkeyid inner join #repetidos R on R.id = S.rkeyid
create table #R (id int, orden int)
select @c = MIN(padre) from #hijosP
while @c is not null
begin
	insert #R select padre, MAX(orden) from #hijosP where @c = padre group by padre
	select @c = MIN(padre) from #hijosP where padre>@c
end
insert into #tablax select id, OBJECT_NAME(id), orden+1 from #R
drop table #hijosP
drop table #R
drop table #repetidos

select * from #tablax
go

create proc sp_borrartablas as
create table #tablas (clave int, id int, nombre varchar(200), orden int) 
insert into #tablas exec sp_orden
declare @clave int, @texto varchar(200), @nombre varchar(200)
select @clave = min(clave) from #tablas
while @clave is not null
begin
	
	select @nombre = nombre from #tablas where clave = @clave
	select @texto = 'drop table [' + @nombre + ']'
	exec(@texto) 
	select @clave = min(clave) from #tablas where clave > @clave
end
select * from #tablas
drop table #tablas
go

exec sp_borrartablas

-- verificar que se hayan realizado la eliminación de registros
     Select * from region
     select * from [order details]
     select * from suppliers