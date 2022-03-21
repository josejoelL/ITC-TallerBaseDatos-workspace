create database ventas;
use ventas;


create table IF NOT EXISTS producto (
proID integer (4) not null AUTO_INCREMENT,
proNom varchar(30)
);
drop table ventas;
create table IF NOT EXISTS ventas (
comID integer (4) not null,
proID integer (4) not null,
venCant int(8)
);

create table IF NOT EXISTS comprador(
comID integer(4) not null AUTO_INCREMENT,
comNom varchar(30)
);

drop table ventas;
ALTER TABLE comprador modify comID integer(4) not null AUTO_INCREMENT;
ALTER TABLE producto modify proID integer(4) not null AUTO_INCREMENT;

alter table producto
add constraint PK_producto primary key (proID); 
alter table comprador
add constraint PK_comprador primary key (comID); 

alter table ventas
add constraint FK_ventas_comprador foreign key (comID) references comprador(comID),
add constraint FK_ventas_producto foreign key (proID) references producto(proID);

insert ventas values('1','10','6');
insert ventas values('2','9','4');
insert ventas values('2','6','6');
insert ventas values('3','8','4');
insert ventas values('3','6','2');
insert ventas values('4','2','6');
insert ventas values('4','4','8');
insert ventas values('4','8','10');
insert ventas values('5','9','4');
insert ventas values('6','10','2');
insert ventas values('7','1','2');
select*from ventas;
insert comprador values('1','Rodriguez');
insert comprador values('2','Barraza');
insert comprador values('3','Camacho');
insert comprador values('4','Godoy');
insert comprador values('5','Guadalupe');
insert comprador values('6','Mal Verde');
insert comprador values('7','Moctezuma');
insert comprador values('8','Taniyama');
insert comprador values('9','Smith');
insert comprador values('10','Messi');
insert comprador values('11','guillermo del toro');

insert producto values('1','pintura verde');
insert producto values('2','pintura roja');
insert producto values('3','pintura azul');
insert producto values('4','pintura amarilla');
insert producto values('5','pintura naranja');
insert producto values('6','pintura purpura');
insert producto values('7','pintura rosa');
insert producto values('8','pintura fushia');
insert producto values('9','pintura blanco');
insert producto values('10','pintura negro');
insert producto values('11','pintura gris');
insert producto values('12','pintura cafe');






