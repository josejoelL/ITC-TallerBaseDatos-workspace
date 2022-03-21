use Northwind

-- declaracion de variable 
declare @nom_variable tipo_dato

-- tipo_dato : son tipos de datos valido en sql server:
bit, int, numeric, char, varchar, datetime, etc.

-- asignacion de variable
select @nom_variable=valor
set @nom_variable=valor

-- los valores de cadena de caracteres y fecha llevan comillas para su asignacion
select @nacimiento= '01-01-2007'
select @nombre='juan perez'

-- los valores numericos se asignacion de manera normal
select @x = 12.1

-- impresion
print @nom_variable
select @nom_variable

-- ejemplo
declare @total numeric(7,3)
select @total
select @total=9999.000
select @total
select @total=count(*) from Employees
select @total
GO

--ejemplo
declare @total numeric(12,2),@min int
select @total=count(*),@min=min(employeeid)from Employees
select @total

--
--
--
--

-- variables de sistema
-- son variables que utiliza sql server para administrar recursos.
-- modificar, solamente leer o imprimir
select @@version :contiene la version de sql server
select @@FETCH_STATUS : se utiliza en cursores, indica la posicion del cursor
select @@error : administra el tipo de error que ha ocurrido
select @@CONNECTIONS : indica el numero de conexiones activas
select @@ROWCOUNT : indica los renglones afectados por una instruccion insert/update/delete
select @@identity : indica el ultimo valor obtenido en una tabla con la propiedad identity

--control de flujo
-- bloque: determina una unidad de trabajo en sql server
begin
sentencia 1
sentencia 2
end
-- sentencia if: se utiliza para ejecutar una condicion
if(condicion)
begin
sentencia 1
sentencia 2
end
else
begin
sentecia3
sentencia4
end
GO
--imprimir el precio del producto mas caro y especificar si es mayor a 30
--pesos o no
declare @precio numeric(12,2)
select @precio = max(unitprice) from products

if @precio > 30
print 'el precio maximo es mayor a 30= '+convert(varchar(10), @precio)
else
print 'el precio maximo es mayor a 30= '+convert(varchar(10), @precio)
GO
--instruccion if exists(consulta): se utiliza para consultar y verificar la existencia de registros

-- verificar si existe el producto 1000
if exists(select * from Products where ProductID=1)
print 'si existe el producto 1000'
else
print 'no existe el producto 1000'

--sentencia while
while(condicion)
begin
sentencia1
sentencia2
end
GO
--recorrer la tabla productos e imprimir la clave de todos los productos
declare @min int
select @min = min(productid) from products

while @min is not null
begin
select @min

select @min = min(productid) from products where productid > @min
end
select'fin del ciclo'

GO

-- ciclo que imprima la clave del empleado (de mayor a menor) y clave de su jefe
declare @emp int, @jefe int
select @emp = max(EmployeeID) from Employees

 

while @emp is not null
    begin
    select @jefe = ReportsTo from Employees where EmployeeID = @emp
    print str(@emp) + ' ,' + str(coalesce(@jefe,''))
    select @emp= MAX(EmployeeID) from Employees where EmployeeID < @emp
    end
print 'fin del ciclo'
GO

--capturar fecha de nacimiento, y mediante un proceso calcule los cumpleaños
-- y el dia de la semana que se festejo. spAniversarioDiaSemana.jpg
declare @fecha datetime, @dia varchar(50)
create table #T(fecha datetime, dia varchar(50))
select @fecha = '1-1-2000'
while @fecha <= GETDATE()
begin
select @dia = DATENAME(DW, @fecha)
insert #T values(@fecha,@dia)
select @fecha = DATEADD(YY,1,@fecha)
end
select * from #T
drop table #T
GO

--mostrar los dias trabajados de una persona
declare @fecha datetime, @conta int = 0, @dia int
select @fecha = '1-1-2000'
while @fecha <= GETDATE()
    begin
    select @dia = DATEPART(DW,@fecha)
    if not @dia in (1,7)
        select @conta = @conta+1
    select @fecha=dateadd(dd,1,@fecha)
end
select trabajos = @conta, datediff(dd, '1-1-2000', getdate())
GO

--mostrar los dias trabajados de todos
declare @min int, @fecha datetime, @conta int, @dia int
create table #tabla(emp int, dias int)

 

select @min = min(EmployeeID) from Employees
while @min is not null
begin
    select @fecha = hiredate from Employees where EmployeeID = @min
    select @conta = 0
    
    while @fecha <= getdate()
        begin
            select @dia = DATEPART(dw, @fecha)
            if @dia not in(1,7)
                select @conta = @conta +1
            select @fecha = dateadd(dd,1,@fecha)
        end
        insert #tabla values(@min, @conta)
        select @min = min(EmployeeID) from Employees where EmployeeID>@min
end
select * from #tabla
print 'fin del ciclo'
select nombre=e.FirstName+' '+e.LastName, trabajados=t.dias,
datediff(dd,hiredate,getdate())
from #tabla T
inner join employees e on e.EmployeeID=t.emp
GO
--proporcionar la fecha de nacimiento y dar la edad exacta
declare @edad int, @emp int, @fecha datetime
select @fecha = '1-12-2000'
select @edad = datediff(yy, @fecha, getdate())
select @fecha = dateadd(yy, @edad, @fecha)
if @fecha>getdate()
    select @edad = @edad-1
select @edad
GO
drop table #tabla
-- tabla con el nombre del empleado y la edad exacta de los empleados --spEdadExacta.jpg
declare @emp int, @edad int, @fecha datetime
create table #tabla(emp int, edad int)

select @emp=min(EmployeeID) from Employees
while @emp is not null
begin
select @fecha=BirthDate from Employees where EmployeeID=@emp
select @edad =DATEDIFF(yy,@fecha,GETDATE())
select @fecha =DATEadd(yy,@edad,@fecha)
if @fecha>GETDATE()
select @edad=@edad-1

insert #tabla values(@emp, @edad)
select @emp=MIN(EmployeeID) from Employees where EmployeeID>@emp
end
print 'fin del ciclo'
select e.firstname+' '+e.LastName, e.BirthDate, t.edad, DATEDIFF(yy,e.BirthDate,GETDATE())
from #tabla t
inner join Employees e on e.EmployeeID=t.emp

GO

-- 
declare @emp int, @dia int, @conta int, @fecha datetime, @texto varchar(200), @año int
create table #table(emp int, texto varchar(200), años int)

select @emp=min(employeeid) from Employees
while @emp is not null
begin
select @fecha= BirthDate from Employees where EmployeeID=@emp
select @conta=0
select @texto=''

while @fecha<=GETDATE()
begin
select @año=YEAR(@fecha)
if @año%4=0
begin
select @conta=@conta+1
select @texto=@texto+','+convert(varchar(4),@año)
end
select @fecha=dateadd(yy,1,@fecha)
end
insert #table values(@emp,@texto,@conta)
select @emp=min(EmployeeID) from Employees where EmployeeID>@emp
end
print 'fin ciclo'
select*from #table
GO

-- trabajo
declare @clave int, @importe numeric, @productos varchar(300), @pro int
create table #tablap(clave int, importe numeric, productos varchar(300))

select @clave = min(OrderID) from [Order Details]
while @clave is not null
begin
select @productos=''
select @importe = sum(Quantity*UnitPrice) from [Order Details] where OrderID=@clave
select @pro= min(ProductID) from [Order Details] where orderid=@clave
while @pro is not null
begin
select @productos = @productos +
isnull((select ProductName from Products p 
inner join [Order Details] o on o.ProductID=p.ProductID 
where o.ProductID=@pro and o.OrderID=@clave)+', ' , '')


select @pro=min(productid) from Products where @pro<ProductID
end
insert #tablap values(@clave, @importe, @productos)
select @clave=min(orderid) from [Order Details] where @clave<OrderID
end

select * from #tablap
GO

drop table #tablap
GO

-- EXEC
-- creacion
create proc[edure]nombre_proc
@parameter tipoDato [=default][output]
[with {recompile| encryption| recompile, encryption}]
as
sentencia_SQL

-- modificacion
alter proc nombre_proc as
sentencia_select

-- eliminacion
drop proc nombre_proc

--ejecucion
[execute] nom_proc lista_paramentros

--para ejecutar instrucciones dinamicas
exec[ute] ('instruccion_SQL'/nombre_variable)
GO

-- ejecutar una consulta mediante una cadena de caracteres,
-- debe ejecutar una sentencia select
declare @nom char(50)
select @nom='customers'
exec ('select*from '+@nom)
GO

-- esto no es valido
declare @nom char(50)
select @nom='products'
select 'select*from '+@nom
GO

-- sentencia raiserror: se utiliza para mandar mensajes de error a una aplicacion
-- o una ventana de resultados
raiserror('mensaje',severidad, estado)
--ejemplo
insert products values('casa',3)

if @@ERROR<>0
 raiserror('error al insertar en la tabla', 16, 1)


--begin try
begin try
declare @valor1 numeric(9,2), @valor2 numeric(9,2), @division numeric(9,2)
set @valor1=100
set @valor2=0
set @division=@valor1/@valor2
print 'la division no reporta error'
end try
begin catch
select @@error, ERROR_NUMBER() as 'N de error', ERROR_SEVERITY() as 'severidad',
ERROR_STATE() as 'estado', ERROR_PROCEDURE() as 'procedimiento',
ERROR_LINE() as 'N linea', ERROR_MESSAGE() as 'mensaje'
end catch
GO

--tipos de procedimiento almacenados:
--1- proc alm que regresa una consulta
--2- sin parametros
--3- con parametros de entrada
--4- con parametros de salida
--5- por valor por retorno
--6- con valores predefinidos

--1- proc alm que regresa una consulta

--sp que reciba la clave de un empleado y regrese las ordenes realizadas
create proc sp_regreso @emp int as
select OrderID, OrderDate from Orders where EmployeeID=@emp

-- ejecucion
exec sp_regreso 2

-- creamos una table temporal para insertar el resultado de una columna
create table #RES(folio int, fecha datetime)

-- ejecutamos el proc y se inserta automaticamente en la tabla #RES
insert #RES
exec sp_regreso 2

--verificamos el contenido de la tabla
select * from #RES

insert #RES
select OrderID, OrderDate from Orders where EmployeeID=1
GO

--
--mostrar los dias trabajados de todos
create proc sp_diastrabajos as
declare @emp int, @fecha datetime, @conta int, @dia int
create table #tabla(emp int, dias int)

 

select @emp = min(EmployeeID) from Employees
while @emp is not null
begin
    select @fecha = hiredate from Employees where EmployeeID = @emp
    select @conta = 0
    
    while @fecha <= getdate()
        begin
            select @dia = DATEPART(dw, @fecha)
            if @dia not in(1,7)
                select @conta = @conta +1
            select @fecha = dateadd(dd,1,@fecha)
        end
        insert #tabla values(@emp, @conta)
        select @emp = min(EmployeeID) from Employees where EmployeeID>@emp
end
select nombre=e.FirstName+' '+e.LastName, trabajados=t.dias,
datediff(dd,hiredate,getdate())
from #tabla T
inner join employees e on e.EmployeeID=t.emp

-- ejecucion
exec sp_diastrabajos
GO

--2- sin parametros
-- procedimiento que actiualice el precio de todos los productos y aumente el 10%
create proc sp_aumento as
update Products set UnitPrice=UnitPrice*1.1

-- ejecucion
exec sp_aumento
-- validar el producto 1
select*from Products where ProductID=1
GO

--3- sp con parametros de entrada

--sp que reciba 4 calificaciones imprimir el promedio
create proc sp_calificaciones
@cal1 int,@cal2 int,@cal3 int,@cal4 int as
declare @prom numeric(12,2)

select @prom=(@cal1+@cal2+@cal3+@cal4)/4

select @prom

-- ejecucion
exec sp_calificaciones 34,56,79,80
-- se puede cambiar el orden de los parametros indicando el nombre antes del valor
exec sp_calificaciones @cal2=56, @cal3=79, @cal4=80, @cal1=34
GO

--4- con parametros de salida

-- sp que reciba 4 calificaciones y regrese el promedio y si fue aprobado.
create proc sp_calificaciones_sal
@cal1 int, @cal2 int, @cal3 int, @cal4 int,
@prom numeric(12,3) output, @tipo char(20) output as

select @prom=(@cal1+@cal2+@cal3+@cal4)/4.0

if @prom>=70
select @tipo='aprobado'
else
select @tipo='reprobado'

--ejecutarlo
declare @a numeric(12,3), @b char(20)
select @a, @b
exec sp_calificaciones_sal 70,80,60,70, @a output, @b output
select @a, @b

GO

-- sp que reciba la clave del empleado y regrese por parametros de salida los años bisiestos
--vividos

create proc sp_años @emp int, @años varchar(200) output as
declare @nacimiento int

select @nacimiento=year(birthdate) from employees where EmployeeID=@emp
select @años=''

while @nacimiento <= year(getdate())
begin
if(@nacimiento%4)<=0
begin
select @años= @años+ convert(varchar(8), @nacimiento)+', '
end
select @nacimiento=@nacimiento+1
end
GO
-- ejecucion
declare @r varchar(200)
exec sp_años 1, @r output
select @r
GO

-- sp que regresa una tabla con el nombre del empleado y los años bisiestos vividos
create proc sp_empleados_años as
create table #emp(emp int, años varchar(200))
declare @emp int, @r varchar(200)

select @emp = min(employeeid) from employees
while @emp is not null
begin
select @r=''
exec sp_años @emp, @r output
insert #emp values(@emp, @r)
select @emp = min(EmployeeID) from Employees where EmployeeID>@emp
end

select nombre=x.firstname + '' + x.lastname, e.años
from #emp e
inner join Employees x on x.EmployeeID=e.emp
GO
--ejecucion
exec sp_empleados_años
GO

-- sp que reciba la fecha de nacimiento y regrese por parametros de salida la edad exacta
create proc sp_edad @fecha datetime, @edad int output as

select @edad=datediff(yy, @fecha, getdate())
select @fecha=dateadd(yy, @edad, @fecha)
if @fecha>getdate()
select @edad=@edad-1
GO
--ejecucion
declare @r int
exec sp_edad '12-31-2000', @r output
select @r
GO

-- sp que imprima una tabla con el nombre del empleado y edad exacta
create proc sp_edad_todos as
declare @emp int, @edadexacta int, @edaddif int, @fechanac datetime
create table #aux (emp int, edadexacta int)

select @emp=min(EmployeeID) from Employees
while @emp is not null
begin
select @fechanac = BirthDate from Employees where EmployeeID=@emp
exec sp_edad @fechanac, @edadexacta output
insert into #aux values(@emp, @edadexacta)
select @emp=min(EmployeeID) from Employees where EmployeeID>@emp
end

select nombre=e.firstname+''+e.lastname, a.edadexacta, nomal=datediff(yy, e.birthdate, getdate())
from #aux a
inner join Employees e on e.EmployeeID=a.emp
-- ejecucion
exec sp_edad_todos
GO

--sp que reciba la fecha de nac y regrese por retorno la edad exacta
create proc sp_edad @fecha datetime as
declare @edad int

select @edad=datediff(yy, @fecha, getdate())
select @fecha=dateadd(yy, @edad, @fecha)
if @fecha > getdate()
select @edad = @edad-1

return @edad
GO
--ejecucion
declare @r int
exec @r=sp_edad '12-1-2000'
select @r
GO

-- sp que reciba la fecha de nac y regrese por retorno la edad exacta con tabla
create proc sp_edad_todos as
declare @emp int, @edadexacta int, @edaddif int, @fechanac datetime
create table #aux (emp int, edadexacta int, edaddif int)

select @emp=min(EmployeeID) from Employees
while @emp is not null
begin
select @fechanac = BirthDate from Employees where EmployeeID=@emp
exec @edadexacta=sp_edad @fechanac
select @edaddif=datediff(yy, @fechanac, getdate())
insert into #aux values(@emp, @edadexacta, @edaddif)
select @emp=min(EmployeeID) from Employees where EmployeeID>@emp
end

select e.firstname, a.edadexacta, a.edaddif, e.birthdate
from #aux a
inner join Employees e on e.EmployeeID=a.emp
-- ejecucion
exec sp_edad_todos
GO

-- proceso jefe superior
declare @emp int, @jefe int, @temp int, @nivel int
select @emp = 9
select @nivel=0
select @jefe=reportsto from Employees where EmployeeID=@emp
while @jefe is not null
begin
select @nivel=@nivel+1
select @jefe=reportsto from Employees where EmployeeID=@jefe
end

select emp=@emp, nivel=@nivel
GO

-- sp que reciba la clave de un empleado y regrese como parametro de salida
-- el nivel y los jefes superiores
create proc sp_jefes_niveles @emp int, @nivel int output, @todos varchar(500) output as
declare @jefe int

select @nivel=0
select @todos=''
select @jefe=ReportsTo from Employees where EmployeeID=@emp
while @jefe is not null
begin
select @nivel=@nivel+1
select @todos=@todos+ firstname+''+lastname+', ' from Employees where EmployeeID=@jefe
select @jefe=ReportsTo from Employees where EmployeeID=@jefe
end
GO

declare @R1 int, @R2 varchar(500)
exec sp_jefes_niveles 7, @R1 output, @R2 output
select @R1, @R2
GO

-- sp_nivel y jefe superior
create proc sp_jefesuperior @emp int, @jefesup int output, @nivel int output as
declare @aux int
select @nivel=0
select @jefesup=ReportsTo from Employees where EmployeeID=@emp
while @jefesup is not null
begin 
select @aux=@jefesup
select @nivel=@nivel+1
select @jefesup=ReportsTo from Employees where EmployeeID=@jefesup
end
select @jefesup=@aux
GO
--ejecucion
declare @a int, @b int
exec sp_jefesuperior 1, @a output, @b output
select sup=@a, nivel=@b
GO

--sp que regrese una tabla con el nombre del empleado, el nombre de su jefe superior y el nivel
create proc sp_repotejefes as
declare @emp int, @a int, @b int
create table #T (emp int, jefe int, nivel int)
select @emp=min(EmployeeID) from Employees
while @emp is not null
begin
exec sp_jefesuperior @emp, @a output, @b output
insert #T values(@emp,@a,@b)
select @emp=min(EmployeeID) from Employees where EmployeeID>@emp
end

select empleado=e.FirstName+''+e.lastname, jefesup=j.FirstName+''+j.lastname,a.nivel
from #T a
inner join Employees e on e.EmployeeID=a.emp
left outer join Employees j on j.EmployeeID=a.jefe
order by nivel
GO
-- ejecucion
exec sp_repotejefes
GO

----sp recursivo, recibe la clave del empleado y regresa la clave de su jefe superiror
create proc sp_jefe_rec( @emp int, @jefe int output) as
begin
	select @jefe = ReportsTo from Employees where EmployeeID = @emp
	if @jefe is null
		select @jefe = @emp
	else
		exec sp_jefe_rec @jefe, @jefe output
end
go
--
declare @r int
exec sp_jefe_rec 9, @r output
select jefesup=@r
GO

--sp recursivo, recibe la clave del empleado y regresar los nombres de todos sus jefes
create proc sp_jefe_nom( @emp int, @nomjefe varchar(1000) output) as
begin
	declare @jefe int
	if @nomjefe is null
		select @nomjefe = ''
	select @jefe = ReportsTo from Employees where EmployeeID = @emp
	if @jefe is not null
	begin
		select @nomjefe = @nomjefe + ', ' + FirstName + ' ' + LastName from Employees where EmployeeID = @jefe
		exec sp_jefe_nom @jefe, @nomjefe output
	end
end
go
--ejecucion
declare @R varchar(1000)
exec sp_jefe_nom 9, @R output
select @R

--Diccionario de datos
-- es la referencia con la que cuenta el servidor para guardar la estructura de las
-- tablas, vistas y sp. Esta informacion esta contenida en tablas de sistema, las cuales
--guardan la informacion de las tablas de usuario

--Tablas de sistema
--Tabla SYSOBJECTS
select * from sysobjects
select * from INFORMATION_SCHEMA.TABLES
xtype:
u: tablas
p: sp
v: vistas

--tabla de usuario de la base de datos
select id, name, xtype
from sysobjects where xtype = 'u'
and name not like 'sys%' and name not like 'MS%'
order by id

--funciones utilizadas
object_id('Nombre de la tabla')
--funcion que recibe el nombre de un objeto y regresar el identificador de dicho objeto
select object_id('categories')

object_name(identificador)
--funcion que recibe el identificador de un objeto y regresa el nombre de dicho objeto
select OBJECT_NAME(645577338)

--Tabla SYSCOLUMNS
--contiene el nombre de columnas de tablas y vistas tambien
--el nombre de los parametros de los procedimientos almacenados
select id, colid, colorder,name, xtype, prec,scale, isnullable
from SYSCOLUMNS where OBJECT_ID('Products') = id

select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME like 'products'

--Tabla SYSTYPES:
--contiene los tipos de datos ascociados a columnas 
-- de tablas y vistas, tambien incluyen los tipos de datos asociados a los parametros de los proc alm
select xtype, name from systypes

--columnas y tipos de datos
select C.colorder, C.name, tipo = T.name, C.prec, C.scale, isnullable 
from SYSCOLUMNS C
inner join SYSTYPES T on C.xtype = T.xtype
where C.id = OBJECT_ID('prueba') and T.name not like 'sysname'
order by C.colorder
GO

create table prueba(clave int, nombre varchar(50), precio numeric(8,2), importe decimal(10,4))

--no es de northwind
sp_columnas_select usuarios, 'u'
sp_codigo_sql ventanillas
sp_codigo_asp ventanillas

create proc sp_Mttoventanillas
@ventanilla int output,
@usuario char(32),
@nomven char(100),
@tipo char(1),
@status char(1),
@grupo int
as
begin
if exists(select*from ventanilla where ventanilla=@ventanilla)
begin
update ventanillas set
ventanilla=@ventanilla,
usuario=@usuario,
nomven=@nomven,
tipo=@tipo,
status=@status,
grupo=@grupo
where
ventanilla=@ventanilla

select
v.ventanilla, v.usuario, v.nomven, v.tipo, v.status, v.grupo,
u.usuario, u.ventanilla, u.nombre, u.apepat, u.apemat, u.status, u.password,
u.titulo, u.cambiarfecha, u.tipo
from usuarios u
inner join ventanillas v on v.usuario=u.usuario
GO
--- hasta aqui
--proc al que reciba el nombre de una tabla y regrese el select completo con el nombre de todos los campos
select colid, name from syscolumns where OBJECT_ID('products') = id
GO
alter proc sp_columnas @tabla nvarchar(100) as
declare @texto varchar(2000), @alias varchar(2), @min int, @columna varchar(50)

select @alias=substring(@tabla,1,1)
select @texto='Select '

select @min = MIN(colid) from syscolumns where OBJECT_ID(@tabla) = id
while @min is not null
begin
select @columna=name from syscolumns where OBJECT_ID(@tabla)=id and @min=colid
select @texto= @texto+@alias+'.'+@columna+','
select @min= min(colid) from syscolumns where object_id(@tabla) = id and colid>@min
end
select @texto = SUBSTRING(@texto,1,LEN(@texto)-1)
select @texto = @texto + ' from ' + @tabla + ' ' + @alias
select @texto
go

--ejecucion
sp_columnas 'territories'
GO

-- sp que reciba el nombre de una tabla y que imprima el codigo para crear esa tabla,
-- con diagrama de flujo.
select c.colid, c.name, tipo=t.name, c.prec, c.scale, isnullable
from syscolumns c
inner join systypes t on c.xtype=t.xtype
where c.id=OBJECT_ID('products') and t.name not like 'sysname'
order by c.colorder

select c.colid, c.colorder,c.name, c.prec, c.scale, isnullable
from syscolumns c
where c.id=OBJECT_ID('products')
GO

alter proc sp_tabla @tabla nvarchar(100) as
declare @texto nvarchar(2000), @min int, @columna varchar(50)
declare @tipo varchar(100), @prec int, @scale int, @null int, @nulltext varchar(50)

select @texto='create table '+ @tabla+'('+char(13)
select @min=min(colid) from syscolumns where OBJECT_ID(@tabla)=id
while @min is not null
begin
select @columna=c.name, @tipo=t.name, @prec=c.prec, @scale=c.scale, @null= isnullable
from syscolumns c
inner join systypes t on c.xtype=t.xtype
where c.id=OBJECT_ID(@tabla) and t.name not like 'sysname' and c.colid=@min
order by c.colorder
if @tipo in('char', 'varchar', 'nchar', 'nvarchar')
select @tipo=@tipo+'('+convert(varchar(10),@prec)+')'

if @tipo in('decimal', 'numeric')
select @tipo=@tipo+'('+convert(varchar(10),@prec)+','+convert(varchar(10),@scale)+')'

if @null=0
select @nulltext=' not null'
else
select @nulltext=' null'

select @texto=@texto+@columna+' '+@tipo+@nulltext+','+char(13)
select @min=min(colid) from syscolumns where OBJECT_ID(@tabla)=id and colid>@min
end

select @texto= SUBSTRING(@texto,1,len(@texto)-2)+')'
print @texto
GO
-- ejecucion
sp_tabla 'order details'
GO

-- tabla sysforeignkey
-- contiene informacion referente a las llaves externas de las tablas, contenido informacion de las tablas que participan
constid: clave de la restriccion
rkeyid: clave de la tabla padre
fkeyid: clave de la tabla hijo
fkey: clave de la columna que interviene en la llave externa

select nombreFK=constid, Padre=rkeyid, Hijo=fkeyid from sysforeignkeys

select
nombreFK= OBJECT_NAME(constid),
padre= OBJECT_NAME(rkeyid),
hijo= OBJECT_NAME(fkeyid)
from sysforeignkeys

--restricciones donde products es hijo
select
nombreFK= OBJECT_NAME(constid),
padre= OBJECT_NAME(rkeyid),
hijo= OBJECT_NAME(fkeyid), fkey, rkey
from sysforeignkeys
where fkeyid=OBJECT_id('products')

--restricciones donde products es padre
select
nombreFK= OBJECT_NAME(constid),
padre= OBJECT_NAME(rkeyid),
hijo= OBJECT_NAME(fkeyid), fkey, rkey
from sysforeignkeys
where rkeyid=OBJECT_id('products')
GO

create proc sp_orden as
declare @cont int, @nom varchar(50), @min int, @min2 int
create table #tablax (clave int identity, id bigint, nombre varchar(50), orden int )

create table #repetidos(id int,  nombre varchar(200))
insert into #repetidos
select rkeyid, OBJECT_NAME(rkeyid) from sysforeignkeys group by rkeyid having COUNT(rkeyid) > 1
select * from #repetidos

insert #tablax
select id, name, 0 f
from sysobjects where id not in(select rkeyid from sysforeignkeys)
and xtype='u'
and name not like 'sys%' and name not like 'ms%'
select * from #tablax


insert #tablax
select rkeyid, padre=object_name(rkeyid),1
from sysforeignkeys
where object_name(fkeyid) in (select object_name(id) from #tablax) and object_name(rkeyid) not in (select object_name(id) from #tablax) 
and object_name(rkeyid) not in  (select object_name(id) from #repetidos)



select * from sysforeignkeys

--sp_orden
drop table #tablax
exec sp_orden

--sp que borre automaticamente todas las tablas 
select @texto='delete from ' + @tabla
exec(@texto)

GO

