CREATE   FUNCTION Fn_QtdFinsDeSemana (@INICIO DATE, @FIM DATE)
	RETURNS INT
	AS
	BEGIN

		DECLARE @QTD INT

		-- Retorno da quantidade de dias que são fins de semana
		SET @QTD = (SELECT COUNT(DISTINCT DATA)
					  FROM Z_FINSDESEMANA (NOLOCK)
					 WHERE NUMDIA IN ('7', '1')
					       AND DATA BETWEEN @INICIO AND @FIM
				    )
		
		RETURN @QTD

END