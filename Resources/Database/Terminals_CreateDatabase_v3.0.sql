CREATE DATABASE [TERMINALS] 
GO
USE [TERMINALS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddFavoriteToGroup]
	(
	@favoriteId int,
	@groupId int
	)

AS
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Options](
	[PropertyName] [nvarchar](20) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_Options] PRIMARY KEY CLUSTERED 
(
	[PropertyName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Options] ([PropertyName], [Value]) VALUES (N'MasterPasswordKey', NULL)
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Favorites](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Protocol] [nvarchar](10) NOT NULL,
	[Port] [int] NOT NULL,
	[ServerName] [nvarchar](255) NOT NULL,
	[NewWindow] [bit] NOT NULL,
	[DesktopShare] [nvarchar](255) NULL,
	[Notes] [nvarchar](500) NULL,
	[ProtocolProperties] [xml] NULL,
	[IconData] [varbinary](max) NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_Favorites] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Only to simplyfy relations, otherwise redundant because of Guid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Favorites', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'XML serialized properties depending on selected protocol. This allowes create customized features without changing database schema independent on selected protol' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Favorites', @level2type=N'COLUMN',@level2name=N'ProtocolProperties'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CredentialBase](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EncryptedUserName] [nvarchar](max) NULL,
	[EncryptedDomain] [nvarchar](max) NULL,
	[EncryptedPassword] [nvarchar](max) NULL,
 CONSTRAINT [PK_CredentialBase] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Directly referenced from Favorites Security or Credentials. This isnt referenced from XML favorite protocol options' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CredentialBase', @level2type=N'COLUMN',@level2name=N'Id'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BeforeConnectExecute](
	[FavoriteId] [int] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Command] [nvarchar](255) NULL,
	[CommandArguments] [nvarchar](255) NULL,
	[InitialDirectory] [nvarchar](255) NULL,
	[WaitForExit] [bit] NOT NULL,
 CONSTRAINT [PK_BeforeConnectExecute] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Credentials](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Credentials_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCredentials]
	(
	@Id int
	)
AS

	delete from CredentialBase where Id = @Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCredentialBase]
	(
	@Id int
	)
AS
	delete from CredentialBase where Id = @Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DisplayOptions](
	[FavoriteId] [int] NOT NULL,
	[Height] [int] NULL,
	[Width] [int] NULL,
	[Size] [tinyint] NULL,
	[Colors] [tinyint] NULL,
 CONSTRAINT [PK_DisplayOptions] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FavoritesInGroup](
	[FavoriteId] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
 CONSTRAINT [PK_FavoritesInGroup] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC,
	[GroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteFavorite]
	(
	@Id int
	)
AS
	delete from Favorites where Id = @Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteGroup]
	(
	@Id int,
  @ParentId int
	)
AS
	delete from Groups where Id = @Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMasterPasswordKey]

AS
SELECT  Value
FROM    Options
WHERE   (PropertyName = 'MasterPasswordKey')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[FavoriteId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[UserSid] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_History_1] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC,
	[Date] ASC,
	[UserSid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFavoriteProtocolProperties]
	(
	@FavoriteId int
	)
AS
select ProtocolProperties from Favorites
  where Id = @FavoriteId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetFavoriteIcon]
(
  @FavoriteId int
)

AS
SELECT  IconData
FROM    Favorites
WHERE   (Id = @FavoriteId)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCredentialBase]
	(
  @EncryptedUserName nvarchar(max),
  @EncryptedDomain nvarchar(max),
  @EncryptedPassword nvarchar(max)
	)
AS
	insert into CredentialBase 
  (EncryptedUserName, EncryptedDomain, EncryptedPassword)
  values  
  (@EncryptedUserName, @EncryptedDomain, @EncryptedPassword)

  select SCOPE_IDENTITY() as Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFavorite]
	(
	@Name nvarchar(255),
  @Protocol nvarchar(5),
  @Port int,
  @ServerName nvarchar(255),
  @NewWindow bit,
  @DesktopShare nvarchar(255),
  @Notes nvarchar(500)
	)
AS
	insert into Favorites 
  (Name, Protocol, Port, ServerName, NewWindow,
  DesktopShare, Notes)
  
  values (@Name, @Protocol, @Port, @ServerName, @NewWindow,
  @DesktopShare, @Notes)

select SCOPE_IDENTITY() as Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertGroup]
	(
  @ParentId int,
  @Name nvarchar(255)
	)
AS
	insert into Groups 
  (ParentId, Name)
  values  
  (@ParentId, @Name)

  select SCOPE_IDENTITY() as Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SetFavoriteIcon]
(
  @FavoriteId int,
  @IconData varbinary(max)
)

AS
update  Favorites
set     IconData = @IconData
WHERE   (Id = @FavoriteId)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Security](
	[FavoriteId] [int] NOT NULL,
	[CredentialId] [int] NULL,
	[CredentialBaseId] [int] NULL,
 CONSTRAINT [PK_Security] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[UpdateMasterPasswordKey]
	(
	@NewKey nvarchar(max)
	)
AS
update Options
set Value = @NewKey
where PropertyName = 'MasterPasswordKey'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateGroup]
	(
	@Id int,
  @ParentId int,
  @Name nvarchar(255)
	)
AS
	update Groups 
  set
  ParentId = @ParentId, Name = @Name
  where Id = @Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[UpdateFavoriteProtocolProperties]
	(
	@FavoriteId int,
  @ProtocolProperties xml
	)
AS
	update Favorites 
  set
  ProtocolProperties = @ProtocolProperties
  where Id = @FavoriteId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFavorite]
	(
	@Id int,
	@Name nvarchar(255),
  @Protocol nvarchar(5),
  @Port int,
  @ServerName nvarchar(255),
  @NewWindow bit,
  @DesktopShare nvarchar(255),
  @Notes nvarchar(500)
	)
AS
	update Favorites 
  set
  Name = @Name, Protocol = @Protocol,
  Port = @Port, ServerName = @ServerName, NewWindow = @NewWindow,
  DesktopShare = @DesktopShare, Notes = @Notes
  where Id = @Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCredentialBase]
	(
	@Id int,
  @EncryptedUserName nvarchar(max),
  @EncryptedDomain nvarchar(max),
  @EncryptedPassword nvarchar(max)
	)
AS
	update CredentialBase 
  set
  EncryptedUserName = @EncryptedUserName, EncryptedDomain = @EncryptedDomain, EncryptedPassword = @EncryptedPassword
  where Id = @Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSecurity]
	(
	@FavoriteId int,
	@CredentialId int,
  @CredentialBaseId int
	)
AS
	update Security 
  set
  CredentialId = @CredentialId, CredentialBaseId = @CredentialBaseId
  where  FavoriteId = @FavoriteId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBeforeConnectExecute]
	(
	@FavoriteId int,
  @Enabled bit,
  @Command nvarchar(255),
  @CommandArguments nvarchar(255),
  @InitialDirectory nvarchar(255),
  @WaitForExit bit
	)
AS
	update BeforeConnectExecute 
  set
  Enabled = @Enabled, Command = @Command, 
  CommandArguments = @CommandArguments, InitialDirectory = @InitialDirectory,
  WaitForExit = @WaitForExit
  where FavoriteId = @FavoriteId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateDisplayOptions]
	(
	@FavoriteId int,
  @Height int,
  @Width int,
  @Size tinyint,
  @Colors tinyint
	)
AS
	update DisplayOptions 
  set
  Height = @Height, Width = @Width, Size = @Size, Colors = @Colors
    where FavoriteId = @FavoriteId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCredentials]
	(
	  @Id int,
    @Name nvarchar(255),
    @EncryptedUserName nvarchar(max),
    @EncryptedDomain nvarchar(max),
    @EncryptedPassword nvarchar(max)
	)
AS
	update CredentialBase 
  set
  EncryptedUserName = @EncryptedUserName, EncryptedDomain = @EncryptedDomain, EncryptedPassword = @EncryptedPassword
  where Id = @Id

	update Credentials 
  set
  Name = @Name
  where Id = @Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertSecurity]
	(
	@FavoriteId int,
	@CredentialId int,
  @CredentialBaseId int
	)
AS
	insert into Security (FavoriteId, CredentialId, CredentialBaseId)
  values (@FavoriteId, @CredentialId, @CredentialBaseId)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertHistory]
	(
	@FavoriteId int,
    @Date datetime,
    @UserSid nvarchar(255)
	)
AS

  declare @hasHistory int
  
  select @hasHistory = count(FavoriteId) from History
  where FavoriteId = @FavoriteId and UserSid = @UserSid and
        DATEADD(ms, -DATEPART(ms, Date), Date) = DATEADD(ms, -DATEPART(ms, @Date), @Date)
	
  if @hasHistory = 0
  begin
	insert into History 
	  (FavoriteId, Date, UserSid)
	values  
	  (@FavoriteId, @Date, @UserSid)
  end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFavoritesInGroup]
	(
	@FavoriteId int,
  @GroupId int
	)
AS
	insert into FavoritesInGroup 
  (FavoriteId, GroupId)
  values  
  (@FavoriteId, @GroupId)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertDisplayOptions]
	(
	@FavoriteId int,
  @Height int,
  @Width int,
  @Size tinyint,
  @Colors tinyint
	)
AS
	insert into DisplayOptions 
  (FavoriteId, Height, Width, Size, Colors)
  values  
  (@FavoriteId, @Height, @Width, @Size, @Colors)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCredentials]
	(
  @Name nvarchar(255),
  @EncryptedUserName nvarchar(max),
  @EncryptedDomain nvarchar(max),
  @EncryptedPassword nvarchar(max)
	)
AS
  declare @CredentialsBaseId int  
  
  insert into CredentialBase 
  (EncryptedUserName, EncryptedDomain, EncryptedPassword)
  values  
  (@EncryptedUserName, @EncryptedDomain, @EncryptedPassword)

  set @CredentialsBaseId = SCOPE_IDENTITY()

  insert into Credentials 
  (Name, Id)
  values  
  (@Name, @CredentialsBaseId)

select @CredentialsBaseId as Id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBeforeConnectExecute]
	(
	@FavoriteId int,
  @Enabled bit,
  @Command nvarchar(255),
  @CommandArguments nvarchar(255),
  @InitialDirectory nvarchar(255),
  @WaitForExit bit
	)
AS
	insert into BeforeConnectExecute 
  (FavoriteId, Enabled, Command, CommandArguments, InitialDirectory,
   WaitForExit)
  
  values  (@FavoriteId, @Enabled, @Command, @CommandArguments,
  @InitialDirectory, @WaitForExit)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetFavoriteGroups]
	(
	@favoriteId int
	)
AS
SELECT DISTINCT GroupId
FROM         FavoritesInGroup
WHERE     (FavoriteId = @favoriteId)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFavoritesInGroup]
	(
	@groupId int
	)
AS
	SELECT DISTINCT FavoriteId
FROM FavoritesInGroup
WHERE GroupId = @groupId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFavoritesHistoryByDate]
	(
  @From datetime,
  @To datetime
	)
AS
	select distinct FavoriteId from History 
  where @From < Date and  Date < @To
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[DeleteFavoritesInGroup]
	(
	@FavoriteId int,
  @GroupId int
	)
AS
	delete from FavoritesInGroup 
  where
  FavoriteId = @FavoriteId and GroupId = @GroupId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteDisplayOptions]
	(
	@FavoriteId int
	)
AS
	delete from DisplayOptions where FavoriteId = @FavoriteId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteSecurity]
	(
	@FavoriteId int,
  @Credential int,
  @CredentialBaseId int
	)
AS
	delete from Security 
  where FavoriteId = @FavoriteId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteBeforeConnectExecute]
	(
	@FavoriteId int
	)
AS
	delete from BeforeConnectExecute where FavoriteId = @FavoriteId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClearHistory]

AS
	delete from History
	RETURN
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Groups] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Groups] ([Id])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Groups]
GO
ALTER TABLE [dbo].[BeforeConnectExecute]  WITH CHECK ADD  CONSTRAINT [FK_BeforeConnectExecute_BeforeConnectExecute] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BeforeConnectExecute] CHECK CONSTRAINT [FK_BeforeConnectExecute_BeforeConnectExecute]
GO
ALTER TABLE [dbo].[Credentials]  WITH CHECK ADD  CONSTRAINT [FK_Credentials_CredentialBase] FOREIGN KEY([Id])
REFERENCES [dbo].[CredentialBase] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Credentials] CHECK CONSTRAINT [FK_Credentials_CredentialBase]
GO
ALTER TABLE [dbo].[DisplayOptions]  WITH CHECK ADD  CONSTRAINT [FK_DisplayOptions_Favorites] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DisplayOptions] CHECK CONSTRAINT [FK_DisplayOptions_Favorites]
GO
ALTER TABLE [dbo].[FavoritesInGroup]  WITH CHECK ADD  CONSTRAINT [FK_FavoritesInGroup_Favorites] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FavoritesInGroup] CHECK CONSTRAINT [FK_FavoritesInGroup_Favorites]
GO
ALTER TABLE [dbo].[FavoritesInGroup]  WITH CHECK ADD  CONSTRAINT [FK_FavoritesInGroup_Groups] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FavoritesInGroup] CHECK CONSTRAINT [FK_FavoritesInGroup_Groups]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Favorites] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Favorites]
GO
ALTER TABLE [dbo].[Security]  WITH CHECK ADD  CONSTRAINT [FK_Security_CredentialBase] FOREIGN KEY([CredentialBaseId])
REFERENCES [dbo].[CredentialBase] ([Id])
GO
ALTER TABLE [dbo].[Security] CHECK CONSTRAINT [FK_Security_CredentialBase]
GO
ALTER TABLE [dbo].[Security]  WITH CHECK ADD  CONSTRAINT [FK_Security_Favorites] FOREIGN KEY([FavoriteId])
REFERENCES [dbo].[Favorites] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Security] CHECK CONSTRAINT [FK_Security_Favorites]
GO
