USE [master]
GO

/****** Object:  Database [Event]    Script Date: 02/15/2016 18:56:44 ******/
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'Event')
DROP DATABASE [Event]
GO

USE [master]
GO

/****** Object:  Database [Event]    Script Date: 02/15/2016 18:56:44 ******/
CREATE DATABASE [Event] ON  PRIMARY 
( NAME = N'Event', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\Event.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Event_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\Event_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [Event] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Event].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Event] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Event] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Event] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Event] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Event] SET ARITHABORT OFF 
GO

ALTER DATABASE [Event] SET AUTO_CLOSE ON 
GO

ALTER DATABASE [Event] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [Event] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Event] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Event] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Event] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Event] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Event] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Event] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Event] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Event] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Event] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Event] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Event] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Event] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Event] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Event] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Event] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Event] SET  READ_WRITE 
GO

ALTER DATABASE [Event] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [Event] SET  MULTI_USER 
GO

ALTER DATABASE [Event] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Event] SET DB_CHAINING OFF 
GO


USE [Event]
GO
/****** Object:  Table [dbo].[User]    Script Date: 02/15/2016 18:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Address] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Image] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND name = N'UQ_Email')
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Email] ON [dbo].[User] 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND name = N'UQ_Username')
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Username] ON [dbo].[User] 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[User] ON
INSERT [dbo].[User] ([ID], [Username], [Email], [Address], [Phone], [Image]) VALUES (1, N'sample string 2', N'sample string 4', N'sample string 5', N'sample string 6', NULL)
INSERT [dbo].[User] ([ID], [Username], [Email], [Address], [Phone], [Image]) VALUES (2, N'test@yahoo.com', N'test@yahoo.com', NULL, NULL, NULL)
INSERT [dbo].[User] ([ID], [Username], [Email], [Address], [Phone], [Image]) VALUES (3, N'linh@yahoo.com', N'linh@yahoo.com', NULL, NULL, NULL)
INSERT [dbo].[User] ([ID], [Username], [Email], [Address], [Phone], [Image]) VALUES (4, N'trang@yahoo.com', N'trang@yahoo.com', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
/****** Object:  Table [dbo].[Event]    Script Date: 02/15/2016 18:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Event]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Event](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Info] [varchar](150) NOT NULL,
	[Time] [datetime] NOT NULL,
	[Place] [varchar](50) NOT NULL,
	[MaxAttendance] [int] NULL,
	[RequireAttendance] [int] NULL,
	[Vote] [int] NULL,
	[Price] [money] NULL,
	[Image] [varchar](50) NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Event] ON
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (31, N'Nullam Suscipit PC', N'Aliquam tincidunt,', CAST(0x0000A53000000000 AS DateTime), N'P.O. Box 437, 3322 Dui. Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (32, N'Suspendisse PC', N'turpis. Nulla', CAST(0x0000A4F000000000 AS DateTime), N'520-7764 Semper St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (33, N'Ut Sem Nulla Consulting', N'natoque penatibus', CAST(0x0000A5B700000000 AS DateTime), N'784-5790 Senectus St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (34, N'Risus Quis Ltd', N'fringilla cursus', CAST(0x0000A57500000000 AS DateTime), N'Ap #225-5165 Mollis Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (35, N'Euismod Incorporated', N'nonummy. Fusce', CAST(0x0000A58A00000000 AS DateTime), N'P.O. Box 522, 9682 Accumsan Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (36, N'Diam Lorem LLP', N'Donec', CAST(0x0000A69700000000 AS DateTime), N'424-1401 Ac Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (37, N'Nibh LLC', N'malesuada', CAST(0x0000A5AC00000000 AS DateTime), N'Ap #596-1871 Phasellus St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (38, N'Eleifend Egestas Sed Associates', N'suscipit,', CAST(0x0000A47000000000 AS DateTime), N'P.O. Box 526, 9393 Nec Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (39, N'Et Eros Ltd', N'eget', CAST(0x0000A47400000000 AS DateTime), N'Ap #996-9770 Nec Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (40, N'Sit Amet Massa Limited', N'leo,', CAST(0x0000A5A700000000 AS DateTime), N'629-2724 Porttitor Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (41, N'Ipsum Associates', N'vel, convallis', CAST(0x0000A52800000000 AS DateTime), N'Ap #271-8338 Tempus Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (42, N'Euismod Corporation', N'imperdiet', CAST(0x0000A6D100000000 AS DateTime), N'Ap #200-5364 Eget Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (43, N'Luctus Corporation', N'justo faucibus', CAST(0x0000A61800000000 AS DateTime), N'392-7710 Fermentum Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (44, N'Pede Ac Urna Corporation', N'Curabitur vel', CAST(0x0000A6BE00000000 AS DateTime), N'P.O. Box 319, 5164 Non Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (45, N'Nascetur Ridiculus Mus Corp.', N'at,', CAST(0x0000A4B600000000 AS DateTime), N'Ap #131-6641 Sem St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (46, N'Neque Sed Institute', N'erat vel', CAST(0x0000A67800000000 AS DateTime), N'893-1650 Eget, Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (47, N'Tempor Arcu Incorporated', N'aptent taciti', CAST(0x0000A68800000000 AS DateTime), N'Ap #280-2039 Et, St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (48, N'Sed Incorporated', N'Curabitur vel', CAST(0x0000A55200000000 AS DateTime), N'P.O. Box 414, 540 Auctor, Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (49, N'Facilisis Incorporated', N'eu,', CAST(0x0000A54800000000 AS DateTime), N'Ap #875-5271 Eu St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (50, N'Bibendum Sed Incorporated2', N'faucibus', CAST(0x0000A6B100000000 AS DateTime), N'P.O. Box 724, 4242 Blandit St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (51, N'Quisque Institute', N'Donec felis', CAST(0x0000A52800000000 AS DateTime), N'Ap #500-5676 Id Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (52, N'Leo Corp.', N'Suspendisse aliquet', CAST(0x0000A4B700000000 AS DateTime), N'451-3698 Faucibus Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (53, N'Nullam Enim Sed Institute', N'felis,', CAST(0x0000A66F00000000 AS DateTime), N'P.O. Box 514, 5848 Sit Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (54, N'Aliquam Company', N'aliquet. Phasellus', CAST(0x0000A68D00000000 AS DateTime), N'4052 Iaculis Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (55, N'Nec Mauris Corporation', N'elementum purus,', CAST(0x0000A55200000000 AS DateTime), N'Ap #622-807 Nulla Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (56, N'Malesuada Ut Inc.', N'blandit viverra.', CAST(0x0000A61300000000 AS DateTime), N'9877 Leo. Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (57, N'Arcu Corporation', N'Aliquam', CAST(0x0000A53200000000 AS DateTime), N'Ap #979-4467 Nulla Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (58, N'Nunc Mauris Foundation', N'porttitor', CAST(0x0000A55D00000000 AS DateTime), N'P.O. Box 975, 9053 Massa. Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (59, N'Sed Eget Associates', N'lectus.', CAST(0x0000A67200000000 AS DateTime), N'P.O. Box 158, 1421 Vel Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (60, N'Quis LLP', N'Nam tempor', CAST(0x0000A49300000000 AS DateTime), N'Ap #885-1240 Iaculis St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (61, N'Nec Urna Industries', N'pharetra ut,', CAST(0x0000A57D00000000 AS DateTime), N'P.O. Box 356, 3957 Nunc St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (62, N'Quisque LLC', N'ante', CAST(0x0000A5CA00000000 AS DateTime), N'P.O. Box 649, 2052 Nec, Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (63, N'Pharetra Associates', N'tellus, imperdiet', CAST(0x0000A61100000000 AS DateTime), N'322-904 Nullam Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (64, N'Sit Amet Consectetuer PC', N'placerat.', CAST(0x0000A6FA00000000 AS DateTime), N'P.O. Box 540, 8203 Malesuada Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (65, N'Tincidunt Vehicula Corp.', N'facilisis', CAST(0x0000A66600000000 AS DateTime), N'5584 Lacus. Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (66, N'Orci Corporation', N'amet', CAST(0x0000A5B900000000 AS DateTime), N'Ap #136-2293 Dolor. Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (67, N'Lorem Foundation', N'congue,', CAST(0x0000A6FF00000000 AS DateTime), N'2527 Mi Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (68, N'Eros Nec Foundation', N'aliquet molestie', CAST(0x0000A58700000000 AS DateTime), N'Ap #720-1859 Urna St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (69, N'Mattis LLP', N'et', CAST(0x0000A55400000000 AS DateTime), N'5408 Eu Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (70, N'Facilisis Vitae Orci LLP', N'tortor. Nunc', CAST(0x0000A49200000000 AS DateTime), N'Ap #223-885 Malesuada St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (71, N'Nunc Quisque Limited', N'Duis elementum,', CAST(0x0000A53000000000 AS DateTime), N'Ap #901-6736 Quisque St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (72, N'Justo Associates', N'ullamcorper', CAST(0x0000A53600000000 AS DateTime), N'P.O. Box 397, 9360 Auctor St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (73, N'Conubia Nostra Per Ltd', N'tristique', CAST(0x0000A49500000000 AS DateTime), N'P.O. Box 406, 309 Amet, St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (74, N'Cras Sed Leo Consulting', N'nonummy ultricies', CAST(0x0000A70900000000 AS DateTime), N'P.O. Box 317, 9591 Laoreet St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (75, N'Nunc Industries', N'elit, pharetra', CAST(0x0000A67100000000 AS DateTime), N'P.O. Box 960, 2866 Massa. St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (76, N'Phasellus Vitae Ltd', N'convallis', CAST(0x0000A4F500000000 AS DateTime), N'P.O. Box 300, 8846 Bibendum. Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (77, N'Cras Institute', N'eu', CAST(0x0000A47900000000 AS DateTime), N'P.O. Box 820, 5174 Maecenas Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (78, N'Non Lobortis Inc.', N'egestas.', CAST(0x0000A6AB00000000 AS DateTime), N'Ap #930-2693 Nulla St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (79, N'Lacinia PC', N'fringilla', CAST(0x0000A62300000000 AS DateTime), N'766-2884 Lacinia Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (80, N'Lacus Nulla Company', N'mi lacinia', CAST(0x0000A58D00000000 AS DateTime), N'P.O. Box 453, 8513 Euismod Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (81, N'Hendrerit Consectetuer Institute', N'Vestibulum', CAST(0x0000A58900000000 AS DateTime), N'Ap #153-4145 Placerat, Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (82, N'Aliquam Inc.', N'ac,', CAST(0x0000A60600000000 AS DateTime), N'Ap #381-413 Magna Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (83, N'Ipsum Sodales Purus LLC', N'Donec tempor,', CAST(0x0000A50D00000000 AS DateTime), N'P.O. Box 943, 4779 Lobortis Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (84, N'Phasellus Fermentum Incorporated', N'elit, dictum', CAST(0x0000A65900000000 AS DateTime), N'P.O. Box 462, 2129 Vel Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (85, N'Dolor Inc.', N'dolor vitae', CAST(0x0000A4ED00000000 AS DateTime), N'Ap #228-1322 Consectetuer Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (86, N'Dictum Institute', N'ac facilisis', CAST(0x0000A70800000000 AS DateTime), N'Ap #121-5534 Tellus Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (87, N'Volutpat Limited', N'sed, hendrerit', CAST(0x0000A53600000000 AS DateTime), N'Ap #882-1086 Tempus Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (88, N'Duis Cursus Diam Company', N'netus', CAST(0x0000A45900000000 AS DateTime), N'P.O. Box 207, 4344 Proin Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (89, N'Non Associates', N'commodo', CAST(0x0000A53300000000 AS DateTime), N'P.O. Box 193, 1946 Dictum Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (90, N'Sem Consequat LLP', N'ut', CAST(0x0000A69500000000 AS DateTime), N'2663 Cum Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (91, N'Nec Tempus Mauris Limited', N'turpis', CAST(0x0000A58F00000000 AS DateTime), N'Ap #124-1819 Proin Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (92, N'Quis Limited', N'nulla', CAST(0x0000A64300000000 AS DateTime), N'Ap #148-1678 Quam St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (93, N'In Molestie PC', N'Curabitur massa.', CAST(0x0000A43F00000000 AS DateTime), N'543-1592 Consectetuer Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (94, N'Cras Limited', N'velit eget', CAST(0x0000A4F300000000 AS DateTime), N'P.O. Box 886, 4566 Vel, St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (95, N'Nibh Dolor Corp.', N'lorem', CAST(0x0000A63500000000 AS DateTime), N'2409 Iaculis St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (96, N'Pede Sagittis Augue Foundation', N'Aenean euismod', CAST(0x0000A50500000000 AS DateTime), N'8631 Dolor Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (97, N'Leo Cras Vehicula LLP', N'dapibus gravida.', CAST(0x0000A5D500000000 AS DateTime), N'2004 Dolor. Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (98, N'Proin Dolor Corporation', N'Mauris', CAST(0x0000A47800000000 AS DateTime), N'183-780 Libero Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (99, N'Augue Id Institute', N'magna,', CAST(0x0000A54C00000000 AS DateTime), N'5601 Nunc Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (100, N'In Associates', N'quam dignissim', CAST(0x0000A52000000000 AS DateTime), N'Ap #737-2347 Nullam Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (101, N'Et Ultrices LLP', N'penatibus', CAST(0x0000A4F600000000 AS DateTime), N'Ap #427-7688 Id Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (102, N'Vel Pede Corporation', N'ut', CAST(0x0000A4E800000000 AS DateTime), N'174-5622 Lorem. St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (103, N'Venenatis Vel Faucibus Foundation', N'placerat,', CAST(0x0000A44300000000 AS DateTime), N'6337 Aenean Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (104, N'Arcu Curabitur Ut Incorporated', N'ut', CAST(0x0000A4D200000000 AS DateTime), N'Ap #854-3517 In, Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (105, N'Convallis Erat Incorporated', N'semper egestas,', CAST(0x0000A62F00000000 AS DateTime), N'P.O. Box 998, 9492 A, Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (106, N'Justo Ltd', N'auctor,', CAST(0x0000A5D700000000 AS DateTime), N'P.O. Box 633, 5520 Arcu Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (107, N'Non Quam Pellentesque Incorporated', N'aliquet lobortis,', CAST(0x0000A5D200000000 AS DateTime), N'Ap #846-4618 Sem Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (108, N'Enim Ltd', N'ante', CAST(0x0000A49000000000 AS DateTime), N'Ap #701-2778 Neque Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (109, N'Nisi Consulting', N'fermentum', CAST(0x0000A58300000000 AS DateTime), N'5862 A Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (110, N'Sem Molestie LLC', N'vulputate,', CAST(0x0000A5E400000000 AS DateTime), N'Ap #721-1769 Faucibus. Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (111, N'Nulla Cras Eu Ltd', N'augue ac', CAST(0x0000A45C00000000 AS DateTime), N'1115 Taciti Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (112, N'Et Rutrum Corp.', N'et arcu', CAST(0x0000A62300000000 AS DateTime), N'6762 Maecenas St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (113, N'Mauris Inc.', N'Cras', CAST(0x0000A46200000000 AS DateTime), N'4225 Nibh St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (114, N'Sed Est Nunc Consulting', N'tempus risus.', CAST(0x0000A6CA00000000 AS DateTime), N'P.O. Box 423, 8561 Sagittis. Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (115, N'Orci Lacus Incorporated', N'et,', CAST(0x0000A69900000000 AS DateTime), N'Ap #308-8518 Etiam Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (116, N'Ipsum Nunc Id Inc.', N'faucibus leo,', CAST(0x0000A62100000000 AS DateTime), N'P.O. Box 317, 8763 Vivamus Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (117, N'Porta Inc.', N'sem', CAST(0x0000A6B000000000 AS DateTime), N'653-5985 Morbi Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (118, N'Vitae Orci Institute', N'risus, at', CAST(0x0000A67700000000 AS DateTime), N'P.O. Box 460, 7660 Malesuada. Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (119, N'Etiam Ligula Tortor Incorporated', N'porttitor', CAST(0x0000A45F00000000 AS DateTime), N'Ap #160-335 Magna Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (120, N'Convallis Erat Eget LLC', N'lacus.', CAST(0x0000A5BF00000000 AS DateTime), N'P.O. Box 891, 7254 Risus. St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (121, N'Egestas Consulting', N'penatibus', CAST(0x0000A67200000000 AS DateTime), N'P.O. Box 760, 6751 Quis Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (122, N'Dis Parturient Corporation', N'cubilia Curae;', CAST(0x0000A63F00000000 AS DateTime), N'882-6704 Ad Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (123, N'Cubilia Curae; Phasellus Associates', N'lacus.', CAST(0x0000A59600000000 AS DateTime), N'Ap #347-4176 Est. St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (124, N'Ullamcorper Company', N'at risus.', CAST(0x0000A6DA00000000 AS DateTime), N'433-6770 Accumsan Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (125, N'Enim Consequat Purus Industries', N'Aenean eget', CAST(0x0000A6DD00000000 AS DateTime), N'P.O. Box 315, 9895 Magna. Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (126, N'Egestas Fusce Aliquet Limited', N'eu', CAST(0x0000A66500000000 AS DateTime), N'857-7976 Integer Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (127, N'Magna Incorporated', N'ac, fermentum', CAST(0x0000A5F000000000 AS DateTime), N'P.O. Box 481, 3930 Diam Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (128, N'Suspendisse Corp.', N'magnis', CAST(0x0000A70B00000000 AS DateTime), N'Ap #346-1776 Integer Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (129, N'Pharetra Quisque Corporation', N'Nunc', CAST(0x0000A57200000000 AS DateTime), N'Ap #558-7346 Sed, Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (130, N'Massa Company', N'euismod ac,', CAST(0x0000A59A00000000 AS DateTime), N'452-7184 Sit Road', NULL, NULL, NULL, NULL, NULL)
GO
print 'Processed 100 total records'
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (131, N'Nullam Suscipit PC', N'Aliquam tincidunt,', CAST(0x0000A53000000000 AS DateTime), N'P.O. Box 437, 3322 Dui. Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (132, N'Suspendisse PC', N'turpis. Nulla', CAST(0x0000A4F000000000 AS DateTime), N'520-7764 Semper St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (133, N'Ut Sem Nulla Consulting', N'natoque penatibus', CAST(0x0000A5B700000000 AS DateTime), N'784-5790 Senectus St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (134, N'Risus Quis Ltd', N'fringilla cursus', CAST(0x0000A57500000000 AS DateTime), N'Ap #225-5165 Mollis Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (135, N'Euismod Incorporated', N'nonummy. Fusce', CAST(0x0000A58A00000000 AS DateTime), N'P.O. Box 522, 9682 Accumsan Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (136, N'Diam Lorem LLP', N'Donec', CAST(0x0000A69700000000 AS DateTime), N'424-1401 Ac Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (137, N'Nibh LLC', N'malesuada', CAST(0x0000A5AC00000000 AS DateTime), N'Ap #596-1871 Phasellus St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (138, N'Eleifend Egestas Sed Associates', N'suscipit,', CAST(0x0000A47000000000 AS DateTime), N'P.O. Box 526, 9393 Nec Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (139, N'Et Eros Ltd', N'eget', CAST(0x0000A47400000000 AS DateTime), N'Ap #996-9770 Nec Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (140, N'Sit Amet Massa Limited', N'leo,', CAST(0x0000A5A700000000 AS DateTime), N'629-2724 Porttitor Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (141, N'Ipsum Associates', N'vel, convallis', CAST(0x0000A52800000000 AS DateTime), N'Ap #271-8338 Tempus Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (142, N'Euismod Corporation', N'imperdiet', CAST(0x0000A6D100000000 AS DateTime), N'Ap #200-5364 Eget Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (143, N'Luctus Corporation', N'justo faucibus', CAST(0x0000A61800000000 AS DateTime), N'392-7710 Fermentum Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (144, N'Pede Ac Urna Corporation', N'Curabitur vel', CAST(0x0000A6BE00000000 AS DateTime), N'P.O. Box 319, 5164 Non Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (145, N'Nascetur Ridiculus Mus Corp.', N'at,', CAST(0x0000A4B600000000 AS DateTime), N'Ap #131-6641 Sem St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (146, N'Neque Sed Institute', N'erat vel', CAST(0x0000A67800000000 AS DateTime), N'893-1650 Eget, Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (147, N'Tempor Arcu Incorporated', N'aptent taciti', CAST(0x0000A68800000000 AS DateTime), N'Ap #280-2039 Et, St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (148, N'Sed Incorporated', N'Curabitur vel', CAST(0x0000A55200000000 AS DateTime), N'P.O. Box 414, 540 Auctor, Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (149, N'Facilisis Incorporated', N'eu,', CAST(0x0000A54800000000 AS DateTime), N'Ap #875-5271 Eu St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (150, N'Bibendum Sed Incorporated', N'faucibus', CAST(0x0000A55400000000 AS DateTime), N'P.O. Box 724, 4242 Blandit St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (151, N'Quisque Institute', N'Donec felis', CAST(0x0000A52800000000 AS DateTime), N'Ap #500-5676 Id Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (152, N'Leo Corp.', N'Suspendisse aliquet', CAST(0x0000A4B700000000 AS DateTime), N'451-3698 Faucibus Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (153, N'Nullam Enim Sed Institute', N'felis,', CAST(0x0000A66F00000000 AS DateTime), N'P.O. Box 514, 5848 Sit Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (154, N'Aliquam Company', N'aliquet. Phasellus', CAST(0x0000A68D00000000 AS DateTime), N'4052 Iaculis Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (155, N'Nec Mauris Corporation', N'elementum purus,', CAST(0x0000A55200000000 AS DateTime), N'Ap #622-807 Nulla Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (156, N'Malesuada Ut Inc.', N'blandit viverra.', CAST(0x0000A61300000000 AS DateTime), N'9877 Leo. Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (157, N'Arcu Corporation', N'Aliquam', CAST(0x0000A53200000000 AS DateTime), N'Ap #979-4467 Nulla Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (158, N'Nunc Mauris Foundation', N'porttitor', CAST(0x0000A55D00000000 AS DateTime), N'P.O. Box 975, 9053 Massa. Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (159, N'Sed Eget Associates', N'lectus.', CAST(0x0000A67200000000 AS DateTime), N'P.O. Box 158, 1421 Vel Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (160, N'Quis LLP', N'Nam tempor', CAST(0x0000A49300000000 AS DateTime), N'Ap #885-1240 Iaculis St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (161, N'Nec Urna Industries', N'pharetra ut,', CAST(0x0000A57D00000000 AS DateTime), N'P.O. Box 356, 3957 Nunc St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (162, N'Quisque LLC', N'ante', CAST(0x0000A5CA00000000 AS DateTime), N'P.O. Box 649, 2052 Nec, Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (163, N'Pharetra Associates', N'tellus, imperdiet', CAST(0x0000A61100000000 AS DateTime), N'322-904 Nullam Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (164, N'Sit Amet Consectetuer PC', N'placerat.', CAST(0x0000A6FA00000000 AS DateTime), N'P.O. Box 540, 8203 Malesuada Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (165, N'Tincidunt Vehicula Corp.', N'facilisis', CAST(0x0000A66600000000 AS DateTime), N'5584 Lacus. Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (166, N'Orci Corporation', N'amet', CAST(0x0000A5B900000000 AS DateTime), N'Ap #136-2293 Dolor. Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (167, N'Lorem Foundation', N'congue,', CAST(0x0000A6FF00000000 AS DateTime), N'2527 Mi Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (168, N'Eros Nec Foundation', N'aliquet molestie', CAST(0x0000A58700000000 AS DateTime), N'Ap #720-1859 Urna St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (169, N'Mattis LLP', N'et', CAST(0x0000A55400000000 AS DateTime), N'5408 Eu Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (170, N'Facilisis Vitae Orci LLP', N'tortor. Nunc', CAST(0x0000A49200000000 AS DateTime), N'Ap #223-885 Malesuada St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (171, N'Nunc Quisque Limited', N'Duis elementum,', CAST(0x0000A53000000000 AS DateTime), N'Ap #901-6736 Quisque St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (172, N'Justo Associates', N'ullamcorper', CAST(0x0000A53600000000 AS DateTime), N'P.O. Box 397, 9360 Auctor St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (173, N'Conubia Nostra Per Ltd', N'tristique', CAST(0x0000A49500000000 AS DateTime), N'P.O. Box 406, 309 Amet, St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (174, N'Cras Sed Leo Consulting', N'nonummy ultricies', CAST(0x0000A70900000000 AS DateTime), N'P.O. Box 317, 9591 Laoreet St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (175, N'Nunc Industries', N'elit, pharetra', CAST(0x0000A67100000000 AS DateTime), N'P.O. Box 960, 2866 Massa. St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (176, N'Phasellus Vitae Ltd', N'convallis', CAST(0x0000A4F500000000 AS DateTime), N'P.O. Box 300, 8846 Bibendum. Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (177, N'Cras Institute', N'eu', CAST(0x0000A47900000000 AS DateTime), N'P.O. Box 820, 5174 Maecenas Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (178, N'Non Lobortis Inc.', N'egestas.', CAST(0x0000A6AB00000000 AS DateTime), N'Ap #930-2693 Nulla St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (179, N'Lacinia PC', N'fringilla', CAST(0x0000A62300000000 AS DateTime), N'766-2884 Lacinia Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (180, N'Lacus Nulla Company', N'mi lacinia', CAST(0x0000A58D00000000 AS DateTime), N'P.O. Box 453, 8513 Euismod Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (181, N'Hendrerit Consectetuer Institute', N'Vestibulum', CAST(0x0000A58900000000 AS DateTime), N'Ap #153-4145 Placerat, Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (182, N'Aliquam Inc.', N'ac,', CAST(0x0000A60600000000 AS DateTime), N'Ap #381-413 Magna Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (183, N'Ipsum Sodales Purus LLC', N'Donec tempor,', CAST(0x0000A50D00000000 AS DateTime), N'P.O. Box 943, 4779 Lobortis Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (184, N'Phasellus Fermentum Incorporated', N'elit, dictum', CAST(0x0000A65900000000 AS DateTime), N'P.O. Box 462, 2129 Vel Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (185, N'Dolor Inc.', N'dolor vitae', CAST(0x0000A4ED00000000 AS DateTime), N'Ap #228-1322 Consectetuer Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (186, N'Dictum Institute', N'ac facilisis', CAST(0x0000A70800000000 AS DateTime), N'Ap #121-5534 Tellus Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (187, N'Volutpat Limited', N'sed, hendrerit', CAST(0x0000A53600000000 AS DateTime), N'Ap #882-1086 Tempus Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (188, N'Duis Cursus Diam Company', N'netus', CAST(0x0000A45900000000 AS DateTime), N'P.O. Box 207, 4344 Proin Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (189, N'Non Associates', N'commodo', CAST(0x0000A53300000000 AS DateTime), N'P.O. Box 193, 1946 Dictum Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (190, N'Sem Consequat LLP', N'ut', CAST(0x0000A69500000000 AS DateTime), N'2663 Cum Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (191, N'Nec Tempus Mauris Limited', N'turpis', CAST(0x0000A58F00000000 AS DateTime), N'Ap #124-1819 Proin Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (192, N'Quis Limited', N'nulla', CAST(0x0000A64300000000 AS DateTime), N'Ap #148-1678 Quam St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (193, N'In Molestie PC', N'Curabitur massa.', CAST(0x0000A43F00000000 AS DateTime), N'543-1592 Consectetuer Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (194, N'Cras Limited', N'velit eget', CAST(0x0000A4F300000000 AS DateTime), N'P.O. Box 886, 4566 Vel, St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (195, N'Nibh Dolor Corp.', N'lorem', CAST(0x0000A63500000000 AS DateTime), N'2409 Iaculis St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (196, N'Pede Sagittis Augue Foundation', N'Aenean euismod', CAST(0x0000A50500000000 AS DateTime), N'8631 Dolor Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (197, N'Leo Cras Vehicula LLP', N'dapibus gravida.', CAST(0x0000A5D500000000 AS DateTime), N'2004 Dolor. Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (198, N'Proin Dolor Corporation', N'Mauris', CAST(0x0000A47800000000 AS DateTime), N'183-780 Libero Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (199, N'Augue Id Institute', N'magna,', CAST(0x0000A54C00000000 AS DateTime), N'5601 Nunc Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (200, N'In Associates', N'quam dignissim', CAST(0x0000A52000000000 AS DateTime), N'Ap #737-2347 Nullam Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (201, N'Et Ultrices LLP', N'penatibus', CAST(0x0000A4F600000000 AS DateTime), N'Ap #427-7688 Id Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (202, N'Vel Pede Corporation', N'ut', CAST(0x0000A4E800000000 AS DateTime), N'174-5622 Lorem. St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (203, N'Venenatis Vel Faucibus Foundation', N'placerat,', CAST(0x0000A44300000000 AS DateTime), N'6337 Aenean Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (204, N'Arcu Curabitur Ut Incorporated', N'ut', CAST(0x0000A4D200000000 AS DateTime), N'Ap #854-3517 In, Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (205, N'Convallis Erat Incorporated', N'semper egestas,', CAST(0x0000A62F00000000 AS DateTime), N'P.O. Box 998, 9492 A, Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (206, N'Justo Ltd', N'auctor,', CAST(0x0000A5D700000000 AS DateTime), N'P.O. Box 633, 5520 Arcu Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (207, N'Non Quam Pellentesque Incorporated', N'aliquet lobortis,', CAST(0x0000A5D200000000 AS DateTime), N'Ap #846-4618 Sem Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (208, N'Enim Ltd', N'ante', CAST(0x0000A49000000000 AS DateTime), N'Ap #701-2778 Neque Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (209, N'Nisi Consulting', N'fermentum', CAST(0x0000A58300000000 AS DateTime), N'5862 A Ave', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (210, N'Sem Molestie LLC', N'vulputate,', CAST(0x0000A5E400000000 AS DateTime), N'Ap #721-1769 Faucibus. Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (211, N'Nulla Cras Eu Ltd', N'augue ac', CAST(0x0000A45C00000000 AS DateTime), N'1115 Taciti Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (212, N'Et Rutrum Corp.', N'et arcu', CAST(0x0000A62300000000 AS DateTime), N'6762 Maecenas St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (213, N'Mauris Inc.', N'Cras', CAST(0x0000A46200000000 AS DateTime), N'4225 Nibh St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (214, N'Sed Est Nunc Consulting', N'tempus risus.', CAST(0x0000A6CA00000000 AS DateTime), N'P.O. Box 423, 8561 Sagittis. Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (215, N'Orci Lacus Incorporated', N'et,', CAST(0x0000A69900000000 AS DateTime), N'Ap #308-8518 Etiam Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (216, N'Ipsum Nunc Id Inc.', N'faucibus leo,', CAST(0x0000A62100000000 AS DateTime), N'P.O. Box 317, 8763 Vivamus Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (217, N'Porta Inc.', N'sem', CAST(0x0000A6B000000000 AS DateTime), N'653-5985 Morbi Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (218, N'Vitae Orci Institute', N'risus, at', CAST(0x0000A67700000000 AS DateTime), N'P.O. Box 460, 7660 Malesuada. Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (219, N'Etiam Ligula Tortor Incorporated', N'porttitor', CAST(0x0000A45F00000000 AS DateTime), N'Ap #160-335 Magna Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (220, N'Convallis Erat Eget LLC', N'lacus.', CAST(0x0000A5BF00000000 AS DateTime), N'P.O. Box 891, 7254 Risus. St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (221, N'Egestas Consulting', N'penatibus', CAST(0x0000A67200000000 AS DateTime), N'P.O. Box 760, 6751 Quis Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (222, N'Dis Parturient Corporation', N'cubilia Curae;', CAST(0x0000A63F00000000 AS DateTime), N'882-6704 Ad Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (223, N'Cubilia Curae; Phasellus Associates', N'lacus.', CAST(0x0000A59600000000 AS DateTime), N'Ap #347-4176 Est. St.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (224, N'Ullamcorper Company', N'at risus.', CAST(0x0000A6DA00000000 AS DateTime), N'433-6770 Accumsan Rd.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (225, N'Enim Consequat Purus Industries', N'Aenean eget', CAST(0x0000A6DD00000000 AS DateTime), N'P.O. Box 315, 9895 Magna. Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (226, N'Egestas Fusce Aliquet Limited', N'eu', CAST(0x0000A66500000000 AS DateTime), N'857-7976 Integer Av.', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (227, N'Magna Incorporated', N'ac, fermentum', CAST(0x0000A5F000000000 AS DateTime), N'P.O. Box 481, 3930 Diam Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (228, N'Suspendisse Corp.', N'magnis', CAST(0x0000A70B00000000 AS DateTime), N'Ap #346-1776 Integer Avenue', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (229, N'Pharetra Quisque Corporation', N'Nunc', CAST(0x0000A57200000000 AS DateTime), N'Ap #558-7346 Sed, Street', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (230, N'Massa Company', N'euismod ac,', CAST(0x0000A59A00000000 AS DateTime), N'452-7184 Sit Road', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (232, N'test', N'forfun', CAST(0x0000A5A00166B664 AS DateTime), N'sample string 5', 1, 1, 1, 1.0000, N'@@')
GO
print 'Processed 200 total records'
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (233, N'test', N'forfun', CAST(0x0000A5A00166B664 AS DateTime), N'sample string 5', 1, 1, 1, 1.0000, N'@@')
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (234, N'FFE', N'final fantasy explorers', CAST(0x0000A5A300000000 AS DateTime), N'home', 1, 1, 1, 1.0000, N'@@')
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (235, N'FFE', N'final fantasy explorers', CAST(0x0000A5A300000000 AS DateTime), N'home', 1, 1, 1, 1.0000, N'@@')
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (236, N'FFE', N'final fantasy explorers', CAST(0x0000A5A300000000 AS DateTime), N'home', 1, 1, 1, 1.0000, N'@@')
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (237, N'FFE', N'final fantasy explorers', CAST(0x0000A5A300000000 AS DateTime), N'home', 1, 1, 1, 1.0000, N'@@')
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (238, N'FFE', N'final fantasy explorers', CAST(0x0000A5A300000000 AS DateTime), N'home', 1, 1, 1, 1.0000, N'@@')
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (239, N'FFE', N'final fantasy explorers', CAST(0x0000A5A300000000 AS DateTime), N'home', 1, 1, 1, 1.0000, N'@@')
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (240, N'FFE', N'final fantasy explorers', CAST(0x0000A5A300000000 AS DateTime), N'home', 1, 1, 1, 1.0000, N'@@')
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (241, N'FFE', N'final fantasy explorers', CAST(0x0000A5A300000000 AS DateTime), N'home', 1, 1, 1, 1.0000, N'@@')
INSERT [dbo].[Event] ([ID], [Name], [Info], [Time], [Place], [MaxAttendance], [RequireAttendance], [Vote], [Price], [Image]) VALUES (242, N'FFE', N'final fantasy explorers', CAST(0x0000A5A700000000 AS DateTime), N'home', 1, 1, 1, 1.0000, N'@@')
SET IDENTITY_INSERT [dbo].[Event] OFF
/****** Object:  Table [dbo].[Category]    Script Date: 02/15/2016 18:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON
INSERT [dbo].[Category] ([ID], [Name]) VALUES (1, N'test')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (2, N'category2')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (3, N'category3')
SET IDENTITY_INSERT [dbo].[Category] OFF
/****** Object:  Table [dbo].[EventUserRole]    Script Date: 02/15/2016 18:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EventUserRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EventUserRole](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_EventUserRole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[EventUserRole] ON
INSERT [dbo].[EventUserRole] ([ID], [Role]) VALUES (1, N'Master')
INSERT [dbo].[EventUserRole] ([ID], [Role]) VALUES (2, N'Supporter')
INSERT [dbo].[EventUserRole] ([ID], [Role]) VALUES (3, N'Member')
SET IDENTITY_INSERT [dbo].[EventUserRole] OFF
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 02/15/2016 18:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoles]') AND name = N'RoleNameIndex')
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles] 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 02/15/2016 18:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[__MigrationHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201601261319341_InitialCreate', N'YTicket.API2.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5C5B6FE3B6127E3FC0F90F829ECE3948AD5CBA8B6D60EF22759273826E2E58678B9EA7052DD10EB112A54A549AA0E82FEB437F52FF428712254BBCE8622BB6532CB088C8E137C3E1901C0E87FEF3F73FC61F9E02DF7AC47142423AB18F4687B685A91B7A842E2776CA16DFBCB33FBCFFE73FC6175EF064FD58D09D703A68499389FDC05874EA3889FB8003948C02E2C661122ED8C80D030779A1737C78F89D7374E46080B001CBB2C69F52CA4880B30FF89C86D4C5114B917F1D7AD84F4439D4CC3254EB06053889908B27F6FFEF89FB15B3D1D9DDD5F12827B7AD339F20106586FD856D214A438618087AFA39C133168774398BA000F9F7CF1106BA05F2132C3A70BA22EFDA97C363DE1767D5B08072D38485414FC0A313A11C476EBE968AED5279A0BE0B50337BE6BDCE5438B1AF3C9C157D0A7D5080CCF074EAC79C78625F972CCE92E806D45D341CE5909731C0FD12C65F4755C403AB73BB83D2988E4787FCDF81354D7D96C6784271CA62E41F5877E9DC27EE0FF8F93EFC8AE9E4E468BE3879F7E62DF24EDE7E8B4FDE547B0A7D05BA5A0114DDC5618463900D2FCAFEDB96536FE7C80DCB669536B956C096605ED8D6357AFA88E9923DC08C397E675B97E4097B458930AECF94C03482462C4EE1F326F57D34F77159EF34F2E4FF37703D7EF37610AE37E8912CB3A197F8C3C489615E7DC27E569B3C90289F5EB5F1FE22C82EE330E0DF75FBCA6BBFCCC2347679674223C93D8A9798D5A51B3B2BE3ED64D21C6A78B32E50F7DFB4B9A4AA796B497987D69909058B6DCF8642DE97E5DBD9E2CEA208062F332DAE912683D3EC5623A9F98155255A19CF5157E3A1D0A9BFF35A781120E20FB01876E0028EC882C4012E7BF97D08A687686F99EF5092C05AE0FD0F250F0DA2C39F03883EC36E1A8389CE180AA217E776F710527C9306736EF9DBE335D8D0DCFF125E229785F105E5AD36C6FB18BA5FC3945D50EF1C31FC99B90520FFBC2741778041C439735D9C249760CCD89B86E067178057949D1CF786E32BD4AE9D91A98F48A0F746A4B5F44B41BAF248F4148A576220D379264DA27E0C97847613B520358B9A53B48A2AC8FA8ACAC1BA492A28CD826604AD72E65483F97AD9080DEFEC65B0FBEFED6DB6799BD6828A1A67B042E2FF628A6358C6BC3BC4188EE96A04BAAC1BBB7016B2E1E34C5F7C6FCA38FD88FC7468566BCD866C11187E3664B0FB3F1B3231A1F89178DC2BE970042A8801BE13BDFE74D53EE724C9B63D1D6ADDDC36F3EDAC01A6E9729624A14BB259A0097E89D0455D7EF0E1ACF63846DE1B3916021D0343277CCB8312E89B2D1BD52D3DC73E66D83A73F3E0E014252EF254354287BC1E82153BAA46B0554CA42EDC7F149E60E938E68D103F042530530965EAB420D42511F25BB524B5ECB885F1BE973CE49A731C61CA19B66AA20B737D08840B50F29106A54D4363A76271CD8668F05A4D63DEE6C2AEC65D894C6CC5265B7C67835D0AFFED450CB359635B30CE66957411C018CEDB85818AB34A5703900F2EFB66A0D289C960A0C2A5DA8A81D635B60303ADABE4D519687E44ED3AFED27975DFCCB37E50DEFEB6DEA8AE1DD8664D1F7B669AB9EF096D18B4C0B16A9EE7735E899F98E67006728AF359225C5DD94438F80CB37AC866E5EF6AFD50A7194436A226C095A1B5808A8B40054899503D842B62798DD2092FA2076C11776B84156BBF045BB10115BB7A215A21345F9BCAC6D9E9F451F6ACB406C5C83B1D162A381A839017AF7AC73B28C514975515D3C517EEE30D573A2606A341412D9EAB4149456706D752619AED5AD239647D5CB28DB424B94F062D159D195C4BC246DB95A4710A7AB8051BA9A8BE850F34D98A4847B9DB947563274F94120563C7905135BE465144E8B29261254AAC599E5E35FD66D63FED28C8311C37D1641F95D2969C5818A325966A8135487A49E2849D2386E688C779A65EA09069F756C3F25FB0AC6E9FEA2016FB4041CDFFCE5BE8AEEF6B9BADEA8D08904BE862C05D9A2C8EAE31007D738BA7BC211FC59AD0FD34F4D3809A3D2C73EBFC02AFDA3E2F5111C68E24BFE24129EA52FCDCBAEE3B8D8C3A2B861AA5D283597FA4CC10267D17FE6755E3269FD48C5284A8AA28A6B0D5CE46CEE4CAF41B2DD94DEC3F58AD082F33B3446E4A154014F5C4A8A437286095BAEEA8F50C942A66BDA63BA29466528594AA7A48594D26A90959AD580BCFA0513D45770E6AFA48155DADED8EAC4924A9426BAAD7C0D6C82CD77547D5E49A548135D5DDB1578927F22ABAC77B97F1F0B2FEE6951F7037DBBD0C182FB3240EB3F955EEF1AB4095E29E58E2A65E0113E57B694EC653DEFAE6940736363327038679EDA95D81D7979EC67B7B3366ED5EBBB6BC37DDEB9BF1FA19ED8B9A8672CA93494AEEE5694F3AD58DC509ABFD318D72E4CA496CAB50236CEDCF09C3C188138C663FFB539F60BE901704D78892054E589ECB61C389F09DF41C677F9EC63849E2F99A13AAE97D4C7DCCB69096451F51EC3EA0584D92D8E0F9C80A54893F5F510F3F4DEC5FB356A7592883FF95151F5857C9674A7E4EA1E23E4EB1F59B9AF4394C3A7DF3396B4F1F3F74D7EAD54F5FF2A607D66D0C33E6D43A9474B9CE08D79F44F492266FBA81346B3F9478BD13AAF606418B2A4D88F59F1CCC091BE4B94121E5BF02F4F4EFBEA2699F146C84A879363014DE202A343D0B5807CBF824C0834F963D09E8D759FD13817544333E0F20B43F98FC38A0FB3254B4DCE156A339146D6349CAF4DC9A5CBD51A6E5AEF72625077BA389AEE659F780DB20977A0DCB786569C883ED8E9A2CE3C1B07769DA2F9E5ABC2FD9C4AB3C8FDD26116F336FB8E166E86F952EBC07096E9A849DDD27056FDBD64C81DC3DCFACEC97FABB67C626D2B8769FE0BB6D63338579F7DCD87AA5F1EE99ADED6AFFDCB1A575DE42779E94ABE617192E6474B1E0B6A4DB3C700E27FC790846907B94F95B497D965753866A0BC3158999A939BD4C66AC4C1C85AF42D1CCB65F5FC586DFD85941D3CCD69094D9C45BACFF8DBC054D336F43AAE32ED285B5C986BA14EE9675AC290FEA35A507D77AD2928DDEE6B336DEAEBFA66CE04194529B3D863BE2D793FC3B884A869C3A3D927DD5EB5ED83B2BBFB008FB7742962B08FE7B8B14BBB55DB3A4B9A28BB0D8BC25890A122942738D19F2604B3D8B1959209741358F31678FBDB3B81DBFE99863EF8ADEA62C4A1974190773BF16F0E24E4013FF2CA3B92EF3F836CA7EB764882E809884C7E66FE9F729F1BD52EE4B4D4CC800C1BD0B11D1E563C9786477F95C22DD84B42390505FE914DDE320F2012CB9A533F488D7910DCCEF235E22F77915013481B40F445DEDE3738296310A1281B16A0F9F60C35EF0F4FE2F47ADFBFE68540000, N'6.1.3-40302')
/****** Object:  Table [dbo].[Notification]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Notification]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Notification](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Information] [varchar](150) NOT NULL,
	[UserID] [int] NOT NULL,
	[New] [bit] NOT NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[UserPaging]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserPaging]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UserPaging] 
	-- Add the parameters for the stored procedure here
	@PageNumber int,
	@RowspPage int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ID, Username, Image FROM (
             SELECT ROW_NUMBER() OVER(ORDER BY ID) AS NUMBER, ID, Username, Image FROM [User]
               ) AS TBL
	WHERE NUMBER BETWEEN ((@PageNumber - 1) * @RowspPage + 1) AND (@PageNumber * @RowspPage)
	ORDER BY NUMBER
END
' 
END
GO
/****** Object:  Table [dbo].[UserCategory]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserCategory](
	[UserID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_UserFavCategory] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[EventUser]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EventUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EventUser](
	[EventID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_EventUser] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[EventUser] ([EventID], [UserID], [RoleID]) VALUES (50, 1, 3)
INSERT [dbo].[EventUser] ([EventID], [UserID], [RoleID]) VALUES (50, 2, 3)
INSERT [dbo].[EventUser] ([EventID], [UserID], [RoleID]) VALUES (50, 3, 1)
INSERT [dbo].[EventUser] ([EventID], [UserID], [RoleID]) VALUES (60, 2, 1)
INSERT [dbo].[EventUser] ([EventID], [UserID], [RoleID]) VALUES (61, 1, 1)
INSERT [dbo].[EventUser] ([EventID], [UserID], [RoleID]) VALUES (70, 2, 2)
INSERT [dbo].[EventUser] ([EventID], [UserID], [RoleID]) VALUES (98, 2, 3)
/****** Object:  StoredProcedure [dbo].[EventPaging]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EventPaging]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EventPaging] 
	-- Add the parameters for the stored procedure here
	@PageNumber int,
	@RowspPage int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ID, Name, Time, Place, Image FROM (
             SELECT ROW_NUMBER() OVER(ORDER BY ID) AS NUMBER, ID, Name, Time, Place, Image  FROM Event
               ) AS TBL
	WHERE NUMBER BETWEEN ((@PageNumber - 1) * @RowspPage + 1) AND (@PageNumber * @RowspPage)
	ORDER BY NUMBER
END
' 
END
GO
/****** Object:  Table [dbo].[EventCategory]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EventCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EventCategory](
	[EventID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_EventCategory] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (37, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (50, 3)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (56, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (79, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (90, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (98, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (100, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (101, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (109, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (110, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (119, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (119, 2)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (120, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (120, 2)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (169, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (176, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (178, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (187, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (188, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (189, 2)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (190, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (209, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (209, 2)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (219, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (233, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (233, 2)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (234, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (234, 3)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (235, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (235, 3)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (239, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (239, 3)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (240, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (240, 3)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (241, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (241, 3)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (242, 1)
INSERT [dbo].[EventCategory] ([EventID], [CategoryID]) VALUES (242, 2)
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND name = N'UserNameIndex')
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers] 
(
	[UserName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'47c4c2c4-3144-4df3-8daa-feb5633b6476', N'trung@yahoo.com', 0, N'AEdi5Jg/olgfCnEx63C1z/JH8pn78UPimdRoQ4DW9LuEoC4nGNNGVypg81O5lCrViw==', N'e186c733-6328-4da3-b813-0aabcc48ba84', NULL, 0, 0, NULL, 0, 0, N'trung@yahoo.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'538845bd-7408-4f3d-a2f7-b1b335ae4f6b', N'test@yahoo.com', 0, N'AEJM6H9Ml7ETVOqlRsupBbc2vPYd8dedc30Hy6sy0JrKKInqWKLCk5mTAbcxJpGBOA==', N'3b8dac6e-eea0-484b-979c-481b7b04807a', NULL, 0, 0, NULL, 0, 0, N'test@yahoo.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'8b276919-8431-42af-b7e2-8d77e67cc0ba', N'linh@yahoo.com', 0, N'AMdnkwjYuxxlddZYTazqWtqzLi6KGbaR3HRfuuklizGp1s0OureiHcAAUmjrc8CsbQ==', N'c00a20b4-65c1-4595-87f2-ca6dbf22e175', NULL, 0, 0, NULL, 0, 0, N'linh@yahoo.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'd25d9cdf-c40a-4f67-a678-e13aa5f4d0d9', N'trang@yahoo.com', 0, N'ABaZ/zTNBOeOvQ1r3qB4qE+F/JbG3qXl2MJjuUn0W5XNA03H4WdR+sflyXIx3gJYzA==', N'4f89c64b-5236-4eea-8820-13af84489874', NULL, 0, 0, NULL, 0, 0, N'trang@yahoo.com')
/****** Object:  Trigger [OnInsertAspUser]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[OnInsertAspUser]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[OnInsertAspUser]
   ON  [dbo].[AspNetUsers]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO dbo.[User] (Username, Email)
	SELECT Email, Email
	FROM inserted
END
'
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND name = N'IX_RoleId')
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles] 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND name = N'IX_UserId')
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles] 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND name = N'IX_UserId')
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins] 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 02/15/2016 18:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND name = N'IX_UserId')
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims] 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_UserCategory_Category]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserCategory_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserCategory]'))
ALTER TABLE [dbo].[UserCategory]  WITH CHECK ADD  CONSTRAINT [FK_UserCategory_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserCategory_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserCategory]'))
ALTER TABLE [dbo].[UserCategory] CHECK CONSTRAINT [FK_UserCategory_Category]
GO
/****** Object:  ForeignKey [FK_UserCategory_User]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserCategory_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserCategory]'))
ALTER TABLE [dbo].[UserCategory]  WITH CHECK ADD  CONSTRAINT [FK_UserCategory_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserCategory_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserCategory]'))
ALTER TABLE [dbo].[UserCategory] CHECK CONSTRAINT [FK_UserCategory_User]
GO
/****** Object:  ForeignKey [FK_Notification_User]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Notification_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[Notification]'))
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Notification_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[Notification]'))
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_User]
GO
/****** Object:  ForeignKey [FK_EventUser_Event]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventUser_Event]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventUser]'))
ALTER TABLE [dbo].[EventUser]  WITH CHECK ADD  CONSTRAINT [FK_EventUser_Event] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventUser_Event]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventUser]'))
ALTER TABLE [dbo].[EventUser] CHECK CONSTRAINT [FK_EventUser_Event]
GO
/****** Object:  ForeignKey [FK_EventUser_EventUserRole]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventUser_EventUserRole]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventUser]'))
ALTER TABLE [dbo].[EventUser]  WITH CHECK ADD  CONSTRAINT [FK_EventUser_EventUserRole] FOREIGN KEY([RoleID])
REFERENCES [dbo].[EventUserRole] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventUser_EventUserRole]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventUser]'))
ALTER TABLE [dbo].[EventUser] CHECK CONSTRAINT [FK_EventUser_EventUserRole]
GO
/****** Object:  ForeignKey [FK_EventUser_User]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventUser_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventUser]'))
ALTER TABLE [dbo].[EventUser]  WITH CHECK ADD  CONSTRAINT [FK_EventUser_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventUser_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventUser]'))
ALTER TABLE [dbo].[EventUser] CHECK CONSTRAINT [FK_EventUser_User]
GO
/****** Object:  ForeignKey [FK_EventCategory_Category]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventCategory_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventCategory]'))
ALTER TABLE [dbo].[EventCategory]  WITH CHECK ADD  CONSTRAINT [FK_EventCategory_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventCategory_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventCategory]'))
ALTER TABLE [dbo].[EventCategory] CHECK CONSTRAINT [FK_EventCategory_Category]
GO
/****** Object:  ForeignKey [FK_EventCategory_Event]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventCategory_Event]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventCategory]'))
ALTER TABLE [dbo].[EventCategory]  WITH CHECK ADD  CONSTRAINT [FK_EventCategory_Event] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventCategory_Event]') AND parent_object_id = OBJECT_ID(N'[dbo].[EventCategory]'))
ALTER TABLE [dbo].[EventCategory] CHECK CONSTRAINT [FK_EventCategory_Event]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]'))
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]'))
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]    Script Date: 02/15/2016 18:58:12 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]'))
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]'))
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
