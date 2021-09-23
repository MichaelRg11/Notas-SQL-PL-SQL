select t1.id_libro,
        upper(substr(t4.titulo, 0, 1)) || lower(substr(t4.titulo, 2)) as "Categoria", 
        upper(substr(t1.nombre, 0, 1)) || lower(substr(t1.nombre, 2)) as "Nombre Libro", 
        upper(substr(t1.descripcion, 0, 1)) || lower(substr(t1.descripcion, 2)) as "Descripcion", 
        upper(substr(t1.idioma, 0, 1)) || lower(substr(t1.idioma, 2)) as "Idioma", 
        t1.url_portada as "URL Portada", 
        to_char(to_date(t1.fecha_lanzamiento, 'dd-mm-rr'), 'FMDay, DD "de" Month "de" YYYY') as "Lanzamiento",
        upper(substr(t2.nombre, 0, 1)) || lower(substr(t2.nombre, 2)) ||  ' ' || 
            upper(substr(t2.apellido, 0, 1)) || lower(substr(t2.apellido, 2)) as "Nombre Autor",
        upper(substr(t3.nombre, 0, 1)) || lower(substr(t3.nombre, 2)) as "Editorial"
from bt_libro t1
join bt_autor t2 on t2.id_autor = t1.id_autor
join bt_editorial t3 on t3.id_editorial = t1.id_editorial
join bt_categoria t4 on t4.id_categoria = t1.id_categoria;

select t1.id_prestamo,
        to_char(to_date(t1.fecha_prestamo, 'dd-mm-rr'), 'FMDay, DD "de" Month "de" YYYY') as "Fecha prestamo",
        upper(substr(t2.nombre, 0, 1)) || lower(substr(t2.nombre, 2)) as "Nombre Libro",
        t2.url_portada as "Portada",
        upper(substr(t3.nombre, 0, 1)) || lower(substr(t3.nombre, 2)) ||  ' ' || 
            upper(substr(t3.apellido, 0, 1)) || lower(substr(t3.apellido, 2)) as "Nombre usuario",
        case 
            when t4.fecha is not null then 'Entregado'
            else 'No entregado'
        end as "Estado",
        to_char(to_date(t4.fecha, 'dd-mm-rr'), 'FMDay, DD "de" Month "de" YYYY') as "Fecha de entrega"
from bt_prestamo t1
join bt_libro t2 on t2.id_libro = t1.id_libro
join bt_cliente t3 on t3.id_cliente = t1.id_cliente
left join bt_devolucion t4 on t4.id_prestamo = t1.id_prestamo;


insert into bt_devolucion(fecha, id_prestamo) 
values ('21-Sep-22', 1);

delete from bt_devolucion where id_devolucion = 2;

commit;

select * from bt_cliente;

select * from bt_devolucion;