
-- Set Password & create master key

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DlsCred123' --- to access the external location (ADLS)

/* Create Database Scoped Credential Managed Identity 
- to authentic & allow Synapse to interact with other azure services */

CREATE DATABASE SCOPED CREDENTIAL beba_onprem   -- > the first step is creating "Credential" &  "Managed identity" 
WITH 
    IDENTITY = 'Managed Identity';

--3) Creating External Data Source - conn. between synapse and ADLS - 2 datasource -(silver, gold)

CREATE EXTERNAL DATA SOURCE silver_layer_source           -- > silver layer data (transform data)
WITH
(
    LOCATION = 'https://newantedetlake.blob.core.windows.net/silver',
    CREDENTIAL = beba_onprem
)

CREATE EXTERNAL DATA SOURCE gold_layer_source                -- > 2nd layer for the gold layer data
WITH
(
    LOCATION = 'https://newantedetlake.blob.core.windows.net/gold',
    CREDENTIAL = beba_onprem
)

-- create a External File Format
CREATE EXTERNAL FILE FORMAT parquet_format
WITH
(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)

-- create a External Table Format

CREATE EXTERNAL TABLE GOLD.ext_employee_table
WITH
(
    LOCATION = 'ext_employee',
    DATA_SOURCE = gold_layer_source,
    FILE_FORMAT = parquet_format
) AS SELECT * FROM GOLD.Employee

SELECT * FROM  GOLD.ext_employee_table

CREATE EXTERNAL TABLE GOLD.ext_department
WITH
(
    LOCATION = 'ext_department',
    DATA_SOURCE = gold_layer_source,
    FILE_FORMAT = parquet_format
) AS SELECT * FROM GOLD.Department

SELECT * FROM  GOLD.ext_department

CREATE EXTERNAL TABLE GOLD.ext_empdepthist
WITH
(
    LOCATION = 'ext_empdepthist',
    DATA_SOURCE = gold_layer_source,
    FILE_FORMAT = parquet_format
) AS SELECT * FROM GOLD.EmployeeDepartmentHistory

SELECT * FROM  GOLD.ext_empdepthist

CREATE EXTERNAL TABLE GOLD.ext_emppayhist
WITH
(
    LOCATION = 'ext_emppayhist',
    DATA_SOURCE = gold_layer_source,
    FILE_FORMAT = parquet_format
) AS SELECT * FROM GOLD.EmployeePaytHistory

SELECT * FROM GOLD.ext_emppayhist


CREATE EXTERNAL TABLE GOLD.ext_shift
WITH
(
    LOCATION = 'ext_shift',
    DATA_SOURCE = gold_layer_source,
    FILE_FORMAT = parquet_format
) AS SELECT * FROM GOLD.Shift

SELECT * FROM GOLD.ext_shift


