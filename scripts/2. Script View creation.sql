# Poyecto entrega 2
## Grupo 14
## Juan Pablo Montaño Díaz
## Nicolas Zuluaga


USE EGRESADOS;

-- Vista 1 - Servicios de carnetización

-- drop view G14View1;

 create view G14View1 (Tipo_de_documento,Número_documento,Nombre,Tramite,Nombre_servicio,Lugar_servicio) as
 select p.per_tipo_documento, p.per_num_documento,concat(p.per_nombre,' ',p.per_apellido),s.serv_nombre,s.serv_horario,s.serv_lugar 
 from persona  p
 join estudiante es on p.per_tipo_documento=es.est_tipo_documento and p.per_num_documento=es.est_num_documento
 join acceso a on p.per_num_documento=a.acc_cedula
 join servicios s on a.acc_codigo_servicio=s.serv_codigo
 where s.serv_area='Registro y matrícula'
 ;
 
 -- select * from G14view1;
 
  -- Vista 2 - Servicios de Orientación ocupacional
  
  -- drop view G14View2;
  
 create view G14View2 (Tipo_de_documento,Número_documento,Nombre,Tramite,Nombre_servicio,Lugar_servicio) as
 select p.per_tipo_documento, p.per_num_documento,concat(p.per_nombre,' ',p.per_apellido),s.serv_nombre,s.serv_horario,s.serv_lugar 
 from persona  p
 join estudiante es on p.per_tipo_documento=es.est_tipo_documento and p.per_num_documento=es.est_num_documento
 join acceso a on p.per_num_documento=a.acc_cedula
 join servicios s on a.acc_codigo_servicio=s.serv_codigo
 where s.serv_area='Bienestar'
 ;
 
 -- select * from G14view2;
 
 -- Vista 3 - Servicios de Orientación ocupacional
 
 -- drop view G14View3;
 
 create view G14View3 (Tipo_de_documento,Número_documento,Nombre,Tramite,Nombre_servicio,Lugar_servicio) as
 select p.per_tipo_documento, p.per_num_documento,concat(p.per_nombre,' ',p.per_apellido),s.serv_nombre,s.serv_horario,s.serv_lugar 
 from persona  p
 join estudiante es on p.per_tipo_documento=es.est_tipo_documento and p.per_num_documento=es.est_num_documento
 join acceso a on p.per_num_documento=a.acc_cedula
 join servicios s on a.acc_codigo_servicio=s.serv_codigo
 where s.serv_area='Secretaria'
 ;
 
 -- select * from G14view3;
 
 -- Vista 4 - Servicios de Bibliotecas
 
 -- drop view G14View4;
 
 create view G14View4 (Tipo_de_documento,Número_documento,Nombre,Tramite,Nombre_servicio,Lugar_servicio) as
 select p.per_tipo_documento, p.per_num_documento,concat(p.per_nombre,' ',p.per_apellido),s.serv_nombre,s.serv_horario,s.serv_lugar 
 from persona  p
 join estudiante es on p.per_tipo_documento=es.est_tipo_documento and p.per_num_documento=es.est_num_documento
 join acceso a on p.per_num_documento=a.acc_cedula
 join servicios s on a.acc_codigo_servicio=s.serv_codigo
 where s.serv_area='Departamento de bibliotecas'
 ;
 
 -- select * from G14view4;
 
  
-- Vista 5 --Actividades academicas: Para saber fechas y ubicación
 
-- drop view G14View5;
 
create view G14View5 (Tipo_de_Actividad,Área,Nombre,Horario,Lugar,Encargado,Capacidad) as 
select a.act_tipo,aa.aca_area,a.act_nombre,a.act_horario,a.act_lugar,a.act_encargado,a.act_capacidad
from  actividad a 
join actividad_academica aa 
on aa.aca_codigo=a.act_codigo
;
 
 -- select * from G14View5;
 
-- Vista 6 --Actividades de emprendimiento: Para saber fechas y ubicación
 
create view G14View6 (Tipo_de_Actividad,Empresa,Invitados,Nombre,Horario,Lugar,Encargado,Capacidad) as 
select a.act_tipo,ae.aemp_empresa,ae.aemp_invitados,a.act_nombre,a.act_horario,a.act_lugar,a.act_encargado,a.act_capacidad
from  actividad a 
join actividad_emprendimiento ae 
on ae.aemp_codigo=a.act_codigo
 ;

-- select * from G14View6;


-- Vista 7 --Actividades de investigación: Para saber fechas y ubicación
 
create view G14View7 (Nombre_grupo,Nombre_actividad,Horario,Lugar,Encargado,Capacidad,Fondos,Patrocinador) as 
select ai.inv_nombre_grupo,a.act_nombre,a.act_horario,a.act_lugar,a.act_encargado,a.act_capacidad,ai.inv_recursos,ai.inv_patrocinador
from  actividad a 
join actividad_investigacion ai 
on ai.inv_codigo=a.act_codigo
;

-- select * from G14View7;


-- Vista 8 --Actividades de sociocultural
 
create view G14View8 (Área_cultural,Titulo,Horario,Lugar,Encargado,Capacidad,Invitado,Nombre_Grupoinvitado,Contacto) as 
select aso.soc_area_cultural,a.act_nombre,a.act_horario,a.act_lugar,a.act_encargado,a.act_capacidad,aso.soc_invitados,ga.gru_nombre,ga.gru_encargado
from  actividad a 
join actividad_sociocultural aso on aso.soc_codigo=a.act_codigo
join participacion_actsoc_gru pag on pag.PARTACTSOC_CODIGO_ACTIVIDAD=aso.soc_codigo
join grupo_artistico ga on pag.PARTACTSOC_GRU_ID=ga.gru_id
;

-- select * from G14View8;


-- Vista 9 -- Ofertas laborales 

create view G14View9 (Nombre_Empresa,Cargo,Salario,Experiencia_Cargo,Lugar,Modalidad,Carrera,Nombre,Carrera_Postulante,Experiencia,Idiomas) as 
select ol.ofe_nombre_empresa,ol.ofe_cargo,ol.ofe_salario,ol.ofe_experiencia,ol.ofe_lugar,ol.ofe_modalidad_trabajo,ol.ofe_carrera,concat(p.per_nombre,' ',p.per_apellido),ho.hv_programa_academico,ho.hv_experiencia,ho.hv_idioma
from  oferta_laboral ol
join postulacion po 
on po.pos_id_oferta =ol.ofe_id
join hojadevida ho
on po.pos_cedula = ho.hv_num_documento 
join egresado eg
on ho.hv_num_documento = eg.egr_num_documento
join persona p
on eg.egr_num_documento=p.per_num_documento
;

-- select * from G14View9;

-- Vista 10 -- Distinciones

create view G14View10 (Tipo_Distincion,Nombre_Distinción,Nombre,Comité,Lugar) as 
select  di.disti_tipo_distincion,di.disti_nombre,concat(p.per_nombre,' ',p.per_apellido),co.comi_nombre,co.comi_lugar
from  acta ac
join distincion di
on ac.acta_id=di.disti_acta
join persona p 
on p.per_num_documento=di.disti_num_identificacion
join comite co
on co.comi_identificador=ac.acta_comite
;

select * from G14View10;


