select	p.nombre
from	PAIS as p inner join PUERTO as puer 
		ON  puer.id_pais= p.id_pais 
		inner join VIAJE v
		ON V.puerto_zarpa = puer.id_puerto
where	p.id_pais NOT IN(
							SELECT distinct pu.id_pais
							from puerto as pu inner join viaje vi
							on pu.id_puerto = vi.puerto_zarpa
							where vi.fecha_zarpa < getdate()
						)
		and p.id_pais in (
							select distinct puerto.id_pais
							from	puerto inner join viaje 
									on	viaje.puerto_zarpa=puerto.id_puerto
									inner join barco on viaje.id_barco= barco.id_barco
							where	viaje.fecha_arriba < getdate()
									AND barco.ID_BANDERA <> puerto.id_pais
						)
