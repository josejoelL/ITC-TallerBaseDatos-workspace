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
insert genero values(32,'ShoujoAi');
insert genero values(33,'RecuentoDeLaVida');
insert genero values(34,'Deportes');
insert genero values(35,'SobreNatural');
insert genero values(36,'SuperPoder');
insert genero values(37,'Thriller');
insert genero values(38,'Vampiro');
insert genero values(39,'Aventura');
insert genero values(40,'Shounen');
insert genero values(41,'Espacio');
insert genero values(42,'juego');
180      agrego
select * from anime; 
245 246
update anime
set animeFotoRuta = 'C:\AdivinaAnime\pic\81'
where animeId= 81;
update opening
set animeId = 109
where opId>= 225;

use adivinaanime;
select * from opening
where animeId =33
group by genID;

UPDATE opening
SET opRuta = REPLACE(opRuta, 'C:AdivinaAnimeop', 'C:\\AdivinaAnime\\op\\')
WHERE opRuta LIKE '%C:AdivinaAnimeop%';

##quitar el seguro y reconectar el sv
UPDATE anime
SET animeFotoRuta = REPLACE(animeFotoRuta, 'C:AdivinaAnimepic', 'C:\\AdivinaAnime\\pic\\')
WHERE animeFotoRuta LIKE '%C:AdivinaAnimepic%';

select X.animeId as 'ID', A.animeNom as 'Title' ,X.genId as 'ID', G.genNom as 'Generos'
from animexgenero X
JOIN anime A ON A.animeId = X.animeId 
JOIN genero G ON G.genId =X.genId
#where X.animeId = 1
group by X.animeId;
SELECT
anime.animeNom as 'anime',
animexgenero.animeId,
genero.genNom as 'genero'
FROM animexgenero
 JOIN anime ON anime.animeId = animexgenero.animeId 
 JOIN genero ON genero.genId =animexgenero.genId
 where anime.animeId = 1
 group by animexgenero.animeId;