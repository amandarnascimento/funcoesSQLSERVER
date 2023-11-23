CREATE FUNCTION XVALORPARCELACOMPONENTE(@CODCOLLAN SMALLINT, @IDLAN INT, @CODTIPOCOMPN INT, @TIPOACAOCOMPN INT)
  RETURNS NUMERIC(15,4) WITH SCHEMABINDING
AS BEGIN
  DECLARE @RETORNO NUMERIC(15,4)
  SET @RETORNO = 0
  SET @RETORNO = CONVERT(NUMERIC(15,4), (SELECT ISNULL(SUM(FLANINTEGRACAO.VALOR), 0)
                                         FROM DBO.FLAN (NOLOCK)
                                                JOIN DBO.FLANINTEGRACAO (NOLOCK)
                                                     JOIN DBO.FLANINTEGRACAODEF (NOLOCK)
                                                          JOIN DBO.XCOMPONENTEVRINTEGRACAO (NOLOCK)
                                                               JOIN DBO.XCOMPONENTE (NOLOCK)
                                                               ON XCOMPONENTE.COD_COMPN = XCOMPONENTEVRINTEGRACAO.CODCOMPN AND
                                                                  XCOMPONENTE.COD_TIPO_COMPN = @CODTIPOCOMPN AND
                                                                  XCOMPONENTE.TIPOENTREGACORRECAO = @TIPOACAOCOMPN
                                                          ON XCOMPONENTEVRINTEGRACAO.CODCOLIGADA = FLANINTEGRACAODEF.CODCOLIGADA AND
                                                             XCOMPONENTEVRINTEGRACAO.IDCAMPO = FLANINTEGRACAODEF.IDCAMPO
                                                     ON FLANINTEGRACAODEF.CODCOLIGADA = FLANINTEGRACAO.CODCOLIGADA AND
                                                        FLANINTEGRACAODEF.IDCAMPO = FLANINTEGRACAO.IDCAMPO
                                                ON FLANINTEGRACAO.CODCOLIGADA = FLAN.CODCOLIGADA AND
                                                   FLANINTEGRACAO.IDLAN = FLAN.IDLAN
                                           WHERE FLAN.CODCOLIGADA = @CODCOLLAN AND
                                                 FLAN.IDLAN = @IDLAN AND
                                                 FLAN.CODAPLICACAO = 'X'))
  RETURN @RETORNO
END

Completion time: 2023-11-23T14:57:04.2043826-03:00
