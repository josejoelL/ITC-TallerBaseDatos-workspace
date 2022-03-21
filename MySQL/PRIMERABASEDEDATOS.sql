CREATE DATABASE sisRes;
USE sisRes;

CREATE TABLE ARTICULO(
ARTID VARCHAR(8),
ARTNOM VARCHAR(30) NOT NULL,
ARTPRECIO NUMERIC(9)
);

CREATE TABLE CLIENTES(
CLIID VARCHAR(8) NOT NULL,
CLINOM VARCHAR(30) NOT NULL

);

CREATE TABLE FACTURAS(
SUCID NUMERIC(2),
NUMFAC NUMERIC(2),
FECHAPAGO TIMESTAMP,
FORMAPAGO VARCHAR(3),
CLIID VARCHAR(8) NOT NULL,
TOTALFACT NUMERIC(14,2)

);

CREATE TABLE DETALLE(
SUCID NUMERIC(2),
NUMFAC NUMERIC(2),
CLEID VARCHAR(8),
CANTART NUMERIC(8,3),
PRECIOUNITARIO NUMERIC(8,3),
SUBTOTALART NUMERIC (9,3)


);
## SI NO TENGO REGISTRO
DROP TABLE CLIENTES;
ALTER TABLE CLIENTES ADD CLEAP VARCHAR(30);


TRUNCATE CLIENTES;

ALTER TABLE CLIENTES
ADD CONSTRAINT CLEIDPK primary key (CLEID);

ALTER TABLE ARTICULO
ADD CONSTRAINT ARTIDPK primary key (ARTID);

ALTER TABLE FACTURA
ADD constraint CLEIDFK foreign key (CLEID) references CLIENTES (CLEID);

ALTER TABLE DETALLE
ADD constraint ARTIDFK foreign key (ARTID) references ARTICULO (ARTID);
##constraint para delimitar datos que se van a registrar 
alter table articulos
add constraint precioPk check (precio>0);

##nombre objeto 
rename table facturas to factura;
##vista 
create view vFactCliente01 as
select * from factura;

select * from vFactCliente01;
##indices
create index Ifactfecha01 on factura(fechaFact);

##crear usuario con la sentencia create

create user docGomez identified by "contraseña";
## creando un rol para usuarios 
create role opConsultas;
grant select on landeros to opConsultTas; ##tablas
drop role opConsultTas; ## booramos
grant select on landeros.articulo to docGomez ;##otorgamos priv de lectura 
revoke opConsultTas from docGomez;##eliminamos al usuario del rol
grant select on landeros to docGomez ;


