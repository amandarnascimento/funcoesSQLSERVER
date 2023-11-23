CREATE  FUNCTION fn_DIAS_UTEIS_ENTRE_DATAS ( @Data_Inicial DateTime, @Data_Final DateTime)
RETURNS INT

BEGIN 

declare @Dias as int	
declare @DiaSemana as int


set @Dias = 0
set @DiaSemana = 0

while @Data_inicial <= @data_final
	begin
		set @DiaSemana = DATEPART(weekday, @Data_inicial)
		if @DiaSemana <> 1 and @DiaSemana <> 7
			begin
				set @Dias = @Dias + 1
			end

		set @Data_inicial = DateAdd(d, 1, @Data_inicial)
	end
RETURN @Dias
end 
