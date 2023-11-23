CREATE FUNCTION [dbo].[fn_PrimDia.sql] ( @InputDate    DATETIME )
RETURNS DATETIME
BEGIN

    RETURN CAST(CAST(YEAR(@InputDate) AS VARCHAR(4)) + '/' + 
                CAST(MONTH(@InputDate) AS VARCHAR(2)) + '/01' AS DATETIME)

END