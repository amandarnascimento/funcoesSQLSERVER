/*CRIAÇÃO DA FUNÇÃO QUE TRAZ DIAS ÚTEIS*/

CREATE function fn_DiasUteis (@DataInicio smalldatetime , @DataFim Datetime)
RETURNS Int AS BEGIN
-- Declaração de variáveis
Declare @Count Int

-- Iniciação de variáveis
SET @Count = 0

-- Looping que verifica o intervalo de datas para contar o número de dias úteis
While @DataInicio <= @DataFim
Begin
-- Verifica se a data em questão é dia de semana ou fim de semana. Compara com calendário de 2018, uma vez que não temos referência de pesquisa registrada em banco de dados para o ano de 2019
If DatePart(WeekDay, @DataInicio) Not In (7,1) And @DataInicio Not In ( select  DATEADD(YEAR, 1, DIAFERIADO) from GFERIADO WHERE YEAR(DIAFERIADO) =2018 )
Select @Count = @Count + 1
Select @DataInicio = Dateadd(day,1,@DataInicio)

End
-- retorno do número de dias úteis.
RETURN  @Count
END