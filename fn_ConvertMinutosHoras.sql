CREATE FUNCTION dbo.fn_ConvertMinutosHoras (@Minutos INT)
RETURNS NVARCHAR(7)
BEGIN
DECLARE @vHoras INTEGER
DECLARE @vMinutos INTEGER
DECLARE @HoraFormatada VARCHAR(7)
 
SET @vHoras = CAST(ROUND(@Minutos / 60, 0) AS INT)
SET @vMinutos = @Minutos % 60
 
SET @HoraFormatada = CASE LEN(@vHoras)
 WHEN 0 THEN '00'
 WHEN 1 THEN '0' + CONVERT(NVARCHAR(1), @vHoras)
 ELSE CONVERT(NVARCHAR(4),@vHoras)
 END
 
SET @HoraFormatada = @HoraFormatada + ':' + CASE LEN(@vMinutos)
 WHEN 0 THEN '00'
 WHEN 1 THEN '0' + CONVERT(NVARCHAR(3), @vMinutos)
 ELSE CONVERT(NVARCHAR(4), @vMinutos)
 END
RETURN @HoraFormatada
END

-- SELECT dbo.fn_ConvertMinutosHoras (100) AS [HH:MM]