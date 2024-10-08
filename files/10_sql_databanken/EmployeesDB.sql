USE [master]
GO
/****** Object:  Database [EmployeesDB]    Script Date: 25/06/2022 20:50:58 ******/
CREATE DATABASE [EmployeesDB]
GO
ALTER DATABASE [EmployeesDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeesDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeesDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeesDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeesDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeesDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeesDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeesDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeesDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeesDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeesDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeesDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeesDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeesDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeesDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeesDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeesDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeesDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeesDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeesDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeesDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeesDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeesDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeesDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeesDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EmployeesDB] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeesDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeesDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeesDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeesDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmployeesDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EmployeesDB] SET QUERY_STORE = OFF
GO
USE [EmployeesDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [EmployeesDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fnConvertGender]    Script Date: 25/06/2022 20:50:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnConvertGender](@gender CHAR(1)) 
RETURNS nvarchar(10)
AS 
BEGIN
   IF @gender = 'M' return 'man';
   IF @gender = 'F' return 'vrouw';
   return 'onbekend';   
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnValidEmail]    Script Date: 25/06/2022 20:50:58 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnValidGender]    Script Date: 25/06/2022 20:50:58 ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 25/06/2022 20:50:58 ******/
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
	[accesscode] [int] NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (1, N'Véronique', N'Coppens', N'ccoppens0@posterous.com', 1, CAST(N'1998-03-27' AS Date), 5894)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (2, N'Géraldine', N'Nouch', N'cnouch1@who.int', 2, CAST(N'1956-09-04' AS Date), 1298)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (3, N'Thérèsa', N'Boatwright', N'bboatwright2@go.com', 2, CAST(N'1943-11-29' AS Date), 7244)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (4, N'Sélène', N'Coursor', N'vcoursor3@nasa.gov', 1, CAST(N'1966-05-12' AS Date), 9494)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (5, N'Maëlla', N'Procter', N'dprocter4@seesaa.be', 2, CAST(N'1989-06-20' AS Date), 9247)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (6, N'Crééz', N'Saffill', N'csaffill5@google.nl', 2, CAST(N'1949-02-25' AS Date), 6534)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (7, N'Poo', N'Snoddie', N'hsnoddy8@census.gov', 1, CAST(N'1980-12-31' AS Date), 7277)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (8, N'Mà', N'Kempshall', N'bkempshall9@zdnet.com', 2, CAST(N'1989-05-09' AS Date), 3074)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (9, N'Lóng', N'Dytham', N'adythama@yelp.com', 1, CAST(N'1993-02-24' AS Date), 9304)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (10, N'Yóu', N'Sweetland', N'fsweetlandb@opensource.org', 1, CAST(N'1981-07-09' AS Date), 4864)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (11, N'Desirée', N'Shemming', N'cshemmingc@cdc.gov', 2, CAST(N'1945-04-28' AS Date), 8122)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (12, N'Maëlys', N'Kersaw', N'skersawd@naver.com', 2, CAST(N'1945-06-09' AS Date), 3083)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (13, N'Réjane', N'St. Louis', N'cstlouise@mapy.cz', 2, CAST(N'1959-03-02' AS Date), 9731)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (14, N'Alizée', N'Blue', N'abluef@freewebs.com', 2, CAST(N'1963-04-06' AS Date), 9781)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (15, N'Kuí', N'Murra', N'dmurrag@delicious.com', 2, CAST(N'1994-02-27' AS Date), 9871)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (16, N'Bérangère', N'Murcott', N'amurcotth@google.pl', 1, CAST(N'1989-05-09' AS Date), 2064)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (17, N'Véronique', N'Daniell', N'mdanielli@sohu.com', 2, CAST(N'1973-01-18' AS Date), 1138)
INSERT [dbo].[Employee] ([id], [firstname], [lastname], [email], [gender], [birthdate], [accesscode]) VALUES (18, N'Audréanne', N'Cordero', N'pcorderoj@biblegateway.com', 2, CAST(N'1975-02-23' AS Date), 3892)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_Accesscode] CHECK  (([accesscode]>=(1000) AND [accesscode]<(9999)))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CK_Employee_Accesscode]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_Gender] CHECK  (([gender]=(0) OR [gender]=(1) OR [gender]=(2) OR [gender]=(9)))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CK_Employee_Gender]
GO
/****** Object:  StoredProcedure [dbo].[spEditEmployee]    Script Date: 25/06/2022 20:50:58 ******/
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
USE [master]
GO
ALTER DATABASE [EmployeesDB] SET  READ_WRITE 
GO
