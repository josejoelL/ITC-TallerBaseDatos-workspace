CREATE DATABASE AdivinaAnime;
USE AdivinaAnime;

CREATE TABLE opening(
opId VARCHAR(8),
opNom VARCHAR(30) NOT NULL,
opRuta VARCHAR(30) NOT NULL
);
CREATE TABLE anime(
animeId VARCHAR(8),
animeNom VARCHAR(30) NOT NULL,
animeYear NUMERIC(9),
animeFotoRuta VARCHAR(30) NOT NULL
);

CREATE TABLE genero(
genId VARCHAR(8),
genNom VARCHAR(30) NOT NULL
);
CREATE TABLE dificultad(
difiId VARCHAR(8),
difiNom VARCHAR(30) NOT NULL

);
##llaves primarias
ALTER TABLE dificultad
ADD CONSTRAINT PK_dificultad primary key (difiId);
ALTER TABLE genero
ADD CONSTRAINT PK_genero primary key (genId);
ALTER TABLE opening
ADD CONSTRAINT PK_opening primary key (opId);
ALTER TABLE anime
ADD CONSTRAINT PK_anime primary key (animeId);

##llaves foraneas
## no las habia registrado
ALTER TABLE anime ADD difiId VARCHAR(8);
ALTER TABLE anime ADD genId VARCHAR(8);
ALTER TABLE opening ADD animeId VARCHAR(8);

ALTER TABLE anime
ADD constraint FK_anime_dificultad foreign key (difiId) references dificultad (difiId);

ALTER TABLE anime
ADD constraint FK_anime_genero foreign key (genId) references genero (genId);

ALTER TABLE opening
ADD constraint FK_opening_anime foreign key (animeId) references anime (animeId);

##agregar datos 
select * from anime;


insert dificultad values(1,'Facil');
insert dificultad values(2,'Normal');
insert dificultad values(3,'Difcil');
insert dificultad values(4,'Extremo');
insert dificultad values(5,'Pesadilla');

insert genero values(1,'Accion');
insert genero values(2,'Coches');
insert genero values(3,'Comedia');
insert genero values(4,'Demencia');
insert genero values(5,'Demonios');
insert genero values(6,'Drama');
insert genero values(7,'Fantasia');
insert genero values(8,'Ecchi');
insert genero values(9,'Juego');
insert genero values(10,'harem');
insert genero values(11,'Historico');
insert genero values(12,'Terror');
insert genero values(13,'OtroMundo');
insert genero values(14,'Josei');
insert genero values(15,'niños');
insert genero values(16,'Magia');
insert genero values(17,'ChicaMagica');
insert genero values(18,'ArtesMarciales');
insert genero values(19,'Mecha');
insert genero values(20,'Militar');
insert genero values(21,'Musica');
insert genero values(22,'Misterio');
insert genero values(23,'Parodia');
insert genero values(24,'Policial');
insert genero values(25,'psicologico');
insert genero values(26,'Romance');
insert genero values(27,'Samurai');
insert genero values(28,'Escuela');
insert genero values(29,'CienciaFiccion');
insert genero values(30,'Seinen');
insert genero values(31,'Shoujo');
insert genero values(32,'ShounenAi');
insert genero values(33,'RecuentoDeLaVida');
insert genero values(34,'Deportes');
insert genero values(35,'SobreNatural');
insert genero values(36,'SuperPoder');
insert genero values(37,'Thriller');
insert genero values(38,'Vampiro');



