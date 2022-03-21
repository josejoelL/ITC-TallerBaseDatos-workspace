CREATE DATABASE RentaPeliculas;
USE RentaPeliculas;

CREATE TABLE catClientes(
cleID VARCHAR(8)NOT NULL,
cleNom VARCHAR(30),
cleAp VARCHAR(30),
cleAm VARCHAR(30),
cleCalle VARCHAR(30),
cleCol VARCHAR(30),
cleCiudad VARCHAR(30),
cleCP VARCHAR(8),
cleNumExt VARCHAR(4),
cleRFC VARCHAR(12),
cleSex VARCHAR(1),
cleEdad VARCHAR(3),
CleFechaNac datetime,
cleCorreo VARCHAR(30),
cleTel varchar (8),
metID VARCHAR(8)
);

ALTER TABLE catClientes modify cleTel varchar (10);

CREATE TABLE catEmpleado(
empID VARCHAR(8)NOT NULL,
empNom VARCHAR(30),
empAp VARCHAR(30),
empAm VARCHAR(30),
empCalle VARCHAR(30),
empCol VARCHAR(30),
empCiudad VARCHAR(30),
empCP VARCHAR(8),
empNumExt VARCHAR(4),
empRFC VARCHAR(12),
empSex VARCHAR(1),
empEdad VARCHAR(2),
empFechaNac datetime,
empCorreo VARCHAR(30),
empTel varchar (8)
);
ALTER TABLE catEmpleado modify empTel varchar (10);


CREATE TABLE catBanco(
banID VARCHAR(8) NOT NULL,
banNom VARCHAR(30)
);

CREATE TABLE metPago(
medID VARCHAR(8) NOT NULL,
metTipo VARCHAR(8),
metCodeVer VARCHAR(3),
metCodeExp VARCHAR(4),
metNumTarjeta VARCHAR(12),
banID VARCHAR(8)
);

ALTER TABLE metPago modify metNumTarjeta VARCHAR(20);
ALTER TABLE metPago modify metCodeExp VARCHAR(5);
ALTER TABLE metPago modify metTipo VARCHAR(20);


CREATE table renta(
renFolio VARCHAR(8) NOT NULL,
cleID VARCHAR(8) NOT NULL,
empID VARCHAR(8) NOT NULL,
renFechaEm datetime,
renFechaDev datetime

);
CREATE table detalle(
renFolio VARCHAR(8) NOT NULL,
pelID VARCHAR(8) NOT NULL,
detCosto VARCHAR(8) NOT NULL,
detCant VARCHAR(8) NOT NULL
);

create table pelicula (
pelID  VARCHAR(8) NOT NULL,
pelTitulo VARCHAR(8),
pelGenero VARCHAR(8),
pelYear year,
pelDirector VARCHAR(20),
pelDuracion varchar (8)

);
ALTER TABLE pelicula modify pelTitulo varchar (30);




##llaves primarias
ALTER TABLE catClientes
ADD CONSTRAINT PK_clientes primary key (cleID);
ALTER TABLE catEmpleado
ADD CONSTRAINT PK_empleado primary key (empID);
ALTER TABLE catbanco
ADD CONSTRAINT PK_banco primary key (banID);
ALTER TABLE metPago
ADD CONSTRAINT PK_metPago primary key (medID);
ALTER TABLE renta
ADD CONSTRAINT PK_renta primary key (renFolio);
ALTER TABLE detalle
ADD CONSTRAINT PK_detalle primary key (renFolio);
ALTER TABLE pelicula
ADD CONSTRAINT PK_pelicula primary key (pelID);

##llaves foraneas

ALTER TABLE catClientes
ADD constraint FK_cliente_metPago foreign key (metID) references metPago (metID);

ALTER TABLE metPago
ADD constraint FK_metPago_Banco foreign key (banID) references catBanco (banID);

ALTER TABLE renta
ADD constraint FK_renta_cliente foreign key (cleID) references catCliente (cleID);

ALTER TABLE renta
ADD constraint FK_renta_empleado foreign key (empID) references catEmpleado (empID);

ALTER TABLE detalle
ADD constraint FK_detalle_renta foreign key (renFolio) references renta (renFolio);

ALTER TABLE detalle
ADD constraint FK_detalle_pelicula foreign key (peliID) references pelicula (peliID);

##agregar datos 
insert catBanco values(1,'banorte');insert catBanco values(1,'banorte');
insert  catBanco values(2,'satander');
insert  catBanco values(3,'banamex');
insert  catBanco values(4,'hsbc');
insert  catBanco values(5,'banbajio');
insert  catBanco values(6,'coppel');
insert  catBanco values(7,'bienestar');
insert  catBanco values(8,'scotiakbank');
insert  catBanco values(9,'banco asteca');
insert catBanco values(10,'banco palomo');

select * from catBanco ;


insert metPago values(1,'tarjeta debito','111','10/24','5012 4011 3030 5050','1');
insert metPago values(2,'tarjeta credito','121','11/24','5012 4011 3030 5051','2');
insert metPago values(3,'tarjeta debito','112','12/24','3012 4011 3030 5051','2');
insert metPago values(4,'tarjeta credito','131','01/24','3012 4011 3030 5052','3');
insert metPago values(5,'tarjeta debito','113','02/24','6012 4011 9030 5053','3');
insert metPago values(6,'tarjeta credito','141','03/24','6012 4011 9030 5054','4');
insert metPago values(7,'tarjeta debito','114','04/24','5012 4011 3030 5055','4');
insert metPago values(8,'tarjeta credito','151','10/24','5012 4011 3030 5056','5');
insert metPago values(9,'tarjeta debito','115','10/24','5012 4011 9030 5057','5');
insert metPago values(10,'tarjeta credito','161','10/24','5012 4011 9030 5058','6');

select * from metPago ;

insert catClientes values(1,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');
insert catClientes values(2,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');
insert catClientes values(3,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');
insert catClientes values(4,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');
insert catClientes values(5,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');
insert catClientes values(6,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');
insert catClientes values(7,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');
insert catClientes values(8,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');
insert catClientes values(9,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');
insert catClientes values(10,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414','1');

insert catEmpleado values(1,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');
insert catEmpleado values(2,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');
insert catEmpleado values(3,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');
insert catEmpleado values(4,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');
insert catEmpleado values(5,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');
insert catEmpleado values(6,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');
insert catEmpleado values(7,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');
insert catEmpleado values(8,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');
insert catEmpleado values(9,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');
insert catEmpleado values(10,'juan','ramirez','beltran','torres','barrancos','culiacan','80222','4444','JURABE220LA','h','29','2000-10-10','fulano@hotmail.com','6672141414');

select * from catEmpleado;

##recordatorio de que en la variable YEAR no puedo poner 1900 por que es de 1900-2155 incluyendo 0000
insert pelicula values('1','star wars 1','futuro','1901','guillermo del toro','380 min');
insert pelicula values('2','star wars 2','futuro','0000','guillermo del toro','380 min');
insert pelicula values('3','star wars 3','futuro','1901','guillermo del toro','380 min');
insert pelicula values('4','star wars 4','futuro','1901','guillermo del toro','380 min');
insert pelicula values('5','star wars 5','futuro','1901','guillermo del toro','380 min');
insert pelicula values('6','star wars 6','futuro','1901','guillermo del toro','380 min');
insert pelicula values('7','star wars 7','futuro','1901','guillermo del toro','380 min');
insert pelicula values('8','star wars 8','futuro','1901','guillermo del toro','380 min');
insert pelicula values('9','star wars 9','futuro','1901','guillermo del toro','380 min');
insert pelicula values('10','star wars 10','futuro','1901','guillermo del toro','380 min');

insert renta values('1','1','1','2021-03-30','2021-04-30');
insert renta values('2','1','1','2021-03-30','2021-04-30');
insert renta values('3','1','1','2021-03-30','2021-04-30');
insert renta values('4','1','1','2021-03-30','2021-04-30');
insert renta values('5','1','1','2021-03-30','2021-04-30');
insert renta values('6','1','1','2021-03-30','2021-04-30');
insert renta values('7','1','1','2021-03-30','2021-04-30');
insert renta values('8','1','1','2021-03-30','2021-04-30');
insert renta values('9','1','1','2021-03-30','2021-04-30');
insert renta values('10','1','1','2021-03-30','2021-04-30');


insert detalle values('1','1','40.00','8');
insert detalle values('2','1','40.00','8');
insert detalle values('3','1','40.00','8');
insert detalle values('4','1','40.00','8');
insert detalle values('5','1','40.00','8');
insert detalle values('6','1','40.00','8');
insert detalle values('7','1','40.00','8');
insert detalle values('8','1','40.00','8');
insert detalle values('9','1','40.00','8');
insert detalle values('10','1','40.00','8');

select*from detalle;

select * from pelicula;


## where es una sentensia condcional
## group by funciones de valor agregado sum o cuantity
##having es la misma wea
##order by ordena asendence o descendencec

##Alias en los select 
##mod resto de la divicion %%%%
##ceil para rriba floor para bajo
##cht codig asqii fprmatear salida, para aprecer todas minuscilas
##cambiar de date time a character
##concat concadena strings
##to_ es para castear y convertir
##m traer armado el sqcript de las tablas de la actividad *7

##auto join union de 2 tablas alter

##cross join