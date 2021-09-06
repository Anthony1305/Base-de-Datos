-- Procedimiento almacenado que permita Ingresar la cedula del cliente y salga todas las fechas que el cliente nos ha visitado. 
CREATE or replace  FUNCTION fechasCliente(varchar)	RETURNS varchar
AS $BODY$
DECLARE
	cedula alias for $1;
	datos RECORD;
	cur_datos cursor FOR select * from cliente as c1
							inner join servicio as s1 on c1.cliente_id = s1.cliente_id
							where c1.cliente_cedula = $1
							order by s1.servicio_fecha;		
begin
	for datos in cur_datos loop
		Raise notice 'Fecha visitada: %', datos.servicio_fecha;
	end loop;
end; $BODY$
language 'plpgsql';

--comprobacion de procedimiento almacenado

select fechasCliente('5727382596');

select fechasCliente('4356208577');

select cliente_cedula from cliente;