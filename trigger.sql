---	trigger cuando un cliente tiene más de 2 mala reputación impida aceptarlo en el motel
create or replace function clienteMalaReputacion() returns trigger
as $clienteMalaReputacion$
    declare
		cantidad int;
begin		
		select count( s1.servicio_calificacion) into cantidad from cliente as c1 
		inner join servicio as s1 on c1.cliente_id = s1.cliente_id
		where s1.servicio_calificacion like '%mala reputacion%' and c1.cliente_id = new.cliente_id;	
        if(cantidad > 2) then
            raise exception 'Este cliente tiene mas de 2 malas reputaciones al alquilar un cuarto, por ende ya no se le permite ingresar nuevamente';
        end if;
        return new;
end;
$clienteMalaReputacion$
language plpgsql;

create trigger clienteMalaReputacionTrigger before insert
on servicio for each row
execute procedure clienteMalaReputacion();

--comprobacion trigger
select c1.cliente_id, count( s1.servicio_calificacion)
from cliente as c1 
inner join servicio as s1 on c1.cliente_id = s1.cliente_id
where s1.servicio_calificacion like '%mala reputacion%' 
group by c1.cliente_id;

insert into servicio (servicio_id, cliente_id, habitacion_id, servicio_fecha, servicio_horaentrada,  servicio_horasalida, 
					  servicio_valorhabitacion)
values (100, 3, 1, '05/09/2021', '09:48 PM', '10:48 PM', 10);