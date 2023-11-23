CREATE  Function dbo.Fn_CalculaTempoCasa (@dataadmissao datetime, @dataatual datetime)    
 returns numeric(9,2)
 as    
  begin    
      
 declare @idade numeric(9,2)
     
 set @idade = convert(numeric(9,2),((datediff(month, @dataatual , @dataadmissao) + 1)/12.00))
     
 return @idade     
end 