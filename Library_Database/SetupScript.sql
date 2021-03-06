USE [master]
GO
/****** Object:  Database [Library]    Script Date: 4/26/2017 12:04:53 PM ******/
CREATE DATABASE [Library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Library.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Library_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Library_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Library] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Library] SET  MULTI_USER 
GO
ALTER DATABASE [Library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Library]
GO
/****** Object:  StoredProcedure [dbo].[Get#OfLoans]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Get#OfLoans]
AS
SELECT B.BranchName, COUNT(L.Branchid) AS #OnLoan
 FROM LIBRARY_BRANCH AS B
 INNER JOIN BOOK_LOANS AS L
 ON B.Branchid = L.Branchid
 GROUP BY B.BranchName
GO
/****** Object:  StoredProcedure [dbo].[Get#ofLostTribe]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Get#ofLostTribe]
AS
SELECT B.Title, L.BranchName, C.No_of_Copies 
FROM BOOK_COPIES AS C INNER JOIN LIBRARY_BRANCH AS L
ON C.Branchid = L.Branchid
INNER JOIN Book AS B
ON C.Bookid = B.Bookid
WHERE C.Bookid = 1 
GO
/****** Object:  StoredProcedure [dbo].[Get#OfSharpsTribe]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Get#OfSharpsTribe]
AS
SELECT B.Title, L.BranchName, C.No_of_Copies 
FROM BOOK_COPIES AS C INNER JOIN LIBRARY_BRANCH AS L
ON C.Branchid = L.Branchid
INNER JOIN Book AS B
ON C.Bookid = B.Bookid
WHERE C.Bookid = 1 AND C.Branchid =2
GO
/****** Object:  StoredProcedure [dbo].[GetCentralSK]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetCentralSK]
AS
SELECT B.Title, A.AuthorName, C.NO_Of_Copies, L.BranchName
FROM Book AS B
INNER JOIN Book_AUTHORS AS A
ON B.Bookid = A.Bookid
INNER JOIN BOOK_COPIES AS C
ON B.Bookid = C.Bookid
INNER JOIN LIBRARY_BRANCH AS L
ON C.Branchid = L.Branchid
WHERE L.Branchid = 1 AND A.AuthorName LIKE '%Stephen King%'
GO
/****** Object:  StoredProcedure [dbo].[GetHeavyBorrowers]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetHeavyBorrowers]
AS
SELECT B.Name, B.[Address], COUNT(L.CardNO) AS #OfBooksOut
FROM BORROWER AS B
INNER JOIN BOOK_LOANS AS L
ON B.CardNo = L.CardNo
GROUP BY B.Name, B.[Address]
HAVING COUNT(L.CardNo) >= 5

GO
/****** Object:  StoredProcedure [dbo].[GetInactiveBorrowers]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetInactiveBorrowers]
AS
SELECT B.CardNo, B.Name
FROM Borrower AS B LEFT JOIN BOOK_LOANS AS L
ON B.CardNo = L.CardNo
WHERE L.Bookid IS NULL
GO
/****** Object:  StoredProcedure [dbo].[GetSharpstownDue]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetSharpstownDue]
AS

DECLARE @CurrentDate AS DATE

SET @CurrentDate = GETDATE()

SELECT B.Title, BR.Name, BR.[Address]
FROM Book AS B INNER JOIN Book_loans AS L
ON B.Bookid = L.Bookid
INNER JOIN BORROWER AS BR
ON BR.CardNo = L.CardNo
WHERE L.Branchid = 2 
AND L.DueDate = @CurrentDate

GO
/****** Object:  Table [dbo].[Book]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Book](
	[Bookid] [int] NOT NULL,
	[Title] [varchar](60) NOT NULL,
	[PublisherName] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Bookid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Book_AUTHORS]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Book_AUTHORS](
	[Bookid] [int] NOT NULL,
	[AuthorName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Bookid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BOOK_COPIES]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK_COPIES](
	[Bookid] [int] NOT NULL,
	[Branchid] [int] NOT NULL,
	[NO_Of_Copies] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BOOK_LOANS]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK_LOANS](
	[Bookid] [int] NOT NULL,
	[Branchid] [int] NOT NULL,
	[CardNo] [int] NOT NULL,
	[DateOut] [date] NOT NULL,
	[DueDate] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BORROWER]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BORROWER](
	[CardNo] [int] NOT NULL,
	[Name] [varchar](60) NULL,
	[Address] [varchar](60) NULL,
	[Phone] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[CardNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LIBRARY_BRANCH]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LIBRARY_BRANCH](
	[Branchid] [int] NOT NULL,
	[BranchName] [varchar](50) NOT NULL,
	[Address] [varchar](60) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Branchid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PUBLISHER]    Script Date: 4/26/2017 12:04:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PUBLISHER](
	[PublisherName] [varchar](60) NOT NULL,
	[Address] [varchar](40) NULL,
	[Phone] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[PublisherName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (1, N'The Lost Tribe', N'Picador USA')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (2, N'The Shining', N'Doubleday')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (3, N'Rita Hayworth and Shawshank Redemption', N'Viking Press')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (4, N'It', N'Viking Press')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (5, N'Harry Potter and the Sorcerer''s Stone', N'Scholastic')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (6, N'Harry Potter and the Chamber of Secrets', N'Scholastic')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (7, N'Harry Potter and the Prisoner of Azkaban', N'Scholastic')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (8, N'Harry Potter and the Goblet of Fire', N'Scholastic')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (9, N'Harry Potter and the Order of the Phoenix', N'Scholastic')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (10, N'Harry Potter and the Half-Blood Prince', N'Scholastic')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (11, N'Harry Potter and the Deathly Hallows', N'Scholastic')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (12, N'50 Shades of Grey', N'Vintage Books')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (13, N'Great Expectations', N'Chapman & Hall')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (14, N'Oliver Twist', N'Chapman & Hall')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (15, N'Adventures of Huckleberry Finn', N'American Publishing Company')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (16, N'Adventures of Tom Sawyer', N'American Publishing Company')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (17, N'The Hobbit', N'Allen & Unwin')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (18, N'The Lord of the Rings:The Fellowship of the Ring', N'Allen & Unwin')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (19, N'The Lord of the Rings:The Two Towers', N'Allen & Unwin')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (20, N'The Lord of the Rings:The Return of the King', N'Allen & Unwin')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (21, N'The Sun Also Rises', N'Scribner')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (22, N'The Old Man and the Sea', N'Scribner')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (23, N'A Game of Thrones', N'Random House')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (24, N'The Alchemist', N'Harper')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (25, N'The Winner Stands Alone', N'Harper')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (26, N'Maktub', N'Harper')
INSERT [dbo].[Book] ([Bookid], [Title], [PublisherName]) VALUES (27, N'Like the Flowing River', N'Harper')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (1, N'Mark Lee')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (2, N'Stephen King')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (3, N'Stephen King')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (4, N'Stephen King')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (5, N'J.K. Rowling')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (6, N'J.K. Rowling')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (7, N'J.K. Rowling')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (8, N'J.K. Rowling')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (9, N'J.K. Rowling')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (10, N'J.K. Rowling')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (11, N'J.K. Rowling')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (12, N'E.L. James')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (13, N'Charles Dickens')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (14, N'Charles Dickens')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (15, N'Mark Twain')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (16, N'Mark Twain')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (17, N'J.R.R. Tolkien')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (18, N'J.R.R. Tolkien')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (19, N'J.R.R. Tolkien')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (20, N'J.R.R. Tolkien')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (21, N'Earnest Hemingway')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (22, N'Earnest Hemingway')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (23, N'George R.R. Martin')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (24, N'Paulo Coelho')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (25, N'Paulo Coelho')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (26, N'Paulo Coelho')
INSERT [dbo].[Book_AUTHORS] ([Bookid], [AuthorName]) VALUES (27, N'Paulo Coelho')
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (1, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (2, 1, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (3, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (4, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (5, 1, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (6, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (7, 1, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (8, 1, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (9, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (10, 1, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (11, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (12, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (13, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (14, 1, 5)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (15, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (16, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (17, 1, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (18, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (19, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (20, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (21, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (22, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (23, 1, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (24, 1, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (25, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (26, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (27, 1, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (1, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (2, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (3, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (4, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (5, 2, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (6, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (7, 2, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (8, 2, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (9, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (10, 2, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (11, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (12, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (13, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (14, 2, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (15, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (16, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (17, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (18, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (19, 2, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (20, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (21, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (22, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (23, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (24, 2, 5)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (25, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (26, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (27, 2, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (1, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (2, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (3, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (4, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (5, 3, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (6, 3, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (7, 3, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (8, 3, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (9, 3, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (10, 3, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (11, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (12, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (13, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (14, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (15, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (16, 3, 5)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (17, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (18, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (19, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (20, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (21, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (22, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (23, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (24, 3, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (25, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (26, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (27, 3, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (1, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (2, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (3, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (4, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (5, 4, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (6, 4, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (7, 4, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (8, 4, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (9, 4, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (10, 4, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (11, 4, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (12, 4, 4)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (13, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (14, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (15, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (16, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (17, 4, 3)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (18, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (19, 4, 2)
GO
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (20, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (21, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (22, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (23, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (24, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (25, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (26, 4, 2)
INSERT [dbo].[BOOK_COPIES] ([Bookid], [Branchid], [NO_Of_Copies]) VALUES (27, 4, 2)
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (12, 4, 13, CAST(0x743C0B00 AS Date), CAST(0x823C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (5, 2, 6, CAST(0xAE3C0B00 AS Date), CAST(0xBC3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (6, 2, 6, CAST(0xAF3C0B00 AS Date), CAST(0xBD3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (7, 2, 6, CAST(0xB03C0B00 AS Date), CAST(0xBE3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (8, 2, 6, CAST(0xB13C0B00 AS Date), CAST(0xBF3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (9, 2, 6, CAST(0xB23C0B00 AS Date), CAST(0xC03C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (10, 2, 6, CAST(0xB33C0B00 AS Date), CAST(0xC13C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (11, 2, 6, CAST(0xB43C0B00 AS Date), CAST(0xC23C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (3, 1, 19, CAST(0xB13C0B00 AS Date), CAST(0xBF3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (17, 1, 19, CAST(0xB13C0B00 AS Date), CAST(0xBF3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (24, 1, 19, CAST(0xB13C0B00 AS Date), CAST(0xBF3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (25, 1, 19, CAST(0xB13C0B00 AS Date), CAST(0xBF3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (12, 3, 19, CAST(0xB23C0B00 AS Date), CAST(0xC03C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (23, 3, 12, CAST(0xA43C0B00 AS Date), CAST(0xB23C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (24, 3, 17, CAST(0xAA3C0B00 AS Date), CAST(0xB83C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (1, 4, 9, CAST(0xAC3C0B00 AS Date), CAST(0xBA3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (17, 2, 3, CAST(0xAC3C0B00 AS Date), CAST(0xBA3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (18, 1, 1, CAST(0xAE3C0B00 AS Date), CAST(0xBC3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (19, 1, 1, CAST(0xAE3C0B00 AS Date), CAST(0xBC3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (20, 1, 1, CAST(0xAE3C0B00 AS Date), CAST(0xBC3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (13, 4, 2, CAST(0xA63C0B00 AS Date), CAST(0xB43C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (14, 4, 2, CAST(0xA63C0B00 AS Date), CAST(0xB43C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (2, 4, 16, CAST(0xA33C0B00 AS Date), CAST(0xB13C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (15, 2, 4, CAST(0xA53C0B00 AS Date), CAST(0xB33C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (22, 4, 2, CAST(0xA13C0B00 AS Date), CAST(0xAF3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (27, 2, 8, CAST(0xA63C0B00 AS Date), CAST(0xB43C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (12, 4, 7, CAST(0x9F3C0B00 AS Date), CAST(0xAD3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (21, 4, 7, CAST(0x9F3C0B00 AS Date), CAST(0xAD3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (23, 2, 10, CAST(0xAA3C0B00 AS Date), CAST(0xB83C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (17, 2, 10, CAST(0xAC3C0B00 AS Date), CAST(0xBA3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (25, 3, 11, CAST(0xA73C0B00 AS Date), CAST(0xB53C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (23, 3, 11, CAST(0xA73C0B00 AS Date), CAST(0xB53C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (4, 1, 12, CAST(0xAD3C0B00 AS Date), CAST(0xBB3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (27, 1, 12, CAST(0xAE3C0B00 AS Date), CAST(0xBC3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (24, 3, 14, CAST(0xAB3C0B00 AS Date), CAST(0xAF3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (21, 3, 14, CAST(0xAB3C0B00 AS Date), CAST(0xAF3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (25, 4, 15, CAST(0xB43C0B00 AS Date), CAST(0xC13C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (3, 4, 15, CAST(0xB43C0B00 AS Date), CAST(0xC13C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (18, 2, 16, CAST(0xB63C0B00 AS Date), CAST(0xC43C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (17, 3, 17, CAST(0xA33C0B00 AS Date), CAST(0xB13C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (12, 1, 18, CAST(0x973C0B00 AS Date), CAST(0xA63C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (4, 1, 18, CAST(0x993C0B00 AS Date), CAST(0xA83C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (24, 2, 20, CAST(0xB23C0B00 AS Date), CAST(0xC03C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (14, 2, 20, CAST(0x9F3C0B00 AS Date), CAST(0xAD3C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (5, 1, 8, CAST(0xB33C0B00 AS Date), CAST(0xC13C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (22, 4, 15, CAST(0x933C0B00 AS Date), CAST(0xA13C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (15, 3, 1, CAST(0x7B3C0B00 AS Date), CAST(0x893C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (14, 1, 16, CAST(0x893C0B00 AS Date), CAST(0x973C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (1, 1, 12, CAST(0xA33C0B00 AS Date), CAST(0xB13C0B00 AS Date))
INSERT [dbo].[BOOK_LOANS] ([Bookid], [Branchid], [CardNo], [DateOut], [DueDate]) VALUES (2, 1, 9, CAST(0xA73C0B00 AS Date), CAST(0xB53C0B00 AS Date))
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (1, N'Bob Jones', N'3280 SW 1st Ave.', N'555-5501')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (2, N'Casey Smith', N'9800 SW Park Ave.', N'555-5502')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (3, N'Jim Halpert', N'480 Scranton St.', N'555-5503')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (4, N'Micheal Scott', N'2233 Dunder Way', N'555-5504')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (5, N'Hank Lawson', N'746 Royal Ave.', N'555-5505')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (6, N'Christina Jackson', N'322 Via Metates', N'555-5506')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (7, N'Barney Stinson', N'581 WaitForIt St.', N'555-5507')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (8, N'Thomas Bonney', N'8437 Tab Ave.', N'555-5508')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (9, N'Burt Bee', N'1174 Chapstick Way', N'555-5509')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (10, N'Dwight Schrute', N'426 Beets St.', N'555-5510')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (11, N'Tony Montana', N'277 Scarface Ave.', N'555-5511')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (12, N'Ricky Bobby', N'625 Talladega Ave.', N'555-5512')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (13, N'Donald Trump', N'1600 Pennsylvania Ave.', N'555-5513')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (14, N'Paul McCartney', N'621 Beatle St.', N'555-5514')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (15, N'Dmitry Vasilyev', N'3272 Shadow Pond St.', N'555-5515')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (16, N'Henry Winkler', N'489 AYYYYY Ave.', N'555-5516')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (17, N'George Carlin', N'6842 Jokes Way', N'555-5517')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (18, N'Jim Gaffigan', N'9542 Hot Pocket St.', N'555-5518')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (19, N'Julius Ceaser', N'111 Rome Ave.', N'555-5519')
INSERT [dbo].[BORROWER] ([CardNo], [Name], [Address], [Phone]) VALUES (20, N'Jennifer Aniston', N'490 Rachel St.', N'555-5520')
INSERT [dbo].[LIBRARY_BRANCH] ([Branchid], [BranchName], [Address]) VALUES (1, N'Central', N'1080 Main St.')
INSERT [dbo].[LIBRARY_BRANCH] ([Branchid], [BranchName], [Address]) VALUES (2, N'Sharpstown', N'364 Sharp St.')
INSERT [dbo].[LIBRARY_BRANCH] ([Branchid], [BranchName], [Address]) VALUES (3, N'North East', N'972 NE Grand Ave.')
INSERT [dbo].[LIBRARY_BRANCH] ([Branchid], [BranchName], [Address]) VALUES (4, N'Park Ave', N' 910 W Park Ave.')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Allen & Unwin', N'378 Oxford Ave.', N'555-8946')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'American Publishing Company', N'1080 American Way', N'555-8888')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Chapman & Hall', N'542 Washington Ave.', N'555-4255')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Doubleday', N'324 1st St.', N'555-6982')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Harper', N'897 Birch Ave.', N'555-4277')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Picador USA', N'728 Grand Ave.', N'555-4892')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Random House', N'3780 House St.', N'555-7269')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Scholastic', N'728 Book Ave.', N'555-2665')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Scribner', N'1112 Main St.', N'555-6622')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Viking Press', N'333 Valhalla St.', N'555-8453')
INSERT [dbo].[PUBLISHER] ([PublisherName], [Address], [Phone]) VALUES (N'Vintage Books', N'9455 Rose St.', N'555-6539')
ALTER TABLE [dbo].[Book]  WITH NOCHECK ADD  CONSTRAINT [Book/Publisher] FOREIGN KEY([Title])
REFERENCES [dbo].[PUBLISHER] ([PublisherName])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [Book/Publisher]
GO
ALTER TABLE [dbo].[Book_AUTHORS]  WITH NOCHECK ADD  CONSTRAINT [Authors/Book] FOREIGN KEY([Bookid])
REFERENCES [dbo].[Book] ([Bookid])
GO
ALTER TABLE [dbo].[Book_AUTHORS] CHECK CONSTRAINT [Authors/Book]
GO
ALTER TABLE [dbo].[BOOK_COPIES]  WITH NOCHECK ADD  CONSTRAINT [Copies/Book] FOREIGN KEY([Bookid])
REFERENCES [dbo].[Book] ([Bookid])
GO
ALTER TABLE [dbo].[BOOK_COPIES] CHECK CONSTRAINT [Copies/Book]
GO
ALTER TABLE [dbo].[BOOK_COPIES]  WITH NOCHECK ADD  CONSTRAINT [Copies/Branch] FOREIGN KEY([Branchid])
REFERENCES [dbo].[LIBRARY_BRANCH] ([Branchid])
GO
ALTER TABLE [dbo].[BOOK_COPIES] CHECK CONSTRAINT [Copies/Branch]
GO
ALTER TABLE [dbo].[BOOK_LOANS]  WITH NOCHECK ADD  CONSTRAINT [Loans/Book] FOREIGN KEY([Bookid])
REFERENCES [dbo].[Book] ([Bookid])
GO
ALTER TABLE [dbo].[BOOK_LOANS] CHECK CONSTRAINT [Loans/Book]
GO
ALTER TABLE [dbo].[BOOK_LOANS]  WITH NOCHECK ADD  CONSTRAINT [Loans/Borrower] FOREIGN KEY([CardNo])
REFERENCES [dbo].[BORROWER] ([CardNo])
GO
ALTER TABLE [dbo].[BOOK_LOANS] CHECK CONSTRAINT [Loans/Borrower]
GO
ALTER TABLE [dbo].[BOOK_LOANS]  WITH NOCHECK ADD  CONSTRAINT [Loans/Branch] FOREIGN KEY([Branchid])
REFERENCES [dbo].[LIBRARY_BRANCH] ([Branchid])
GO
ALTER TABLE [dbo].[BOOK_LOANS] CHECK CONSTRAINT [Loans/Branch]
GO
USE [master]
GO
ALTER DATABASE [Library] SET  READ_WRITE 
GO
