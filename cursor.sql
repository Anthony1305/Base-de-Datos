--	Cursor que muestre cuantos accesorios se han ocupado en cada habitación.
do $$
declare
        datos record;
        datos_lis cursor for select h1.habitacion_numero, h1.habitacion_tipo, count( c1.insumo_id) as cantidad
									from servicio as s1
									inner join habitacion as h1 on s1.habitacion_id = h1.habitacion_id
									inner join consumo as c1 on s1.servicio_id = c1.servicio_id
									group by  h1.habitacion_numero, h1.habitacion_tipo
									order by  h1.habitacion_numero;
begin
	for datos in datos_lis loop
		Raise notice 'Número de habitación: %, Tipo de habitación: %, Cantidad de accesorios usados: %', 
		datos.habitacion_numero, datos.habitacion_tipo, datos.cantidad;
	end loop;
end $$
language 'plpgsql';