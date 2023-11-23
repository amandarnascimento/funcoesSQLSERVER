
create Function fnCalculaIdade (@datanascimento datetime, @dataatual datetime)  
 returns int  
 as  
  begin  
    
 declare @idade int  
   
 set @idade = (YEAR(@dataatual) - YEAR(@datanascimento))-   
  case when (month(@dataatual) < month(@datanascimento)) then   
             '1'  
  else   
   case when ((month(@dataatual) = month(@datanascimento)) and (day(@dataatual) < day(@datanascimento))) then  
    '1'  
   else          
    case when (day(@dataatual) = day(@datanascimento)) then  
    '0'  
    else  
    '0'      
    end  
   end  
  end  
   
 return @idade   
end  