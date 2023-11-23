CREATE FUNCTION [dbo].[fn_ConvMin] (@MINUTOS int)
RETURNS NVARCHAR(7)
BEGIN
   DECLARE @iHoras   INTEGER
   DECLARE @iMinutos INTEGER 
   DECLARE @sEdita   VARCHAR(7)
   
   SET @iHoras = CAST(ROUND(@MINUTOS/60, 0) AS INT)
   SET @iMinutos = @MINUTOS % 60     
 
   SET @sEdita = CASE LEN(@iHoras)
                 WHEN 0 THEN '00'
                 WHEN 1 THEN '0' + CONVERT(NVARCHAR(1), @iHoras)
                 ELSE CONVERT(NVARCHAR(4),@iHoras)
                 END
 
   SET @sEdita = @sEdita + ':' + CASE LEN(@iMinutos)
                                 WHEN 0 THEN '00' 
                                 WHEN 1 THEN '0' + CONVERT(NVARCHAR(3), @iMinutos)    
                                 ELSE CONVERT(NVARCHAR(4), @iMinutos)      
                                 END 
   IF @sEdita = '00:00' BEGIN SET @sEdita = '     '  END
    
RETURN @sEdita
END
