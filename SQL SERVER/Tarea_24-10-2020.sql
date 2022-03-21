use Northwind
-- 1) AGREGAR A LA TABLA CUSTOMERS EL CAMPO IMPORTETOTAL, EL CUAL REPRESENTARÁ EL IMPORTE TOTAL DE VENTAS QUE HA TENIDO ESE CLIENTE. 
--CREAR UN PROCEDIMIENTO ALMACENADO QUE LLENE DICHO CAMPO.
alter table Customers alter column ImporteTotal decimal(12,2)
go
create proc sp_totalCustomer as
create table #imp (customerid varchar(20), suma decimal(12,2))
declare @clave varchar(20)
insert #imp select C.CustomerID, sum(Quantity*UnitPrice) from [Order Details] OD 
	inner join Orders O on O.OrderID = OD.OrderID
	inner join Customers C on C.CustomerID = O.CustomerID
	group by C.CustomerID
	order by 1
select @clave = MIN(CustomerID) from Customers
while @clave is not null
begin
	update Customers set ImporteTotal = (select suma from #imp where @clave like customerid) where CustomerID = @clave
	select @clave = MIN(CustomerID) from Customers where CustomerID>@clave
end
go

-- ejecucion
exec sp_totalCustomer
select * from Customers
go
-- 2) PROCEDIMIENTO ALMACENADO QUE RECIBA DOS CLAVES DE CLIENTES Y UN AÑO, Y REGRESE DOS PARAMETRO DE SALIDA: EL NOMBRE DEL CLIENTE QUE MAS HA VENDIDO EN ESE AÑO Y EL IMPORTE TOTAL DE VENTAS.
create proc sp_ComparacionCliente @C1 varchar(20), @C2 varchar(20), @año int, @NomCliente varchar(100) output, @Importe decimal(12,2) output as
create table #imp (customerid varchar(20), nombre varchar(200), suma decimal(12,2))
insert #imp select C.CustomerID, C.CompanyName,sum(Quantity*UnitPrice) from [Order Details] OD 
	inner join Orders O on O.OrderID = OD.OrderID
	inner join Customers C on C.CustomerID = O.CustomerID
	where C.CustomerID in (@C1, @C2) and year(O.OrderDate) = 1998
	group by C.CustomerID, C.CompanyName
	order by 1
select @Importe = Max(suma) from #imp
select @NomCliente = nombre from #imp where @Importe = suma
go
--ejecucion{
declare @NomCliente varchar(100), @Importe decimal(12,2)
exec sp_ComparacionCliente 'ALFKI', 'ANATR', 1998, @NomCliente output, @Importe output
select Nombre = @NomCliente, ImporteAño = @Importe
go
-- 3) PROCEDIMIENTO ALMACENADO QUE RECIBA LA CLAVE DE JEFE Y REGRESE UNA TABLA CON EL NOMBRE DEL JEFE ENVIADO, EL NOMBRE DE LOS EMPLEADOS A SU CARGO.
create proc sp_EmpDeJefe @Jefe int as
create table #imp(Jefe varchar(100), Empleados varchar(500))
declare @Nombres varchar(500), @Padawanes int, @NomJefe varchar(100)
select @Padawanes = min(EmployeeID) from Employees where ReportsTo = @Jefe
select @Nombres = ''
while @Padawanes is not null 
begin
	select @Nombres = @Nombres + (select FirstName + ' ' +LastName from Employees where EmployeeID = @Padawanes) + ', '
	select @Padawanes = min(EmployeeID) from Employees where ReportsTo = @Jefe and @Padawanes<EmployeeID
end
select @Nombres = SUBSTRING(@Nombres, 1, len(@Nombres) - 2)
select @NomJefe = FirstName + ' ' + LastName from Employees where EmployeeID = @Jefe
insert #imp values(@NomJefe, @Nombres)
select * from #imp
go
--ejecucion
exec sp_EmpDeJefe 5
go
-- 4) PROCEDIMIENTO ALMACENADO QUE RECIBA LA CLAVE DE UN EMPLEADO, REGRESE EN UN PARAMETRO DE SALIDA LOS NOMBRES DE LOS CLIENTES QUE HA ATENDIDO.
alter proc sp_Atendidos @Emp int, @Nombres varchar(500) output as
declare @Cliente varchar(100)
select @Nombres = ''
select @Cliente = min(C.CustomerID) from [Order Details] OD
inner join Orders O on O.OrderID = OD.OrderID
inner join Customers C on C.CustomerID = O.CustomerID
where @Emp = o.EmployeeID
while @Cliente is not null
begin
	select @Nombres = @Nombres + (select CompanyName 
	from Customers
	where @Cliente = CustomerID) + ', '
	select @Cliente = min(C.CustomerID) from [Order Details] OD
	inner join Orders O on O.OrderID = OD.OrderID
	inner join Customers C on C.CustomerID = O.CustomerID
	where @Emp = o.EmployeeID and @Cliente<C.CustomerID
end
select @Nombres = SUBSTRING(@Nombres, 1, len(@Nombres) - 2)
go
--Ejecucion
declare @Nombres varchar(500)
exec sp_Atendidos 5, @Nombres output
select @Nombres
go
--5) FUNCION ESCALAR QUE RECIBA DOS CLAVES DE PROVEEDORES Y UN AÑO, Y REGRESE EL NOMBRE DEL PROVEEDOR QUE MAS HA VENDIDO PIEZAS DE LOS DOS EN ESE AÑO Y EL TOTAL DE PIEZAS VENDIDAS. 
--POR EJEMPLO, DEBE REGRESAR: JUAN PEREZ VENDIO 450 PIEZAS. 
create function dbo.Proveedores (@P1 int, @P2 int, @año int) 
returns varchar(100)
begin
declare @Nombre varchar(100), @Piezas int 
declare @imp table (Clave int, Nombre varchar(100), Piezas int)
insert @imp select P.SupplierID, S.ContactName, sum(OD.Quantity) 
from Products P
inner join Suppliers S on P.SupplierID = S.SupplierID
inner join [Order Details] OD on OD.ProductID = P.ProductID
inner join Orders O on O.OrderID = OD.OrderID
where P.SupplierID in (@P1, @P2) and @año = year(O.OrderDate)
group by P.SupplierID, S.ContactName
select @Piezas = max(Piezas) from @imp
select @Nombre = Nombre from @imp where Piezas = @Piezas
return @Nombre + ' ha vendido ' + cast(@Piezas as varchar) + ' piezas'
end
go
--ejeccucion
select Proveedor = dbo.Proveedores(1,2,1998)
go
-- 6) FUNCION DE TABLA EN LINEA QUE RECIBA EL AÑO Y REGRESE UNA TABLA CON EL NOMBRE DE TODOS LOS CLIENTES, EL IMPORTE DE VENTAS Y EL TOTAL DE ORDENES REALIZADAS ESE AÑO.
create function dbo.NomClientes (@año int)
returns table as
return (select C.CompanyName, Importe = sum(OD.Quantity * OD.UnitPrice), Ordenes = count(O.OrderID) 
from [Order Details] OD
inner join Orders O on O.OrderID = OD.OrderID
inner join Customers C on O.CustomerID = C.CustomerID
where year(O.OrderDate) = @año
group by C.CompanyName)
--Ejecucion
select * from dbo.NomClientes(1998)
--7) FUNCION DE TABLA EN LINEA QUE RECIBA LA CLAVE DEL EMPLEADO Y AÑO, REGRESE EN UNA CONSULTA EL NOMBRE DEL PRODUCTO Y TOTAL DE PRODUCTOS COMPRADOS POR ESE EMPLEADO Y ESE AÑO.
create function dbo.ComprasProductos (@Empleado int, @año int)
returns table as
return(select P.ProductName, Cantidad = sum(OD.Quantity)
from [Order Details] OD
inner join Orders O on O.OrderID = OD.OrderID
inner join Employees E on E.EmployeeID = O.EmployeeID
inner join Products P on P.ProductID = OD.ProductID
where @Empleado = E.EmployeeID and year(O.OrderDate) = @año
group by P.ProductName)
--Ejecucion
select * from dbo.ComprasProductos(5,1998)
--8) Mostrar el numero de productos vendidos por año, en los años 1996, 1997 y 1998 en una sola tabla
declare @Emp int
select @Emp = 5
select A.ProductName, A.Cantidad, B.Cantidad, C.Cantidad from dbo.ComprasProductos (@Emp, 1996) A
inner join dbo.ComprasProductos (@Emp, 1997) B on A.ProductName = B.ProductName
inner join dbo.ComprasProductos (@Emp, 1998) C on A.ProductName = C.ProductName
go
--9) FUNCION DE TABLA DE MULTISENTENCIA (NO LLEVA PARAMETROS DE ENTRADA) QUE REGRESE UNA TABLA CON EL NOMBRE DEL TERRITORIO Y LOS NOMBRES DE LOS EMPLEADOS QUE LO ATIENDEN.
alter function dbo.TerritoriosEmpleados ()
returns @T table (Territorios varchar(20), Empleados varchar(500)) as
begin
	declare @Territorio int,  @Nombres varchar(500), @Emp int, @NomTerritorio varchar(100)
	select @Territorio = min(TerritoryID) from Territories
	while @Territorio is not null
	begin
		select @Emp = min(EmployeeID) from EmployeeTerritories where @Territorio = TerritoryID 
		select @Nombres = ''
		while @Emp is not null
		begin
			select @Nombres = @Nombres +  (select FirstName + ' ' + LastName from Employees where @Emp = EmployeeID) + ', '
			select @Emp = min(EmployeeID) from EmployeeTerritories where @Territorio = TerritoryID and EmployeeID>@Emp
		end
		select @NomTerritorio = TerritoryDescription from Territories where TerritoryID = @Territorio
		insert @T values (@NomTerritorio, @Nombres)
		select @Territorio = min(TerritoryID) from Territories where TerritoryID > @Territorio
	end
	return
end
go
--Ejecucion
select * from dbo.TerritoriosEmpleados ()
--10) FUNCION DE TABLA DE MULTISENTENCIA (NO LLEVA PARAMETROS DE ENTRADA) QUE REGRESE UNA TABLA CON DOS COLUMNAS: LA FECHA Y LOS FOLIOS DE LAS ORDENES QUE SE REALIZARON ESA FECHA.
alter function dbo.FoliosPorFecha ()
returns @T table (Fecha date, Folio varchar(500)) as
begin
	declare @Fecha date, @Folios varchar(500), @Orden int
	select @Fecha = min(OrderDate) from Orders
	while @Fecha is not null
	begin
		select @Folios = ''
		select @Orden = min(OrderID) from Orders where @Fecha = OrderDate
		while @Orden is not null
		begin
			declare @NomFolio varchar(100) 
			select @NomFolio = OrderID from Orders where @Orden = OrderID
			select @Folios = @Folios + @NomFolio + ', '
			select @Orden = min(OrderID) from Orders where @Orden < OrderID and @Fecha = OrderDate
		end
		insert @T values (@Fecha, @Folios)
		select @Fecha = min(OrderDate) from Orders where @Fecha<OrderDate
	end
	return
end
go
--ejecucion
select * from dbo.FoliosPorFecha ()

select * from Orders