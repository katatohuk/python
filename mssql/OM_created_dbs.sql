use master
go

DECLARE @name VARCHAR(50) -- database name
DECLARE @path VARCHAR(256) -- path for data files 
DECLARE @fileName VARCHAR(256) -- filename 
DECLARE @cmd varchar(256)
declare @cmd1 varchar(max)
DECLARE @prevver VARCHAR(50) -- previous version no
DECLARE @curver VARCHAR(50) -- current version no
DECLARE @create varchar(max) -- create all databases

set @path = 'D:\MSSQL_DATA\'
-- Choose previous version
set @prevver = '_631_'
-- Set desired version
set @curver = '_65_'


DECLARE db_cursor CURSOR FOR 
select replace(name,@prevver,@curver)
from sys.databases
--change below to previous verios as well
where name like 'FNS_631%' order by name


OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @name 

WHILE @@FETCH_STATUS = 0  
BEGIN  
       
	  set @cmd = 'mkdir ' + @path + @name + '\'
	  print '#################################'
	  print 'Creating data/log dirs on server'
	  print '#################################'
	  	  --Creating directoried for new dbs
	  print @cmd
	  print CHAR(10)
	  --exec xp_cmdshell @cmd

	  --Now lets create all databases
	  print '#################################'
	  print 'Creating databases'
	  print '#################################'
	  print CHAR(10)

set @create = 'CREATE DATABASE [' + @name +']
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = ' + @name + ', FILENAME = ' + @path + @name + '\' + @name + '.mdf' +', SIZE = 5120KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = ' +  @name + '_log, FILENAME = ' + @path + @name + '\' + @name + '_log.ldf , SIZE = 1024KB , FILEGROWTH = 10%)
 COLLATE Latin1_General_CI_AS
GO
ALTER DATABASE ['+@name+'] SET COMPATIBILITY_LEVEL = 110
GO
ALTER DATABASE ['+@name+'] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE ['+@name+']SET ANSI_NULLS OFF 
GO
ALTER DATABASE ['+@name+'] SET ANSI_PADDING OFF 
GO
ALTER DATABASE ['+@name+'] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE ['+@name+'] SET ARITHABORT OFF 
GO
ALTER DATABASE ['+@name+'] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE ['+@name+'] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE ['+@name+'] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE ['+@name+'] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE ['+@name+'] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE ['+@name+'] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE ['+@name+'] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE ['+@name+'] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE ['+@name+'] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE ['+@name+']SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE ['+@name+'] SET  DISABLE_BROKER 
GO
ALTER DATABASE ['+@name+'] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE ['+@name+'] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE ['+@name+'] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE ['+@name+']SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE ['+@name+'] SET  READ_WRITE 
GO
ALTER DATABASE ['+@name+'] SET RECOVERY FULL 
GO
ALTER DATABASE ['+@name+'] SET  MULTI_USER 
GO
ALTER DATABASE ['+@name+'] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE ['+@name+'] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE ['+@name+']
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N''PRIMARY'') ALTER DATABASE ['+@name+'] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO'

print @create
--exec @create
      FETCH NEXT FROM db_cursor INTO @name 
END

CLOSE db_cursor  
DEALLOCATE db_cursor 