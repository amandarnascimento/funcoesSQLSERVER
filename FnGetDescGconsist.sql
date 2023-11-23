Create Function [dbo].[FnGetDescGconsist] (@CODTABELA varchar(20),@CODCLIENTE varchar(20)  )  
returns varchar(200)
as  
  begin  

      declare @StrSql int  
      declare @Retorno varchar(200);

      SELECT TOP 1
            @Retorno = DESCRICAO 
      FROM 
            GCONSIST  
      WHERE  
            CODTABELA = @CODTABELA
            AND CODCLIENTE = @CODCLIENTE
            
      RETURN @Retorno
      
end