CREATE FUNCTION [dbo].[fn_converterMinutoparaHora]
(
    @MINUTES BIGINT  
)
RETURNS NVARCHAR(100)

AS
BEGIN
DECLARE @HOURS  NVARCHAR(1000)

SET @HOURS = 
    CASE WHEN @MINUTES >= 60 THEN
        (SELECT 
   		    CASE 
		      WHEN LEN(CAST((@MINUTES / 60) AS VARCHAR))=1 THEN  '0' + CAST((@MINUTES / 60) AS VARCHAR)+':' 
		      ELSE CAST((@MINUTES / 60) AS VARCHAR)+':' 
            END +
                
		    CASE WHEN (@MINUTES % 60) > 0 THEN
                CASE
			      WHEN  LEN(CAST((@MINUTES % 60) AS VARCHAR))=1 THEN '0'+CAST((@MINUTES % 60) AS VARCHAR)
				  ELSE CAST((@MINUTES % 60) AS VARCHAR)
                END 
                ELSE '00'
            END)
    ELSE 
      CASE
        WHEN  LEN(CAST((@MINUTES % 60) AS VARCHAR))=1 THEN '00:0'+CAST((@MINUTES % 60) AS VARCHAR)
	    ELSE '00:'+CAST((@MINUTES % 60) AS VARCHAR)
      END 
    END

RETURN @HOURS
END