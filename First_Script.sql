SELECT * FROM OPENROWSET(
    BULK 'https://newantedetlake.blob.core.windows.net/silver/HumanResources/Employee/',
    FORMAT = 'DELTA'
) AS DL_Query
