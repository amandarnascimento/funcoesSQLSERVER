create   FUNCTION [dbo].[fn_primeiro_dia_mes]
(
  @ano varchar(4) ,
  @mes varchar(2) 
)
RETURNS dateTime
AS
BEGIN
declare @ReturnDate datetime
declare @dia datetime = @ano +'-'+ @mes + '-'+ '01'

set @ReturnDate = @ano +'-'+ @mes + '-'+ '01'

RETURN @ReturnDate

END
