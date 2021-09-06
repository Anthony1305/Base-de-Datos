--	En un diagrama de barra mostrar cuanto 
--por año he obtenido de ganancias el motel.
select  to_char( s1.servicio_fecha,'YYYY') as año, 
sum( s1.servicio_valortotal) - sum (i1.insumo_preciocompra)
as total from  servicio as s1
inner join consumo  as h1 on s1.servicio_id = h1.servicio_id
inner join insumo  as i1 on h1.insumo_id = i1.insumo_id
group by año 



