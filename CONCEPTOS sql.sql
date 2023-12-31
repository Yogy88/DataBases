Create database CONCEPTOS

CREATE TABLE PERSONAS(
IDPERSONA INT IDENTITY (1,1),
NOMBRE NVARCHAR (100),
APELLIDO NVARCHAR (100),
EDAD INT,
IDOCUPACION INT,
PRIMARY KEY (IDPERSONA),
FOREIGN KEY (IDOCUPACION) REFERENCES OCUPACIONES (IDOCUPACION),
)
CREATE TABLE OCUPACIONES (
IDOCUPACION INT IDENTITY (1,1),
NOMBRE_DEL_CARGO NVARCHAR (100),
ANTIGUEDAD_A�OS INT,
PROVINCIA NVARCHAR (100),
PRIMARY KEY (IDOCUPACION),
)

CREATE TABLE EMPRESAS (
IDEMPRESA INT IDENTITY (1,1),
NOMBRE_EMPRESA NVARCHAR (100),
NUMERO_EMPLEADOS INT,
IDOCUPACION INT,
PRIMARY KEY (IDEMPRESA),
FOREIGN KEY (IDOCUPACION) REFERENCES OCUPACIONES (IDOCUPACION),
)


----INDICES: SIRVEN PARA ORDERNAR ALFABETICAMENTE LOS DATOS
--EXECUTE sp_helpindex 'LISTADO DE NOMBRES'  --SE EJECUTA EL COMANDO SP_HELPINDEX (QUE VIENE POR DEFAULT) Y SE LE DA UN NOMBRE
--CREATE CLUSTERED INDEX LISTADOS_DE_NOMBRES --SE CREA EL NOMBRE DEL INDICE
--ON PERSONAS (NOMBRE) --SE INDICA LA TABLA Y LA COLUMNA, ���NO FUNCIONA SI HAY PRIMARY EN LA TABLA EN CUESTION!!!

----BORRAR BASE DE DATOS/TABLA/COLUMNA
--DROP DATABASE
--DROP TABLE 
--DROP COLUMN 

----ELIMINAR EL CONTENIDO DE UNA TABLA
--DELETE TABLE


----INSERTAR DATOS EN UNA DE LAS TABLAS (SIEMPRE PONER LOS CAMPOS, AUNQUE NO SEA NECESARIO
									   --PORQUE ASI LO PIDE EL PROFESOR)
--INSERT INTO PERSONAS (NOMBRE, APELLIDO,EDAD) VALUES ('AGUSTINA','MENDEZ',38)
--INSERT INTO OCUPACIONES (NOMBRE_DEL_CARGO, ANTIGUEDAD_A�OS, PROVINCIA) VALUES ('ABOGADA',15,'MISIONES')

--ALTER: CON ESTO PODEMOS AGRAGAR O QUITAR COLUMNAS A UNA TABLA DE MANERA PARTICULAR 
--ALTER TABLE EMPRESAS
--ADD
--RUBRO NVARCHAR (30)

--CON ESTO PODEMOS BORRAR UNA COLUMNA EN PARTICULAR DE UNA DETERMINADA TABLA
--ALTER TABLE [NOMBRE DE LA TABLA]
--ADD
--DROP COLUMN [NOMBRE DE LA COLUMNA]


----LIKE: PERMITE BUSCAR DATOS POR MEDIO DE ESTIMACIONES 
--SELECT * FROM PERSONAS WHERE NOMBRE LIKE '%ON%'


----ACTUALIZAR DATOS EN UNA TABLA DE MANERA GENERAL
--UPDATE PERSONAS SET NOMBRE ='JOSE', APELLIDO='PEREZ', EDAD=25


----ACTUALIZAR DATOS DE MANERA PARTICULAR, INGRESANDO UNA NUEVA LINEA/ROW A LA TABLA
--UPDATE PERSONAS SET NOMBRE ='URIEL', APELLIDO='SANTARELLI',EDAD=30 WHERE IDPERSONA =1


----SELECT: SIRVE PARA MOSTRAR LOS PRIMEROS ELEMENTOS DE UNA TABLA EN CUESTION
--SELECT TOP (5)* FROM PERSONAS

----AQUI HACEMOS LOS MISMO PERO EN LUGAR DE PEDIR UNA CANTIDAD, PEDIMOS UN PORCENTAJE
--SELECT TOP (20) PERCENT * FROM OCUPACIONES

----BETWEEN: SIRVE ESTABLECER UN RANGO DE BUSQUEDA ENTRE 2 VALORES
--SELECT * FROM EMPRESAS WHERE (IDEMPRESA BETWEEN 3 AND 5)

----IN: PERMITE PERZONALIZAR UNA CONSULTA DICIENDO QUE ES LO QUE ESTAMOS BUSCANDO
--SELECT * FROM OCUPACIONES WHERE (NOMBRE_DEL_CARGO IN ('TECNICO PROFESIONAL'))

----CONSULTAS MULTIPLES: SE ULTILIZA PARA BUSCAR ELEMENTOS MEDIANTE VARIOS PARAMETROS
--SELECT * FROM EMPRESAS WHERE (NUMERO_EMPLEADOS LIKE 200000) OR (NOMBRE_EMPRESA LIKE 'AMAZON')

--ORDENAR EN ORDERN ASCENDENTE/DESCENDENTE LA SELECCION DEL CONTENIDO DE LA TABLA SEGUN EL CRITERIO
--SELECT  TOP (100) PERCENT IDEMPRESA, NUMERO_EMPLEADOS, IDOCUPACION, NOMBRE_EMPRESA
--FROM  dbo.EMPRESAS ORDER BY IDEMPRESA ASC

--PROCEDIMIENTOS ALAMCENADOS / STORE PROCEDURES SE ENCARGA DEL CONTROL DE ERRORES MEDIANTE TRAY/CATCH
--CREATE PROCEDURE SUMAR( 
--@N1 INT,
--@N2 INT,
--@RESULTADO INT OUTPUT
--)
--AS

--BEGIN
--SET @RESULTADO = @N1 + @N2


--BEGIN TRY

--DECLARE  @RESULTADO INT
--EXEC SUMAR 1,2,@RESULTADO OUTPUT
--SELECT @RESULTADO

--END TRY
--BEGIN CATCH 
--SET @RESULTADO = -1
--END CATCH

--END


--ALTER PROCEDURE SUMAR ( 
--@N1 INT,
--@N2 INT,
--@RESULTADO BIT OUTPUT,
--@RESULTADOMENSAJE NVARCHAR(100) OUTPUT
--)
--AS
--BEGIN
--DECLARE @SUMA INT
--	BEGIN TRY
--		BEGIN TRANSACTION 
--		 insert into PERSONAS(NOMBRE,APELLIDO,EDAD)
--		 values ('prueba','prueba',15)
--		 	SET @SUMA = @N1 + @N2
--			SET @RESULTADO=1
--			SET @RESULTADOMENSAJE='OK'
--			SELECT @SUMA
--		COMMIT TRANSACTION
--	END TRY

--	BEGIN CATCH
--		SET @RESULTADO = 0 
--		SET @RESULTADOMENSAJE=ERROR_MESSAGE()
--		ROLLBACK TRANSACTION		
--	END CATCH

--END



--DECLARE  @RESULTADO bit
--DECLARE  @RESULTADOMENSAJE nvarchar(100)
--EXEC SUMAR 2147483647,2000000,@RESULTADO OUTPUT,@RESULTADOMENSAJE OUTPUT
--SELECT @RESULTADO,@RESULTADOMENSAJE

--DECLARE  @RESULTADO bit
--DECLARE  @RESULTADOMENSAJE nvarchar(100)
--EXEC SUMAR 1,1,@RESULTADO OUTPUT,@RESULTADOMENSAJE OUTPUT
--SELECT @RESULTADO,@RESULTADOMENSAJE

--SELECT * FROM PERSONAS

--SELECT CURRENT_USER ESTE COMANDO NOS PERMITE SABER QUE USUARIO ESTA LOGUEADO 

--TRIGGERS/DISPARADORES: PROCEDIMIENTO ALMACENADO QUE SE EJECUTA CUANDO SE INTENTA 
					   --MODIFICAR (INSERTAR, ACTUALIZAR, ELIMINAR) LOS DATOS DE UNA TABLA (O VISTA)

--CREATE TABLE AUDITORIAS (
--IDAUDITORIA INT IDENTITY (1,1),
--IDELEMENTO NVARCHAR (20),
--TABLA NVARCHAR,
--ACCION NVARCHAR 
--PRIMARY KEY (IDAUDITORIA)
--)

--DROP TABLE AUDITORIAS


--CREATE TRIGGER DIS_AUDITORIA
--ON EMPRESAS 
--FOR INSERT 
--AS
--BEGIN
--INSERT INTO AUDITORIA
--SELECT IDEMPRESA, 'RUBRO','NOMBRE_EMPRESA'
--FROM inserted 

--END

--MANEJO DE EXCEPCIONES: Si ocurre un error dentro de la transacci�n en un bloque TRY 
--inmediatamente se dirige al bloque CATCH.
--Para poder regresar la informaci�n del error tenemos nuevas funciones en SQL Server, veamos cuales son:

--BEGIN TRY
--    DECLARE @TOTAL INT;
--    SET @TOTAL = 20;
--    SELECT @TOTAL/0
--END TRY
--BEGIN CATCH
--    SELECT
--    ERROR_NUMBER() AS Numero_de_Error,
--    ERROR_SEVERITY() AS Gravedad_del_Error,
--    ERROR_STATE() AS Estado_del_Error,
--    ERROR_PROCEDURE() AS Procedimiento_del_Error,
--    ERROR_LINE() AS Linea_de_Error,
--    ERROR_MESSAGE() AS Mensaje_de_Error;
--END CATCH



CREATE TABLE PRODUCTOS (
IDPRODUCTO INT IDENTITY (1,1),
NOMBREdePRODUCTO NVARCHAR (100),
DESCRIPCION NVARCHAR (100),
PRECIO INT,
STOCK INT,
PRIMARY KEY (IDPRODUCTO)
)

SELECT AVG (PRECIO) FROM PRODUCTOS

SELECT AVG (STOCK) FROM PRODUCTOS

SELECT NOMBREdePRODUCTO, PRECIO FROM PRODUCTOS WHERE PRECIO >(SELECT AVG (PRECIO)FROM PRODUCTOS);

SELECT COUNT (*) FROM PRODUCTOS

SELECT COUNT (DISTINCT NOMBREdePRODUCTO) FROM PRODUCTOS

SELECT MAX (PRECIO) FROM PRODUCTOS

SELECT NOMBREdePRODUCTO, PRECIO FROM PRODUCTOS WHERE PRECIO >(SELECT MIN(PRECIO) FROM PRODUCTOS)

SELECT NOMBREdePRODUCTO FROM PRODUCTOS ORDER BY PRECIO DESC

SELECT MIN (STOCK) FROM PRODUCTOS

SELECT SUM (PRECIO) FROM PRODUCTOS










create database PROCEDIMIENTOS_ALMACENADOS

USE PROCEDIMIENTOS_ALMACENADOS

create table viajeros (
idviajero int identity (1,1) not null,
nombre nvarchar (50),
apellido nvarchar (50),
DNI int,
fecha_de_viaje date,
fecha_de_retorno date,
primary key (idviajero)
)

insert into viajeros (nombre,apellido,DNI,fecha_de_viaje,fecha_de_retorno) values

('Nestor', 'Altamira', 34263321,'20/12/2011','12/01/2012')

select * from viajeros


--1) Crear un procedimiento almacenado que realice un INSERT en una tabla.
if OBJECT_ID ('insercion') is not null
begin
	drop procedure insercion
end

go

create procedure insercion
as

	insert into viajeros (nombre, apellido, DNI, fecha_de_viaje, fecha_de_retorno) values 
	('Gaston',  'Santarelli', 33485723, '02/10/2013', '10/11/2013')
go
	  
exec insercion

select * from viajeros

--2) Crear un procedimiento almacenado que realice un ABM (alta, baja y modificaci�n) de una
--tabla.

if OBJECT_ID ('alta_baja_modificacion') is not null
begin
	drop procedure alta_baja_modificacion
end

go

create procedure alta_baja_modificacion
as
	insert into viajeros (nombre, apellido, DNI, fecha_de_viaje, fecha_de_retorno) values 
	('Gabriel',  'Menendez', 33485824, '03/11/2013', '10/12/2013')
	delete viajeros where idviajero = 1
	update viajeros set nombre = 'Mariano', apellido = 'Centeno', DNI=32495632, fecha_de_viaje = '10/10/2015', fecha_de_retorno='11/12/2015'
	where idviajero = 7
go

exec alta_baja_modificacion

select * from viajeros

--3) Crear un procedimiento almacenado que devuelva los registros de un rango de fechas.
--PROCEDIMIENTOS DEFINIDOS POR EL USUARIO

if object_id ('fechas') is not null
begin 
	drop procedure fechas
end 

go

create procedure fechas

as 
	select * from viajeros as Parcial where (fecha_de_viaje between '01/01/2011' and '01/10/2011')
go

exec fechas

--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

--1) Crear un procedimiento almacenado que reciba como par�metro un id de un cliente y como
--salida su nombre


CREATE PROCEDURE RECIBIR_INFORMACION
@N1 INT,
@NUMERO NVARCHAR (20) OUTPUT
AS
BEGIN
SELECT @NUMERO =  nombre FROM viajeros WHERE @N1 = idviajero
END

DECLARE @SALIDA NVARCHAR (20)
EXECUTE RECIBIR_INFORMACION 6, @SALIDA OUTPUT

SELECT @SALIDA AS 'NOMBRE SOLICITADO'





--2) Crear un procedimiento almacenado que funcione como calculadora (+, (+,--,*,/) la variable de
--salida ser� el r esultado.



CREATE PROCEDURE CALCULADORA
@N1 INT,
@N2 INT,
@SIGNO CHAR,
@TIPO_OPERACION INT OUTPUT
AS
BEGIN
SELECT @TIPO_OPERACION = case @SIGNO
			when '+' then @N1 + @N2
			when '-' then @N1 - @N2
			when '*' then @N1 * @N2
			when '/' then @N1 / @N2
			END
END

DECLARE @OBTENIDO INT
EXECUTE CALCULADORA 10,3,'*',@OBTENIDO OUTPUT

SELECT @OBTENIDO AS RESULTADO

