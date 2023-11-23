CREATE   FUNCTION [dbo].[fn_FormatoCpf] (@cpf as varchar(100))  
 RETURNS VARCHAR(15) AS  
  
 BEGIN  
    
  DECLARE @RESULTADO VARCHAR(15)  
  DECLARE @BASE VARCHAR(100)  
   SET @BASE = REPLACE(REPLACE(REPLACE(@cpf, '.', ''), ',', ''), '-', '')  
    
   SET @RESULTADO = (SELECT CONCAT(LEFT(@BASE, 3), '.'  
           , SUBSTRING(@BASE, 4, 3), '.'  
           , SUBSTRING(@BASE, 7, 3), '-'  
           , RIGHT(@BASE, 2)  
           )  
       )  
   
  RETURN @RESULTADO  
  
 END