USE [master]
GO
/****** Object:  Database [ConversationManager]    Script Date: 2/8/2021 07:41:35 ******/
CREATE DATABASE [ConversationManager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ConversationManager', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ConversationManager.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ConversationManager_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ConversationManager_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ConversationManager] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ConversationManager].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ConversationManager] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ConversationManager] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ConversationManager] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ConversationManager] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ConversationManager] SET ARITHABORT OFF 
GO
ALTER DATABASE [ConversationManager] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ConversationManager] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ConversationManager] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ConversationManager] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ConversationManager] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ConversationManager] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ConversationManager] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ConversationManager] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ConversationManager] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ConversationManager] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ConversationManager] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ConversationManager] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ConversationManager] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ConversationManager] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ConversationManager] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ConversationManager] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ConversationManager] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ConversationManager] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ConversationManager] SET  MULTI_USER 
GO
ALTER DATABASE [ConversationManager] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ConversationManager] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ConversationManager] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ConversationManager] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ConversationManager] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ConversationManager] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ConversationManager] SET QUERY_STORE = OFF
GO
USE [ConversationManager]
GO
/****** Object:  Table [dbo].[Conversations]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conversations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nchar](255) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Conversations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[ConversationId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK__Messages__3214EC07723DBDE4] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Thoughts]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thoughts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[MessageId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK__Thoughts__3214EC07B01405FD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Conversations] ADD  CONSTRAINT [DF_Conversations_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Conversations] ADD  CONSTRAINT [DF_Conversations_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Messages] ADD  CONSTRAINT [DF_Messages_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Messages] ADD  CONSTRAINT [DF_Messages_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Thoughts] ADD  CONSTRAINT [DF_Thoughts_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Thoughts] ADD  CONSTRAINT [DF_Thoughts_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_MessageConversation] FOREIGN KEY([ConversationId])
REFERENCES [dbo].[Conversations] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_MessageConversation]
GO
ALTER TABLE [dbo].[Thoughts]  WITH CHECK ADD  CONSTRAINT [FK_ThoughtMessage] FOREIGN KEY([MessageId])
REFERENCES [dbo].[Messages] ([Id])
GO
ALTER TABLE [dbo].[Thoughts] CHECK CONSTRAINT [FK_ThoughtMessage]
GO
/****** Object:  StoredProcedure [dbo].[Conversations_Create]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_Create] @Title nvarchar(MAX)
AS
INSERT INTO dbo.Conversations ([Title])
VALUES (@Title)
GO
/****** Object:  StoredProcedure [dbo].[Conversations_Delete_ById]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_Delete_ById] @Id int
AS
DELETE FROM dbo.Conversations
WHERE [Id] = @Id
GO
/****** Object:  StoredProcedure [dbo].[Conversations_Get_All]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_Get_All]
AS
SELECT [Id], [Title], DateCreated, DateModified
FROM dbo.Conversations
GO
/****** Object:  StoredProcedure [dbo].[Conversations_Get_ById]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_Get_ById] @Id int
AS
SELECT [Id], [Title], [DateCreated], [DateModified]
FROM dbo.Conversations
WHERE [Id] = @Id
GO
/****** Object:  StoredProcedure [dbo].[Conversations_Search_ByTitle]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_Search_ByTitle] @Query nvarchar(MAX)
AS
SELECT [Id], [Title], [DateCreated], [DateModified] 
FROM dbo.Conversations
WHERE [Title] LIKE '%' + @Query + '%';
GO
/****** Object:  StoredProcedure [dbo].[Conversations_Update_ById]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_Update_ById] @Id int, @Title nvarchar(MAX)
AS
UPDATE dbo.Conversations
SET [Title] = @Title
WHERE [Id] = @Id
GO
/****** Object:  StoredProcedure [dbo].[Messages_Create]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Messages_Create] @Text nvarchar(MAX), @ConversationId int
AS
INSERT INTO dbo.Messages ([Text], [ConversationId])
VALUES (@Text, @ConversationId)
GO
/****** Object:  StoredProcedure [dbo].[Messages_Delete_ById]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Messages_Delete_ById] @Id int
AS
DELETE FROM dbo.Messages
WHERE [Id] = @Id
GO
/****** Object:  StoredProcedure [dbo].[Messages_Get_All]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Messages_Get_All]
AS
SELECT [Id], [Text], [ConversationId], [DateCreated], [DateModified]
FROM dbo.Messages
GO
/****** Object:  StoredProcedure [dbo].[Messages_Get_ByConversationId]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Messages_Get_ByConversationId] @ConversationId int
AS
SELECT [Id], [Text], [ConversationId], [DateCreated], [DateModified]
FROM dbo.Messages
WHERE [ConversationId] = @ConversationId
GO
/****** Object:  StoredProcedure [dbo].[Messages_Get_ById]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Messages_Get_ById] @Id int
AS
SELECT [Id], [Text], [ConversationId], [DateCreated], [DateModified]
FROM dbo.Messages
WHERE [Id] = @Id
GO
/****** Object:  StoredProcedure [dbo].[Messages_Update_ById]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Messages_Update_ById] @Id int, @Text nvarchar(MAX)
AS
UPDATE dbo.Messages
SET [Text] = @Text
WHERE [Id] = @Id
GO
/****** Object:  StoredProcedure [dbo].[Thoughts_Create]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Thoughts_Create] @Text nvarchar(MAX), @MessageId int
AS
INSERT INTO dbo.Thoughts ([Text], [MessageId])
VALUES (@Text, @MessageId)
GO
/****** Object:  StoredProcedure [dbo].[Thoughts_Delete_ById]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Thoughts_Delete_ById] @Id int
AS
DELETE FROM dbo.Thoughts
WHERE [Id] = @Id
GO
/****** Object:  StoredProcedure [dbo].[Thoughts_Get_ById]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Thoughts_Get_ById] 
	@Id int
AS
SELECT [Id], [Text], [MessageId], [DateCreated], [DateModified]
FROM dbo.Thoughts  
WHERE Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[Thoughts_Get_ByMessageId]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Thoughts_Get_ByMessageId] 
@MessageId int
AS
SELECT [Id], [Text], [MessageId], [DateCreated], [DateModified]
FROM dbo.Thoughts
WHERE [MessageId] = @MessageId
GO
/****** Object:  StoredProcedure [dbo].[Thoughts_Update_ById]    Script Date: 2/8/2021 07:41:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Thoughts_Update_ById] @Id int, @Text nvarchar(MAX)
AS
UPDATE dbo.Thoughts
SET [Text] = @Text
WHERE [Id] = @Id
GO
USE [master]
GO
ALTER DATABASE [ConversationManager] SET  READ_WRITE 
GO
