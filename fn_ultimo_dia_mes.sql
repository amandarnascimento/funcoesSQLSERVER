create   FUNCTION [dbo].[fn_ultimo_dia_mes]
(
  @ano varchar(4) ,
  @mes varchar(2) 
)
RETURNS dateTime
AS
BEGIN
declare @ReturnDate datetime

set @ReturnDate = case 
						when @mes = 01 then  @ano +'-'+ @mes + '-'+ '31 23:59:59'
						when @mes = 02 then  @ano +'-'+ @mes + '-'+ '28 23:59:59'
						when @mes = 02 then  @ano +'-'+ @mes + '-'+ '29 23:59:59'
						when @mes = 03 then  @ano +'-'+ @mes + '-'+ '31 23:59:59'
						when @mes = 04 then  @ano +'-'+ @mes + '-'+ '30 23:59:59'
						when @mes = 05 then  @ano +'-'+ @mes + '-'+ '31 23:59:59'
						when @mes = 06 then  @ano +'-'+ @mes + '-'+ '30 23:59:59'
						when @mes = 07 then  @ano +'-'+ @mes + '-'+ '31 23:59:59'
						when @mes = 08 then  @ano +'-'+ @mes + '-'+ '31 23:59:59'
						when @mes = 09 then  @ano +'-'+ @mes + '-'+ '30 23:59:59'
						when @mes = 10 then  @ano +'-'+ @mes + '-'+ '31 23:59:59'
						when @mes = 11 then  @ano +'-'+ @mes + '-'+ '30 23:59:59'
						when @mes = 12 then  @ano +'-'+ @mes + '-'+ '31 23:59:59'

					end 

RETURN @ReturnDate

END
