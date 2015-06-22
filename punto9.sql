CREATE PROCEDURE posiciones_barco
	@id_barco int,
	@fecha date,
	@fecha_hasta date
 AS
BEGIN
	SELECT L.LATITUD,L.LONGITUD
	FROM LOCALIZACION l
	WHERE	l.id_barco=@id_barco
			AND l.fecha>=@fecha
			and l.fecha<=@fecha_hasta
END


/*
  LLAMADA
*/

DECLARE	@return_value int

EXEC	@return_value = [dbo].[posiciones_barco]
		@id_barco = 1,
		@fecha = '1994/06/04',
		@fecha_hasta='2017/06/04'

SELECT	'Return Value' = @return_value

GO
