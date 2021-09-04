--DROP DATABASE JRoldanEjercicio3

Create Database JRoldanEjercicio2
go

Use JRoldanEjercicio2

create TABLE CTL_ROLES(
IdRole int PRIMARY KEY IDENTITY(1,1) NOT NULL,
RoleName varchar(20) NULL)

GO

CREATE TABLE CTL_USERS(
Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
IdRole int foreign key references CTL_ROLES(IdRole),
Name varchar(20) NULL,
LastName varchar(25) NULL,
SurName varchar(25) NULL,
Email varchar(80) NOT NULL,
UserName varchar(15) NOT NULL,
Password varbinary(8000) NOT NULL,
Parent int NULL,
Status int NOT NULL
) 

GO


ALTER TABLE CTL_USERS
ADD UNIQUE (Email);

GO

CREATE PROCEDURE CTL_USERSGetALL
AS
SELECT
	CTL_USERS.Id, 
	CTL_USERS.Name,
	CTL_USERS.LastName,
	CTL_USERS.SurName ,
	CTL_USERS.Email ,
	CTL_USERS.UserName ,
	CTL_USERS.Password,
	CTL_USERS.Parent, 
	CTL_USERS.Status,
	CTL_ROLES.IdRole ,
	CTL_ROLES.RoleName
FROM CTL_USERS 
INNER JOIN CTL_ROLES ON CTL_ROLES.IdRole=CTL_USERS.IdRole


GO

CREATE PROCEDURE CTL_USERSAdd 
@IdRole int ,
@Name varchar(20),
@LastName varchar(25) ,
@SurName varchar(25) ,
@Email varchar(80),
@UserName varchar(15),
@Password varbinary(8000),
@Parent int,
@Status int 
AS
BEGIN TRY
INSERT INTO CTL_USERS Values(@IdRole,@Name,@LastName,@SurName,@Email,@UserName,@Password,@Parent,@Status)
SELECT 'Usuario Insertado' AS UsuarioCorrecto
END TRY  
BEGIN CATCH  	
	SELECT ERROR_MESSAGE() AS UsuarioCorrecto   
END CATCH


GO

CREATE PROCEDURE CTL_USERSUpdate 
@Id int,
@IdRole int ,
@Name varchar(20),
@LastName varchar(25) ,
@SurName varchar(25) ,
@Email varchar(80),
@UserName varchar(15),
@Password varbinary(8000),
@Parent int,
@Status int 
AS
BEGIN TRY
UPDATE [dbo].[CTL_USERS]
   SET [IdRole] = @IdRole
      ,[Name] = @Name
      ,[LastName] = @LastName
      ,[SurName] = @SurName
      ,[Email] = @Email
      ,[UserName] = @UserName
      ,[Password] = @Password
      ,[Parent] = @Parent
      ,[Status] = @Status
 WHERE Id=@Id
 SELECT 'Usuario Actualizado' AS UsuarioCorrecto
END TRY  
BEGIN CATCH  	
	SELECT ERROR_MESSAGE() AS UsuarioCorrecto   
END CATCH

GO

 CREATE PROCEDURE CTL_USERSDelete 
 @Id int
 as
 Delete from CTL_USERS WHERE CTL_USERS.Id=@Id

GO

 CREATE PROCEDURE CTL_USERSGetById 
 @Id int
 as
 SELECT
	CTL_USERS.Id, 
	CTL_USERS.Name,
	CTL_USERS.LastName,
	CTL_USERS.SurName ,
	CTL_USERS.Email ,
	CTL_USERS.UserName ,
	CTL_USERS.Password,
	CTL_USERS.Parent, 
	CTL_USERS.Status,
	CTL_ROLES.IdRole ,
	CTL_ROLES.RoleName
FROM CTL_USERS 
INNER JOIN CTL_ROLES ON CTL_ROLES.IdRole=CTL_USERS.IdRole
WHERE CTL_USERS.Id=@Id

GO

CREATE procedure [dbo].[CTL_USERSGetAllBusqueda]
@Nombre varchar(10) ,
@ApellidoPaterno varchar(10) ,
@ApellidoMaterno varchar (10),
@Email varchar(50)
as
IF(@NOMBRE='' AND @ApellidoPaterno='' AND @ApellidoMaterno='' AND @Email='')
 Begin 
	SELECT
	CTL_USERS.Id, 
	CTL_USERS.Name,
	CTL_USERS.LastName,
	CTL_USERS.SurName ,
	CTL_USERS.Email ,
	CTL_USERS.UserName ,
	CTL_USERS.Password,
	CTL_USERS.Parent, 
	CTL_USERS.Status,
	CTL_ROLES.IdRole ,
	CTL_ROLES.RoleName
FROM CTL_USERS 
INNER JOIN CTL_ROLES ON CTL_ROLES.IdRole=CTL_USERS.IdRole
 END
ELSE
 BEGIN
SELECT
	CTL_USERS.Id, 
	CTL_USERS.Name,
	CTL_USERS.LastName,
	CTL_USERS.SurName ,
	CTL_USERS.Email ,
	CTL_USERS.UserName ,
	CTL_USERS.Password,
	CTL_USERS.Parent, 
	CTL_USERS.Status,
	CTL_ROLES.IdRole ,
	CTL_ROLES.RoleName
FROM CTL_USERS 
INNER JOIN CTL_ROLES ON CTL_ROLES.IdRole=CTL_USERS.IdRole
	WHERE 
		CTL_USERS.Name like '%'+@Nombre+'%' and		
		CTL_USERS.LastName like '%'+@ApellidoPaterno+'%' and 
		CTL_USERS.SurName like '%'+ @ApellidoMaterno+'%' and
		CTL_USERS.Email like '%'+ @Email+'%'
END

GO


CREATE PROCEDURE CTL_ROLESGetAll
AS
SELECT
CTL_ROLES.IdRole,
CTL_ROLES.RoleName
FROM CTL_ROLES
