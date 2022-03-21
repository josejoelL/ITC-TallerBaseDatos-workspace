create database productosElectronicos;
use productosElectronicos;


create table productoTerminado(
proTerID varchar (8) not null,
proTerNom varchar (30) 

);

create table parte(
parID varchar (8) not null,
parNom varchar (30), 
parCant varchar (20),
proTerID varchar (8)

);
##cambio proTerID por que estaba como porTerID como no se cambiar las columnas dropie toda la tabla 
drop table parte;
select*from parte;

alter table productoTerminado
add constraint PK_productoTerminado   primary key (proTerID);

alter table parte
add constraint PK_parte primary key (parID);

alter table parte
add constraint FK_parte_productoTerminado foreign key (proTerID) references productoTerminado (proTerID);

