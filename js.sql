[
  { idntfccion: '0104000044280014000000000' },
  { idntfccion: '0102000013280902900000438' },
  { idntfccion: '0104000010000001000000000' },
  { idntfccion: '0104000003690001000000000' },
  { idntfccion: '0105000003750001000000000' },
  { idntfccion: '0105000000270001901020007' },
  { idntfccion: '0105000004930002000000000' },
  { idntfccion: '0102000013190001000000000' },
  { idntfccion: '0104000003540001000000000' },
  { idntfccion: '0102000013080001000000000' },
  { idntfccion: '0102000013190004000000000' },
  { idntfccion: '0102000013190002000000000' },
  { idntfccion: '0100000001440020000000000' },
  { idntfccion: '0105000004930003000000000' },
  { idntfccion: '0102000013190003000000000' },
  { idntfccion: '0100000010210001000000000' },
  { idntfccion: '0102000012740001000000000' },
  { idntfccion: '0104000009940001000000000' },
  { idntfccion: '0104000003630001000000000' },
  { idntfccion: '0105000000040016000000000' },
]

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0104000044280014000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0102000013280902900000438', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0104000010000001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0104000003690001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0105000003750001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0105000000270001901020007', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0105000004930002000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0102000013190001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0104000003540001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0102000013080001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0105000000040016000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0104000003630001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0104000009940001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0102000012740001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0100000010210001000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0102000013190003000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0105000004930003000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0100000001440020000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0102000013190002000000000', 2021, 2021);

insert into cb_g_candidatos_juridico (cdgo_clnte, idntfccion_sjto, vgncia_dsde, vgncia_hsta)
values (8758, '0102000013190004000000000', 2021, 2021);

select * from gn_g_actos a
where a.id_acto = 8758575;
-- 471947
select * from gd_g_documentos a
where a.id_dcmnto = 471947;

select * from gn_g_actos_vigencia a
where a.id_acto = 8758575;

select * from gn_g_actos_sujeto_impuesto a
where a.id_acto = 8758575;

select * from gn_g_actos_responsable a
where a.id_acto = 8758575;

update gn_g_actos set id_dcmnto = null
where id_acto = 8758575;

-- eliminar acto y documento asociado 
delete gn_g_actos_vigencia a 
where a.id_acto = 8758575;

delete gn_g_actos_responsable a
where a.id_acto = 8758575;

delete gn_g_actos_sujeto_impuesto a
where a.id_acto = 8758575;

delete gn_g_actos a
where a.id_acto = 8758575;
-- 471947
delete gd_g_documentos a
where a.id_dcmnto = 471947;