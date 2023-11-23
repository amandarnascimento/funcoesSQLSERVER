
create	 FUNCTION [dbo].[fn_dias_uteis_FERIADO] ( @Data_Inicial DateTime)
RETURNS INT

BEGIN 

declare @Dias as int	
declare @DiaSemana as int


set @Dias = 0
set @DiaSemana = 0
		set @DiaSemana = DATEPART(weekday, @Data_inicial)
		if @DiaSemana <> 1 and @DiaSemana <> 7
			begin
				set @Dias = 1
			end

			IF EXISTS (SELECT * FROM GFERIADO WHERE CODCALENDARIO  = '1' AND DIAFERIADO = @Data_inicial)
				BEGIN 
					set @Dias = 0
				END 

		set @Data_inicial = DateAdd(d, 1, @Data_inicial)

RETURN @Dias
end 