USE [master]
GO
/****** Object:  Database [CompanyDB]    Script Date: 25/06/2022 21:20:30 ******/
CREATE DATABASE [CompanyDB]
GO
ALTER DATABASE [CompanyDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CompanyDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CompanyDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CompanyDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CompanyDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CompanyDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CompanyDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CompanyDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CompanyDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CompanyDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CompanyDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CompanyDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CompanyDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CompanyDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CompanyDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CompanyDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CompanyDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CompanyDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CompanyDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CompanyDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CompanyDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CompanyDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CompanyDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CompanyDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CompanyDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CompanyDB] SET  MULTI_USER 
GO
ALTER DATABASE [CompanyDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CompanyDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CompanyDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CompanyDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CompanyDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CompanyDB] SET QUERY_STORE = OFF
GO
USE [CompanyDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [CompanyDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fnConvertGender]    Script Date: 25/06/2022 21:20:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* fnConvertGender */

CREATE FUNCTION [dbo].[fnConvertGender](@gender CHAR(1)) 
RETURNS nvarchar(10)
AS 
BEGIN
   IF @gender = 'M' return 'man';
   IF @gender = 'F' return 'vrouw';
   return 'onbekend';   
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnValidEmail]    Script Date: 25/06/2022 21:20:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* fnValidEmail */

CREATE FUNCTION [dbo].[fnValidEmail](@email varchar(255))

RETURNS BIT AS
BEGIN     
  DECLARE @result as Bit
  IF (@email <> '' AND @email NOT LIKE '_%@__%.__%')
     SET @result = 0  
  ELSE 
    SET @result = 1   
  RETURN @result
END 
GO
/****** Object:  UserDefinedFunction [dbo].[fnValidGender]    Script Date: 25/06/2022 21:20:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* fnValidGender */

CREATE FUNCTION [dbo].[fnValidGender]( @gender char(1) )
RETURNS BIT
AS 
BEGIN
   /* declare variables */
   DECLARE @result BIT

   /* calculate */
   IF @gender = 'M' OR @gender = 'F' OR @gender = 'O' 
      SET @result = 1
   ELSE
      SET @result = 0

   /* return */
   RETURN @result;
END
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 25/06/2022 21:20:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[firstname] [nvarchar](50) NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[gender] [tinyint] NOT NULL,
	[birthdate] [date] NOT NULL,
	[accesscode] [int] NULL,
	[boss_id] [int] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Job]    Script Date: 25/06/2022 21:20:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[startdate] [date] NOT NULL,
	[enddate] [date] NULL,
	[jobtitle] [nvarchar](50) NOT NULL,
	[employee_id] [int] NOT NULL,
 CONSTRAINT [PK_Job] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (1, N'Véronique', N'Coppens', N'ccoppens0@posterous.com', 1, CAST(N'1998-03-27' AS Date), 5894, 2)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (2, N'Géraldine', N'Nouch', N'cnouch1@who.int', 2, CAST(N'1956-09-04' AS Date), 1298, NULL)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (3, N'Thérèsa', N'Boatwright', N'bboatwright2@go.com', 2, CAST(N'1943-11-29' AS Date), 7244, 13)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (4, N'Sélène', N'Coursor', N'vcoursor3@nasa.gov', 1, CAST(N'1966-05-12' AS Date), 9494, 13)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (5, N'Maëlla', N'Procter', N'dprocter4@seesaa.be', 2, CAST(N'1989-06-20' AS Date), 9247, 2)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (6, N'Crééz', N'Saffill', N'csaffill5@google.nl', 2, CAST(N'1949-02-25' AS Date), NULL, 5)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (7, N'Poo', N'Snoddie', N'hsnoddy8@census.gov', 1, CAST(N'1980-12-31' AS Date), 7277, 13)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (8, N'Mà', N'Kempshall', N'bkempshall9@zdnet.com', 2, CAST(N'1989-05-09' AS Date), 3074, 1)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (9, N'Lóng', N'Dytham', N'adythama@yelp.com', 1, CAST(N'1993-02-24' AS Date), 9304, 18)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (10, N'Yóu', N'Sweetland', N'fsweetlandb@opensource.org', 1, CAST(N'1981-07-09' AS Date), NULL, 1)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (11, N'Desirée', N'Shemming', N'cshemmingc@cdc.gov', 2, CAST(N'1945-04-28' AS Date), 8122, 5)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (12, N'Maëlys', N'Kersaw', N'skersawd@naver.com', 2, CAST(N'1945-06-09' AS Date), 3083, 1)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (13, N'Réjane', N'St. Louis', N'cstlouise@mapy.cz', 2, CAST(N'1959-03-02' AS Date), 9731, 2)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (14, N'Alizée', N'Blue', N'abluef@freewebs.com', 2, CAST(N'1963-04-06' AS Date), 9781, 18)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (15, N'Kuí', N'Murra', N'dmurrag@delicious.com', 2, CAST(N'1994-02-27' AS Date), 9871, 1)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (16, N'Bérangère', N'Murcott', N'amurcotth@google.pl', 1, CAST(N'1989-05-09' AS Date), NULL, 1)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (17, N'Véronique', N'Daniell', N'mdanielli@sohu.com', 2, CAST(N'1973-01-18' AS Date), 1138, 13)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode], [boss_id]) VALUES (18, N'Audréanne', N'Cordero', N'pcorderoj@biblegateway.com', 2, CAST(N'1975-02-23' AS Date), 3892, 2)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[Job] ON 

INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (1, CAST(N'2016-02-06' AS Date), CAST(N'2016-06-06' AS Date), N'Recruiter', 7)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (2, CAST(N'2016-02-16' AS Date), CAST(N'2017-04-18' AS Date), N'Junior Programmer', 17)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (3, CAST(N'2016-06-06' AS Date), CAST(N'2017-06-14' AS Date), N'HR manager', 7)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (4, CAST(N'2016-06-13' AS Date), CAST(N'2019-12-08' AS Date), N'Junior Editor', 8)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (5, CAST(N'2016-08-13' AS Date), NULL, N'Administrative Officer', 11)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (6, CAST(N'2016-08-16' AS Date), CAST(N'2019-08-20' AS Date), N'Copywriter', 14)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (7, CAST(N'2016-09-25' AS Date), CAST(N'2017-06-24' AS Date), N'Actuary', 3)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (8, CAST(N'2016-10-28' AS Date), CAST(N'2018-06-11' AS Date), N'Junior Sales', 5)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (9, CAST(N'2016-12-18' AS Date), CAST(N'2017-11-01' AS Date), N'Help Desk Technician', 2)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (10, CAST(N'2017-04-18' AS Date), CAST(N'2018-03-24' AS Date), N'Senior Programmer', 17)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (11, CAST(N'2017-06-14' AS Date), CAST(N'2018-10-16' AS Date), N'Physical Therapy Assistant', 7)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (12, CAST(N'2017-06-24' AS Date), CAST(N'2018-05-09' AS Date), N'Junior Contractor', 3)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (13, CAST(N'2017-07-29' AS Date), CAST(N'2019-03-30' AS Date), N'Sales Executive', 15)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (14, CAST(N'2017-11-01' AS Date), CAST(N'2022-05-17' AS Date), N'Senior Financial Analyst', 2)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (15, CAST(N'2017-12-28' AS Date), CAST(N'2019-12-26' AS Date), N'Developer I', 1)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (16, CAST(N'2018-03-24' AS Date), CAST(N'2019-03-01' AS Date), N'Functional Analyst', 17)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (17, CAST(N'2018-05-09' AS Date), NULL, N'Computer Systems Analyst IV', 3)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (18, CAST(N'2018-06-11' AS Date), NULL, N'Sales Executive', 5)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (19, CAST(N'2018-10-16' AS Date), NULL, N'Paralegal', 7)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (20, CAST(N'2019-02-05' AS Date), CAST(N'2019-06-22' AS Date), N'Assitant Floor Manager', 12)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (21, CAST(N'2019-03-01' AS Date), NULL, N'Project leader', 17)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (22, CAST(N'2019-03-30' AS Date), NULL, N'Section head', 15)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (23, CAST(N'2019-06-22' AS Date), NULL, N'Floor Manager', 12)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (24, CAST(N'2019-08-20' AS Date), CAST(N'2021-08-01' AS Date), N'Social Media Specialist', 14)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (25, CAST(N'2019-09-11' AS Date), NULL, N'Trainer', 16)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (26, CAST(N'2019-12-08' AS Date), NULL, N'Senior Editor', 8)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (27, CAST(N'2019-12-26' AS Date), NULL, N'Developer II', 1)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (28, CAST(N'2020-01-02' AS Date), NULL, N'Programmer Analyst III', 4)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (29, CAST(N'2020-01-15' AS Date), CAST(N'2021-11-04' AS Date), N'Helpdesk', 6)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (30, CAST(N'2020-03-05' AS Date), NULL, N'Legal Assistant', 13)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (31, CAST(N'2020-03-16' AS Date), CAST(N'2022-03-17' AS Date), N'Accountant', 10)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (32, CAST(N'2020-11-22' AS Date), CAST(N'2021-12-22' AS Date), N'Cost Accountant', 18)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (33, CAST(N'2021-08-01' AS Date), NULL, N'PR manager', 14)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (34, CAST(N'2021-11-04' AS Date), CAST(N'2022-03-16' AS Date), N'IT assistant', 6)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (35, CAST(N'2021-12-22' AS Date), NULL, N'Budget Responsive', 18)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (36, CAST(N'2022-01-19' AS Date), NULL, N'Junior Designer', 9)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (37, CAST(N'2022-03-16' AS Date), NULL, N'Developer', 6)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (38, CAST(N'2022-03-17' AS Date), NULL, N'Financial Analyst', 10)
INSERT [dbo].[Job] ([id], [startdate], [enddate], [jobtitle], [employee_id]) VALUES (39, CAST(N'2022-05-17' AS Date), CAST(N'2017-11-01' AS Date), N'General Director', 2)
SET IDENTITY_INSERT [dbo].[Job] OFF
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Boss_Employee] FOREIGN KEY([boss_id])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Boss_Employee]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Employee] FOREIGN KEY([employee_id])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Employee]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_Accesscode] CHECK  (([accesscode]>=(1000) AND [accesscode]<(9999)))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CK_Employee_Accesscode]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_Gender] CHECK  (([gender]=(0) OR [gender]=(1) OR [gender]=(2) OR [gender]=(9)))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CK_Employee_Gender]
GO
/****** Object:  StoredProcedure [dbo].[spEditEmployee]    Script Date: 25/06/2022 21:20:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* spEditEmployee */

CREATE   PROCEDURE [dbo].[spEditEmployee]( 
   @id INT,
   @fn NVARCHAR(50),
   @ln NVARCHAR(50),
   @em NVARCHAR(255),
   @gen CHAR(1),
   @bd DATE,
   @ac INT
) AS
BEGIN
   /* declare variables */
   DECLARE @result INT;

   /* validate */
   IF dbo.fnValidEmail(@em) = 0
      BEGIN
         RAISERROR('incorrect email', 16, 1);
         RETURN 0;
      END
   IF dbo.fnValidGender(@gen) = 0
      BEGIN
         RAISERROR('incorrect gender', 16, 1);
         RETURN 0;
      END

   /* update */
   UPDATE Employees  
      SET firstname = @fn, lastname = @ln, email = @em, gender = @gen, birthdate = @bd, accesscode = @ac  
   WHERE ID = @id;

   /* return */
   RETURN 1;
END;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vier codes volgens ISO/IEC 5218 norm: 0 = onbekend, 1 = man, 2 = vrouw, 9 = niet van toepassing' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'de id van de baas-Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'boss_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'einddatum; is NULL als het de huidige job is' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Job', @level2type=N'COLUMN',@level2name=N'enddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'verwijst naar de Employee die de job uitvoert of uitvoerde' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Job', @level2type=N'COLUMN',@level2name=N'employee_id'
GO
USE [master]
GO
ALTER DATABASE [CompanyDB] SET  READ_WRITE 
GO
