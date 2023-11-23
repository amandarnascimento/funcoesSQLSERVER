CREATE FUNCTION [dbo].func_RetornaNivelPai(
   @InputString VARCHAR(MAX),
   @Delimiter   VARCHAR(MAX),
   @DefaultVal  VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
   DECLARE @Pai    VARCHAR(MAX)
   DECLARE @Lenght INT
   /* Se n�o informar o delimitador utilizar ponto (.) */
   IF @Delimiter IS NULL
   BEGIN
	  SET @Delimiter = '.'
   END
   /* Se n�o informou o retorno padr�o utilizar h�fen (-) */
   /* Pega o tamanho do par�metro */
   SET @Lenght = LEN(@InputString)
   /* Seta o valor padr�o para o pai */
   SET @Pai = @DefaultVal
   WHILE @Lenght > 0
   BEGIN
	  IF SUBSTRING(@InputString, @Lenght, 1) = @Delimiter AND @Lenght != 1
	  BEGIN
		 SET @Pai = SUBSTRING(@InputString, 1, @Lenght - 1)
		 BREAK
	  END
	  SET @Lenght = @Lenght - 1
   END
   RETURN @Pai
END