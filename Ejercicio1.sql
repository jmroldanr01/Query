CREATE DATABASE JRoldanEjercicio1
GO

use JRoldanEjercicio1
GO
--Creacion DE Tabla
CREATE TABLE GPS_DATA(
Id int  PRIMARY KEY IDENTITY(1,1) NOT NULL,
DateSystem datetime NOT NULL,
DateEvent datetime NULL,
Latitude float NULL,
Longitude float NULL,
Battery int NULL,
Source int NULL,
Type int NULL)
-- Consultar Todos
GO

CREATE PROCEDURE GPS_DATAGetAll
AS
SELECT
	Id,
	DateSystem,
	DateEvent ,
	Latitude ,
	Longitude ,
	Battery ,
	Source,
	Type
FROM GPS_DATA

GO
--Agregar
CREATE PROCEDURE GPS_DATAAdd --'2021-09-02','2021-09-02',15151,151515,20,120,1
@DateSystem datetime ,
@DateEvent datetime ,
@Latitude float ,
@Longitude float ,
@Battery int ,
@Source int ,
@Type int 
AS
INSERT INTO GPS_DATA Values(@DateSystem,@DateEvent,@Latitude,@Longitude,@Battery,@Source,@Type)

GO
--Actualizar
CREATE PROCEDURE GPS_DATAUpdate
@Id int,
@DateSystem datetime ,
@DateEvent datetime ,
@Latitude float ,
@Longitude float ,
@Battery int ,
@Source int ,
@Type int 
as
UPDATE [dbo].[GPS_DATA]
   SET [DateSystem] = @DateSystem
      ,[DateEvent] =@DateEvent 
      ,[Latitude] = @Latitude
      ,[Longitude] = @Longitude
      ,[Battery] = @Battery
      ,[Source] = @Source
      ,[Type] = @Type
 WHERE Id=@Id

 GO
 --Eliminar 
 CREATE PROCEDURE GPS_DATADelete 
 @Id int
 AS
 DELETE FROM GPS_DATA WHERE Id=@Id


