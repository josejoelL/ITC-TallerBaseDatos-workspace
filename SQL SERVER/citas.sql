create database citas

go

use citas

go

create table hospitales(
hospID int not null,
hospNombre varchar (50) not null,
hospDomicilio varchar (50) not null,
hospTelefono varchar (10) not null )
go
create table consultorios (
consultID int not null,
consultDescripcion varchar (50) not null ,
hospID int not null )
go
create table pacientes(
pacID int not null,
pacNombre varchar( 50) not null ,
pacApellidos varchar( 50 ) not null, 
pacDomicilio varchar (50) not null,
pacTelefono varchar (10) not null,-- aadd aqui es solo vvar
pacCorreo varchar (50) not null )
go
create table doctores (
docID int not null,
docNombre varchar(50) not null,
docApellidos varchar(50) not null,
docCelular varchar (10) not null )
go
create table especialidades (
espID int not null,
espNombre varchar(50) not null )
go

create table laboratorios (
labID int not null,
labNombre varchar (50) not null,
labDescripcion varchar (50) not null,
labDomicilio varchar (50) not null )
go
create table medicamentos (
medID int not null,
medNombre varchar (50) not null,
medDescripcion varchar (50) not null,
medSustAct varchar (50) not null,
labID int not null )
go
create table recetas (
folioRec int not null,
recFecha datetime not null,
folio int not null)
go 

create table citas (
folio int not null,
fechaCaptura datetime not null,
fechaCita datetime not null,
peso numeric(12,2) not null,
presion numeric(12,2) not null,
estatura numeric(12,2) not null,
sintomas varchar( 50 ) not null,
diagnostico varchar( 50 ) not null ,
consultID int not null,
pacID int not null,
docID int not null )
go
create table EspxDoc (
espID int not null,
docID int not null )
go

create table MedxRecetas (
folioRec int not null,
medID int not null,
docis varchar (50) not null,
cantidad numeric(12,2) not null )
go
alter table hospitales add constraint pk_hospitales  primary key ( hospID )
alter table consultorios add constraint pk_consultorios  primary key ( consultID )
alter table pacientes add constraint pk_pacientes  primary key ( pacID )
alter table doctores add constraint pk_doctores  primary key ( docID )
alter table especialidades add constraint pk_especialidad  primary key ( espID )
alter table laboratorios add constraint pk_laboratorios  primary key ( labID )
alter table medicamentos add constraint pk_medicamentos  primary key ( medID )
alter table recetas add constraint pk_recetas  primary key ( folioRec )
alter table citas  add constraint pk_citas  primary key ( folio )
go
alter table MedxRecetas add
 constraint fk_folioRec foreign key ( folioRec ) references recetas ( folioRec ),
 constraint fk_medID foreign key ( medID ) references medicamentos ( medID ) 
go
alter table MedxRecetas add constraint pk_MedxRecetas  primary key ( folioRec,medID )
go
alter table EspxDoc  add
 constraint fk_espID foreign key ( espID ) references especialidades ( espID ),
 constraint fk_docID foreign key ( docID ) references doctores ( docID ) 

go
alter table EspxDoc  add constraint pk_EspxDoc  primary key ( espID,docID )
go

alter table consultorios add 

constraint fk_consultHospital foreign key ( hospID ) references hospitales ( hospID ) 

go

alter table medicamentos add 
constraint fk_medLaboratorio foreign key ( labID ) references laboratorios ( labID ) 
go

alter table citas add 
constraint fk_citas_consultorio foreign key ( consultID ) references consultorios ( consultID ) ,
constraint fk_citas_paciente foreign key ( pacID) references pacientes ( pacID ) ,
constraint fk_citas_doctor foreign key ( docID ) references doctores ( docID ) 
go
alter table recetas add 
constraint fk_recetas_citas foreign key ( folio ) references citas ( folio) 
go
insert hospitales values(1,' hospital culiacan','culiacan sinaloa','6673717401')
insert hospitales values(2,' hospital mazatlan','mazatlan sinaloa','6673717402')
insert hospitales values(3,'hospital guamuchil','guamuchil sinaloa','6673717403')
insert hospitales values(4,'hospital guasave','guasave sinaloa','6673717404')
insert hospitales values(5,'hospital mochis','mochis sinaloa','6673717405')

insert consultorios values(1,'piso uno',1)
insert consultorios values(2,'piso dos',1)
insert consultorios values(3,'piso tres',1)
insert consultorios values(4,'piso cuatro',1)
insert consultorios values(5,'piso cinco',1)

insert laboratorios values(1,'laboratorio culiacan','laboratorio ','culiacan sinaloa')
insert laboratorios values(2,'laboratorio mazatlan','laboratorio','mazatlan sinaloa')
insert laboratorios values(3,'laboratorio guamuchil','laboratorio','guamuchil sinaloa')
insert laboratorios values(4,'laboratorio guasave','laboratorio','guasave sinaloa')
insert laboratorios values(5,'laboratorio mochis','laboratorio','mochis sinaloa')

insert medicamentos values(1,'paracetamol','medicamento controlado','no',1)
insert medicamentos values(2,'antibiotico','medicamento controlado','no',2)
insert medicamentos values(3,'antidesflamatorio','medicamento controlado','no',3)
insert medicamentos values(4,'aspirina','medicamento controlado','no',4)
insert medicamentos values(5,'betobismol','medicamento controlado','no',5)

insert especialidades values(1,'cirujano')
insert especialidades values(2,'pediatra')
insert especialidades values(3,'otorinolaringologo')
insert especialidades values(4,'cirujano plastico')
insert especialidades values(5,'oftamologo')

insert pacientes values(1,'ramon','robles cazares','culiacan sinaloa','6673717401','rufles@gmail.com')
insert pacientes values(2,'toledo','landeros cambray','culiacan sinaloa','6673717402','toledo@gmail.com')
insert pacientes values(3,'carlos','rodriguez covarubias','culiacan sinaloa','6673717403','carlos@gmail.com')
insert pacientes values(4,'fernando','sigueñal santos','culiacan sinaloa','6673717404','fernando@gmail.com')
insert pacientes values(5,'francisco','clemente gerardo','culiacan sinaloa','6673717405','francisco@gmail.com')

insert doctores values(1,'carmen','robles cazares','6673717401')
insert doctores values(2,'dora','landeros cambray','6673717402')
insert doctores values(3,'camila','rodriguez covarubias','6673717403')
insert doctores values(4,'arnoldo','sigueñal santos','6673717404')
insert doctores values(5,'sandra','clemente gerardo','6673717405')


insert recetas values(1,'2016-10-10')
insert recetas values(2,'2017-10-10')
insert recetas values(3,'2017-11-11')
insert recetas values(4,'2018-10-10')
insert recetas values(5,'2018-11-10')

insert citas values(1,'2016-10-10','2018-11-10',70,30,1.70,'covid','covid',1,4,1)
insert citas values(2,'2018-10-10','2016-10-10',70,30,1.70,'covid','covid',1,1,2)
insert citas values(3,'2017-11-11','2017-11-11',70,30,1.70,'covid','covid',3,1,2)
insert citas values(4,'2018-10-10','2017-10-10',70,30,1.70,'covid','covid',3,4,1)
insert citas values(5,'2018-11-10','2016-10-10',70,30,1.70,'covid','covid',1,5,3)

insert EspxDoc values(1,1)
insert EspxDoc values(2,2)
insert EspxDoc values(3,3)
insert EspxDoc values(4,4)
insert EspxDoc values(5,5)

insert MedxRecetas values(1,1,1,1)
insert MedxRecetas values(2,2,1,1)
insert MedxRecetas values(3,3,1,1)
insert MedxRecetas values(4,4,1,1)
insert MedxRecetas values(5,5,1,1)