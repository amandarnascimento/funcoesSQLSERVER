CREATE   FUNCTION Fn_Dias_Uteis_Entre_Datas_Com_Feriado ( @Data_Inicial DateTime, @Data_Final DateTime,  @CODCALEND VARCHAR(MAX))
RETURNS INT

BEGIN 

declare @Dias as int	
declare @DiaSemana as int
declare @Data_Inicial_ori	DateTime = @Data_Inicial
declare @Data_Final_ori		DateTime = @Data_Final



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

		
			set @Dias = @Dias  - (
			select isnull(count(*),0) from GFERIADO 
			where   CODCALENDARIO = @CODCALEND
				and diaferiado between @Data_inicial and @data_final
				)
		
		
	end RETURN 
 @Dias


end 	