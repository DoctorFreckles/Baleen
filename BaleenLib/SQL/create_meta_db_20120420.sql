USE [master]
GO

/****** Object:  Database [BAL_META]    Script Date: 04/20/2012 11:19:56 ******/
CREATE DATABASE [BAL_META] ON  PRIMARY 
( NAME = N'BAL_META', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\BAL_META.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'BAL_META_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\BAL_META_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [BAL_META] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BAL_META].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [BAL_META] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [BAL_META] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [BAL_META] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [BAL_META] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [BAL_META] SET ARITHABORT OFF 
GO

ALTER DATABASE [BAL_META] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [BAL_META] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [BAL_META] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [BAL_META] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [BAL_META] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [BAL_META] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [BAL_META] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [BAL_META] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [BAL_META] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [BAL_META] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [BAL_META] SET  DISABLE_BROKER 
GO

ALTER DATABASE [BAL_META] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [BAL_META] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [BAL_META] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [BAL_META] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [BAL_META] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [BAL_META] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [BAL_META] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [BAL_META] SET  READ_WRITE 
GO

ALTER DATABASE [BAL_META] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [BAL_META] SET  MULTI_USER 
GO

ALTER DATABASE [BAL_META] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [BAL_META] SET DB_CHAINING OFF 
GO


