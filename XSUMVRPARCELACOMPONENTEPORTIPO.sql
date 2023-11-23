CREATE FUNCTION XSUMVRPARCELACOMPONENTEPORTIPO(@NUMVENDA INT, @CODGRUPO INT, @NUMPARC INT, @CODTIPOPARC INT, @ARRAYCODTIPOCOMPN VARCHAR(MAX))
RETURNS NUMERIC(15,4)
AS BEGIN
  DECLARE @VRPRINCIPAL NUMERIC(15,4)
  DECLARE @VRINTEGRACAO NUMERIC(15,4)
  DECLARE @RETORNO NUMERIC(15,4)
  DECLARE @ENDINDEX INT
  DECLARE @STARTINDEX INT
  DECLARE @CODTIPOCOMPN INT
  DECLARE @TABLECODTIPOCOMPN TABLE (CODTIPOCOMPN INT)
  DECLARE @ACAO INT
  SET @STARTINDEX = 1
  SET @VRPRINCIPAL = 0
  SET @VRINTEGRACAO = 0
  IF (@ARRAYCODTIPOCOMPN IS NOT NULL)
  BEGIN
    SET @ARRAYCODTIPOCOMPN = @ARRAYCODTIPOCOMPN + '|'
    SET @ENDINDEX = CHARINDEX('|',@ARRAYCODTIPOCOMPN,@STARTINDEX)
    WHILE (@ENDINDEX > 0)
    BEGIN
      SET @CODTIPOCOMPN = CAST(SUBSTRING(@ARRAYCODTIPOCOMPN,@STARTINDEX,(@ENDINDEX - @STARTINDEX)) AS INT)
      IF @CODTIPOCOMPN = 0
      BEGIN
        SET @ARRAYCODTIPOCOMPN = '1'
		    DECLARE CURSORTIPOCOMPN CURSOR FOR SELECT DISTINCT XCOMPONENTE.COD_TIPO_COMPN
										                       FROM DBO.XVENDAPARCELA (NOLOCK)
										                            JOIN DBO.FLAN (NOLOCK)
										  		                           JOIN DBO.FLANINTEGRACAO (NOLOCK)
												                                  JOIN DBO.FLANINTEGRACAODEF (NOLOCK)
													                                     JOIN DBO.XCOMPONENTEVRINTEGRACAO (NOLOCK)
                                                                    JOIN DBO.XCOMPONENTE (NOLOCK)
                                                                    ON XCOMPONENTE.COD_COMPN = XCOMPONENTEVRINTEGRACAO.CODCOMPN
													                                     ON XCOMPONENTEVRINTEGRACAO.CODCOLIGADA = FLANINTEGRACAODEF.CODCOLIGADA AND
														                                      XCOMPONENTEVRINTEGRACAO.IDCAMPO = FLANINTEGRACAODEF.IDCAMPO
												                                  ON FLANINTEGRACAODEF.CODCOLIGADA = FLANINTEGRACAO.CODCOLIGADA AND
													                                   FLANINTEGRACAODEF.IDCAMPO = FLANINTEGRACAO.IDCAMPO AND
													                                   FLANINTEGRACAODEF.ACAO IN (1,2)
											                                ON FLANINTEGRACAO.CODCOLIGADA = FLAN.CODCOLIGADA AND
												                                 FLANINTEGRACAO.IDLAN = FLAN.IDLAN
											                          ON FLAN.CODCOLIGADA = XVENDAPARCELA.CODCOLLAN AND
												                           FLAN.IDLAN = XVENDAPARCELA.IDLAN AND
												                           FLAN.CODAPLICACAO = 'X'
											                     WHERE XVENDAPARCELA.NUMVENDA = @NUMVENDA AND
												                         XVENDAPARCELA.CODGRUPO = @CODGRUPO AND
												                         XVENDAPARCELA.NUMPARC = @NUMPARC AND
												                         XVENDAPARCELA.CODTIPOPARC = @CODTIPOPARC
        OPEN CURSORTIPOCOMPN
        FETCH NEXT FROM CURSORTIPOCOMPN INTO @CODTIPOCOMPN
        WHILE (@@FETCH_STATUS = 0)
        BEGIN
          SET @ARRAYCODTIPOCOMPN = @ARRAYCODTIPOCOMPN + '|' + CAST(@CODTIPOCOMPN AS VARCHAR)
          FETCH NEXT FROM CURSORTIPOCOMPN INTO @CODTIPOCOMPN
        END
        CLOSE CURSORTIPOCOMPN
        DEALLOCATE CURSORTIPOCOMPN
        SET @ARRAYCODTIPOCOMPN = @ARRAYCODTIPOCOMPN + '|'
        SET @ENDINDEX = CHARINDEX('|',@ARRAYCODTIPOCOMPN,@STARTINDEX)
        SET @CODTIPOCOMPN = CAST(SUBSTRING(@ARRAYCODTIPOCOMPN,@STARTINDEX,(@ENDINDEX - @STARTINDEX)) AS INT)
      END
      IF @CODTIPOCOMPN > 0
      BEGIN
        INSERT INTO @TABLECODTIPOCOMPN(CODTIPOCOMPN) values (@CODTIPOCOMPN)
      END
      SET @STARTINDEX = @ENDINDEX + 1
      SET @ENDINDEX = CHARINDEX('|',@ARRAYCODTIPOCOMPN,@STARTINDEX)
    END
    IF EXISTS(SELECT 1 FROM @TABLECODTIPOCOMPN WHERE CODTIPOCOMPN IN (1,2))
    BEGIN
      SET @VRPRINCIPAL = CAST((SELECT ISNULL(SUM(FLAN.VALORORIGINAL), 0)
                               FROM DBO.XVENDAPARCELA (NOLOCK)
                                    JOIN DBO.