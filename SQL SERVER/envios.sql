create database envios

go

use envios

go

create table categorias(

catid int not null,

nombre varchar( 50) not null )

go

create table tamaños(

tamid int not null,

nombre varchar( 50) not null )

go

create table productos(

prodid int not null,

nombre varchar( 50) not null,

precio numeric(12,2) not null,

catid int not null,

tamid int not null )

create table municipios(

munid int not null,

nombre varchar( 50) not null )

go

create table clientes(

cliid int not null,

nombre varchar( 50) not null ,

apellidos varchar( 50 ) not null, 

munid int )

go

create table envios(

folio int not null,

fecha datetime not null,

cliid int not null )

go

create table detalle(

folio int not null,

prodid int not null,

cantidad numeric(12,2) not null,

precio numeric(12,2) not null,

pesounitario numeric(12,2) not null )

go

alter table categorias add constraint pk_categorias  primary key ( catid )

alter table productos add constraint pk_productos  primary key ( prodid )

alter table tamaños add constraint pk_tamaños  primary key ( tamid )

alter table municipios add constraint pk_municipios  primary key ( munid )

alter table clientes add constraint pk_clientes  primary key ( cliid )

alter table envios add constraint pk_envios  primary key ( folio )

alter table detalle add constraint pk_detalle primary key ( folio, prodid )

go

alter table productos add 

constraint fk_products_categorias foreign key ( catid) references categorias( catid ),

constraint fk_products_tamaños foreign key ( tamid ) references tamaños( tamid )

go

alter table clientes add 

constraint fk_clientes_municipios foreign key ( munid ) references municipios( munid ) 

go

alter table envios add 

constraint fk_envios_clientes foreign key ( cliid ) references clientes( cliid ) 

go

alter table detalle  add 

constraint fk_detalles_productos  foreign key ( prodid ) references productos( prodid ),

constraint fk_detalles_envios foreign key ( folio ) references envios( folio )

go

--views





create view vw_clientes as
select c.cliid, clienteNombre=c.nombre, clienteApellido=c.apellidos, m.munid, MunNombre=m.nombre
from clientes c
inner join municipios m on m.munid=c.munid
GO
create view vw_envios as
select e.folio,e.fecha, c.cliid,c.clienteNombre,c.clienteApellido,
c.munid,c.MunNombre
from envios e
inner join vw_clientes c on c.cliid=e.cliid
GO
create view vw_productos as
select p.prodid,prodNombre=p.nombre,p.precio,c.catid,NomCategoria=c.nombre,
t.tamid,tamaño=t.nombre
from productos p
inner join categorias c on c.catid=p.catid
inner join tamaños t on t.tamid=p.tamid
GO
create view vw_detalle as
select d.folio,d.prodid,d.cantidad,d.precio,d.pesounitario,e.fecha, e.cliid,e.clienteNombre,e.clienteApellido,
e.munid,e.MunNombre,p.prodNombre,p.catid,p.NomCategoria,
p.tamid,p.tamaño
from detalle d
inner join vw_envios e on e.folio=d.folio
inner join vw_productos p on p.prodid=d.prodid 
GO

--CONSULTA CON EL NOMBRE DEL TAMAÑO DEL PRODUCTO Y TOTAL DE PIEZAS QUE CONTIENE
select tamaño,[total de piezas]=count(distinct prodid)
from vw_productos
group by tamaño

--CONSULTA CON EL NOMBRE DEL CLIENTE, TOTAL ENVIOS REALIZADOS EN 2016, 2017 Y 2018. CADA AÑO EN UNA COLUMNA
select nombre_cliente=clienteNombre+''+clienteApellido,
año_2016 = sum(case when year(fecha) = 2016 then 1 else 0 end),
año_2017 = sum(case when year(fecha) = 2017 then 1 else 0 end),
año_2018 = sum(case when year(fecha) = 2018 then 1 else 0 end)
from vw_envios
group by clienteNombre,clienteApellido

-- CONSULTA CON EL NOMBRE DEL PRODUCTO, PESO TOTAL DE LOS ENVIOS. MOSTRAR SOLO LOS ENVIOS QUE TENGAN MAS 20 KG DE PESO.
select  prodNombre, peso=sum(distinct pesounitario)
from VW_Detalle
group by prodNombre
having sum(pesounitario)>20

-- CONSULTA CON EL AÑO E IMPORTE TOTAL DEL ENVIO. MOSTRAR SOLO EL PRIMER SEMESTRE DE LOS AÑOS Y QUE EL IMPORTE SEA MAYOR A 500 PESOS
select Año = year(fecha), total = sum(precio*cantidad)
from vw_detalle
where datepart(mm, fecha) < 7
group by year(fecha)
having sum(precio*cantidad) > 500

--CONSULTA CON EL NOMBRE MUNICIPIO Y TOTAL DE CLIENTES QUE VIVEN EN ESE MUNICIPIO
select MunNombre, clientes=count(distinct cliid)
from vw_clientes
group by MunNombre

--CONSULTA CON EL NOMBRE DE LA CATEGORIA, CANTIDAD DE PIEZAS ENVIADAS E IMPORTE TOTAL DEL ENVIO
select
NomCategoria, cantidad, total_de_importe=sum(precio*cantidad)
from vw_detalle
group by NomCategoria, cantidad

insert municipios values(1,'culiacan')
insert municipios values(2,'mazatlan')
insert municipios values(3,'guamuchil')

insert clientes values(1,'juan','santo',1)
insert clientes values(2,'manuel','ferrer',1)
insert clientes values(3,'juanito','banana',1)

insert envios values(1,'2016-10-10',1)
insert envios values(2,'2017-10-10',2)
insert envios values(3,'2017-11-11',3)
insert envios values(4,'2018-10-10',1)
insert envios values(5,'2018-11-10',1)
insert envios values(6,'2018-11-10',2)
insert envios values(7,'2018-06-06',2)

insert tamaños values(1,'chico')
insert tamaños values(2,'chicogrande')
insert tamaños values(3,'chicomediano')

insert categorias values(1,'sabritas')
insert categorias values(2,'galletas')
insert categorias values(3,'refrescos')

insert productos values(1,'rufles',1.00,1,3)
insert productos values(2,'tostitos',2.50,1,3)
insert productos values(3,'choquis',3.00,2,1)
insert productos values(4,'fanta',4.00,3,2)

insert detalle values(1,1,2,1.00,1.00)
insert detalle values(2,2,4,2.50,1.50)
insert detalle values(3,3,1,3.00,2.00)
insert detalle values(4,3,4,3.00,1.50)
insert detalle values(5,3,4,3.00,20.50)
insert detalle values(6,3,4,400.00,20.50)
insert detalle values(7,3,4,400.00,20.50)

