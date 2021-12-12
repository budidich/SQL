-- https://habr.com/ru/post/577612/

CREATE TABLE smth (
                    id     int IDENTITY PRIMARY KEY,
                    field1 nvarchar(200),
                    field2 nvarchar(max),
                    field3 nvarchar(max),
                    /* добавл€ю столбцы, чтобы сканировать кластерный индекс не всегда было выгодно */
                    field4 nvarchar(max),
                    field5 nvarchar(max),
                    field6 nvarchar(max),
                    field7 nvarchar(max),
                    field8 nvarchar(max),
                    field9 nvarchar(max),
                    field0 nvarchar(max),
                    /* а там ещЄ 40 столбцов с разными типами */
                  );

GO


--заполним случайными данными
;WITH 
    n AS (
    SELECT 0 n UNION ALL SELECT 0
),  n1 AS (
    SELECT 0 n
    FROM n, n n1, n n2
),  n2 AS (
    SELECT 0 n
    FROM n1 n, n1 n1, n1 n2
),  nums AS (
    SELECT 0 n          /* 262144 строк */
    FROM n2 n, n2 n1
)
INSERT INTO smth (field1, field2, field3, field4, field5, field6, field7, field8, field9, field0)
SELECT 
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field1,
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field2,
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field3,
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field4,
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field5,
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field6,
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field7,
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field8,
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field9,
    CASE WHEN RAND(CHECKSUM(NEWID())) > 0.5 THEN CAST(NEWID() AS nvarchar(200)) ELSE NULL END AS field0
FROM nums;
GO

--добавл€ем дубли
INSERT INTO smth (field1, field2, field3)
SELECT field1, field2, field3
FROM smth;
GO 4 -- 4194304 строк



CREATE INDEX ix_ST ON smth (field1);
GO

SET STATISTICS TIME, IO, XML ON;

SELECT id
FROM smth
WHERE 
        field1 = N'0FCD0182-AF6E-47E9-94F9-456F2047992C' 
    OR  field2 = N'67D1B1C6-8E11-4E7F-BDAD-EF33D8D3AF87'
    OR  field3 = N'D75B375A-E977-4EDD-A836-7AF4967B8BFD'

SET STATISTICS TIME, IO, XML OFF;
SET STATISTICS TIME, IO, XML OFF;