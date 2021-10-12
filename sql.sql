-- Para eliminar un ajuste se debe borrar primero de la tabla gf_g_ajuste_detalle y despues de la tabla gf_g_ajustes
select * from gf_g_ajuste_detalle where id_ajste = 48412;

delete from gf_g_ajuste_detalle where id_ajste = 48413;

select * from gf_g_ajustes where id_ajste = 48412;

delete from gf_g_ajustes where id_ajste = 48413;









-- id para crear ajustes
select g.id_sjto_impsto, g.idntfccion_sjto, sum(vlor_sldo_cptal)
from V_GF_G_CARTERA_X_CONCEPTO d
join v_si_i_sujetos_impuesto g on g.id_sjto_impsto = d.id_sjto_impsto
where d.cdgo_clnte = 6
    and d.vgncia in ( 2020 )
  /*  and d.id_sjto_impsto in( select distinct id_sjto_impsto
from gi_g_liquidaciones x
where cdgo_clnte = 6
and id_prcso_crga in (372,373) and vgncia in ( 2018, 2019 ))*/
group by g.id_sjto_impsto, idntfccion_sjto
having sum(vlor_sldo_cptal) = 0 ;


create table gd_g_crga_dcmto_tem(
  id_acto number,
  id_dcmto number,
  nmro_acto number,
  nmbre_dcmto varchar(250),
  tmño_dcmto number,
  obsrvcion varchar(250)
);

select * from gd_g_crga_dcmto_tem order by 3;

delete from gd_g_crga_dcmto_tem where 1 = 2;

drop table gd_g_crga_dcmto_tem;
/
create table gd_g_dummy(
  id_dmmy number,
  file_blob blob
);

insert into gd_g_dummy(id_dmmy, file_blob) values(id_dmmy, empty_blob());

select * from gd_g_dummy;

/

select *--id_acto, id_dcmnto 
from gn_g_actos
where id_acto in (129179, 129167, 129170, 129183, 129182, 129181, 129172);

select * from gd_g_documentos
where id_dcmnto in (26741, 26742, 26743, 26744,  26745);

select dbms_lob.getLength(file_blob) from gd_g_documentos where rownum = 1;
/
select b.id_dcmnto, b.file_name
from gn_g_actos a
inner join gd_g_documentos b on a.id_dcmnto = b.id_dcmnto
where a.id_acto = 129167;

select * --b.nmro_acto, b.id_Acto
from gi_g_determinaciones a
join gn_g_actos b on a.id_Acto = b.id_Acto
where b.id_dcmnto is null and a.id_dtrmncion_lte = 822;


select b.nmro_acto, b.id_Acto
from gi_g_determinaciones a
join gn_g_actos b on a.id_Acto = b.id_Acto
where b.nmro_acto = 20190047839--and b.id_dcmnto is null -- a.id_dtrmncion_lte = 869
