USE [TestDataBase]
GO

-- Deletion old table if exist
IF OBJECT_ID('[TestDataBase].[dbo].[Table1]', 'U') IS NOT NULL
  DROP TABLE [TestDataBase].[dbo].[Table1]
GO

-- Create table 1
CREATE TABLE [TestDataBase].[dbo].[Table1]
(
	id int NOT NULL, 
	num int, 
	text char(50), 
    PRIMARY KEY (ID)
)
GO
