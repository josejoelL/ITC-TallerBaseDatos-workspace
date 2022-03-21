create database DB1
create database DB2
--Tablas de DB1
use DB1
create table clientes(
cte int not null primary key, 
nombre varchar(50), 
domicilio varchar (100))
create table Empleados
(emp int not null primary key, 
nombre varchar(50), 
domicilio varchar(50), 
teléfono char(10))
create table Ventas(
folio int not null primary key, 
fecha date, 
cte int foreign key references clientes(cte), 
emp int foreign key references Empleados(emp)
)
--Tablas de DB2
use DB2

create table Categorias(
cat int not null primary key, 
nombre varchar(50))
create table Productos(
prod int not null primary key, 
nombre varchar(50), 
cat int foreign key references Categorias(cat), 
precio numeric(7,2))
create table Ventas(
folio int not null primary key, 
fecha date, 
prod int foreign key references Productos(prod), 
cantidad int, 
precio numeric(7,2))
-- 1.- Dar de alta al IS ALMA pueda apagar el servidor con el comando SHUTDOWN.
create login Alma with password='123'
must_change, check_expiration=on
use master
grant shutdown to Alma
-- 2.- Dar de alta al IS JUAN para que pueda auxiliar en la administración de inicios de sesión, que pueda dar de alta inicios de sesión y cambiar password.
create login Juan with password='123'
must_change, check_expiration=on
use master
sp_addSRVRoleMember Juan, securityadmin
-- 3.- Dar de alta al IS JOSE y configurarlo para que tenga las mismas características que el inicio de sesión SA.
create login Jose with password='123'
must_change, check_expiration=on
sp_addSRVRoleMember Jose, SysAdmin
-- 4.- Dar de alta al IS ANA debe tener permiso de seleccionar y modificar todas las tablas de la BD1.
create login Ana with password='123'
must_change, check_expiration=on
use DB1
create user Ana
grant select to Ana
grant update to Ana
-- 5.- Dar de alta al IS PEDRO para que pueda seleccionar todas las tablas de las bases de datos BD1 y BD2.
create login Pedro with password='123'
must_change, check_expiration=on
Use DB1
create user Pedro
grant select to Pedro
grant update to Pedro
Use DB2
create user Pedro
grant select to Pedro
grant update to Pedro
-- 6.- Dar de alta al IS NORA Y PERLA para que puedan crear todos los objetos en BD1.
create login Nora with password='123'
must_change, check_expiration=on
create login Perla with password='123'
must_change, check_expiration=on
Use DB1
create user Nora
create user Perla
grant create table, create proc, create view to Nora
sp_addrolemember db_ddlAdmin, Perla
-- 7.- En la base de datos BD1 crear la función CONSULTA y darle permiso para que pueda seleccionar solo las 2 primeras columnas de cada tabla.
use DB1
sp_addrole CONSULTA
grant select on clientes(cte, nombre) to CONSULTA
grant select on Empleados (emp, nombre) to CONSULTA
grant select on Ventas(folio, fecha) to CONSULTA
-- 8.- A los IS NORA Y PERLA creados en el punto 6, agregarlos en la función CONSULTA de la base de datos BD1.
sp_addrolemember CONSULTA, Nora
sp_addrolemember CONSULTA, Perla
-- 9.- Dar de alta al IS CARLOS y que pueda insertar y eliminar datos en la BD2, además pueda crear vistas y tablas en la misma base de datos.
create login Carlos with password='123'
must_change, check_expiration=on
use DB2
create user Carlos
grant insert, delete, create view, create table to Carlos
-- 10.- Quitarle el acceso al servidor a JOSE.
alter login Jose disable