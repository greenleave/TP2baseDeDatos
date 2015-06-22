ALTER trigger insercion_bodega_operacion
ON OPERACION
INSTEAD OF INSERT
as
declare @m3Utilizados int
declare @capacidadBodega int 
declare @m3Producto int
declare @cantidad int
	select	@capacidadBodega =ISNULL (M3,0)
	from	bodega b,
			inserted i 
	where	b.id_barco=i.id_barco
			AND b.NUMERO_BODEGA=i.numero_bodega

	select	@m3Utilizados= ISNULL (sum(pr.M3*op.cantidad),0)
	from	PRODUCTO pr  inner join OPERACION op ON pr.ID_PRODUCTO=op.id_producto,
			inserted i	
	where op.id_viaje=i.id_viaje

	select @m3Producto = ISNULL (pro.m3,0)
	from	PRODUCTO pro,
			inserted i 
	where pro.ID_PRODUCTO=i.id_producto

	select @cantidad=i.cantidad
	from inserted i
	if (@capacidadBodega>= (@m3Utilizados +  ( @m3Producto *@cantidad ) ) )
	begin
		insert into OPERACION
		select i.FECHA as FECHA, i.HORA AS HORA, i.NUMERO_BODEGA AS NUMERO_BODEGA, i.ID_BARCO AS ID_BARCO, i.ID_VIAJE AS ID_VIAJE, i.ID_PRODUCTO AS ID_PRODUCTO, i.ID_TIPO_OPERACION AS ID_TIPO_OPERACION, i.CANTIDAD AS CANTIDAD
		from inserted as i
	end



insert into OPERACION
(FECHA, HORA, NUMERO_BODEGA, ID_BARCO, ID_VIAJE, ID_PRODUCTO, ID_TIPO_OPERACION, CANTIDAD) values('17/03/2015','01:02:59',5,2,11,4,1,4)
