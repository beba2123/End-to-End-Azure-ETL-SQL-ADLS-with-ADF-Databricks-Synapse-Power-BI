CREATE SCHEMA GOLD;    --Schema  Creation for GOLD layer

CREATE VIEW GOLD.Employee
AS 
SELECT * FROM OPENROWSET(
    BULK 'https://newantedetlake.blob.core.windows.net/silver/HumanResources/Employee/',
    FORMAT = 'DELTA'
) AS DL_Query

CREATE VIEW GOLD.Department
AS 
SELECT * FROM OPENROWSET(
    BULK 'https://newantedetlake.blob.core.windows.net/silver/HumanResources/Department/',
    FORMAT = 'DELTA'
) AS DL_Query


CREATE VIEW GOLD.EmployeeDepartmentHistory
AS 
SELECT * FROM OPENROWSET(
    BULK 'https://newantedetlake.blob.core.windows.net/silver/HumanResources/EmployeeDepartmentHistory/',
    FORMAT = 'DELTA'
) AS DL_Query


CREATE VIEW GOLD.EmployeePaytHistory
AS 
SELECT * FROM OPENROWSET(
    BULK 'https://newantedetlake.blob.core.windows.net/silver/HumanResources/EmployeePaytHistory/',
    FORMAT = 'DELTA'
) AS DL_Query

CREATE VIEW GOLD.Shift
AS 
SELECT * FROM OPENROWSET(
    BULK 'https://newantedetlake.blob.core.windows.net/silver/HumanResources/Shift/',
    FORMAT = 'DELTA'
) AS DL_Query
