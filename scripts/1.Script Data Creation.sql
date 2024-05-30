# Poyecto entrega 2
## Grupo 14
## Juan Pablo Montaño Díaz
## Nicolas Zuluaga


CREATE SCHEMA EGRESADOS;
USE EGRESADOS;

#------------------- SCRIPT DE LA CREACIÓN DE TABLAS ---------------------------
#### --------------------------------------------TABLAS DE UNIVERSIDAD -----------------------


#Tabla con información de la sede de la universidad
CREATE TABLE SEDE (
SED_NOMBRE varchar(50) UNIQUE NOT NULL COMMENT "Nombre de la sede de la universidad" primary key,
SED_Vicerrector varchar(50) UNIQUE NOT NULL COMMENT "Nombre de  el/la vicerrector/a de la sede",
SED_ESTUDIANTES int not null comment "Numero de estudiantes de la sede",
SED_FACULTADES int not null comment "Numero de facultades en la sede"
);


#Tabla con información de las facultades de la universidad
CREATE TABLE FACULTAD (
FAC_CODIGO INT unique NOT NULL COMMENT "Código identificativo de la facultad" primary key, 
FAC_SEDE varchar(50) NOT NULL COMMENT "Nombre de la sede de la universidad a la cual pertenece la facultad",
CONSTRAINT FAC_SEDE FOREIGN KEY (FAC_SEDE) REFERENCES SEDE(SED_NOMBRE),
FAC_NOMBRE VARCHAR(50) not null comment "Nombre de la facultad",
FAC_DECANO varchar(50) UNIQUE NOT NULL COMMENT "Nombre de  el/la decano/a de la sede",
FAC_NUMERO int not null comment "Numero de telefono de la facultad",
FAC_HORARIO varchar(50) not null comment "Horario de atención de la facultad",
FAC_OFICINA varchar(50) not null comment "Oficina de la secretaria de facultad"
);

#Tabla con información de los departamentos 
CREATE TABLE DEPARTAMENTO (
DEP_CODIGO INT UNIQUE NOT NULL COMMENT "Codigo identificador del departamento" primary key, 
DEP_NOMBRE VARCHAR(50) not null comment "Nombre de la facultad",
DEP_FACULTAD int NOT NULL COMMENT "Código de la facultad a la cual pertenece el departamento",
CONSTRAINT DEP_FACULTAD FOREIGN KEY (DEP_FACULTAD) REFERENCES FACULTAD(FAC_CODIGO),
DEP_TELEFONO int not null comment "Numero de telefono del departamento",
DEP_HORARIO varchar(50) not null comment "Horario de atención del departamento",
DEP_OFICINA int not null comment "Oficina de atención del departamento"
);


#Tabla con información de los programas academicos
CREATE TABLE PROGRAMA (
PRO_ID int not null comment "Codigo SIA del programa Academico" primary key, 
PRO_NOMBRE VARCHAR(50) not null comment "Nombre del programa",
PRO_DEPARTAMENTO int NOT NULL COMMENT "Codigo del departamento al cual pertenece el programa",
CONSTRAINT PRO_DEPARTAMENTO FOREIGN KEY (PRO_DEPARTAMENTO) REFERENCES DEPARTAMENTO(DEP_CODIGO),
PRO_DIRECTOR varchar(50) UNIQUE NOT NULL COMMENT "Nombre de  el/la director/a del area curricular del programa"
);


####---------------------------------------------TABLAS DE PERSONAS ------------------------------------

#Tabla de informacion basica de la persona, esta es una clase
CREATE TABLE  PERSONA (  
	PER_TIPO_DOCUMENTO varchar(50) NOT NULL COMMENT "Tipo de documento de identidad de la persona",
    PER_NUM_DOCUMENTO INT NOT NULL unique comment "Numero de identificacion de la persona", 
    PER_NOMBRE VARCHAR(50) NOT NULL comment "Nombre de la persona", 
    PER_APELLIDO varchar(50) NOT NULL comment "Apellido de la persona",
    PER_FECHA_NACIMIENTO datetime not null comment "Fecha de nacimiento de la persona",
    PRIMARY KEY(PER_TIPO_DOCUMENTO,PER_NUM_DOCUMENTO)
);

#drop table PERSONA;
#Tabla de información del egresado, subclase de persona
CREATE TABLE  EGRESADO (  
	EGR_TIPO_DOCUMENTO varchar(50) NOT NULL COMMENT "Tipo de documento de identidad de la persona",
    EGR_NUM_DOCUMENTO INT NOT NULL comment "Numero de identificacion de la persona", 
    CONSTRAINT EGR_TIPO_DOCUMENTO FOREIGN KEY (EGR_TIPO_DOCUMENTO) REFERENCES PERSONA(PER_TIPO_DOCUMENTO),
    CONSTRAINT EGR_NUM_DOCUMENTO FOREIGN KEY (EGR_NUM_DOCUMENTO) REFERENCES PERSONA(PER_NUM_DOCUMENTO),
    EGR_PAPA DECIMAL(2,1) NOT NULL comment "Promedio académico ponderado acumulado", 
    EGR_PA DECIMAL (2,1) NOT NULL comment "Promedio academico del egresado",
    EGR_SEMESTRE_INGRESO VARCHAR(50) NOT NULL COMMENT "Semestre de ingreso a la universidad",
    EGR_SEMESTRE_EGRESO varchar(50) NOT NULL COMMENT "Semestre de egreso de la universidad",
    PRIMARY KEY(EGR_TIPO_DOCUMENTO,EGR_NUM_DOCUMENTO)
);


#Tabla de información de los estudiantes, subclase de persona
CREATE TABLE  ESTUDIANTE (  
	EST_TIPO_DOCUMENTO varchar(50) NOT NULL COMMENT "Tipo de documento de identidad de la persona",
    EST_NUM_DOCUMENTO INT NOT NULL comment "Numero de identificacion de la persona", 
    CONSTRAINT EST_TIPO_DOCUMENTO FOREIGN KEY (EST_TIPO_DOCUMENTO) REFERENCES PERSONA(PER_TIPO_DOCUMENTO),
    CONSTRAINT EST_NUM_DOCUMENTO FOREIGN KEY (EST_NUM_DOCUMENTO) REFERENCES PERSONA(PER_NUM_DOCUMENTO),
    EST_PAPA DECIMAL(2,1) NOT NULL comment "Promedio académico ponderado acumulado del estudiante", 
    EST_PA DECIMAL (2,1) NOT NULL comment "Promedio academico del estudiante",
    EST_SEMESTRE_INGRESO VARCHAR(50) NOT NULL COMMENT "Semestre de ingreso a la universidad",
    EST_AVANCE varchar(50) NOT NULL COMMENT "Avance de la carrera del estudiante",
    PRIMARY KEY(EST_TIPO_DOCUMENTO,EST_NUM_DOCUMENTO)
);

#Tabla de información de las personas administrativas
CREATE TABLE ADMINISTRATIVO (  
	ADM_TIPO_DOCUMENTO varchar(50) NOT NULL COMMENT "Tipo de documento de identidad de la persona",
    ADM_NUM_DOCUMENTO INT NOT NULL comment "Numero de identificacion de la persona", 
    CONSTRAINT ADM_TIPO_DOCUMENTO FOREIGN KEY (ADM_TIPO_DOCUMENTO) REFERENCES PERSONA(PER_TIPO_DOCUMENTO),
    CONSTRAINT ADM_NUM_DOCUMENTO FOREIGN KEY (ADM_NUM_DOCUMENTO) REFERENCES PERSONA(PER_NUM_DOCUMENTO),
    ADM_CARGO varchar(50) NOT NULL comment "Cargo admiministrativo que desempenha la persona", 
    ADM_AREA varchar(50) NOT NULL comment "Area administrativa para la cual desempeña el cargo",
    ADM_FECHA_INGRESO datetime  NOT NULL COMMENT "Fecha de ingreso de la persona al cargo",
    ADM_TIPO_CONTRATO varchar(50) NOT NULL COMMENT "Tipo de contrato laboral",
    ADM_SEDE varchar(50) NOT NULL COMMENT "Sede de la universidad para la cual la persona desempenha sus funciones",
    CONSTRAINT ADM_SEDE FOREIGN KEY (ADM_SEDE) REFERENCES SEDE(SED_NOMBRE),
    PRIMARY KEY(ADM_TIPO_DOCUMENTO,ADM_NUM_DOCUMENTO)
);






### --------------------------------------------- TABLAS DE SERVICIOS -----------------------------------
CREATE TABLE SERVICIOS(
SERV_CODIGO int unique not null auto_increment comment "Codigo identificador del servicio" primary key, 
SERV_NOMBRE VARCHAR(50) NOT NULL COMMENT "Nombre del servicio",
SERV_AREA varchar(50) NOT null comment "Area de la universidad que brinda el servicio" ,
SERV_HORARIO varchar(50) not null comment "horario en el cual se puede realizar el servicio",
SERV_LUGAR varchar(50) not null comment "Lugar donde se puede realizar el servicio"
);


#### ---------------------------------------------TABLAS DE ACTIVIDADES ---------------------------------


### Esta seccion es respecto a todo lo involucrado con las actividades a las cuales pueden acceder los egresados


##Superclase de la actividad
CREATE TABLE  ACTIVIDAD (  
	ACT_CODIGO INT NOT NULL auto_increment comment "Código identificador de la actividad" primary key, 
    ACT_NOMBRE VARCHAR(50) NOT NULL comment "Nombre de la actividad", 
    ACT_HORARIO varchar(50) NOT NULL comment "Horario de la actividad",
    ACT_LUGAR varchar(50) NOT NULL comment "Lugar donde se realizara la actividad",
    ACT_ENCARGADO varchar(50) NOT NULL comment "Persona o entidad encargada de la actividad",
    ACT_CAPACIDAD INT NOT NULL comment "Cantidad de personas que pueden participar en la actividad",
    ACT_COSTO INT NOT NULL comment "Costo de la actividad",
    ACT_TIPO varchar(50) comment "Tipo de la actividad"
);


#Ahora, creamos las tablas de la actividad

#Tabla de actividad académica
CREATE TABLE  ACTIVIDAD_ACADEMICA (  
	ACA_CODIGO INT NOT NULL comment "Código identificador de la actividad",
    FOREIGN KEY (ACA_CODIGO) REFERENCES ACTIVIDAD(ACT_CODIGO),
    ACA_AREA varchar(50) comment "Área académica de la que se trata la actividad"
);

#Tabla de actividad de empleo
CREATE TABLE  ACTIVIDAD_BOLSA_EMPLEO (  
	BOL_CODIGO INT NOT NULL comment "Código de la feria de empleo",
    FOREIGN KEY (BOL_CODIGO) REFERENCES ACTIVIDAD(ACT_CODIGO),
    BOL_EMPRESAS_PRIVADAS int not null comment "Cantidad de empresas invitadas a la actividad",
    BOL_AREA_TRABAJO varchar(50) not null comment "Área del conocimiento/industria de la cual fueron invitadas las empresas"
);


#Tabla de actividad DE EMPREDIMIENTO
CREATE TABLE  ACTIVIDAD_EMPRENDIMIENTO (  
	AEMP_CODIGO INT NOT NULL comment "Código identificador de la actividad",
    FOREIGN KEY (AEMP_CODIGO) REFERENCES ACTIVIDAD(ACT_CODIGO),
    AEMP_EMPRESA varchar(50) NOT NULL comment "Área académica de la que se trata la actividad",
    AEMP_INVITADOS varchar(50) NOT NULL comment "Invitados al evento que no forman parte de la universidad",
    AEMP_EQUIPOS varchar(50) NOT NULL comment "Recursos tecnológicos necesarios para la actividad"
);


#Tabla de actividad investigación
CREATE TABLE  ACTIVIDAD_INVESTIGACION (  
	INV_CODIGO INT NOT NULL comment "Código registrado en el sistema HERMES del grupo de investigación o actividad investigativa",
    FOREIGN KEY (INV_CODIGO) REFERENCES ACTIVIDAD(ACT_CODIGO),
    INV_NOMBRE_GRUPO varchar(50) NOT NULL comment "Nombre del grupo de investigacion",
    INV_RECURSOS INT NOT NULL comment "Recursos economicos dados por la universidad al grupo de investigación",
    INV_PATROCINADOR varchar(50) comment "Empresa o entidad externa (si hay) que proporcione recursos adicionales al grupo de investigación"
);

#Tabla de actividad sociocultural
CREATE TABLE  ACTIVIDAD_SOCIOCULTURAL (  
	SOC_CODIGO INT NOT NULL auto_increment comment "Código de la actividad sociocultural",
    FOREIGN KEY (SOC_CODIGO) REFERENCES ACTIVIDAD(ACT_CODIGO),
    SOC_INVITADOS varchar(50) comment "Invitados al evento que no forman parte de la universidad",
    SOC_AREA_CULTURAL varchar(50) NOT NULL comment "Area cultural a la cual esta enfocada el evento"
);



#Tabla con la información de los grupos artísticos
CREATE TABLE  GRUPO_ARTISTICO (  
	GRU_ID INT NOT NULL auto_increment comment "Código identificador del grupo artistico en el sistema de bienestar" PRIMARY key, 
    GRU_NOMBRE varchar(60) not null comment "nombre del grupo artístico",
    GRU_TIPO varchar(50) comment "Tipo de grupo artistico, ej: Danza, teatro, musica",
    GRU_ENCARGADO VARCHAR(50) COMMENT "Persona que representa y/o lidera el grupo artistico"
);

ALTER TABLE GRUPO_ARTISTICO auto_increment= 12000;
#Tabla de directorios de empresas, aquí se guardará la información de las empresas
CREATE TABLE  DIRECTORIO_EMPRESA (  
	DIR_NOMBRE varchar(50) NOT NULL UNIQUE comment "Nombre del directorio" PRIMARY key, 
    DIR_TIPO_EMPRESA varchar(50) comment "La empresa es para estudiantes o egresados",
    DIR_MERCADO varchar(50) comment "Mercado o nicho para el cual está enfocado el directorio"
);


#Tabla de empresas, aqui se guarda la información detallada de una empresa
CREATE TABLE  EMPRESA (    
	EMP_NIT INT NOT NULL UNIQUE comment "NIT de la empresa" PRIMARY key, 
    EMP_RAZON_SOCIAL VARCHAR(50) NOT NULL COMMENT "Razon social de la empresa",
    EMP_UBICACION VARCHAR(50) NOT NULL COMMENT "DIreccion fisica de la empresa",
    EMP_PERSONA_DE_CONTACTO VARCHAR(50) NOT NULL COMMENT "Nombre de la persona encarga del servicio de atención de la empresa",
    EMP_HORARIO INT NOT NULL,
    EMP_MISION VARCHAR(250) NOT NULL comment "Mision de la empresa",
    EMP_VISION VARCHAR(250) NOT NULL comment "Vision de la empresa",
    EMP_ANNO_CREACION int not null comment "Anno de creacion de la empresa", 
    EMP_DIRECTORIO VARCHAR(50) NOT NULL comment "Directorio donde se encuentra registrada la empresa",
    CONSTRAINT EMP_DIRECTORIO FOREIGN KEY (EMP_DIRECTORIO) REFERENCES DIRECTORIO_EMPRESA(DIR_NOMBRE)
);

#Tabla de oferta laboral, aquí se guarda toda al información relevante de una oferta laboral especifica
CREATE TABLE  OFERTA_LABORAL (  
	OFE_ID INT NOT NULL UNIQUE auto_increment comment "Código identificador de la oferta laboral" PRIMARY key, 
    OFE_CODIGO_FERIA INT NOT NULL comment "Código de la feria de empleo",
    OFE_EMPRESA_NIT INT NOT NULL COMMENT "Persona que representa y/o lidera el grupo artistico",
    OFE_NOMBRE_EMPRESA VARCHAR(150) NOT NULL comment "Nombre de la empresa que publica la oferta",
    OFE_CARGO VARCHAR(150) NOT NULL comment "Cargo de la oferta laboral",
    OFE_SALARIO INT NOT NULL comment "Salario del cargo a desempeñar",
    OFE_EXPERIENCIA VARCHAR(550) NOT NULL comment "experiencia laboral necesaria en el cargo",
    OFE_LUGAR VARCHAR(150) NOT NULL comment "Dirección del lugar de trabajo de la oferta",
    OFE_MODALIDAD_TRABAJO VARCHAR(150) NOT NULL comment "Modalidad de trabajo del cargo",
	OFE_TIPO_CONTRATO VARCHAR(150) NOT NULL comment "Tipo de contrato de la oferta laboral",
    OFE_CARRERA VARCHAR(550) NOT NULL comment "Carreras buscadas para el cargo",
    CONSTRAINT OFE_EMPRESA_NIT FOREIGN KEY (OFE_EMPRESA_NIT) REFERENCES EMPRESA(EMP_NIT),
    CONSTRAINT OFE_CODIGO_FERIA FOREIGN KEY (OFE_CODIGO_FERIA) REFERENCES ACTIVIDAD_BOLSA_EMPLEO(BOL_CODIGO)
);

ALTER TABLE OFERTA_LABORAL AUTO_INCREMENT = 5000000;

#Tabla de convocatoria, aquí se guarda toda al información relevante de una convocatoria de la universidad
CREATE TABLE  	CONVOCATORIA (  
	CON_CODIGO INT NOT NULL UNIQUE auto_increment comment "Código identificador de la convocatoria" PRIMARY key, 
    CON_FECHA_INICIO DATETIME NOT NULL UNIQUE comment "Fecha de inicio de la convocatoria",
    CON_FECHA_CIERRE DATETIME NOT NULL UNIQUE comment "Fecha de cierre de la convocatoria",
    CON_NUMERO_CUPOS int NOT NULL comment "Numero de personas a ser aceptadas en la convocatoria",
    CON_ACTIVIDAD int NOT NULL UNIQUE comment "Codigo de la actividad para la cual se esta realizando la convocatoria",
    CONSTRAINT CON_ACTIVIDAD FOREIGN KEY (CON_ACTIVIDAD) REFERENCES ACTIVIDAD(ACT_CODIGO)
);
alter table convocatoria auto_increment=65401;  

### SCRIPT DE TABLAS DE RELACIONES MUCHOS A MUCHOS----------------------


#Tabla de hoja de vida
CREATE TABLE HOJADEVIDA (  
    HV_TIPO_DOCUMENTO varchar(50) NOT NULL COMMENT "Tipo de documento de identidad de la persona",
    HV_NUM_DOCUMENTO INT NOT NULL unique comment "Numero de identificacion de la persona", 
    HV_PROGRAMA_ACADEMICO varchar(50) not null comment "Programa academico de la persona",
    HV_EXPERIENCIA varchar(2000) not null comment "Experiencia laboral de la persona",
    HV_IDIOMA varchar(200) comment "Idiomas que habla la persona",
    CONSTRAINT HV_TIPO_DOCUMENTO FOREIGN KEY (HV_TIPO_DOCUMENTO) REFERENCES EGRESADO(EGR_TIPO_DOCUMENTO),
    CONSTRAINT HV_NUM_DOCUMENTO FOREIGN KEY (HV_NUM_DOCUMENTO) REFERENCES EGRESADO(EGR_NUM_DOCUMENTO)
);






#Tabla de acceso a los servicios
CREATE TABLE  ACCESO (  
	ACC_CODIGO_TRANSACCION INT not null auto_increment comment "Codigo artificial para identificar la transacción servicio-persona" primary key,
    ACC_CODIGO_SERVICIO int not null comment "Nombre del servicio al cual se accede",
    ACC_CEDULA INT NOT NULL comment "Cedula de la persona que accede al servicio",
	CONSTRAINT ACC_CEDULA FOREIGN KEY (ACC_CEDULA) REFERENCES PERSONA(PER_NUM_DOCUMENTO),
	CONSTRAINT ACC_CODIGO_SERVICIO FOREIGN KEY (ACC_CODIGO_SERVICIO) REFERENCES SERVICIOS(SERV_CODIGO),
    ACC_FECHA datetime  not null comment "Fecha en la que se accedio al servicio"
);

ALTER TABLE ACCESO auto_increment=567000;

#RELACION GRUPO ARTISTICO- ACTIVIDAD SOCIOCULTURAL
CREATE TABLE  PARTICIPACION_ACTSOC_GRU (  
	PARTACTSOC_CODIGO_ACTIVIDAD int not null comment "Código de la actividad en la que se va a participar" , 
     PARTACTSOC_GRU_ID int not null comment "Codigo ID del grupo artistico que participa",
	CONSTRAINT PARTACTSOC_GRU_ID FOREIGN KEY (PARTACTSOC_GRU_ID) REFERENCES GRUPO_ARTISTICO(GRU_ID),
	CONSTRAINT PARTACTSOC_CODIGO_ACTIVIDAD FOREIGN KEY (PARTACTSOC_CODIGO_ACTIVIDAD) REFERENCES ACTIVIDAD_SOCIOCULTURAL(SOC_CODIGO)
);


#Tabla de postulacion de una oferta laboral
CREATE TABLE POSTULACION (  
	POS_CEDULA INT NOT NULL comment "Cédula del postulante a la oferta laboral" ,
    POS_FECHA DATETIME comment "Fecha de postulación a la oferta laboral" , 
    FOREIGN KEY (POS_CEDULA) REFERENCES HOJADEVIDA(HV_NUM_DOCUMENTO),
    POS_ID_OFERTA INT NOT NULL comment "Código de la oferta laboral",
    FOREIGN KEY (POS_ID_OFERTA) REFERENCES OFERTA_LABORAL(OFE_ID),
    PRIMARY KEY (POS_CEDULA,POS_FECHA)
);

#Tabla de aplicacion de una oferta laboral
CREATE TABLE APLICACION (  
	APL_CODIGO INT NOT NULL comment "Codigo de la convocatoria a la que se aplico",
    FOREIGN KEY (APL_CODIGO) REFERENCES CONVOCATORIA(CON_CODIGO),
    APL_IDENTIFICACION INT comment "Numero de identificacion de la persona",
    APL_TIPO_DOCUMENTO varchar(50) NOT NULL COMMENT "Tipo de documento de identidad de la persona",
    CONSTRAINT APL_TIPO_DOCUMENTO FOREIGN KEY (APL_TIPO_DOCUMENTO) REFERENCES PERSONA(PER_TIPO_DOCUMENTO),
    FOREIGN KEY (APL_IDENTIFICACION) REFERENCES PERSONA(PER_NUM_DOCUMENTO),
    APL_FECHA_APLICACION datetime not null comment "Fecha de la aplicacion a la convocatoria",
    PRIMARY KEY (APL_CODIGO, APL_IDENTIFICACION, APL_TIPO_DOCUMENTO,APL_FECHA_APLICACION)
);

#Tabla de la sede que brinda servicios
CREATE TABLE SEDE_BRINDA_SERVICIOS (  
    BRI_SERVICIO int comment "Codigo del servicio que se oferta", 
    FOREIGN KEY (BRI_SERVICIO) REFERENCES SERVICIOS(SERV_CODIGO),
    BRI_SEDE VARCHAR(50) NOT NULL comment "Sede que ofrece el servicio",
    FOREIGN KEY (BRI_SEDE) REFERENCES SEDE(SED_NOMBRE),
    PRIMARY KEY (BRI_SERVICIO,BRI_SEDE)
);

#Tabla de estudio entre egresado y programa
CREATE TABLE EGRESADO_ESTUDIO_PROGRAMA(
EEP_TIPO_IDENTIFICACION varchar(50) not null comment "Tipo de documento de la persona",
EEP_IDENTIFICACION INT NOT NULL COMMENT "NUMERO DE IDENTIFICACION DEL EGRESADO", 
EEP_PROGRAMA INT NOT NULL COMMENT "CODIGO DEL PROGRAMA ACADEMICO", 
FOREIGN KEY (EEP_TIPO_IDENTIFICACION) REFERENCES EGRESADO(EGR_TIPO_DOCUMENTO),
FOREIGN KEY (EEP_IDENTIFICACION) REFERENCES EGRESADO(EGR_NUM_DOCUMENTO),
FOREIGN KEY (EEP_PROGRAMA) REFERENCES PROGRAMA(PRO_ID),
primary key(EEP_TIPO_IDENTIFICACION,EEP_IDENTIFICACION,EEP_PROGRAMA)
);


#Tabla de estudio entre estudiante y programa
CREATE TABLE ESTUDIANTE_ESTUDIO_PROGRAMA(
ESEP_TIPO_IDENTIFICACION VARCHAR(50) NOT NULL COMMENT "TIPO DE IDENTIFIACION DEL ESTUDIANTE",
ESEP_IDENTIFICACION INT NOT NULL COMMENT "NUMERO DE IDENTIFICACION DEL ESTUDIANTE", 
ESEP_PROGRAMA INT NOT NULL COMMENT "CODIGO DEL PROGRAMA ACADEMICO", 
FOREIGN KEY (ESEP_IDENTIFICACION) REFERENCES ESTUDIANTE(EST_NUM_DOCUMENTO),
FOREIGN KEY (ESEP_PROGRAMA) REFERENCES PROGRAMA(PRO_ID),
primary key(ESEP_TIPO_IDENTIFICACION,ESEP_IDENTIFICACION,ESEP_PROGRAMA)
);

#Finalmente, vamos a crear las tablas de la parte administrativa
CREATE TABLE COMITE(
COMI_IDENTIFICADOR INT NOT NULL UNIQUE AUTO_INCREMENT COMMENT "ID identificador del comité" primary key,
COMI_NOMBRE varchar(50) not null comment "Nombre del comite",
COMI_LUGAR varchar(50) not null comment "Lugar donde se realiza el comite"
);


ALTER TABLE COMITE AUTO_INCREMENT=3500;

CREATE TABLE ADMINISTRATIVO_PARTICIPA_COMITE(
ADPARCOM_TIPO_DOCUMENTO varchar(50) not null comment "Tipo de documento del administrativo",
ADPARCOM_NUM_DOCUMENTO int not null unique comment "Numero de documento del administrativo",
ADPARCOM_COMI_IDENTIFICADOR int not null comment "Identificador del comité donde participa el administrativo",
FOREIGN KEY (ADPARCOM_TIPO_DOCUMENTO) references ADMINISTRATIVO(ADM_TIPO_DOCUMENTO),
FOREIGN KEY (ADPARCOM_NUM_DOCUMENTO) references ADMINISTRATIVO(ADM_NUM_DOCUMENTO),
FOREIGN KEY (ADPARCOM_COMI_IDENTIFICADOR) references COMITE(COMI_IDENTIFICADOR),
Primary key(ADPARCOM_COMI_IDENTIFICADOR,ADPARCOM_TIPO_DOCUMENTO,ADPARCOM_NUM_DOCUMENTO)
);



CREATE TABLE ACTA (
ACTA_ID int not null unique auto_increment comment "Identificador del acta" primary key,
ACTA_FECHA datetime not null comment "Fecha en la que se radicó el acta",
ACTA_COMITE int comment "Codigo del comite que hizo el acta",
foreign key (ACTA_COMITE) references COMITE(COMI_IDENTIFICADOR)
); 

alter table acta auto_increment=14569703;

CREATE TABLE DISTINCION (
DISTI_ACTA INT NOT NULL COMMENT "Codigo del acta que otorga la distinción",
DISTI_TIPO_IDENTIFICACION varchar(50) NOT NULL COMMENT "Tipo de documento de la persona a la que se le otorga la distinción",
DISTI_NUM_IDENTIFICACION INT NOT NULL COMMENT "Numero de identificacino a quien se le otorga la distincion",
DISTI_NOMBRE varchar(50) not null comment "Nombre de la distincion otorgada",
DISTI_TIPO_DISTINCION varchar(50) not null comment "Categoria a la que pertenece la distincion otorgada", 
FOREIGN KEY (DISTI_TIPO_IDENTIFICACION) REFERENCES PERSONA(PER_TIPO_DOCUMENTO),
FOREIGN KEY (DISTI_NUM_IDENTIFICACION) REFERENCES PERSONA(PER_NUM_DOCUMENTO),
FOREIGN KEY (DISTI_ACTA) REFERENCES ACTA(ACTA_ID),
PRIMARY KEY (DISTI_ACTA,DISTI_TIPO_IDENTIFICACION,DISTI_NUM_IDENTIFICACION)
);


##### VAMOS A AÑADIR LOS DATOS --------------------------------------------------



#Ahora, vamos a insertar los datos para las talblas relacionadas con la universidad
INSERT INTO SEDE (SED_NOMBRE, SED_VICERRECTOR, SED_ESTUDIANTES, SED_FACULTADES) VALUES
("Bogotá", "Lionel Messi",11000, 5),
("Medellín","Kyliam Mbappé",5000,3),
("Manizales","Neymar Jr",4000,2),
("La Paz","Cristiano Ronaldo",2500,2);


#Añadimos la información de las facultades ---------- 

INSERT INTO FACULTAD (FAC_CODIGO,FAC_SEDE, FAC_NOMBRE, FAC_DECANO, FAC_NUMERO,FAC_HORARIO,FAC_OFICINA) VALUES
(10,"Bogotá","Ingenieria","Radamel Falcao",315654892, "L-V 8-12m",604),
(11,"Bogotá","Ciencias","Carlos Bacca",316984125, "L-V 1 pm-5pm",312),
(12,"Bogota","Artes", "Robert de Niro", 311578403, "Ma-J 12m - 4pm",514),
(13,"Bogotá","Derecho","Pep Guardiola", 358498203, "Mie-V 8-12m", 923),
(14,"Bogota", "Ciencias económicas", "Albert Einstein",369788516, "L-J 1-8 pm", 456),
(15,"Medellín", "Ciencias", "Stephen Hawking", 12345678,"L-Mie 8am-12m", 215),
(16,"Medellín", "Ingenieria","Rene Higuita", 356142890, "L-V 8am-12m", 70 ),
(17,"Medellín","Ciencias humanas", "Rene Descartes",35841265, "L-V 12m-5 pm", 420),
(18,"Manizales","Medicina","Hipocrates",356898104,"L-D 7 am-7pm", 911),
(19,"Manizales","Arquitectura","Miguel Angel",311685420,"L-Mie 8 am -5 pm", 633),
(20,"La Paz","Ciencias","Karl Gauss",365987125,"L-V 8 am- 5pm",314),
(21,"La Paz","Ciencias humanas", "Karl Marx", 365211984, "L-J 10 am -5 pm", 15)
;

#Añadimos la información de los departamentos
INSERT INTO DEPARTAMENTO (DEP_CODIGO,DEP_NOMBRE, DEP_FACULTAD, DEP_TELEFONO,DEP_HORARIO,DEP_OFICINA) VALUES
(1001,"Ingenieria eléctrica",10,5551229, "L-J 8-12m",1001),
(1002,"Ingenieria electrónica",10,5551228, "L-J 8-12m",1002),
(1003,"Ingenieria de sistemas e industrial",10,5551227, "L-J 8-12m",1003),
(1004,"Ingenieria agronómica y agrícola",10,5551226, "L-J 8-12m",1004),
(1005,"Ingenieria química",10,5551224, "L-J 8-12m",1006),
(1101,"Matemáticas",11,5551234, "L-V 8-12m",2271),
(1102,"Estadística",11,5551235, "L-V 8-5pm",2196),
(1103,"Física",11,5551236, "L-Mie 8-5 pm",2098),
(1104,"Química",11,5551237, "M-J 8-12m",2999),
(1105,"Biología",11,5551238, "L-D 8-8 pm",2406),
(1201,"Cine y televisión",12,5551240, "L-V 8-4pm",3001),
(1202,"Arquitectura",12,5551241, "L-V 8-2pm",3002),
(1203,"Artes plasticas",12,5551242, "L-J 8-2pm",3003),
(1204,"Música",12,5551243, "L-Mie 12-4pm",3004),
(1301,"Derecho",13, 5551244, "Mie-V 8-12m", 4001),
(1302,"Ciencias políticas",13, 5551245, "L-V 8-5pm", 4002),
(1401,"Economía",14,5551246, "L-J 1-8 pm", 5001),
(1402,"Administración de empresas",14,5551247, "L-V 2-4 pm", 5002),
(1501,"Matemáticas",15,5551247, "L-V 8-12m",6001),
(1502,"Biología",15,5551248, "L-V 8-5pm",6002),
(1503,"Física",15,5551249, "L-Mie 8-5 pm",6003),
(1504,"Química",15,5551250, "M-J 8-12m",6004),
(1601,"Ingenieria electrónica",16,5551251, "L-J 8-12m",7002),
(1602,"Ingenieria de sistemas",16,5551252, "L-J 8-12m",7003),
(1603,"Ingenieria física",16,5551253, "L-V 8-5 pm",7004),
(1604,"Ingenieria de minas",16,5551254, "L-J 8-12m",7005),
(1701,"Sociología",17,5551255, "L-V 8-5 pm",8001),
(1702,"Filología",17,5551256, "L-J 8-12 m",8002),
(1703,"Psicología",17,5551257, "L-V 1 pm-5 pm",8003),
(1801,"Medicina",18,5551258,"L-S 7 am-5pm", 9001),
(1802,"Fisioterapia",18,5551259,"L-V 7 am-3pm", 9002),
(1803,"Odontología",18,5551260,"Mar-S 8 am-5pm", 9003),
(1901,"Arquitectura",19,5551261,"L-Mie 8 am -5 pm", 1101),
(2001,"Estadística",20,5551262,"L-V 8 am- 5pm",1201),
(2002,"Biología",20,5551263,"L-V 9 am- 1pm",1202),
(2101,"Antropologia",21, 5551264, "Mie-V 10 am -5 pm", 1301),
(2102,"Filosofía",21, 5551265, "Mar-J 10 am -5 pm", 1302)
;

#Añadimos la información de los programas
#describe programa;
INSERT INTO PROGRAMA (PRO_ID,PRO_NOMBRE, PRO_DEPARTAMENTO, PRO_DIRECTOR) VALUES
(10011,"Ingenieria eléctrica",1001,"Zinedine Zidane"),
(10021,"Ingenieria electrónica",1002,"Didier Deschamps"),
(10031,"Ingenieria de sistemas",1003,"Freddy Mercury"),
(10032,"Ingenieria industrial",1003,"Bob Dylan"),
(10041,"Ingenieria agronómica",1004,"Chico Cesar"),
(10042,"Ingenieria agrícola",1004,"Andres Parra"),
(10051,"Ingenieria química",1005,"Larisa Manoela"),
(11011,"Ciencias de la computación",1101, "John Rodriguez"),
(11012,"Matemáticas",1101,"Francisco Gomez"),
(11021,"Estadística",1102,"Ronald Reagan"),
(11031,"Física",1103, "Michel Faraday"),
(11041,"Química",1104,"Fernando Quintero"),
(11042,"Química farmaceútica",1104,"Fernando Botero"),
(11051,"Biología",1105,"Egan Bernal"),
(12011,"Cine y televisión",1201,"Quentin Tarantino"),
(12021,"Arquitectura",1202,"Rogelio Salmona"),
(12022,"Diseño Industrial",1202,"Hugo Lombardi"),
(12031,"Artes plasticas",1203,"Woody allen"),
(12041,"Música",1204,"Toto la Momposina"),
(13011,"Derecho",1301, "Jorge Gaitan"),
(13021,"Ciencias políticas",1302,"Gabriel Ramirez"),
(14011,"Economía",1401,"Beatriz Pinzon Solano"),
(14021,"Administración de empresas",1402,"Hermes Pinzon"),
(15011,"Matemáticas",1501,"Pierre Cauchy"),
(15021,"Biología",1502,"John Humboldt"),
(15031,"Física",1503,"Paul Dirac"),
(15041,"Química",1504,"Paul Lebesgue"),
(16011,"Ingenieria electrónica",1601,"Juan Bernoulli"),
(16021,"Ingenieria de sistemas",1602,"Leonhard Euler"),
(16031,"Ingenieria física",1603,"Isaac Newton"),
(16041,"Ingenieria de minas",1604,"Pablo Riemann"),
(17011,"Sociología",1701,"Paul Erdos"),
(17012,"Antropología",1701,"Henri Poincare"),
(17021,"Filología",1702,"David Hilbert"),
(17031,"Psicología",1703, "Sigmund Freud"),
(18011,"Medicina",1801,"Alexander Flemming"),
(18021,"Fisioterapia",1802,"David Parkinson"),
(18022,"Terapia ocupacional",1802,"John Von Neumann"),
(18031,"Odontología",1803,"Kurt Godel"),
(19011,"Arquitectura",1901,"Leopoldo Kronecker"),
(20011,"Estadística",2001,"Ronald Fisher"),
(20012,"Ciencias de la computación",2001, "Karl Pearson"),
(20021,"Biología",2002,"Claude Shannon"),
(21011,"Antropologia",2101,"Andre Weil"),
(21012,"Trabajo Social",2101,"Alexander Grothendieck"),
(21021,"Filosofía",2102,"Jean Fourier")
;

##### INSERTAMOS DATOS EN LAS TABLAS RELACIONADAS A SERVICIOS ------------------------

INSERT INTO SERVICIOS (SERV_CODIGO,SERV_NOMBRE, SERV_AREA, SERV_HORARIO,SERV_LUGAR) VALUES 
(2024051,"Carnetizacion foto antigua","Registro y matrícula"," 2 -4 pm","Edificio polideportivo"),
(2024052,"Carnetizacion foto nueva","Registro y matrícula"," 2 -4 pm","Edificio polideportivo"),
(2024053, "Orientación ocupacional","Bienestar","8-12 m", "Hospital universitario"),
(2024054, "Certificado de notas egresado", "Secretaria","8 am - 5 pm", "Oficina de facultad" ),
(2024055, "Certificado de notas", "Secretaria","8 am - 5 pm", "Oficina de facultad" ),
(2024056, "Certificado de matricula", "Secretaria","8 am - 5 pm", "Oficina de facultad" ),
(2024057, "Bibliotecas", "Departamento de bibliotecas", "7 am - 7pm", "Biblioteca central");

INSERT into SEDE_BRINDA_SERVICIOS (BRI_SERVICIO, BRI_SEDE) VALUES 
(2024051,"Bogotá"),
(2024052,"Bogotá"),
(2024053,"Bogotá"),
(2024054,"Bogotá"),
(2024055,"Bogotá"),
(2024056,"Bogotá"),
(2024057,"Bogotá"),
(2024051,"Medellín"),
(2024052,"Medellín"),
(2024053,"Medellín"),
(2024054,"Medellín"),
(2024055,"Medellín"),
(2024056,"Medellín"),
(2024057,"Medellín"),
(2024051,"Manizales"),
(2024052,"Manizales"),
(2024054,"Manizales"),
(2024055,"Manizales"),
(2024056,"Manizales"),
(2024057,"Manizales"),
(2024051,"La Paz"),
(2024052,"La Paz"),
(2024054,"La Paz"),
(2024055,"La Paz"),
(2024056,"La Paz")
;



#Para la tabla personas
-- Insertar datos
INSERT INTO PERSONA (PER_TIPO_DOCUMENTO, PER_NUM_DOCUMENTO, PER_NOMBRE,PER_APELLIDO, PER_FECHA_NACIMIENTO) VALUES
('Cedula de ciudadania', 6451328, 'Juan', 'Perez', '1990-01-01'),
('Cedula de ciudadania', 6833215, 'Carlos','Sanchez', '1985-02-15'),
('Cedula de ciudadania', 7468231, 'María', 'Gomez', '1988-03-10'),
('Cedula de ciudadania', 9786213, 'Jose', 'Martinez', '1992-04-20'),
('Cedula de ciudadania', 15083215, 'Ana' ,'Rodriguez', '1995-05-25'),
('Cedula de ciudadania', 4686621, 'Julieta','Alvarado', '2000-06-01'),
('Cedula de ciudadania', 8037070, 'Juan', 'Diaz', '2001-11-13'),
('Cedula de ciudadania', 10062621, 'Amelia', 'Gomez', '2005-02-08'),
('Cedula de ciudadania', 94876234, 'Elena', 'Fernandez', '1995-08-15'),
('Cedula de ciudadania', 85673456, 'Andrés', 'Castro', '1996-07-20'),
('Cedula de ciudadania', 72364578, 'Carolina', 'Lopez', '1997-06-10'),
('Cedula de ciudadania', 94537284, 'Gabriel', 'Ramirez', '1998-05-05'),
('Cedula de ciudadania', 83645217, 'Lucía', 'Martinez', '1999-04-25'),
('Cedula de ciudadania', 91567382, 'Alejandro', 'Gonzalez', '2000-03-01'),
('Cedula de ciudadania', 78456234, 'María', 'Torres', '2001-02-14'),
('Cedula de ciudadania', 82573468, 'Juan', 'Rodríguez', '2002-01-30'),
('Cedula de ciudadania', 95382746, 'Valentina', 'Hernandez', '2003-12-20'),
('Cedula de ciudadania', 67823459, 'Pedro', 'Diaz', '2004-11-10'),
('Cedula de ciudadania', 78923485, 'Camila', 'Perez', '1995-10-05'),
('Cedula de ciudadania', 83476295, 'José', 'Gomez', '1996-09-15'),
('Cedula de ciudadania', 90234578, 'Laura', 'Suarez', '1997-08-25'),
('Cedula de ciudadania', 74385692, 'Diego', 'Sanchez', '1998-07-30'),
('Cedula de ciudadania', 82634578, 'Sofía', 'Ramirez', '1999-06-18'),
('Cedula de ciudadania', 91548723, 'Mateo', 'Torres', '2000-05-12'),
('Cedula de ciudadania', 78346578, 'Ana Maria', 'Gonzalez', '2001-04-03'),
('Cedula de ciudadania', 83926574, 'Carlos', 'Gutierrez', '2002-03-19'),
('Cedula de ciudadania', 90573284, 'Isabella', 'Munoz', '2003-02-08'),
('Cedula de ciudadania', 78453628, 'Martín', 'Vargas', '2004-01-26'),
('Cedula de ciudadania', 85472384, 'Miguel', 'Dominguez', '1995-11-14'),
('Cedula de ciudadania', 76248593, 'Juliana', 'Pineda', '1996-12-23'),
('Cedula de ciudadania', 89374562, 'Santiago', 'Mejia', '1997-03-16'),
('Cedula de ciudadania', 82936475, 'Manuela', 'Gomez', '1998-02-25'),
('Cedula de ciudadania', 94582734, 'Sebastian', 'Garcia', '1999-05-14'),
('Cedula de ciudadania', 76823495, 'Laura', 'Morales', '2000-06-05'),
('Cedula de ciudadania', 85367248, 'Luis', 'Rojas', '2001-07-28'),
('Cedula de ciudadania', 94738265, 'Valeria', 'Castillo', '2002-04-11'),
('Cedula de ciudadania', 92345678, 'Ricardo', 'López', '1995-03-15'),
('Cedula de ciudadania', 87234567, 'Daniela', 'Ortega', '1996-01-20'),
('Cedula de ciudadania', 80345678, 'Fernando', 'Moreno', '1997-04-10'),
('Cedula de ciudadania', 75323456, 'Sofia', 'Gonzalez', '1998-02-19'),
('Cedula de ciudadania', 81234567, 'Raul', 'Hernandez', '1999-07-25'),
('Cedula de ciudadania', 86234567, 'Paula', 'Ramirez', '2000-12-13'),
('Cedula de ciudadania', 73456789, 'David', 'Fernandez', '2001-11-18'),
('Cedula de ciudadania', 72456789, 'Nicolas', 'Martinez', '2002-08-29'),
('Cedula de ciudadania', 89345678, 'Claudia', 'Rodriguez', '2003-09-05'),
('Cedula de ciudadania', 81234568, 'Pablo', 'Sanchez', '2004-06-12'),
('Cedula de ciudadania', 72345689, 'Angela', 'Garcia', '1995-12-21'),
('Cedula de ciudadania', 91234567, 'Juan Carlos', 'Perez', '1996-05-22'),
('Cedula de ciudadania', 84345678, 'Andrea', 'Lopez', '1997-08-14'),
('Cedula de ciudadania', 76345678, 'Marta', 'Diaz', '1998-04-18'),
('Cedula de ciudadania', 93456789, 'Francisco', 'Vega', '1999-10-07'),
('Cedula de ciudadania', 97234567, 'Adriana', 'Gutierrez', '2000-03-30'),
('Cedula de ciudadania', 90234567, 'Javier', 'Gomez', '2001-07-19'),
('Cedula de ciudadania', 75234567, 'Camilo', 'Ruiz', '2002-01-25'),
('Cedula de ciudadania', 81235678, 'Liliana', 'Mendoza', '2003-06-16'),
('Cedula de ciudadania', 86234568, 'Marcelo', 'Torres', '2004-11-11'),
('Cedula de ciudadania', 89346578, 'Patricia', 'Castro', '1995-02-27'),
('Cedula de ciudadania', 83456789, 'Cristina', 'Ramirez', '1996-03-08'),
('Cedula de ciudadania', 75345678, 'Luis Miguel', 'Garcia', '1997-05-15'),
('Cedula de ciudadania', 71234567, 'Rosa', 'Fernandez', '1998-07-22'),
('Cedula de ciudadania', 92346789, 'Pedro', 'Martinez', '1999-11-13'),
('Cedula de ciudadania', 83456780, 'Ana', 'Vargas', '2000-04-17'),
('Cedula de ciudadania', 86234569, 'Esteban', 'Perez', '2001-02-04'),
('Cedula de ciudadania', 90235678, 'Sandra', 'Ortega', '2002-12-24'),
('Cedula de ciudadania', 72345678, 'Monica', 'Sanchez', '2003-09-09'),
('Cedula de ciudadania', 84345679, 'Eduardo', 'Gonzalez', '2004-01-03'),
('Cedula de ciudadania', 91234568, 'Nora', 'Diaz', '1995-06-14'),
('Cedula de ciudadania', 73234567, 'Rafael', 'Lopez', '1996-08-28'),
('Cedula de ciudadania', 85234567, 'Teresa', 'Hernandez', '1997-10-06'),
('Cedula de ciudadania', 78456789, 'Julio', 'Vega', '1998-03-20'),
('Cedula de ciudadania', 81234569, 'Mario', 'Gutierrez', '1999-05-08'),
('Cedula de ciudadania', 87234568, 'Irma', 'Gomez', '2000-06-01'),
('Cedula de ciudadania', 89345789, 'Carlos', 'Ruiz', '2001-07-11'),
('Cedula de ciudadania', 75346789, 'Mariana', 'Mendoza', '2002-08-13'),
('Cedula de ciudadania', 72456780, 'Federico', 'Torres', '2003-11-19'),
('Cedula de ciudadania', 93456780, 'Ines', 'Castro', '2004-12-25'),
('Cedula de ciudadania', 79456789, 'Hector', 'Ramirez', '1995-01-18'),
('Cedula de ciudadania', 87234569, 'Alicia', 'Garcia', '1996-03-24'),
('Cedula de ciudadania', 79345678, 'Gustavo', 'Fernandez', '1997-04-12'),
('Cedula de ciudadania', 83456790, 'Victoria', 'Martinez', '1998-07-27'),
('Cedula de ciudadania', 75235678, 'Roberto', 'Vargas', '1999-09-09'),
('Cedula de ciudadania', 86234570, 'Elsa', 'Perez', '2000-02-11'),
('Cedula de ciudadania', 82345678, 'Ramiro', 'Ortega', '2001-11-02'),
('Cedula de ciudadania', 74345678, 'Leticia', 'Sanchez', '2002-04-28'),
('Cedula de ciudadania', 92345679, 'Felipe', 'Gonzalez', '2003-07-05'),
('Cedula de ciudadania', 81235679, 'Beatriz', 'Diaz', '2004-08-15'),
('Cedula de ciudadania', 83456791, 'Oscar', 'Lopez', '1995-05-19'),
('Cedula de ciudadania', 90345678, 'Silvia', 'Hernandez', '1996-12-03'),
('Cedula de ciudadania', 73235678, 'Juan', 'Vega', '1997-11-21'),
('Cedula de ciudadania', 82456789, 'Laura', 'Gutierrez', '1998-03-11'),
('Cedula de ciudadania', 84356789, 'Alejandra', 'Gomez', '1999-06-14'),
('Cedula de ciudadania', 76234568, 'Francisco', 'Ruiz', '2000-09-23'),
('Cedula de ciudadania', 81235680, 'Pilar', 'Mendoza', '2001-05-26'),
('Cedula de ciudadania', 89234567, 'Luz', 'Torres', '2002-03-07'),
('Cedula de ciudadania', 79345679, 'Emilio', 'Castro', '2003-02-16'),
('Cedula de ciudadania', 75346780, 'Natalia', 'Ramirez', '2004-07-10'),
('Cedula de ciudadania', 610056841, 'Luisa','Fernandez', '1993-06-30'),
('Cedula de ciudadania', 100239098, 'Pedro','González', '1991-07-15'),
('Tarjeta de identidad', 987654321, 'Mateo', 'Garcia', '2006-01-15'),
('Tarjeta de identidad', 876543210, 'Valeria', 'Martinez', '2007-02-20'),
('Tarjeta de identidad', 765432109, 'Santiago', 'Lopez', '2008-03-10'),
('Tarjeta de identidad', 654321098, 'Isabella', 'Rodriguez', '2006-04-05'),
('Tarjeta de identidad', 543210987, 'Juan Felipe', 'Hernandez', '2007-05-25'),
('Tarjeta de identidad', 432109876, 'Valentina', 'Gomez', '2008-06-30'),
('Tarjeta de identidad', 321098765, 'Daniel', 'Perez', '2006-07-14'),
('Tarjeta de identidad', 210987654, 'Mariana', 'Sanchez', '2007-08-19'),
('Tarjeta de identidad', 109876543, 'Gabriel', 'Ramirez', '2008-09-28'),
('Tarjeta de identidad', 987654322, 'Ana', 'Diaz', '2006-10-03'),
('Tarjeta de identidad', 876543211, 'Diego', 'Martinez', '2007-11-12'),
('Tarjeta de identidad', 765432110, 'Lucia', 'Gutierrez', '2008-12-17'),
('Tarjeta de identidad', 654321099, 'Alejandro', 'Torres', '2006-11-09'),
('Tarjeta de identidad', 543210988, 'Maria', 'Castro', '2007-12-28'),
('Tarjeta de identidad', 432109877, 'Samuel', 'Vargas', '2008-02-05'),
('Tarjeta de identidad', 321098766, 'Sofia', 'Fernandez', '2006-03-21'),
('Tarjeta de identidad', 210987655, 'David', 'Lopez', '2007-04-30'),
('Tarjeta de identidad', 109876544, 'Laura', 'Garcia', '2008-05-10'),
('Tarjeta de identidad', 987654323, 'Carlos', 'Hernandez', '2006-06-14'),
('Tarjeta de identidad', 876543212, 'Valeria', 'Perez', '2007-07-23'),
('Tarjeta de identidad', 765432111, 'Juan', 'Gomez', '2008-08-04'),
('Tarjeta de identidad', 654321100, 'Camila', 'Rodriguez', '2006-09-11'),
('Tarjeta de identidad', 543210989, 'Daniel', 'Sanchez', '2007-10-22'),
('Tarjeta de identidad', 432109878, 'Mariana', 'Ramirez', '2008-11-01'),
('Tarjeta de identidad', 321098767, 'Mateo', 'Diaz', '2006-12-12'),
('Tarjeta de identidad', 210987656, 'Isabella', 'Martinez', '2007-01-27'),
('Tarjeta de identidad', 109876545, 'Juan', 'Lopez', '2008-02-14'),
('Tarjeta de identidad', 987654324, 'Valentina', 'Gomez', '2006-03-25'),
('Tarjeta de identidad', 876543213, 'Diego', 'Perez', '2007-04-04'),
('Tarjeta de identidad', 765432112, 'Lucia', 'Gutierrez', '2008-05-18'),
('Tarjeta de identidad', 654321101, 'Alejandro', 'Torres', '2006-06-29'),
('Tarjeta de identidad', 543210990, 'Maria', 'Castro', '2007-07-10'),
('Tarjeta de identidad', 432109879, 'Samuel', 'Vargas', '2008-08-23'),
('Tarjeta de identidad', 321098768, 'Sofia', 'Fernandez', '2006-09-04'),
('Tarjeta de identidad', 210987657, 'David', 'Lopez', '2007-10-19'),
('Tarjeta de identidad', 109876546, 'Laura', 'Garcia', '2008-11-30'),
('Tarjeta de identidad', 987654325, 'Carlos', 'Hernandez', '2006-12-11'),
('Tarjeta de identidad', 876543214, 'Valeria', 'Perez', '2007-01-26'),
('Tarjeta de identidad', 765432113, 'Juan Pablo', 'Gutierrez', '2008-02-10'),
('Tarjeta de identidad', 654321102, 'Camila Andrea', 'Rodriguez', '2006-03-20'),
('Tarjeta de identidad', 543210991, 'Daniel Steven ', 'Sanchez', '2007-04-01'),
('Tarjeta de identidad', 432109880, 'Mariana', 'Ramirez', '2008-05-14'),
('Tarjeta de identidad', 321098769, 'Mateo', 'Diaz', '2006-06-25'),
('Tarjeta de identidad', 210987658, 'Isabella', 'Martinez', '2007-07-06'),
('Tarjeta de identidad', 109876547, 'Juan Diego', 'Lopez', '2008-08-19'),
('Tarjeta de identidad', 987654326, 'Valentina', 'Gomez', '2006-09-30'),
('Tarjeta de identidad', 876543215, 'Diego', 'Ramirezz', '2007-10-11'),
('Tarjeta de identidad', 765432114, 'Lucia', 'Gutierrez', '2008-11-24'),
('Tarjeta de identidad', 654321103, 'Alejandro', 'Torres', '2006-12-03'),
('Tarjeta de identidad', 543210992, 'Maria Angelica', 'Castro', '2007-01-18'),
('Tarjeta de identidad', 432109881, 'Samuel', 'Vargas', '2008-02-27'),
('Tarjeta de identidad', 321098770, 'Ana Sofia', 'Fernandez', '2006-03-14'),
('Tarjeta de identidad', 210987659, 'David', 'Lopez', '2007-04-25'),
('Tarjeta de identidad', 109876548, 'Laura Camila', 'Garcia', '2008-05-07'),
('Tarjeta de identidad', 987654327, 'Carlos', 'Hernandez', '2006-06-12'),
('Tarjeta de identidad', 876543216, 'Valeria', 'Perez', '2007-07-27'),
('Tarjeta de identidad', 765432115, 'Juan David', 'Gomez', '2008-08-10'),
('Tarjeta de identidad', 654321104, 'Camila', 'Rodriguez', '2006-09-20'),
('Tarjeta de identidad', 543210993, 'Daniel', 'Sanchez', '2007-10-05'),
('Tarjeta de identidad', 432109882, 'Mariana', 'Ramirez', '2008-11-14'),
('Tarjeta de identidad', 321098771, 'Mateo Enrique', 'Diaz', '2006-12-29'),
('Tarjeta de identidad', 210987660, 'Isabella', 'Martinez', '2007-01-04'),
('Tarjeta de identidad', 109876549, 'Juan Pablo', 'Lopez', '2008-02-15'),
('Tarjeta de identidad', 987654328, 'Valentina', 'Gomez', '2006-03-30'),
('Tarjeta de identidad', 876543217, 'Diego', 'Perez', '2007-04-14'),
('Tarjeta de identidad', 765432116, 'Ana Lucia', 'Gutierrez', '2008-05-25'),
('Tarjeta de identidad', 654321105, 'Alejandro', 'Torres', '2006-06-06'),
('Tarjeta de identidad', 543210994, 'Maria', 'Castro', '2007-07-21'),
('Tarjeta de identidad', 432109883, 'Samuel', 'Vargas', '2008-08-02'),
('Tarjeta de identidad', 321098772, 'Sofia', 'Fernandez', '2006-09-09'),
('Tarjeta de identidad', 210987661, 'David', 'Lopez', '2007-10-24'),
('Tarjeta de identidad', 109876550, 'Laura', 'Garcia', '2008-11-05'),
('Tarjeta de identidad', 987654329, 'Carlos', 'Hernandez', '2006-12-16'),
('Tarjeta de identidad', 876543218, 'Valeria', 'Perez', '2007-01-31'),
('Tarjeta de identidad', 765432117, 'Juan Felipe', 'Gomez', '2008-03-13'),
('Tarjeta de identidad', 654321106, 'Camila', 'Rodriguez', '2006-04-24'),
('Tarjeta de identidad', 543210995, 'Daniel', 'Sanchez', '2007-05-09'),
('Tarjeta de identidad', 432109884, 'Mariana', 'Ramirez', '2008-06-18'),
('Tarjeta de identidad', 321098773, 'Mateo', 'Diaz', '2006-07-29'),
('Tarjeta de identidad', 210987662, 'Isabella', 'Martinez', '2007-08-11'),
('Tarjeta de identidad', 109876551, 'Felipe', 'Lopez', '2008-09-22'),
('Tarjeta de identidad', 987654330, 'Valentina', 'Gomez', '2006-10-03'),
('Tarjeta de identidad', 876543219, 'Diego', 'Perez', '2007-11-18'),
('Tarjeta de identidad', 765432118, 'Lucia', 'Gutierrez', '2008-12-30'),
('Tarjeta de identidad', 654321107, 'Alejandro', 'Torres', '2006-11-04'),
('Tarjeta de identidad', 543210996, 'Maria', 'Castro', '2007-12-15'),
('Tarjeta de identidad', 432109885, 'Samuel', 'Vargas', '2008-01-25'),
('Tarjeta de identidad', 321098774, 'Sofia', 'Fernandez', '2006-02-05'),
('Tarjeta de identidad', 210987663, 'David', 'Lopez', '2007-03-18'),
('Tarjeta de identidad', 109876552, 'Laura', 'Garcia', '2008-04-29'),
('Tarjeta de identidad', 987654331, 'Carlos', 'Hernandez', '2006-05-10'),
('Tarjeta de identidad', 876543220, 'Valeria', 'Perez', '2007-06-21'),
('Tarjeta de identidad', 765432119, 'Andres', 'Gomez', '2008-07-04'),
('Tarjeta de identidad', 654321108, 'Camilo', 'Rodriguez', '2006-08-15'),
('Tarjeta de identidad', 543210997, 'Daniel', 'Sanchez', '2007-09-26'),
('Tarjeta de identidad', 432109886, 'Mariana', 'Ramirez', '2008-10-07'),
('Tarjeta de identidad', 321098775, 'Mateo', 'Diaz', '2006-11-18'),
('Tarjeta de identidad', 210987664, 'Isabella', 'Martinez', '2007-12-29'),
('Tarjeta de identidad', 109876553, 'Andres', 'Lopez', '2008-01-09'),
('Tarjeta de identidad', 987654332, 'Valentina', 'Gomez', '2006-02-20'),
('Tarjeta de identidad', 876543221, 'Diego', 'Perez','2007-10-11'),
('Cedula de extranjeria', 1234567890, 'Leonardo', 'DiCaprio', '1974-11-11'),
('Cedula de extranjeria', 15678901, 'Jennifer', 'Aniston', '1969-02-11'),
('Cedula de extranjeria', 356789012, 'Brad', 'Pitt', '1963-12-18'),
('Cedula de extranjeria', 456890123, 'Angelina', 'Jolie', '1975-06-04'),
('Cedula de extranjeria', 567901234, 'Tom', 'Cruise', '1962-07-03'),
('Cedula de extranjeria', 678012345, 'Emma', 'Watson', '1990-04-15'),
('Cedula de extranjeria', 790123456, 'Dwayne', 'Johnson', '1972-05-02'),
('Cedula de extranjeria', 890234567, 'Scarlett', 'Johansson', '1984-11-22'),
('Cedula de extranjeria', 902345678, 'Johnny', 'Depp', '1963-06-09'),
('Cedula de extranjeria', 112334455, 'Megan', 'Fox', '1986-05-16'),
('Cedula de extranjeria', 22345566, 'Robert', 'Downey Jr.', '1965-04-04'),
('Cedula de extranjeria', 334455667, 'Natalie', 'Portman', '1981-06-09'),
('Cedula de extranjeria', 445566788, 'Chris', 'Evans', '1981-06-13'),
('Cedula de extranjeria', 556678899, 'Anne', 'Hathaway', '1982-11-12'),
('Cedula de extranjeria', 667889900, 'Chris', 'Hemsworth', '1983-08-11'),
('Cedula de extranjeria', 778990011, 'Gal', 'Gadot', '1985-04-30'),
('Cedula de extranjeria', 889900122, 'Ryan', 'Reynolds', '1976-10-23'),
('Cedula de extranjeria', 990112233, 'Margot', 'Robbie', '1990-07-02'),
('Cedula de extranjeria', 334556677, 'Tom', 'Holland', '1996-06-01'),
('Cedula de extranjeria', 223445566, 'Zendaya', 'Coleman', '1996-09-01');
#Estos son los administrativos
INSERT INTO PERSONA (PER_TIPO_DOCUMENTO, PER_NUM_DOCUMENTO, PER_NOMBRE,PER_APELLIDO, PER_FECHA_NACIMIENTO) VALUES
('Cedula de ciudadania', 1234567899, 'Lionel','Messi', '1990-01-15'),
('Cedula de ciudadania', 987643211, 'Cristiano Ronaldo', 'Dos Santos', '1985-05-23'),
('Cedula de ciudadania', 456791233, 'Neymar Jr', 'da Silva Santos', '1978-03-17'),
('Cedula de ciudadania', 789124566, 'Kyliam', 'Mbappé', '1992-11-08'),
('Cedula de ciudadania', 326549877, 'Radamel', 'Falcao', '1988-07-12'),
('Cedula de ciudadania', 654983211, 'Carlos', 'Bacca', '1995-09-25'),
('Cedula de ciudadania', 987216544, 'Robert', 'de Niro', '1983-02-14'),
('Cedula de ciudadania', 157534866, 'Pep', 'Guardiola', '1991-04-20'),
('Cedula de ciudadania', 257413699, 'Albert Einstein', 'Ramírez', '1987-06-30'),
('Cedula de ciudadania', 369851477, 'Stephen', 'Hawking', '1994-12-01'),
('Cedula de ciudadania', 741259633, 'Rene', 'Higuita', '1989-08-16'),
('Cedula de ciudadania', 859637411, 'Rene', 'Descartes', '1993-10-10'),
('Cedula de ciudadania', 967418522, 'Hipocrates', 'Griego', '1984-05-19'),
('Cedula de ciudadania', 147253699, 'Miguel Angel', 'Italiano', '1990-07-05'),
('Cedula de ciudadania', 258391477, 'Karl', 'Gauss', '1986-03-29'),
('Cedula de ciudadania', 391472588, 'Karl', 'Marx', '1992-09-21'),
('Cedula de ciudadania', 741398522, 'Zinedine', 'Zidane', '1985-12-13'),
('Cedula de ciudadania', 852741633, 'Didier', 'Deschamps', '1991-02-28'),
('Cedula de ciudadania', 963827411, 'Freddy', 'Mercury', '1983-01-18'),
('Cedula de ciudadania', 147392588, 'Bob', 'Dylan', '1987-11-09'),
('Cedula de ciudadania', 287419633, 'Chico', 'Cesar', '1994-06-07'),
('Cedula de ciudadania', 369281477, 'Larissa', 'Manoela', '1993-04-14'),
('Cedula de ciudadania', 741829633, 'John', 'Rodriguez', '1990-08-20'),
('Cedula de ciudadania', 829631477, 'Ronald', 'Reagan', '1989-10-22'),
('Cedula de ciudadania', 963147822, 'Michel', 'Faraday', '1991-12-02'),
('Cedula de ciudadania', 148523699, 'Marina', 'Suárez', '1988-02-25'),
('Cedula de ciudadania', 258637411, 'Fernando', 'Quintero', '1986-06-18'),
('Cedula de ciudadania', 369412588, 'Egan', 'Bernal', '1995-09-09'),
('Cedula de ciudadania', 741638522, 'Quentin', 'Tarantino', '1983-11-04'),
('Cedula de ciudadania', 852179633, 'Hugo', 'Lombardi', '1984-03-22'),
('Cedula de ciudadania', 963257411, 'Rogelio', 'Salmona', '1987-05-11'),
('Cedula de ciudadania', 149632588, 'Woody', 'Allen', '1992-07-07'),
('Cedula de ciudadania', 258143699, 'Beatriz', 'Pinzon Solano', '1989-10-01'),
('Cedula de ciudadania', 369589633, 'Toto', 'la Momposina', '1990-03-08'),
('Cedula de ciudadania', 741631477, 'Jorge', 'Gaitan', '1985-06-26'),
('Cedula de ciudadania', 852712588, 'Pierre', 'Cauchy', '1993-12-30'),
('Cedula de ciudadania', 963521477, 'John', 'Von Neumann', '1988-01-20'),
('Cedula de ciudadania', 147257411, 'Kurt', 'Godel', '1994-04-11'),
('Cedula de ciudadania', 258938522, 'David', 'Hilbert', '1986-09-03'),
('Cedula de ciudadania', 369179633, 'Leonhard', 'Euler', '1987-12-16'),
('Cedula de ciudadania', 741823699, 'Paul ', 'Lebesgue', '1989-11-15'),
('Cedula de ciudadania', 852361477, 'Claude', 'Shannon', '1992-02-06'),
("Cedula de ciudadania",060420141, "Pirlo", "Montaño","2014-04-06"),
("Cedula de ciudadania",190820141,"Perla","Diaz","2014-08-19")
;

select * from programa;
#Ahora. vamos a insertar los datos de la tabla egresados
#SELECT* FROM programa;
#SELECT * FROM PERSONA;
INSERT INTO egresado (EGR_TIPO_DOCUMENTO, EGR_NUM_DOCUMENTO, EGR_PAPA,EGR_PA, EGR_SEMESTRE_INGRESO,EGR_SEMESTRE_EGRESO) VALUES
('Cedula de ciudadania', 6451328, 4.3, 4.3, "2014-1","2019-2"),
('Cedula de ciudadania', 6833215, 4.1,4.1, "2015-1","2019-2"),
('Cedula de ciudadania', 7468231, 3.7, 3.7, "2010-2","2016-1"),
('Cedula de ciudadania', 9786213, 4.6, 4.6, "2015-1","2021-1"),
('Cedula de ciudadania', 15083215, 3.5 ,3.7, "2013-2","2018-2"),
('Cedula de ciudadania', 4686621, 4.0,4.2, "2017-2","2022-2"),
('Cedula de ciudadania', 8037070, 4.1, 4.1, "2018-2","2024-1"),
('Cedula de ciudadania', 10062621, 5.0, 5.0, "2019-1","2023-2"),
('Cedula de ciudadania', 94876234, 3.9, 4.1, "2019-1","2022-2"),
('Cedula de ciudadania', 85673456, 4.2, 4.2, "2018-1","2023-2"),
('Cedula de ciudadania', 72364578, 3.1, 3.1, "2018-2","2022-2"),
('Cedula de ciudadania', 94537284, 4.8, 4.8, "2017-2","2021-1"),
('Cedula de ciudadania', 83645217, 3.7, 3.7, "2017-1","2021-2"),
('Cedula de ciudadania', 91567382, 3.6, 3.6, "2015-2","2020-1"),
('Cedula de ciudadania', 78456234, 4.3, 4.3, "2015-1","2019-2"),
('Cedula de ciudadania', 82573468, 3.6, 3.6, "2014-2","2020-2"),
('Cedula de ciudadania', 95382746, 4.5, 4.5, "2015-2","2021-1"),
('Cedula de ciudadania', 67823459, 4.0, 4.1, "2014-2","2020-1"),
('Cedula de ciudadania', 78923485, 4.2, 4.2, "2016-2","2022-1"),
('Cedula de ciudadania', 83476295, 3.3, 3.5, "2015-1","2019-2"),
('Cedula de ciudadania', 90234578, 3.4, 3.4, "2014-2","2018-2"),
('Cedula de ciudadania', 74385692, 4.7, 4.7, "2015-2","2020-1"),
('Cedula de ciudadania', 82634578, 3.9, 4.0, "2013-2","2018-1"),
('Cedula de ciudadania', 91548723, 3.0, 3.2, "2016-1","2020-2"),
('Cedula de ciudadania', 78346578, 4.3, 4.3, "2016-2","2021-1"),
('Cedula de ciudadania', 83926574, 3.4, 3.5, "2017-2","2021-1"),
('Cedula de ciudadania', 90573284, 4.3, 4.3, "2017-1","2023-1"),
('Cedula de ciudadania', 78453628, 4.8, 4.8, "2016-2","2023-2"),
('Cedula de ciudadania', 85472384, 4.9, 4.9, "2015-2","2022-1"),
('Cedula de ciudadania', 76248593,4.2, 4.2, "2018-1","2022-2"),
('Cedula de ciudadania', 89374562, 3.1, 3.3, "2015-2","2020-1"),
('Cedula de ciudadania', 82936475, 3.7, 3.8, "2016-2","2023-1"),
('Cedula de ciudadania', 94582734, 4.0, 4.2, "2017-2","2022-2"),
('Cedula de ciudadania', 76823495, 3.0, 3.1, "2014-2","2020-2"),
('Cedula de ciudadania', 85367248, 4.2, 4.3, "2015-2","2023-2"),
('Cedula de ciudadania', 94738265, 4.0, 4.2, "2011-2","2017-1"),
('Cedula de ciudadania', 92345678, 3.0, 3.2, "2011-1","2017-1"),
('Cedula de ciudadania', 87234567, 4.7, 4.7, "2011-1","2016-1"),
('Cedula de ciudadania', 80345678, 4.1, 4.1, "2011-1","2015-2"),
('Cedula de ciudadania', 75323456, 5.0, 5.0, "2019-2","2023-2"),
('Cedula de ciudadania', 81234567, 3.8, 3.8, "2020-1","2024-1"),
('Cedula de ciudadania', 86234567, 4.5, 4.5, "2020-1","2024-1"),
('Cedula de ciudadania', 73456789, 4.3, 4.3, "2020-1","2024-1"),
('Cedula de ciudadania', 72456789, 4.9, 4.9, "2019-1","2022-2"),
('Cedula de ciudadania', 89345678, 3.0, 3.4, "2019-1","2024-1"),
('Cedula de ciudadania', 81234568, 3.1, 3.3, "2019-2","2024-1"),
('Cedula de ciudadania', 72345689, 4.5, 4.6, "2019-1","2023-1"),
('Cedula de ciudadania', 91234567, 3.8,3.8 , "2018-1","2023-1"),
('Cedula de ciudadania', 84345678, 5.0, 5.0, "2017-2","2023-2"),
('Cedula de ciudadania', 76345678, 3.8, 3.8, "2015-2","2020-1"),
('Cedula de ciudadania', 93456789, 3.6, 3.6, "2014-1","2019-2"),
('Cedula de ciudadania', 97234567, 4.1, 4.2, "2013-2","2018-2"),
('Cedula de ciudadania', 90234567, 3.2, 3.7, "2013-2","2017-1"),
('Cedula de ciudadania', 75234567, 4.2, 4.3, "2013-2","2017-2"),
('Cedula de ciudadania', 81235678, 4.6, 4.6, "2015-2","2021-1"),
('Cedula de ciudadania', 86234568, 3.5, 3.5, '2012-2',"2018-1"),
('Cedula de extranjeria', 1234567890, 3.9, 3.9,"2015-2", "2020-1"),
('Cedula de extranjeria', 15678901, 4.2, 4.2, "2017-2","2022-1"),
('Cedula de extranjeria', 356789012, 4.4, 4.4,"2018-1","2023-1" ),
('Cedula de extranjeria', 456890123, 3.3, 3.3, "2014-2","2019-1"),
('Cedula de extranjeria', 567901234, 3.2, 3.2,"2019-2","2024-1"),
('Cedula de extranjeria', 678012345, 4.8, 4.8, "2016-2","2020-2"),
('Cedula de extranjeria', 790123456, 3.7, 3.8,"2013-2","2018-1"),
('Cedula de extranjeria', 890234567, 4.2,4.3, "2015-1","2019-2");

select * from egresado_estudio_programa;

insert into egresado_estudio_programa(EEP_TIPO_IDENTIFICACION,EEP_IDENTIFICACION,EEP_PROGRAMA) value
('Cedula de ciudadania', 6451328,11011),
('Cedula de ciudadania', 6833215,11012),
('Cedula de ciudadania', 7468231,11012),
('Cedula de ciudadania', 9786213,11012),
('Cedula de ciudadania', 15083215,11012),
('Cedula de ciudadania', 4686621,11012),
('Cedula de ciudadania', 8037070,11012),
('Cedula de ciudadania', 10062621,11012),
('Cedula de ciudadania', 94876234,11021),
('Cedula de ciudadania', 85673456,11021),
('Cedula de ciudadania', 72364578,11021),
('Cedula de ciudadania', 94537284,11021),
('Cedula de ciudadania', 83645217,11021),
('Cedula de ciudadania', 91567382,11021),
('Cedula de ciudadania', 78456234,11021),
('Cedula de ciudadania', 82573468,11021),
('Cedula de ciudadania', 95382746,11021),
('Cedula de ciudadania', 67823459,11021),
('Cedula de ciudadania', 78923485,11031),
('Cedula de ciudadania', 83476295,11031),
('Cedula de ciudadania', 90234578,11031),
('Cedula de ciudadania', 74385692,11031),
('Cedula de ciudadania', 82634578,11031),
('Cedula de ciudadania', 91548723,11031),
('Cedula de ciudadania', 78346578,11031),
('Cedula de ciudadania', 83926574,11031),
('Cedula de ciudadania', 90573284,11031),
('Cedula de ciudadania', 78453628,12011),
('Cedula de ciudadania', 85472384,12011),
('Cedula de ciudadania', 76248593,12011),
('Cedula de ciudadania', 89374562,12011),
('Cedula de ciudadania', 82936475,12011),
('Cedula de ciudadania', 94582734,10032),
('Cedula de ciudadania', 76823495,10032),
('Cedula de ciudadania', 85367248,10032),
('Cedula de ciudadania', 94738265,13021),
('Cedula de ciudadania', 92345678,13021),
('Cedula de ciudadania', 87234567,10042),
('Cedula de ciudadania', 80345678,10042),
('Cedula de ciudadania', 75323456,13021),
('Cedula de ciudadania', 81234567,10031),
('Cedula de ciudadania', 86234567,10032),
('Cedula de ciudadania', 73456789,10041),
('Cedula de ciudadania', 72456789,10042),
('Cedula de ciudadania', 89345678,10051),
('Cedula de ciudadania', 81234568,11011),
('Cedula de ciudadania', 72345689,10051),
('Cedula de ciudadania', 91234567,10021),
('Cedula de ciudadania', 84345678,10021),
('Cedula de ciudadania', 76345678,10021),
('Cedula de ciudadania', 93456789,10021),
('Cedula de ciudadania', 97234567,10011),
('Cedula de ciudadania', 90234567,10041),
('Cedula de ciudadania', 75234567,10041),
('Cedula de ciudadania', 81235678,10041),
('Cedula de ciudadania', 86234568,10041),
('Cedula de extranjeria', 1234567890,10051),
('Cedula de extranjeria', 15678901,13021),
('Cedula de extranjeria', 356789012 ,13021),
('Cedula de extranjeria', 456890123,10051),
('Cedula de extranjeria', 567901234, 10042),
('Cedula de extranjeria', 678012345,11021),
('Cedula de extranjeria', 790123456, 11031),
('Cedula de extranjeria', 890234567, 11011);

#Vamos a crear las hojas de vida
INSERT INTO HOJADEVIDA (HV_TIPO_DOCUMENTO, HV_NUM_DOCUMENTO, HV_PROGRAMA_ACADEMICO, HV_EXPERIENCIA, HV_IDIOMA) VALUES
('Cedula de ciudadania', 78453628, 'Cine y televisión', 'Realizó prácticas profesionales en una productora de cine independiente, donde participó en la producción y edición de cortometrajes. Adquirió experiencia en el uso de software de edición de video y diseño gráfico.', 'Español, Francés'),
('Cedula de ciudadania', 80345678, 'Ingenieria agrícola', 'Trabajó como asistente de campo en una empresa agroindustrial, donde realizó labores de siembra, cosecha y mantenimiento de cultivos. Participó en proyectos de investigación sobre nuevas técnicas de cultivo sostenible.', 'Español'),
('Cedula de ciudadania', 81234567, 'Ingenieria de sistemas', 'Desarrolló aplicaciones web y móviles como parte de un equipo de desarrollo en una empresa de tecnología. Participó en el diseño, implementación y prueba de sistemas informáticos para clientes.', 'Español, Inglés'),
('Cedula de ciudadania', 91548723, 'Ingenieria de sistemas', 'Realizó prácticas profesionales en el departamento de sistemas de una empresa financiera, donde colaboró en el mantenimiento y actualización de sistemas de gestión empresarial. Adquirió experiencia en el desarrollo de aplicaciones y la administración de bases de datos.', 'Español'),
('Cedula de ciudadania', 92345678, 'Ciencias políticas', 'Trabajó como asistente de investigación en un centro de estudios políticos, donde contribuyó en la recopilación y análisis de datos para proyectos de investigación sobre participación ciudadana y sistemas electorales.', 'Español, Inglés'),
('Cedula de ciudadania', 93456789, 'Matemáticas', 'Participó como tutor académico en el departamento de matemáticas de una universidad, donde brindó apoyo a estudiantes en temas de álgebra, cálculo y estadística. Organizó sesiones de estudio y preparación para exámenes.', 'Español'),
('Cedula de ciudadania', 94537284, 'Ciencias de la computación', 'Trabajó como desarrollador de software en una empresa de tecnología, donde colaboró en el diseño e implementación de sistemas de gestión de contenido y aplicaciones web. Adquirió experiencia en el desarrollo ágil y la integración continua.', 'Español, Inglés'),
('Cedula de ciudadania', 94738265, 'Matemáticas', 'Realizó prácticas como asistente de investigación en el departamento de matemáticas aplicadas, donde colaboró en proyectos de modelado matemático y simulación numérica. Utilizó software especializado para análisis estadístico y optimización.', 'Español, Francés'),
('Cedula de ciudadania', 94876234, 'Ciencias políticas', 'Participó como voluntario en campañas políticas locales, donde colaboró en actividades de difusión, organización de eventos y contacto con la comunidad. Contribuyó en la elaboración de propuestas y discursos.', 'Español'),
('Cedula de ciudadania', 95382746, 'Biología', 'Realizó una pasantía en un laboratorio de biotecnología, donde participó en proyectos de investigación sobre biología molecular y celular. Adquirió experiencia en técnicas de cultivo celular, clonación y análisis genético.', 'Español, Inglés'),
('Cedula de ciudadania', 97234567, 'Ingenieria eléctrica', 'Trabajó como pasante en una empresa de ingeniería eléctrica, donde colaboró en la instalación y mantenimiento de sistemas de energía renovable. Participó en proyectos de diseño y optimización de redes eléctricas.', 'Español'),
('Cedula de extranjeria', 356789012, 'Filosofía', 'Realizó prácticas en un centro de estudios filosóficos, donde colaboró en la revisión y análisis de textos filosóficos clásicos y contemporáneos. Participó en debates y seminarios sobre ética y política.', 'Español, Inglés'),
('Cedula de extranjeria',456890123, 'Ingenieria química', 'Trabajó como asistente de laboratorio en un centro de investigación en ingeniería química, donde colaboró en experimentos de síntesis y caracterización de materiales. Realizó análisis químicos y físicos utilizando equipos especializados.', 'Español, Inglés, Alemán'),
('Cedula de extranjeria', 567901234, 'Ingenieria agronómica', 'Realizó prácticas en una finca experimental, donde participó en la planificación y ejecución de proyectos de investigación agrícola. Adquirió experiencia en el manejo de cultivos, fertilización y control de plagas.', 'Español, Portugués'),
('Cedula de extranjeria', 678012345, 'Biología', 'Trabajó como voluntario en un centro de conservación de la biodiversidad, donde colaboró en la rehabilitación y liberación de especies en peligro de extinción. Participó en actividades de monitoreo de poblaciones y educación ambiental.', 'Español, Inglés, Francés'),
('Cedula de extranjeria', 790123456, 'Diseño Industrial', 'Realizó pasantías en estudios de diseño industrial, donde participó en el desarrollo de productos innovadores y la creación de prototipos. Colaboró en el diseño de interfaces de usuario y la selección de materiales.', 'Español, Inglés'),
('Cedula de extranjeria', 890234567, 'Arquitectura', 'Trabajó como asistente de diseño en un estudio de arquitectura, donde participó en la elaboración de planos y maquetas para proyectos de diseño urbano y arquitectura sostenible. Adquirió experiencia en el uso de software de diseño asistido por computadora.', 'Español, Inglés'),
('Cedula de extranjeria', 1234567890, 'Matemáticas', 'Realizó prácticas en el departamento de matemáticas de una institución educativa, donde colaboró en la elaboración de material didáctico y la impartición de clases de refuerzo. Participó en proyectos de investigación en didáctica de las matemáticas.', 'Español, Inglés'),
('Cedula de ciudadania', 4686621, 'Matemáticas', 'Trabajó como tutor académico en el departamento de matemáticas de su universidad, ofreciendo apoyo individualizado a estudiantes en temas de cálculo diferencial e integral, álgebra lineal y estadística.', 'Español, Inglés'),
('Cedula de ciudadania', 6451328, 'Ciencias de la computación', 'Realizó una pasantía en una empresa de desarrollo de software, donde participó en el diseño e implementación de sistemas de gestión de bases de datos. Adquirió experiencia en lenguajes de programación como Java y Python.', 'Español'),
('Cedula de ciudadania', 6833215, 'Ciencias políticas', 'Trabajó como asistente de investigación en un centro de estudios políticos, donde colaboró en la elaboración de informes y análisis sobre políticas públicas y procesos electorales. Participó en encuestas y entrevistas a actores políticos.', 'Español'),
('Cedula de ciudadania', 7468231, 'Arquitectura', 'Realizó prácticas en un estudio de arquitectura, donde participó en el diseño y modelado de proyectos arquitectónicos utilizando software de diseño asistido por computadora. Colaboró en la elaboración de planos y presentaciones para clientes.', 'Español, Inglés'),
('Cedula de ciudadania', 8037070, 'Ciencias de la computación', 'Trabajó como desarrollador de software en una startup tecnológica, donde contribuyó en el desarrollo de aplicaciones web y móviles. Participó en equipos ágiles utilizando metodologías como Scrum y Kanban.', 'Español, Inglés'),
('Cedula de ciudadania', 9786213, 'Ingenieria de sistemas', 'Realizó prácticas en una empresa de consultoría en tecnologías de la información, donde participó en proyectos de implementación de sistemas ERP y CRM. Adquirió experiencia en el análisis de requerimientos y la configuración de sistemas empresariales.', 'Español'),
('Cedula de ciudadania', 10062621, 'Ingenieria de sistemas', 'Trabajó como desarrollador de software en una empresa de servicios informáticos, donde participó en el diseño e implementación de aplicaciones empresariales. Colaboró en proyectos de integración de sistemas y migración de datos.', 'Español, Inglés'),
('Cedula de ciudadania', 15083215, 'Ingenieria de sistemas', 'Realizó prácticas en el departamento de tecnología de una entidad financiera, donde colaboró en el desarrollo y mantenimiento de sistemas de gestión de transacciones bancarias. Adquirió experiencia en el uso de frameworks como Spring y Hibernate.', 'Español, Inglés'),
('Cedula de extranjeria', 15678901, 'Filosofía', 'Trabajó como asistente de investigación en un proyecto sobre ética aplicada, donde participó en la revisión bibliográfica y la redacción de informes. Colaboró en la organización de conferencias y debates sobre temas éticos contemporáneos.', 'Español, Inglés');


INSERT INTO ESTUDIANTE (EST_TIPO_DOCUMENTO, EST_NUM_DOCUMENTO, EST_PAPA, EST_PA, EST_SEMESTRE_INGRESO, EST_AVANCE)
VALUES
('Cedula de ciudadania', 86234568, 3.2, 3.3, '2019-1', 66),
('Cedula de ciudadania', 89346578, 4.1, 4.2, '2020-2', 53),
('Cedula de ciudadania', 83456789, 3.5, 3.6, '2018-2', 81),
('Cedula de ciudadania', 75345678, 3.9, 4.0, '2021-1', 44),
('Cedula de ciudadania', 71234567, 4.0, 4.1, '2019-2', 63),
('Cedula de ciudadania', 92346789, 3.6, 3.7, '2020-1', 51),
('Cedula de ciudadania', 83456780, 3.7, 3.8, '2018-1', 94),
('Cedula de ciudadania', 86234569, 4.2, 4.3, '2022-1', 32),
('Cedula de ciudadania', 90235678, 3.8, 3.9, '2019-1', 74),
('Cedula de ciudadania', 72345678, 3.4, 3.5, '2018-2', 82),
('Cedula de ciudadania', 84345679, 4.3, 4.4, '2022-2', 34),
('Cedula de ciudadania', 91234568, 3.5, 3.6, '2020-2', 56),
('Cedula de ciudadania', 73234567, 3.6, 3.7, '2019-2', 61),
('Cedula de ciudadania', 85234567, 3.7, 3.8, '2021-1', 42),
('Cedula de ciudadania', 78456789, 4.1, 4.2, '2018-1', 93),
('Cedula de ciudadania', 81234569, 4.0, 4.1, '2020-1', 59),
('Cedula de ciudadania', 87234568, 3.9, 4.0, '2019-1', 65),
('Cedula de ciudadania', 89345789, 4.2, 4.3, '2022-1', 34),
('Cedula de ciudadania', 75346789, 4.3, 4.4, '2021-2', 42),
('Cedula de ciudadania', 72456780, 3.7, 3.8, '2019-2', 60),
('Cedula de ciudadania', 93456780, 3.8, 3.9, '2020-1', 56),
('Cedula de ciudadania', 79456789, 4.1, 4.2, '2022-2', 31),
('Cedula de ciudadania', 87234569, 4.0, 4.1, '2021-1', 46),
('Cedula de ciudadania', 79345678, 3.9, 4.0, '2018-1', 97),
('Cedula de ciudadania', 83456790, 3.8, 3.9, '2020-2', 53),
('Cedula de ciudadania', 75235678, 4.2, 4.3, '2019-1', 62),
('Cedula de ciudadania', 86234570, 4.3, 4.4, '2021-2', 42),
('Cedula de ciudadania', 82345678, 3.7, 3.8, '2022-1', 31),
('Cedula de ciudadania', 74345678, 3.5, 3.6, '2019-2', 66),
('Cedula de ciudadania', 92345679, 3.6, 3.7, '2020-1', 51),
('Cedula de ciudadania', 81235679, 3.9, 4.0, '2022-2', 31),
('Cedula de ciudadania', 83456791, 3.8, 3.9, '2019-1', 61),
('Cedula de ciudadania', 90345678, 4.1, 4.2, '2020-2', 56),
('Cedula de ciudadania', 73235678, 4.2, 4.3, '2018-2', 89),
('Cedula de ciudadania', 82456789, 3.7, 3.8, '2019-2', 69),
('Cedula de ciudadania', 84356789, 3.8, 3.9, '2020-1', 56),
('Cedula de ciudadania', 76234568, 4.1, 4.2, '2021-1', 42),
('Cedula de ciudadania', 81235680, 3.5, 3.6, '2018-1', 96),
('Cedula de ciudadania', 89234567, 3.6, 3.7, '2022-1', 32),
('Cedula de ciudadania', 79345679, 3.9, 4.0, '2021-2', 41),
('Cedula de ciudadania', 75346780, 3.8, 3.9, '2019-2', 61),
('Cedula de ciudadania', 610056841, 4.0, 4.1, '2020-1', 53),
('Cedula de ciudadania', 100239098, 3.7, 3.8, '2022-2', 24),
('Tarjeta de identidad', 987654321, 4.3, 4.4, '2019-1', 63),
('Tarjeta de identidad', 876543210, 4.2, 4.3, '2020-2', 56),
('Tarjeta de identidad', 765432109, 3.5, 3.6, '2018-2', 88),
('Tarjeta de identidad', 654321098, 4.0, 4.1, '2021-1', 36),
('Tarjeta de identidad', 543210987, 3.9, 4.0, '2019-2', 66),
('Tarjeta de identidad', 432109876, 3.8, 3.9, '2020-1', 57),
('Tarjeta de identidad', 321098765, 3.7, 3.8, '2022-2', 34),
('Tarjeta de identidad', 210987654, 4.1, 4.2, '2019-1', 66),
('Tarjeta de identidad', 109876543, 4.2, 4.3, '2020-2', 59),
('Tarjeta de identidad', 987654322, 4.3, 4.4, '2018-1', 92),
('Tarjeta de identidad', 876543211, 3.9, 4.0, '2020-2', 54),
('Tarjeta de identidad', 765432110, 4.0, 4.1, '2019-1', 80),
('Tarjeta de identidad', 654321099, 3.8, 3.9, '2021-1', 74),
('Tarjeta de identidad', 543210988, 3.7, 3.8, '2022-2', 36),
('Tarjeta de identidad', 432109877, 4.1, 4.2, '2019-1', 69),
('Tarjeta de identidad', 321098766, 3.6, 3.7, '2020-2', 54),
('Tarjeta de identidad', 210987655, 4.2, 4.3, '2018-1', 95),
('Tarjeta de identidad', 109876544, 4.0, 4.1, '2020-2', 57),
('Tarjeta de identidad', 987654323, 3.7, 3.8, '2019-1', 67),
('Tarjeta de identidad', 876543212, 3.6, 3.7, '2021-1', 40),
('Tarjeta de identidad', 765432111, 4.1, 4.2, '2022-2', 25),
('Tarjeta de identidad', 654321100, 4.3, 4.3, "2023-1",17),
('Tarjeta de identidad', 543210989, 4.1, 4.1, '2023-2',7),
('Tarjeta de identidad', 432109878, 4.5, 4.5, '2023-2',12),
('Tarjeta de identidad', 321098767, 4.3,4.3, "2023-2",9),
('Tarjeta de identidad', 210987656, 3.7,3.8, "2021-2", 42),
('Tarjeta de identidad', 109876545, 4.1,4.1, "2022-2",18),
('Tarjeta de identidad', 987654324, 3.8, 3.8, "2019-2",85),
('Tarjeta de identidad', 876543213, 4.1, 4.1, "2022-1",41),
('Tarjeta de identidad', 765432112, 4.5, 4.5, "2021-2",62),
('Tarjeta de identidad', 654321101, 4.7, 4.7, "2023-1",8),
('Tarjeta de identidad', 543210990, 3.4, 3.4, "2020-2",75),
('Tarjeta de identidad', 432109879, 4.7, 4.7, '2019-1',81),
('Tarjeta de identidad', 321098768, 2.8, 3.0, "2022-1",40),
('Tarjeta de identidad', 210987657, 2.9, 3.0, '2022-2',25),
('Tarjeta de identidad', 109876546, 3.2, 3.2, "2022-2",24),
('Tarjeta de identidad', 987654325, 3.0, 3.0, '2022-2',18),
('Tarjeta de identidad', 876543214, 2.9, 3.0, '2022-2',17),
('Tarjeta de identidad', 765432113, 3.2, 3.2, '2022-2', 26),
('Tarjeta de identidad', 654321102, 4.2, 4.2, '2022-2',24),
('Tarjeta de identidad', 543210991, 4.2, 4.2, '2022-2', 26),
('Tarjeta de identidad', 432109880, 2.7, 3.0, '2022-2', 34),
('Tarjeta de identidad', 321098769, 4.6,  4.6,'2022-2',32),
('Tarjeta de identidad', 210987658, 3.9, 3.9, "2021-2",54),
('Tarjeta de identidad', 109876547, 4.2, 4.2, "2021-2",57),
('Tarjeta de identidad', 987654326, 4.4, 4.4, '2021-2',42),
('Tarjeta de identidad', 876543215, 4.1, 4.1, "2021-2",63),
('Tarjeta de identidad', 765432114, 4.4, 4.4, '2021-2', 65),
('Tarjeta de identidad', 654321103, 4.2, 4.2, '2021-2',68),
('Tarjeta de identidad', 543210992, 4.4, 4.4, '2021-2',58),
('Tarjeta de identidad', 432109881, 4.3, 4.3, '2021-2',42),
('Tarjeta de identidad', 321098770, 4.1, 4.1, '2021-2',47),
('Tarjeta de identidad', 210987659, 4.5, 4.5, '2021-2',59),
('Tarjeta de identidad', 109876548, 2.7, 2.7, '2020-2',77),
('Tarjeta de identidad', 987654327, 3.2, 3.2,'2020-2', 79),
('Tarjeta de identidad', 876543216, 3.5, 3.5, '2020-2',83),
('Tarjeta de identidad', 765432115, 3.9, 3.9, '2020-2',76),
('Tarjeta de identidad', 654321104, 4.2, 4.2, '2020-2',82),
('Tarjeta de identidad', 543210993, 4.6, '4.6', "2020-2",88),
('Tarjeta de identidad', 432109882, 4.2, 4.2, '2020-2',91),
('Tarjeta de identidad', 321098771, 4.1, 4.1, '2020-2',87),
('Tarjeta de identidad', 210987660, 3.9, 3.9, "2020-2",78),
('Tarjeta de identidad', 109876549, 2.8, 3.0, '2020-2',82),
('Tarjeta de identidad', 987654328, 3.6, 3.6, '2020-2',83),
('Tarjeta de identidad', 876543217, 3.2, 3.5, '2020-2', 91),
('Tarjeta de identidad', 765432116, 4.3, 4.3, '2021-1', 66),
('Tarjeta de identidad', 654321105, 4.2, 4.2, '2021-1',72),
('Tarjeta de identidad', 543210994, 4.5, 4.5, '2021-1',75),
('Tarjeta de identidad', 432109883, 4.8, 4.8, '2021-1',78),
('Tarjeta de identidad', 321098772, 4.2, 4.2, '2021-1',75),
('Tarjeta de identidad', 210987661, 3.9, 3.9, '2021-1',72),
('Tarjeta de identidad', 109876550, 3.4, 3.4, "2021-1",63),
('Tarjeta de identidad', 987654329, 4.5, 4.5, '2021-1',54),
('Tarjeta de identidad', 876543218, 4.2, 4.2, "2021-1", 64),
('Tarjeta de identidad', 765432117, 4.2, 4.2, '2021-1', 67),
('Tarjeta de identidad', 654321106, 4.3, 4.3, '2021-1',72),
('Tarjeta de identidad', 543210995, 4.5, 4.5, '2021-1', 65),
('Tarjeta de identidad', 432109884, 3.9, 3.9, '2022-1',41),
('Tarjeta de identidad', 321098773, 4.1, 4.1, '2022-1',32),
('Tarjeta de identidad', 210987662, 4.8, 4.8, '2022-1',35),
('Tarjeta de identidad', 109876551, 4.5, 4.5, '2022-1',34),
('Tarjeta de identidad', 987654330, 3.9, 3.9, '2022-1',38),
('Tarjeta de identidad', 876543219, 3.4, 3.4, '2022-1',31),
('Tarjeta de identidad', 765432118, 3.4, 3.5, "2022-1",31),
('Tarjeta de identidad', 654321107, 3.4, 3.4, '2022-1', 32),
('Tarjeta de identidad', 543210996, 4.3,4.3, "2022-1",38),
('Tarjeta de identidad', 432109885, 4.2, 4.2, '2022-1',42),
('Tarjeta de identidad', 321098774, 4.5, 4.5, '2022-1',45),
('Tarjeta de identidad', 210987663, 4.2, 4.2, '2023-1',22),
('Tarjeta de identidad', 109876552, 4.0, 4.0, "2023.1",21),
('Tarjeta de identidad', 987654331, 4.1, 4.1, '2023-1',17),
('Tarjeta de identidad', 876543220, 4.1, 4.1, '2023-1',12),
('Tarjeta de identidad', 765432119, 3.1, 3.1, '2023-1',8),
('Tarjeta de identidad', 654321108, 3.7, 3.7, '2023-1', 21),
('Tarjeta de identidad', 543210997, 4.1, 4.1, "2023-1",28),
('Tarjeta de identidad', 432109886, 3.9, 3.9, "2023-1",22),
('Tarjeta de identidad', 321098775, 4.3, 4.3, "2023-1",26),
('Tarjeta de identidad', 210987664, 4.5,4.5, "2023-1",23),
('Tarjeta de identidad', 109876553, 4.1, 4.1, "2023-2",13),
('Tarjeta de identidad', 987654332, 4.2, 4.2, "2023-.2",9),
('Tarjeta de identidad', 876543221, 4.3, 4.3,"2023-2",11),
('Cedula de extranjeria', 902345678, 4.7, 4.7,"2023-2",14),
('Cedula de extranjeria', 112334455, 3.2, 3.2,"2023-2",7),
('Cedula de extranjeria', 22345566, 4.0, 4.0, "2023-2",12 ),
('Cedula de extranjeria', 334455667, 4.0, 4.1,"2023-2",6),
('Cedula de extranjeria', 445566788, 4.2, 4.2,"2022-1",51),
('Cedula de extranjeria', 556678899, 3.5, 3.5, '2021-1',72),
('Cedula de extranjeria', 667889900, 3.8, 3.8, '2020-2',78),
('Cedula de extranjeria', 778990011, 4.1, 4.1, "2022-1",42),
('Cedula de extranjeria', 889900122, 4.4,4.4, '2023-1',14),
('Cedula de extranjeria', 990112233, '4.2', '4.2', "2020-1",62),
('Cedula de extranjeria', 334556677, 3.8, 3.8, '2019-1',97),
('Cedula de extranjeria', 223445566, "3.3", "3.3", "2019-2",88);


insert into estudiante_estudio_programa(ESEP_TIPO_IDENTIFICACION,ESEP_IDENTIFICACION,ESEP_PROGRAMA) value
    ('Cedula de ciudadania', 86234568, 10011),
    ('Cedula de ciudadania', 89346578, 10021),
    ('Cedula de ciudadania', 83456789, 10031),
    ('Cedula de ciudadania', 75345678, 10032),
    ('Cedula de ciudadania', 71234567, 10041),
    ('Cedula de ciudadania', 92346789, 10042),
    ('Cedula de ciudadania', 83456780, 10051),
    ('Cedula de ciudadania', 86234569, 11011),
    ('Cedula de ciudadania', 90235678, 11012),
    ('Cedula de ciudadania', 72345678, 11021),
    ('Cedula de ciudadania', 84345679, 11031),
    ('Cedula de ciudadania', 91234568, 11041),
    ('Cedula de ciudadania', 73234567, 11042),
    ('Cedula de ciudadania', 85234567, 11051),
    ('Cedula de ciudadania', 78456789, 12011),
    ('Cedula de ciudadania', 81234569, 12021),
    ('Cedula de ciudadania', 87234568, 12022),
    ('Cedula de ciudadania', 89345789, 12031),
    ('Cedula de ciudadania', 75346789, 12041),
    ('Cedula de ciudadania', 72456780, 13011),
    ('Cedula de ciudadania', 93456780, 13021),
    ('Cedula de ciudadania', 79456789, 10031),
    ('Cedula de ciudadania', 87234569, 14021),
    ('Cedula de ciudadania', 79345678, 15011),
    ('Cedula de ciudadania', 83456790, 15021),
    ('Cedula de ciudadania', 75235678, 15031),
    ('Cedula de ciudadania', 86234570, 15041),
    ('Cedula de ciudadania', 82345678, 16011),
    ('Cedula de ciudadania', 74345678, 16021),
    ('Cedula de ciudadania', 92345679, 16031),
    ('Cedula de ciudadania', 81235679, 16041),
    ('Cedula de ciudadania', 83456791, 17011),
    ('Cedula de ciudadania', 90345678, 17012),
    ('Cedula de ciudadania', 73235678, 17021),
    ('Cedula de ciudadania', 82456789, 17031),
    ('Cedula de ciudadania', 84356789, 18011),
    ('Cedula de ciudadania', 76234568, 18021),
    ('Cedula de ciudadania', 81235680, 18022),
    ('Cedula de ciudadania', 89234567, 18031),
    ('Cedula de ciudadania', 79345679, 19011),
    ('Cedula de ciudadania', 75346780, 20011),
    ('Cedula de ciudadania', 610056841, 20012),
    ('Cedula de ciudadania', 100239098, 20021),
    ('Tarjeta de identidad', 987654321, 21011),
    ('Tarjeta de identidad', 876543210, 21012),
    ('Tarjeta de identidad', 765432109, 21021),
    ('Tarjeta de identidad', 654321098, 21021),
    ('Tarjeta de identidad', 543210987, 21021),
    ('Tarjeta de identidad', 432109876, 10042), 
    ('Tarjeta de identidad', 321098765, 10051),
    ('Tarjeta de identidad', 210987654, 11011),
    ('Tarjeta de identidad', 109876543, 11012),
    ('Tarjeta de identidad', 987654322, 11021),
    ('Tarjeta de identidad', 876543211, 11031),
    ('Tarjeta de identidad', 765432110, 11041),
    ('Tarjeta de identidad', 654321099, 11042),
    ('Tarjeta de identidad', 543210988, 11011),
    ('Tarjeta de identidad', 432109877, 11021), 
    ('Tarjeta de identidad', 321098766, 11031),
    ('Tarjeta de identidad', 210987655, 11041),
    ('Tarjeta de identidad', 109876544, 11011),
    ('Tarjeta de identidad', 987654323, 11021),
    ('Tarjeta de identidad', 876543212, 11021),
    ('Tarjeta de identidad', 765432111, 11031),
    ('Tarjeta de identidad', 654321100, 11041),
    ('Tarjeta de identidad', 543210989, 18011),
    ('Tarjeta de identidad', 432109878, 18021),
    ('Tarjeta de identidad', 321098767, 18031),
    ('Tarjeta de identidad', 210987656, 18011),
    ('Tarjeta de identidad', 109876545, 18011),
    ('Tarjeta de identidad', 987654324, 18021),
    ('Tarjeta de identidad', 876543213, 18031),
    ('Tarjeta de identidad', 765432112, 18031),
    ('Tarjeta de identidad', 654321101, 12031),
    ('Tarjeta de identidad', 543210990, 12031),
    ('Tarjeta de identidad', 432109879, 12021),
    ('Tarjeta de identidad', 321098768, 12031),
    ('Tarjeta de identidad', 210987657, 11042),
    ('Tarjeta de identidad', 109876546, 11042),
    ('Tarjeta de identidad', 987654325, 11041),
    ('Tarjeta de identidad', 876543214, 12021),
    ('Tarjeta de identidad', 765432113, 10031), 
    ('Tarjeta de identidad', 654321102, 10041),
    ('Tarjeta de identidad', 543210991, 10011), 
    ('Tarjeta de identidad', 432109880, 10021),
    ('Tarjeta de identidad', 321098769, 10021),
    ('Tarjeta de identidad', 210987658, 10031), 
    ('Tarjeta de identidad', 109876547, 10041),
    ('Tarjeta de identidad', 987654326, 10011),
    ('Tarjeta de identidad', 876543215, 10011),
    ('Tarjeta de identidad', 765432114, 10021),
    ('Tarjeta de identidad', 654321103, 10031),
    ('Tarjeta de identidad', 543210992, 10032),
    ('Tarjeta de identidad', 432109881, 10041),
    ('Tarjeta de identidad', 321098770, 10042),
    ('Tarjeta de identidad', 210987659, 10051),
    ('Tarjeta de identidad', 109876548, 11011), 
    ('Tarjeta de identidad', 987654327, 11012),
    ('Tarjeta de identidad', 876543216, 11021),
    ('Tarjeta de identidad', 765432115, 11031),
    ('Tarjeta de identidad', 654321104, 11041),
    ('Tarjeta de identidad', 543210993, 11042),
    ('Tarjeta de identidad', 432109882, 11051),
    ('Tarjeta de identidad', 321098771, 12011),
    ('Tarjeta de identidad', 210987660, 12021),
    ('Tarjeta de identidad', 109876549, 12022),
    ('Tarjeta de identidad', 987654328, 12031),
    ('Tarjeta de identidad', 876543217, 12041),
    ('Tarjeta de identidad', 765432116, 13011),
    ('Tarjeta de identidad', 654321105, 13021),
    ('Tarjeta de identidad', 543210994, 14011),
    ('Tarjeta de identidad', 432109883, 14021),
    ('Tarjeta de identidad', 321098772, 15011),
    ('Tarjeta de identidad', 210987661, 15021),
    ('Tarjeta de identidad', 109876550, 15031),
    ('Tarjeta de identidad', 987654329, 15041),
    ('Tarjeta de identidad', 876543218, 16011),
    ('Tarjeta de identidad', 765432117, 16021),
    ('Tarjeta de identidad', 654321106, 16031),
    ('Tarjeta de identidad', 543210995, 16041), 
    ('Tarjeta de identidad', 432109884, 17011),
    ('Tarjeta de identidad', 321098773, 17012),
    ('Tarjeta de identidad', 210987662, 17021),
    ('Tarjeta de identidad', 109876551, 17011),
    ('Tarjeta de identidad', 987654330,    17011),
('Tarjeta de identidad', 876543219, 10051),
('Tarjeta de identidad', 765432118, 10011),
('Tarjeta de identidad', 654321107, 10021),
('Tarjeta de identidad', 543210996, 10031),
('Tarjeta de identidad', 432109885, 10041),
('Tarjeta de identidad', 321098774, 10051),
('Tarjeta de identidad', 210987663, 10011),
('Tarjeta de identidad', 109876552, 10021),
('Tarjeta de identidad', 987654331, 19011),
('Tarjeta de identidad', 876543220, 18031),
('Tarjeta de identidad', 765432119, 18031),
('Tarjeta de identidad', 654321108, 19011),
('Tarjeta de identidad', 543210997, 20011),
('Tarjeta de identidad', 432109886, 20021),
('Tarjeta de identidad', 321098775, 20021),
('Tarjeta de identidad', 210987664, 20012), 
('Tarjeta de identidad', 109876553, 20011),
('Tarjeta de identidad', 987654332, 21011),
('Tarjeta de identidad', 876543221, 21021),
('Cedula de extranjeria', 902345678, 17031), 
('Cedula de extranjeria', 112334455, 18011),
('Cedula de extranjeria', 22345566,  18021),
('Cedula de extranjeria', 334455667, 18022),
('Cedula de extranjeria', 445566788, 18031),
('Cedula de extranjeria', 556678899, 19011),
('Cedula de extranjeria', 667889900, 20011),
('Cedula de extranjeria', 778990011, 20012),
('Cedula de extranjeria', 889900122, 20021),
('Cedula de extranjeria', 990112233, 21011),
('Cedula de extranjeria', 334556677, 21012),
('Cedula de extranjeria', 223445566, 21021);



INSERT INTO ADMINISTRATIVO (ADM_TIPO_DOCUMENTO, ADM_NUM_DOCUMENTO, ADM_CARGO, ADM_AREA, ADM_FECHA_INGRESO, ADM_TIPO_CONTRATO, ADM_SEDE) VALUES
('Cedula de ciudadania', 1234567899, 'Director', 'Recursos Humanos', '2020-01-15', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 987643211, 'Coordinador', 'Financiera', '2018-05-23', 'Indefinido', 'Medellín'),
('Cedula de ciudadania', 456791233, 'Analista', 'Tecnología', '2019-03-17', 'Temporal', 'Manizales'),
('Cedula de ciudadania', 789124566, 'Asistente', 'Académica', '2021-11-08', 'Indefinido', 'La Paz'),
('Cedula de ciudadania', 326549877, 'Jefe', 'Administrativa', '2022-07-12', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 654983211, 'Coordinador', 'Logística', '2017-09-25', 'Temporal', 'Bogotá'),
('Cedula de ciudadania', 987216544, 'Gerente', 'Recursos Humanos', '2023-02-14', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 157534866, 'Director', 'Financiera', '2020-04-20', 'Indefinido', 'Medellín'),
('Cedula de ciudadania', 257413699, 'Analista', 'Tecnología', '2019-06-30', 'Indefinido', 'Medellín'),
('Cedula de ciudadania', 369851477, 'Asistente', 'Académica', '2021-12-01', 'Temporal', 'Manizales'),
('Cedula de ciudadania', 741259633, 'Jefe', 'Administrativa', '2018-08-16', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 859637411, 'Coordinador', 'Logística', '2017-10-10', 'Temporal', 'Bogotá'),
('Cedula de ciudadania', 967418522, 'Gerente', 'Recursos Humanos', '2022-05-19', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 147253699, 'Director', 'Financiera', '2020-07-05', 'Indefinido', 'Medellín'),
('Cedula de ciudadania', 258391477, 'Analista', 'Tecnología', '2019-03-29', 'Temporal', 'Manizales'),
('Cedula de ciudadania', 391472588, 'Asistente', 'Académica', '2021-09-21', 'Indefinido', 'Manizales'),
('Cedula de ciudadania', 741398522, 'Jefe', 'Administrativa', '2018-12-13', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 852741633, 'Coordinador', 'Logística', '2017-02-28', 'Temporal', 'La Paz'),
('Cedula de ciudadania', 963827411, 'Gerente', 'Recursos Humanos', '2023-01-18', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 147392588, 'Director', 'Financiera', '2020-11-09', 'Indefinido', 'Medellín'),
('Cedula de ciudadania', 287419633, 'Analista', 'Tecnología', '2019-06-07', 'Indefinido', 'La Paz'),
('Cedula de ciudadania', 369281477, 'Asistente', 'Académica', '2021-04-14', 'Temporal', 'La Paz'),
('Cedula de ciudadania', 741829633, 'Jefe', 'Administrativa', '2018-08-20', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 829631477, 'Coordinador', 'Logística', '2017-10-22', 'Temporal', 'Manizales'),
('Cedula de ciudadania', 963147822, 'Gerente', 'Recursos Humanos', '2022-12-02', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 148523699, 'Director', 'Financiera', '2020-02-25', 'Indefinido', 'Medellín'),
('Cedula de ciudadania', 258637411, 'Analista', 'Tecnología', '2019-06-18', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 369412588, 'Asistente', 'Académica', '2021-09-09', 'Temporal', 'Medellín'),
('Cedula de ciudadania', 741638522, 'Jefe', 'Administrativa', '2018-11-04', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 852179633, 'Coordinador', 'Logística', '2017-03-22', 'Temporal', 'Manizales'),
('Cedula de ciudadania', 963257411, 'Gerente', 'Recursos Humanos', '2022-05-11', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 149632588, 'Director', 'Financiera', '2020-07-07', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 258143699, 'Analista', 'Tecnología', '2019-10-01', 'Temporal', 'Manizales'),
('Cedula de ciudadania', 369589633, 'Asistente', 'Académica', '2021-03-08', 'Indefinido', 'La Paz'),
('Cedula de ciudadania', 741631477, 'Jefe', 'Administrativa', '2018-06-26', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 852712588, 'Coordinador', 'Logística', '2017-12-30', 'Temporal', 'La Paz'),
('Cedula de ciudadania', 963521477, 'Gerente', 'Recursos Humanos', '2022-01-20', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 147257411, 'Director', 'Financiera', '2020-04-11', 'Indefinido', 'Medellín'),
('Cedula de ciudadania', 258938522, 'Analista', 'Tecnología', '2019-09-03', 'Temporal', 'Manizales'),
('Cedula de ciudadania', 369179633, 'Asistente', 'Académica', '2021-12-16', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 741823699, 'Jefe', 'Administrativa', '2018-11-15', 'Indefinido', 'Bogotá'),
('Cedula de ciudadania', 852361477, 'Coordinador', 'Logística', '2017-02-06', 'Temporal', 'Medellín'),
("Cedula de ciudadania", 60420141, 'Asistente', 'Académica', '2021-04-06', 'Indefinido', 'Bogotá'),
("Cedula de ciudadania", 190820141, 'Asistente', 'Logística', '2022-08-19', 'Indefinido', 'Bogotá');




###------------------------ DATOS DE ACTIVIDADES ---------------------------------------------
INSERT INTO ACTIVIDAD (ACT_NOMBRE, ACT_HORARIO, ACT_LUGAR, ACT_ENCARGADO, ACT_CAPACIDAD, ACT_COSTO, ACT_TIPO) VALUES
('Conferencia de Inteligencia Artificial', '10:00-12:00 8 May', 'Auditorio Principal Ed. Julio Garavito', 'Dr. Juan Pérez', 200, 0, 'Conferencia Académica'),
('Feria de Empleo', '09:00-17:00 5 Jun', 'Gimnasio Polideportivo', 'Oficina de Empleo', 500, 0, 'Feria de Empleo'),
('Charla con Egresados de Ingeniería', '14:00-16:00 28 May', 'Salón 101 Aulas de ingenieria', 'Asociación de Egresados', 100, 0, 'Charla con Egresados'),
('Taller de Danza Contemporánea', '16:00-18:00 27 May', 'Sala de Danza Edificio Artes', 'Prof. Ana López', 30, 0, 'Actividad Cultural'),
('Taller de Teatro', '18:00-20:00 16 Jun', 'Teatro Universitario Edificio Artes', 'Prof. Carlos Mendoza', 50, 0, 'Actividad Cultural'),
('Concierto de Música Clásica', '19:00-21:00 4 Jun', 'Auditorio de Música Edificio Artes', 'Orquesta Universitaria', 150, 10, 'Actividad Cultural'),
('Clase de Pintura', '10:00-12:00 30 May', 'Taller de Artes Edificio Artes', 'Prof. Laura Gómez', 20, 5, 'Actividad Cultural'),
('Charla con Empresas Tecnológicas', '15:00-17:00 31 May', 'Salón 202 Aulas de Ciencias', 'Departamento de Vinculación', 100, 0, 'Charla con Empresas'),
('Conferencia sobre Emprendimiento', '11:00-13:00 30 May', 'Auditorio B CyT', 'Centro de Emprendimiento', 200, 0, 'Emprendimiento'),
('Taller de Innovación', '14:00-16:00 10 Jun', 'Salón 305 CyT', 'Prof. Mario Sánchez', 50, 0, 'Emprendimiento'),
('Seminario de Investigación en Ciencias', '09:00-11:00 5 Jun', 'Laboratorio Central Edificio Ciencias', 'Dr. María Rodríguez', 60, 0, 'Grupo de Investigación'),
('Encuentro de Grupos de Investigación', '13:00-15:00 9 Jun', 'Biblioteca Central', 'Coordinación de Investigación', 80, 0, 'Grupo de Investigación'),
('Conferencia sobre Robótica', '10:00-12:00 16 Jun', 'Auditorio A CyT', 'Ing. José Martínez', 150, 0, 'Conferencia Académica'),
('Feria de Proyectos Estudiantiles', '09:00-17:00 20 Jun', 'Plaza Central', 'Consejo Estudiantil', 300, 0, 'Feria de Empleo'),
('Charla de Innovación Empresarial', '16:00-18:00 16 Jul', 'Salón 306 Aulas ingenieria', 'Incubadora de Empresas', 100, 0, 'Charla con Empresas'),
('Taller de Escritura Creativa', '11:00-13:00 15 Jun', 'Sala de Lectura Biblioteca Central', 'Prof. Julia Fernández', 25, 0, 'Actividad Cultural'),
('Concierto de Jazz', '19:00-21:00 21 Jul', 'Auditorio de Música Edificio Artes', 'Banda Universitaria', 150, 10, 'Actividad Cultural'),
('Clase Magistral de Fotografía', '14:00-16:00 6 Jun', 'Taller de Artes Edificio Artes', 'Prof. Daniel Ruiz', 20, 0, 'Actividad Cultural'),
('Seminario sobre Energías Renovables', '10:00-12:00 1 Jul', 'Auditorio C CyT', 'Dr. Luis Torres', 100, 0, 'Conferencia Académica'),
('Feria de Innovación y Tecnología', '09:00-17:00 27 Jun', 'Centro de Convenciones Polideportivo', 'Departamento de Tecnología', 400, 0, 'Feria de Empleo'),
('Encuentro de Egresados de Medicina', '13:00-15:00 10 Jul', 'Salón 102 Aulas de Ciencias', 'Asociación de Egresados', 80, 0, 'Charla con Egresados'),
('Taller de Escultura', '16:00-18:00 5 Jul',"Salón 306 Aulas  de ingenieria" ,'Prof. Raquel Pérez', 15, 5, 'Actividad Cultural'),
('Charla sobre Marketing Digital', '11:00-13:00 2 Ago', 'Salón 204 Aulas de ingenieria', 'Departamento de Artes Plásticas', 100, 0, 'Charla con Empresas'),
('Conferencia sobre Big Data', '10:00-12:00 1 Ago', 'Auditorio B CyT', 'Dr. David Jiménez', 150, 0, 'Conferencia Académica'),
('Taller de Creación de Startups', '14:00-16:00 26 Jun', 'Salón 306 Aulas ingenieria', 'Prof. Clara Mejía', 50, 0, 'Emprendimiento'),
('Feria de Empleo de Ingeniería', '09:00-17:00 4 Ago', 'Gimnasio Polideportivo', 'Oficina de Empleo', 600, 0, 'Feria de Empleo'),
('Feria de Empleo de Ciencias Sociales', '09:00-17:00 12 Ago', 'Plaza Central', 'Oficina de Empleo', 500, 0, 'Feria de Empleo'),
('Feria de Empleo de Tecnología', '09:00-17:00 1 Sept', 'Centro de Convenciones Polideportivo', 'Oficina de Empleo', 700, 0, 'Feria de Empleo'),
('Taller de Programación Avanzada', '14:00-16:00 22 Ago', 'Laboratorio de Computación Aulas de Ciencias', 'Ing. Roberto García', 40, 0, 'Actividad Académica'),
('Conferencia sobre Neurociencia', '11:00-13:00 4 Ago', 'Auditorio C CyT', 'Dr. Elena Martínez', 120, 0, 'Conferencia Académica'),
('Taller de Salsa', '16:00-18:00 23 Jul', 'Sala de Danza Edificio Artes', 'Prof Carlos Herrera', 20, 10, 'Actividad Cultural'),
('Charla de Experiencias Profesionales', '15:00-17:00 16 Jun', 'Salón 302', 'Asociación de Egresados', 80, 0, 'Charla con Egresados'),
('Seminario sobre Derechos Humanos', '10:00-12:00 27 May', 'Auditorio A CyT', 'Dr. Andrea Morales', 100, 0, 'Conferencia Académica'),
('Clase Magistral de Danza Folclórica', '18:00-20:00 24 May', 'Sala de Danza Edificio Artes', 'Prof. Laura Peña', 30, 0, 'Actividad Cultural'),
('Charla sobre Responsabilidad Social Empresarial', '13:00-15:00 15 Ago', 'Salón 203 Aulas de Ciencias', 'Centro de Emprendimiento', 100, 0, 'Emprendimiento');

select * from ACTIVIDAD;

-- Insertamos los datos en actividad academica
INSERT INTO ACTIVIDAD_ACADEMICA (ACA_CODIGO, ACA_AREA) VALUES
(1, 'Inteligencia Artificial'),
(3, "Oficina de empleo"),
(13, 'Robótica'),
(19, 'Energías Renovables'),
(21, "Salud"),
(24, 'Big Data'),
(29,"Programación"),
(30, 'Neurociencia'),
(32, "Oficina de Empleo"),
(33, 'Derechos Humanos');


-- Insertar datos en la tabla ACTIVIDAD_BOLSA_EMPLEO
INSERT INTO ACTIVIDAD_BOLSA_EMPLEO (BOL_CODIGO, BOL_EMPRESAS_PRIVADAS, BOL_AREA_TRABAJO) VALUES
(2, 50, 'Multisectorial'),
(14, 30, 'Tecnología y Ciencias'),
(20, 40, 'Innovación y Tecnología'),
(25, 45, 'Ingeniería'),
(26, 35, 'Ciencias Sociales'),
(27, 60, 'Tecnología');

-- Insercion de datos en la tabla ACTIVIDAD_SOCIOCULTURAL
INSERT INTO ACTIVIDAD_SOCIOCULTURAL (SOC_CODIGO, SOC_INVITADOS, SOC_AREA_CULTURAL) VALUES
(4, 'Compañía de Danza Local', 'Danza'),
(5, 'Grupo de Teatro Independiente', 'Teatro'),
(6, 'Artistas Invitados', 'Música'),
(7, 'Comunidad de Pintores Locales', 'Pintura'),
(16, 'Escritores Locales', 'Escritura Creativa'),
(17, 'Bandas de Jazz Locales', 'Música'),
(18, 'Fotógrafos Invitados', 'Fotografía'),
(22, 'Escultores Locales', 'Escultura'),
(28, 'Bailarines de Salsa Locales', 'Danza'),
(31, "Salsunal","Danza"),
(34, 'Grupos de Danza Folclórica', 'Danza'); 


# Insertamos daots en la tabla de grupo artístico
INSERT INTO GRUPO_ARTISTICO (GRU_NOMBRE, GRU_TIPO, GRU_ENCARGADO) VALUES
('Ballet Clásico de Viena', 'Danza', 'Juan Pérez'),
('Teatro de la Afro de Cali', 'Teatro', 'María Rodríguez'),
('Orquesta Sinfónica de Bogotá', 'Música', 'Pedro Martínez'),
('Colectivo de Pintores Salvador Dalí', 'Pintura', 'Ana Gómez'),
('Grupo de Escritores Creativos GABO', 'Escritura Creativa', 'Carlos Fernández'),
('Big Band de Ciudad Furiosa', 'Música', 'Laura Sánchez'),
('Círculo de Fotografía Sebastiao Salgado', 'Fotografía', 'Luis Ramírez'),
('Escuela de Cultura MAMBO', 'Escultura', 'Sofía López'),
('Grupo de Baile de Salsa Ciudad Blanca', 'Danza', 'Diego González'),
('Compañía de Danzas Folclóricas del Llano', 'Danza', 'Camila Hernández'),
('Ensamble de Jazz Ciudad K', 'Música', 'Javier Castro'),
('Grupo de Teatro Comunitario La Policarpa', 'Teatro', 'Laura Pérez'),
('Banda de Rock Alternativo Gatos Rabiosos', 'Música', 'Carlos García'),
('Colectivo de Fotografía Urbana La Belleza Gris', 'Fotografía', 'Valeria Rodríguez'),
('Grupo de Baile de Tango de Medellín', 'Danza', 'Roberto Martínez'),
('Taller de Pintura al Aire Libre Escuela Graffiti', 'Pintura', 'Marcela Gómez'),
('Orquesta Sinfónica de Bucaramanga', 'Música', 'Raul Hernández'),
('Grupo de Teatro Experimental de Varsovia', 'Teatro', 'Natalia Fernández'),
('Ensamble de Música Latina Celia Cruz', 'Música', 'Mateo López'),
('Compañía de Danza Contemporánea DANCONBO', 'Danza', 'Juliana Ramírez'),
('Taller de Escritura Creativa JUMAR', 'Escritura Creativa', 'Felipe Castro'),
('Colectivo de Música Electrónica AVICCI', 'Música', 'Carolina González'),
('Grupo de Baile de Hip-Hop Ciudad EMINEM', 'Danza', 'Daniel Pérez');

#Insertamos los datos de participacion de grupo artístico en las actividades socioculturales

INSERT INTO PARTICIPACION_ACTSOC_GRU (PARTACTSOC_CODIGO_ACTIVIDAD, PARTACTSOC_GRU_ID) VALUES
(4, 12000), -- Compañía de Danza Local en Ballet Clásico de Viena
(4, 12009), -- Compañía de Danza Local en Compañía de Danzas Folclóricas del Llano
(4, 12019), -- Compañía de Danza Local en Compañía de Danza Contemporánea DANCONBO
(5, 12001), -- Grupo de Teatro Independiente en Teatro de la Afro de Cali
(5, 12011), -- Grupo de Teatro Independiente en Grupo de Teatro Comunitario La Policarpa
(5, 12017), -- Grupo de Teatro Independiente en Grupo de Teatro Experimental de Varsovia
(6, 12003), -- Artistas Invitados en Orquesta Sinfónica de Bogotá
(6, 12012), -- Artistas Invitados en Banda de Rock Alternativo Gatos Rabiosos
(6, 12022), -- Artistas Invitados en Compañía de Hip Hop EMINEM
(7, 12003), -- Comunidad de Pintores Locales en Colectivo de Pintores Salvador Dalí
(7, 12013), -- Comunidad de Pintores Locales en Colectivo de Fotografía Urbana La Belleza Gris
(7, 12015), -- Comunidad de Pintores Locales en Taller de Pintura al Aire Libre Escuela Graffiti
(16,12004), -- Escritores Locales en Grupo de Escritores Creativos GABO
(16,12013), -- Escritores Locales en Grupo de Baile de Tango de Medellín
(16, 12022), -- Escritores Locales en Grupo de Baile de Hip-Hop Ciudad EMINEM
(17, 12005), -- Bandas de Jazz Locales en Big Band de Ciudad Furiosa
(17, 12014), -- Bandas de Jazz Locales en Ensamble de Jazz Ciudad K
(18, 12006), -- Fotógrafos Invitados en Círculo de Fotografía Sebastiao Salgado
(18, 12015), -- Fotógrafos Invitados en Colectivo de Fotografía Urbana La Belleza Gris
(18, 12019), -- Fotógrafos Invitados en Colectivo de Música Electrónica AVICCI
(22, 12007), -- Escultores Locales en Escuela de Cultura MAMBO
(22, 12016), -- Escultores Locales en Grupo de Baile de Salsa Ciudad Blanca 
(22, 12022), -- Escultores Locales en Grupo de Baile de Hip-Hop Ciudad EMINEM
(28, 12017), -- Bailarines de Salsa Locales en Grupo de Baile de Salsa Ciudad Blanca
(28, 12018), -- Bailarines de Salsa Locales en Grupo de Baile de Tango de Medellín
(28, 12019), -- Bailarines de Salsa Locales en Compañía de Danza Contemporánea DANCONBO
(28, 12021), -- Bailarines de Salsa Locales en Grupo de Baile de Hip-Hop Ciudad EMINEM  #Hasta aquí todo bien
(31, 12000),  -- Salsunal en Ballet Clásico de Viena
(31, 12010), -- Salsunal en Compañía de Danzas Folclóricas del Llano
(31, 12020), -- Salsunal en Compañía de Danza Contemporánea DANCONBO
(34, 12000),  -- Grupos de Danza Folclórica en Ballet Clásico de Viena
(34, 12009), -- Grupos de Danza Folclórica en Compañía de Danzas Folclóricas del Llano
(34, 12018), -- Grupos de Danza Folclórica en Compañía de Danza Contemporánea DANCONBO
(34, 12021); -- Grupos de Danza Folclórica en Grupo de Baile de Hip-Hop Ciudad EMINEM


-- Insertar datos en la tabla ACTIVIDAD_INVESTIGACION
INSERT INTO ACTIVIDAD_INVESTIGACION (INV_CODIGO, INV_NOMBRE_GRUPO, INV_RECURSOS, INV_PATROCINADOR) VALUES
(11, 'Grupo de Investigación en Ciencias Naturales', 50000, 'Fundación Ciencia y Vida'),
(12, 'Grupo Interdisciplinario de Investigación', 30000, 'Empresa Innovadora S.A.');

-- Insertamos los datos en la talba de ACTIVIDAD_EMPRENDIMIENTO
INSERT INTO ACTIVIDAD_EMPRENDIMIENTO (AEMP_CODIGO, AEMP_EMPRESA, AEMP_INVITADOS, AEMP_EQUIPOS) VALUES
(8, "Departamento de Vinculación", "Empresas de telecomunicaciones","Proyector"),
(9, 'Centro de Emprendimiento', 'Empresas emergentes', 'Proyector, Computadoras'),
(10, 'Prof. Mario Sánchez', 'Expertos en innovación', 'Tabletas, Pizarras electrónicas'),
(15, "Universidad Nacional, Incubadora de Empresas", "Amazon Start Ups","Proyectores, computadoras, Sistemas de audio"),
(23, "Centro de Emprendimiento", "McDonalds", "Laptops,Sistema de audio"),
(25, 'Prof. Clara Mejía', 'Inversores, Mentores', 'Laptops, Software de diseño'),
(35, 'Centro de Emprendimiento', 'Directivos de empresas', 'Proyector, Sistemas de audio');


#Añadimos los datos de la tabla CONVOCATORIA
-- Inserción de datos adicionales en la tabla CONVOCATORIA
INSERT INTO CONVOCATORIA (CON_FECHA_INICIO, CON_FECHA_CIERRE, CON_NUMERO_CUPOS, CON_ACTIVIDAD) VALUES
('2024-06-01 10:00:00', '2024-06-15 12:00:00', 40, 12),  -- Encuentro de Grupos de Investigación
('2024-06-16 10:00:00', '2024-07-01 12:00:00', 150, 13),  -- Conferencia sobre Robótica
('2024-06-20 09:00:00', '2024-07-15 17:00:00', 300, 14),  -- Feria de Proyectos Estudiantiles
('2024-06-15 11:00:00', '2024-06-30 13:00:00', 25, 15),  -- Taller de Escritura Creativa
('2024-07-21 19:00:00', '2024-08-10 21:00:00', 150, 16),  -- Concierto de Jazz
('2024-06-06 14:00:00', '2024-06-20 16:00:00', 20, 17),  -- Clase Magistral de Fotografía
('2024-07-01 10:00:00', '2024-07-15 12:00:00', 100, 18),  -- Seminario sobre Energías Renovables
('2024-06-27 09:00:00', '2024-07-20 17:00:00', 400, 19),  -- Feria de Innovación y Tecnología
('2024-07-10 13:00:00', '2024-07-25 15:00:00', 80, 20),  -- Encuentro de Egresados de Medicina
('2024-07-05 16:00:00', '2024-07-20 18:00:00', 15, 21),  -- Taller de Escultura
('2024-08-02 11:00:00', '2024-08-16 13:00:00', 100, 22),  -- Charla sobre Marketing Digital
('2024-08-01 10:00:00', '2024-08-15 12:00:00', 150, 23),  -- Conferencia sobre Big Data
('2024-06-26 14:00:00', '2024-07-10 16:00:00', 50, 24),  -- Taller de Creación de Startups
('2024-08-04 09:00:00', '2024-08-20 17:00:00', 600, 25),  -- Feria de Empleo de Ingeniería
('2024-08-12 09:00:00', '2024-08-27 17:00:00', 500, 26),  -- Feria de Empleo de Ciencias Sociales
('2024-09-01 09:00:00', '2024-09-15 17:00:00', 700, 27),  -- Feria de Empleo de Tecnología
('2024-08-22 14:00:00', '2024-09-05 16:00:00', 40, 28),  -- Taller de Programación Avanzada
('2024-08-04 11:00:00', '2024-08-18 13:00:00', 120, 29),  -- Conferencia sobre Neurociencia
('2024-07-23 16:00:00', '2024-08-06 18:00:00', 20, 30),  -- Taller de Salsa
('2024-06-16 15:00:00', '2024-07-01 17:00:00', 80, 31),  -- Charla de Experiencias Profesionales
('2024-05-27 10:00:00', '2024-06-10 12:00:00', 100, 32),  -- Seminario sobre Derechos Humanos
('2024-05-24 18:00:00', '2024-06-07 20:00:00', 30, 33),  -- Clase Magistral de Danza Folclórica
('2024-08-15 13:00:00', '2024-08-30 15:00:00', 100, 34),  -- Charla sobre Responsabilidad Social Empresarial
('2024-09-10 10:00:00', '2024-09-24 12:00:00', 200, 35);  -- Conferencia de Inteligencia Artificial
 







####--------------------------DATOS DE EMPRESAS Y EMPLEO -------------------------------
INSERT INTO DIRECTORIO_EMPRESA(DIR_NOMBRE,DIR_TIPO_EMPRESA,DIR_MERCADO) VALUE
("EgresadosIngenieria","Egresados","Ingenieria"),
("PracticasIngenieria","Estudiantes","Ingenieria"),
("EgresadosEconomia","Egresados","Economia"),
("PracticasEconomia","Estudiantes","Economia"),
("EgresadosMedicina","Egresados","Medicina"),
("EgresadosCiencias","Egresados","Ciencias"),
("PracticasCiencias","Estudiantes","Ciencias"),
("EgresadosDerecho","Egresados","Derecho"),
("PracticasDerecho","Estudiantes","Derecho"),
("EgresadosArtes","Egresados","Artes"),
("PracticasArtes","Estudiantes","Artes")
;



INSERT INTO EMPRESA (EMP_NIT, EMP_RAZON_SOCIAL, EMP_UBICACION, EMP_PERSONA_DE_CONTACTO, EMP_HORARIO, EMP_MISION, EMP_VISION, EMP_ANNO_CREACION, EMP_DIRECTORIO) VALUES
(123456789, 'Empresa A', 'Calle 123, Ciudad A', 'Juan Perez', 8, 'Proporcionar soluciones tecnológicas innovadoras', 'Ser líderes en el mercado tecnológico', 2005, "EgresadosIngenieria"),
(234567890, 'Empresa B', 'Avenida 456, Ciudad B', 'Maria Rodriguez', 9, 'Ofrecer servicios financieros de calidad', 'Ser la institución financiera más confiable', 2010, 'EgresadosEconomia'),
(345678901, 'Empresa C', 'Carrera 789, Ciudad C', 'Pedro Martinez', 7, 'Proveer productos de belleza naturales', 'Promover el cuidado de la piel de forma sostenible', 2008, 'EgresadosMedicina'),
(456789012, 'Empresa D', 'Calle 012, Ciudad D', 'Ana Gomez', 8, 'Desarrollar soluciones educativas innovadoras', 'Ser reconocidos como líderes en educación virtual', 2012, 'EgresadosCiencias'),
(567890123, 'Empresa E', 'Avenida 123, Ciudad E', 'Carlos Fernandez', 9, 'Fabricar productos de limpieza ecológicos', 'Ser la empresa número uno en limpieza sostenible', 2007, 'EgresadosCiencias'),
(678901234, 'Empresa F', 'Carrera 234, Ciudad F', 'Laura Sanchez', 7, 'Brindar servicios de consultoría empresarial', 'Ser la consultora más confiable y efectiva', 2015, 'PracticasDerecho'),
(789012345, 'Empresa G', 'Calle 345, Ciudad G', 'Luis Ramirez', 8, 'Proporcionar soluciones logísticas integrales', 'Ser el referente en logística eficiente', 2006, 'PracticasIngenieria'),
(890123456, 'Empresa H', 'Avenida 456, Ciudad H', 'Sofia Lopez', 9, 'Ofrecer servicios de marketing digital', 'Ser la agencia líder en estrategias digitales', 2018, 'PracticasCiencias'),
(901234567, 'Empresa I', 'Carrera 567, Ciudad I', 'Diego Gonzalez', 7, 'Desarrollar software a medida', 'Ser reconocidos por nuestras soluciones innovadoras', 2009, 'EgresadosIngenieria'),
(112233445, 'Empresa J', 'Calle 678, Ciudad J', 'Camila Hernandez', 8, 'Producir alimentos orgánicos', 'Fomentar la alimentación saludable y sostenible', 2014, "EgresadosMedicina"),
(223344556, 'Empresa K', 'Avenida 789, Ciudad K', 'Javier Castro', 9, 'Ofrecer servicios de consultoría legal', 'Ser el referente en asesoramiento legal', 2004, 'EgresadosDerecho'),
(334455667, 'Empresa L', 'Carrera 890, Ciudad L', 'Laura Perez', 7, 'Proporcionar servicios de transporte seguro', 'Ser la empresa de transporte más confiable', 2011, 'EgresadosIngenieria'),
(445566778, 'Empresa M', 'Calle 901, Ciudad M', 'Carlos Garcia', 8, 'Fabricar productos textiles de alta calidad', 'Ser líderes en moda sostenible', 2003, 'PracticasArtes'),
(556677889, 'Empresa N', 'Avenida 012, Ciudad N', 'Valeria Rodriguez', 9, 'Brindar servicios de consultoría en recursos humanos', 'Ser la consultora más innovadora en gestión del talento', 2016, 'PracticasEconomia'),
(667788900, 'Empresa O', 'Carrera 123, Ciudad O', 'Roberto Martinez', 7, 'Desarrollar soluciones de ingeniería ambiental', 'Ser líderes en proyectos de sostenibilidad', 2013, 'EgresadosDerecho'),
(778899011, 'Empresa P', 'Calle 234, Ciudad P', 'Marcela Gomez', 8, 'Ofrecer servicios de diseño gráfico', 'Ser la agencia creativa más reconocida', 2002, 'EgresadosArtes'),
(889900122, 'Empresa Q', 'Avenida 345, Ciudad Q', 'Raul Hernandez', 9, 'Producir energía renovable', 'Ser la empresa líder en energías limpias', 2017, 'EgresadosCiencias'),
(990011233, 'Empresa R', 'Carrera 456, Ciudad R', 'Natalia Fernandez', 7, 'Proporcionar soluciones de seguridad informática', 'Ser la empresa más confiable en ciberseguridad', 2019, 'EgresadosIngenieria'),
(100112344, 'Empresa S', 'Calle 567, Ciudad S', 'Mateo Lopez', 8, 'Brindar servicios de consultoría en marketing', 'Ser la agencia de marketing más creativa', 2007, 'EgresadosArtes'),
(211223455, 'Empresa T', 'Avenida 678, Ciudad T', 'Juliana Ramirez', 9, 'Desarrollar aplicaciones móviles innovadoras', 'Ser líderes en el mercado de apps', 2012, 'EgresadosIngenieria'),
(322334566, 'Empresa U', 'Carrera 789, Ciudad U', 'Felipe Castro', 7, 'Ofrecer servicios de consultoría en gestión empresarial', 'Ser la consultora preferida por las grandes empresas', 2015, 'EgresadosEconomia'),
(433445677, 'Empresa V', 'Calle 890, Ciudad V', 'Carolina Gonzalez', 8, 'Fabricar productos electrónicos de última generación', 'Ser la marca de tecnología más innovadora', 2008, 'EgresadosCiencias'),
(544556788, 'Empresa W', 'Avenida 901, Ciudad W', 'Daniel Perez', 9, 'Desarrollar soluciones de inteligencia artificial', 'Revolucionar la industria con IA', 2011, 'PracticasIngenieria'),
(655667899, 'Empresa X', 'Carrera 012, Ciudad X', 'Valentina Hernandez', 7, 'Proporcionar servicios de consultoría en finanzas', 'Ser la consultora financiera más confiable', 2016, 'PracticasCiencias'),
(766778900, 'Empresa Y', 'Calle 123, Ciudad Y', 'Fernando Gomez', 8, 'Fabricar productos farmacéuticos de calidad', 'Mejorar la salud y el bienestar de las personas', 2005, "PracticasIngenieria" );   


INSERT INTO OFERTA_LABORAL (
    OFE_CODIGO_FERIA, OFE_EMPRESA_NIT, OFE_NOMBRE_EMPRESA, OFE_CARGO, OFE_SALARIO, OFE_EXPERIENCIA, OFE_LUGAR, OFE_MODALIDAD_TRABAJO, OFE_TIPO_CONTRATO, OFE_CARRERA
) VALUES
(2, 123456789, 'Empresa A', 'Desarrollador de Software', 3000, '2 años en desarrollo de software', 'Calle 123, Ciudad A', 'Presencial', 'Indefinido', 'Ingeniería de Sistemas o Ciencias de la computación'),
(2, 789012345, 'Empresa G', 'Gerente de Logística', 4000, '3 años en logística', 'Calle 345, Ciudad G', 'Híbrido', 'Indefinido', 'Ingeniería Industrial o matemáticas'),
(2, 890123456, 'Empresa H', 'Especialista en análisis de negocios', 3500, '2 años en análisis de negocios', 'Avenida 456, Ciudad H', 'Remoto', 'Indefinido', 'Estadística o afines'),
(14, 901234567, 'Empresa I', 'Ingeniero de Software', 3200, '2 años en desarrollo de software', 'Carrera 567, Ciudad I', 'Presencial', 'Indefinido', 'Ingeniería de Sistemas'),
(14, 112233445, 'Empresa J', 'Gerente de Producción', 4200, '3 años en producción alimentaria o de productos perecederos', 'Calle 678, Ciudad J', 'Híbrido', 'Indefinido', 'Ingeniería Agrícola o afines'),
(14, 223344556, 'Empresa K', 'Abogado Corporativo', 3800, '4 años en derecho corporativo', 'Avenida 789, Ciudad K', 'Remoto', 'Indefinido', 'Derecho'),
(20, 345678901, 'Empresa C', 'Analista de rutas', 2800, '1 año en productos en el sector logístico', 'Carrera 789, Ciudad C', 'Presencial', 'Indefinido', 'Matemáticas o Ingenieria industrial'),
(20, 556677889, 'Empresa N', 'Consultor de Recursos Humanos', 3600, '3 años en recursos humanos', 'Avenida 012, Ciudad N', 'Híbrido', 'Indefinido', 'Administración de Empresas'),
(20, 667788900, 'Empresa O', 'Ingeniero Ambiental', 3900, '2 años en ingeniería ambiental', 'Carrera 123, Ciudad O', 'Presencial', 'Indefinido', 'Ingeniería agraria, agrícola o afines'),
(25, 234567890, 'Empresa B', 'Analista Financiero', 4000, '2 años en análisis financiero', 'Avenida 456, Ciudad B', 'Presencial', 'Indefinido', 'Economía o Estadística'),
(25, 678901234, 'Empresa F', 'Consultor Empresarial', 3700, '3 años en consultoría empresarial', 'Carrera 234, Ciudad F', 'Híbrido', 'Indefinido', 'Administración de Empresas'),
(25, 100112344, 'Empresa S', 'Consultor', 3300, '2 años en consultoria', 'Calle 567, Ciudad S', 'Remoto', 'Indefinido', 'Economia o Estadística'),
(26, 567890123, 'Empresa E', 'Especialista en Sostenibilidad', 3500, '2 años en proyectos sostenibles', 'Avenida 123, Ciudad E', 'Presencial', 'Indefinido', 'Biología, Química o afines'),
(26, 889900122, 'Empresa Q', 'Ingeniero en Energías Renovables', 4100, '2 años en energías renovables', 'Avenida 345, Ciudad Q', 'Híbrido', 'Indefinido', 'Ingeniería electrica o electrónica'),
(26, 223344556, 'Empresa K', 'Consultor Legal', 3800, '4 años en derecho corporativo', 'Avenida 789, Ciudad K', 'Remoto', 'Indefinido', 'Derecho'),
(27, 789012345, 'Empresa G', 'Coordinador de Logística', 3600, '3 años en logística', 'Calle 345, Ciudad G', 'Presencial', 'Indefinido', 'Ingeniería Industrial'),
(27, 544556788, 'Empresa W', 'Desarrollador de IA', 4300, '2 años en inteligencia artificial', 'Avenida 901, Ciudad W', 'Híbrido', 'Indefinido', 'Ingeniería de Sistemas o Ciencias de la computación'),
(27, 766778900, 'Empresa Y', 'Químico Farmacéutico', 4000, '3 años en farmacia', 'Calle 123, Ciudad Y', 'Presencial', 'Indefinido', 'Química, Química farmaceutica o Ingeniería química'),
(2, 901234567, 'Empresa I', 'Ingeniero de Software', 3200, '2 años en desarrollo de software', 'Carrera 567, Ciudad I', 'Presencial', 'Indefinido', 'Ingeniería agronoma, ingeneria agrícola o ingeniería química'),
(2, 112233445, 'Empresa J', 'Gerente de Producción', 4200, '3 años en producción alimentaria', 'Calle 678, Ciudad J', 'Híbrido', 'Indefinido', 'Ingeniería agronoma, ingenieria agrícola o ingenieria química'),
(20, 223344556, 'Empresa K', 'Abogado Corporativo', 3800, '4 años en derecho corporativo', 'Avenida 789, Ciudad K', 'Remoto', 'Indefinido', 'Derecho'),
(20, 345678901, 'Empresa C', 'Asesor de servicios financieros', 2800, '1 año en análisis de productos financieros', 'Carrera 789, Ciudad C', 'Presencial', 'Indefinido', 'Estadística o matemáticas'),
(26, 556677889, 'Empresa N', 'Consultor de Recursos Humanos', 3600, '3 años en recursos humanos', 'Avenida 012, Ciudad N', 'Híbrido', 'Indefinido', 'Administración de Empresas'),
(27, 667788900, 'Empresa O', 'Ingeniero Ambiental', 3900, '2 años en ingeniería ambiental', 'Carrera 123, Ciudad O', 'Presencial', 'Indefinido', 'Ingeniería Agronoma o afines'),
(27, 234567890, 'Empresa B', 'Analista Financiero', 4000, '2 años en análisis financiero', 'Avenida 456, Ciudad B', 'Presencial', 'Indefinido', 'Economía'),
(2, 678901234, 'Empresa F', 'Consultor Empresarial', 3700, '3 años en consultoría empresarial', 'Carrera 234, Ciudad F', 'Híbrido', 'Indefinido', 'Administración de Empresas');

INSERT INTO POSTULACION (POS_CEDULA, POS_FECHA, POS_ID_OFERTA) VALUES
(4686621, '2024-04-23', 5000001),
(4686621, '2024-05-10', 5000013),
(6451328, '2024-03-20', 5000002),
(6833215, '2024-05-15', 5000003),
(7468231, '2024-03-14', 5000004),
(8037070, '2024-04-01', 5000005),
(9786213, '2024-03-27', 5000006),
(10062621, '2024-03-17', 5000007),
(15083215, '2024-05-05', 5000008),
(78453628, '2024-03-29', 5000009),
(80345678, '2024-05-12', 5000010),
(81234567, '2024-04-07', 5000011),
(81234567, '2024-05-18', 5000018),
(91548723, '2024-03-24', 5000012),
(92345678, '2024-05-08', 5000013),
(93456789, '2024-04-18', 5000014),
(94537284, '2024-04-10', 5000015),
(94738265, '2024-04-22', 5000016),
(94876234, '2024-04-02', 5000017),
(95382746, '2024-05-18', 5000018),
(97234567, '2024-04-06', 5000019),
(97234567, '2024-05-20', 5000025),
(15678901, '2024-05-16', 5000020),
(356789012, '2024-04-12', 5000021),
(456890123, '2024-05-03', 5000022),
(567901234, '2024-03-18', 5000023),
(678012345, '2024-05-09', 5000024),
(790123456, '2024-03-15', 5000025),
(890234567, '2024-04-09', 5000001),
(890234567, '2024-05-19', 5000019),
(1234567890, '2024-03-22', 5000002);


select * from servicios; 
INSERT INTO ACCESO (ACC_CODIGO_SERVICIO, ACC_CEDULA, ACC_FECHA) VALUES
(2024051, 4686621, '2024-04-15 10:15:00'),
(2024052, 6451328, '2024-03-22 14:30:00'),
(2024053, 6833215, '2024-05-02 09:45:00'),
(2024054, 7468231, '2024-03-30 11:00:00'),
(2024055, 8037070, '2024-04-10 16:20:00'),
(2024056, 9786213, '2024-04-25 13:15:00'),
(2024057, 10062621, '2024-03-18 15:45:00'),
(2024051, 15083215, '2024-05-12 08:30:00'),
(2024052, 60420141, '2024-04-17 10:00:00'),
(2024053, 67823459, '2024-03-28 12:45:00'),
(2024054, 71234567, '2024-05-03 14:30:00'),
(2024055, 72345678, '2024-04-20 11:45:00'),
(2024056, 72345689, '2024-04-25 09:00:00'),
(2024057, 72364578, '2024-05-07 16:30:00'),
(2024051, 72456780, '2024-04-05 10:15:00'),
(2024052, 72456789, '2024-05-15 11:30:00'),
(2024053, 73234567, '2024-03-22 14:00:00'),
(2024054, 73235678, '2024-04-08 12:00:00'),
(2024055, 73456789, '2024-05-18 09:30:00'),
(2024056, 74345678, '2024-04-12 15:00:00'),
(2024057, 74385692, '2024-03-19 16:00:00'),
(2024051, 75234567, '2024-04-21 13:00:00'),
(2024052, 75235678, '2024-05-10 10:30:00'),
(2024053, 75323456, '2024-04-30 12:30:00'),
(2024054, 75345678, '2024-03-25 11:15:00'),
(2024055, 75346780, '2024-04-14 14:15:00'),
(2024056, 75346789, '2024-05-04 10:45:00'),
(2024057, 76234568, '2024-03-21 09:30:00'),
(2024051, 76248593, '2024-04-11 15:30:00'),
(2024052, 76345678, '2024-05-08 08:45:00'),
(2024053, 76823495, '2024-04-28 14:00:00'),
(2024054, 78346578, '2024-03-27 13:45:00'),
(2024055, 78453628, '2024-05-05 11:00:00'),
(2024056, 78456234, '2024-04-19 12:45:00'),
(2024057, 78456789, '2024-03-29 16:15:00'),
(2024051, 78923485, '2024-04-03 14:45:00'),
(2024052, 79345678, '2024-05-09 10:15:00'),
(2024053, 79345679, '2024-03-24 11:30:00'),
(2024054, 79456789, '2024-04-13 12:15:00'),
(2024055, 80345678, '2024-05-01 09:15:00'),
(2024056, 81234567, '2024-03-26 13:00:00'),
(2024057, 81234568, '2024-04-09 15:45:00'),
(2024051, 81234569, '2024-05-06 11:45:00'),
(2024052, 81235678, '2024-04-02 10:30:00'),
(2024053, 81235679, '2024-03-23 14:15:00'),
(2024054, 81235680, '2024-04-24 13:15:00'),
(2024055, 82345678, '2024-05-14 16:00:00'),
(2024056, 82456789, '2024-03-20 11:15:00'),
(2024057, 82573468, '2024-04-18 15:15:00'),
(2024051, 4686621, '2024-05-01 09:15:00'),
(2024052, 6451328, '2024-05-05 11:00:00'),
(2024053, 6833215, '2024-04-30 13:45:00'),
(2024054, 7468231, '2024-05-03 14:30:00'),
(2024055, 8037070, '2024-04-25 10:00:00'),
(2024056, 9786213, '2024-04-28 12:15:00'),
(2024057, 10062621, '2024-04-29 15:30:00'),
(2024051, 15083215, '2024-05-06 16:45:00'),
(2024052, 67823459, '2024-05-07 09:30:00'),
(2024053, 72345689, '2024-05-08 11:00:00'),
(2024054, 72364578, '2024-05-09 14:15:00'),
(2024055, 72456789, '2024-05-10 12:30:00'),
(2024056, 73456789, '2024-05-11 15:45:00'),
(2024057, 74385692, '2024-05-12 10:00:00'),
(2024051, 75234567, '2024-05-13 11:30:00'),
(2024052, 75323456, '2024-05-14 14:45:00'),
(2024053, 76248593, '2024-05-15 16:00:00'),
(2024054, 76345678, '2024-05-16 09:15:00'),
(2024055, 76823495, '2024-05-17 11:30:00'),
(2024056, 78346578, '2024-05-18 14:45:00'),
(2024057, 78453628, '2024-05-19 16:00:00'),
(2024051, 78456234, '2024-05-20 10:15:00'),
(2024052, 78923485, '2024-05-21 11:30:00'),
(2024053, 80345678, '2024-05-22 14:45:00'),
(2024054, 81234567, '2024-05-23 16:00:00'),
(2024055, 81234568, '2024-05-24 09:15:00'),
(2024056, 81235678, '2024-05-25 11:30:00');


INSERT INTO APLICACION (APL_CODIGO, APL_IDENTIFICACION, APL_TIPO_DOCUMENTO, APL_FECHA_APLICACION) VALUES
(65401, 92345678, 'Cedula de ciudadania', '2024-05-01 10:30:00'),
(65402, 93456789, 'Cedula de ciudadania', '2024-05-02 11:45:00'),
(65403, 94537284, 'Cedula de ciudadania', '2024-05-03 09:15:00'),
(65404, 94582734, 'Cedula de ciudadania', '2024-05-04 13:20:00'),
(65405, 94738265, 'Cedula de ciudadania', '2024-05-05 14:00:00'),
(65406, 94876234, 'Cedula de ciudadania', '2024-05-06 12:30:00'),
(65407, 95382746, 'Cedula de ciudadania', '2024-05-07 10:45:00'),
(65408, 97234567, 'Cedula de ciudadania', '2024-05-08 11:00:00'),
(65409, 356789012, 'Cedula de extranjeria', '2024-05-09 15:30:00'),
(65410, 456890123, 'Cedula de extranjeria', '2024-05-10 16:45:00'),
(65411, 567901234, 'Cedula de extranjeria', '2024-05-11 09:00:00'),
(65412, 678012345, 'Cedula de extranjeria', '2024-05-12 14:10:00'),
(65413, 790123456, 'Cedula de extranjeria', '2024-05-13 10:20:00'),
(65414, 890234567, 'Cedula de extranjeria', '2024-05-14 12:40:00'),
(65415, 1234567890, 'Cedula de extranjeria', '2024-05-15 08:30:00'),
(65416, 22345566, 'Cedula de extranjeria', '2024-05-16 11:15:00'),
(65417, 71234567, 'Cedula de ciudadania', '2024-05-17 13:25:00'),
(65418, 72345678, 'Cedula de ciudadania', '2024-05-18 14:50:00'),
(65419, 72456780, 'Cedula de ciudadania', '2024-05-19 09:40:00'),
(65420, 73234567, 'Cedula de ciudadania', '2024-05-20 10:55:00'),
(65421, 73235678, 'Cedula de ciudadania', '2024-05-21 11:30:00'),
(65422, 74345678, 'Cedula de ciudadania', '2024-05-22 12:15:00'),
(65423, 75235678, 'Cedula de ciudadania', '2024-05-23 13:00:00'),
(65424, 75345678, 'Cedula de ciudadania', '2024-05-24 14:05:00'),
(65401, 75346780, 'Cedula de ciudadania', '2024-05-01 09:45:00'),
(65402, 75346789, 'Cedula de ciudadania', '2024-05-02 10:00:00'),
(65403, 76234568, 'Cedula de ciudadania', '2024-05-03 14:20:00'),
(65404, 78456789, 'Cedula de ciudadania', '2024-05-04 09:35:00'),
(65405, 79345678, 'Cedula de ciudadania', '2024-05-05 12:50:00'),
(65406, 79345679, 'Cedula de ciudadania', '2024-05-06 11:10:00'),
(65407, 79456789, 'Cedula de ciudadania', '2024-05-07 14:30:00'),
(65408, 81234569, 'Cedula de ciudadania', '2024-05-08 10:20:00'),
(65409, 81235679, 'Cedula de ciudadania', '2024-05-09 11:40:00'),
(65410, 81235680, 'Cedula de ciudadania', '2024-05-10 15:00:00'),
(65411, 82345678, 'Cedula de ciudadania', '2024-05-11 10:55:00'),
(65412, 82456789, 'Cedula de ciudadania', '2024-05-12 13:20:00'),
(65413, 83456780, 'Cedula de ciudadania', '2024-05-13 09:15:00'),
(65414, 83456789, 'Cedula de ciudadania', '2024-05-14 12:00:00'),
(65415, 83456790, 'Cedula de ciudadania', '2024-05-15 14:45:00'),
(65416, 83456791, 'Cedula de ciudadania', '2024-05-16 16:10:00'),
(65417, 84345679, 'Cedula de ciudadania', '2024-05-17 10:20:00'),
(65418, 84356789, 'Cedula de ciudadania', '2024-05-18 11:30:00'),
(65419, 85234567, 'Cedula de ciudadania', '2024-05-19 12:40:00');




## DATOS TABLAS ADMINISTRATIVAS
INSERT INTO COMITE(COMI_NOMBRE,COMI_LUGAR) VALUES 
("Bienestar", "Rectoria"),
("Egresados","Oficina de egresados"),
("Academico","Oficina central Edificio Ciencias"),
("Investigativo","CyT"),
("Etica","Registro y matrícula");

INSERT INTO ACTA (ACTA_FECHA, ACTA_COMITE) VALUES
('2024-05-01 00:00:00', 3500),  -- Acta de apoyo económico por el Comité de Bienestar
('2024-05-05 00:00:00', 3500),  -- Acta de apoyo alimenticio por el Comité de Bienestar
('2024-04-30 00:00:00', 3500),  -- Acta de apoyo psicológico por el Comité de Bienestar
('2024-05-03 00:00:00', 3500),  -- Acta de apoyo físico por el Comité de Bienestar
('2024-04-25 00:00:00', 3502),  -- Acta académica por el Comité Académico
('2024-04-28 00:00:00', 3502),  -- Acta de intercambio estudiantil por el Comité Académico
('2024-04-29 00:00:00', 3502),  -- Acta general académica por el Comité Académico
('2024-05-06 00:00:00', 3503),  -- Acta de publicación de trabajos investigativos por el Comité Investigativo
('2024-05-07 00:00:00', 3503),  -- Acta de verificación de laboratorios por el Comité Investigativo
('2024-05-08 00:00:00', 3503),  -- Acta de gestión de recursos para investigación por el Comité Investigativo
('2024-05-09 00:00:00', 3504),  -- Acta de asuntos éticos por el Comité de Ética
('2024-05-10 00:00:00', 3504),  -- Acta de ética académica por el Comité de Ética
('2024-05-11 00:00:00', 3504),  -- Acta de ética administrativa por el Comité de Ética
('2024-05-12 00:00:00', 3504),  -- Acta de ética investigativa por el Comité de Ética
('2024-05-13 00:00:00', 3500),  -- Acta de seguimiento económico por el Comité de Bienestar
('2024-05-14 00:00:00', 3502),  -- Acta de revisión de programas académicos por el Comité Académico
('2024-05-15 00:00:00', 3503),  -- Acta de auditoría de proyectos de investigación por el Comité Investigativo
('2024-05-16 00:00:00', 3504),  -- Acta de revisión de políticas éticas por el Comité de Ética
('2024-05-17 00:00:00', 3500),  -- Acta de atención alimenticia por el Comité de Bienestar
('2024-05-18 00:00:00', 3502),  -- Acta de aprobación de becas por el Comité Académico
('2024-05-19 00:00:00', 3503),  -- Acta de control de calidad de investigaciones por el Comité Investigativo
('2024-05-20 00:00:00', 3504),  -- Acta de análisis de casos éticos por el Comité de Ética
('2024-05-21 00:00:00', 3500),  -- Acta de seguimiento psicológico por el Comité de Bienestar
('2024-05-22 00:00:00', 3502),  -- Acta de evaluación de docentes por el Comité Académico
('2024-05-23 00:00:00', 3503),  -- Acta de asignación de recursos para proyectos por el Comité Investigativo
('2024-05-24 00:00:00', 3504),  -- Acta de seguimiento de normativas éticas por el Comité de Ética
('2024-05-25 00:00:00', 3500),  -- Acta de seguimiento físico por el Comité de Bienestar
('2024-05-26 00:00:00', 3502),  -- Acta de coordinación de seminarios académicos por el Comité Académico
('2024-05-27 00:00:00', 3503),  -- Acta de revisión de solicitudes de fondos por el Comité Investigativo
('2024-05-28 00:00:00', 3504), -- Acta de evaluación de conducta ética por el Comité de Ética
('2024-05-29 00:00:00', 3500), -- Acta de seguimiento económico por el Comité de Bienestar
('2024-05-30 00:00:00', 3502), -- Acta de gestión de programas de formación por el Comité Académico
('2024-06-01 00:00:00', 3503), -- Acta de gestión de equipos de investigación por el Comité Investigativo
('2024-06-02 00:00:00', 3504), -- Acta de capacitación en ética por el Comité de Ética
('2024-06-03 00:00:00', 3500), -- Acta de seguimiento alimenticio por el Comité de Bienestar
('2024-06-04 00:00:00', 3502), -- Acta de revisión de planes de estudio por el Comité Académico
('2024-06-05 00:00:00', 3503), -- Acta de gestión de publicaciones científicas por el Comité Investigativo
('2024-06-06 00:00:00', 3504), -- Acta de análisis de casos de ética profesional por el Comité de Ética
('2024-06-07 00:00:00', 3500), -- Acta de seguimiento psicológico por el Comité de Bienestar
('2024-06-08 00:00:00', 3502), -- Acta de gestión de prácticas profesionales por el Comité Académico
('2024-06-09 00:00:00', 3503); -- Acta de revisión de políticas de investigación por el Comité Investigativo




INSERT INTO DISTINCION (DISTI_ACTA, DISTI_TIPO_IDENTIFICACION, DISTI_NUM_IDENTIFICACION, DISTI_NOMBRE, DISTI_TIPO_DISTINCION) VALUES
(14569703, 'Cedula de ciudadania', 4686621, 'Distincion Academica', 'Academica'),
(14569704, 'Cedula de ciudadania', 6451328, 'Distincion Investigativa', 'Investigativa'),
(14569705, 'Cedula de ciudadania', 6833215, 'Distincion de Emprendimiento', 'Emprendimiento'),
(14569706, 'Cedula de ciudadania', 7468231, 'Distincion de Impacto Social', 'Impacto Social'),
(14569707, 'Cedula de ciudadania', 8037070, 'Distincion Academica', 'Academica'),
(14569708, 'Cedula de ciudadania', 9786213, 'Distincion Investigativa', 'Investigativa'),
(14569709, 'Cedula de ciudadania', 10062621, 'Distincion de Emprendimiento', 'Emprendimiento'),
(14569710, 'Cedula de ciudadania', 15083215, 'Distincion de Impacto Social', 'Impacto Social'),
(14569711, 'Cedula de extranjeria', 15678901, 'Distincion Academica', 'Academica'),
(14569712, 'Cedula de ciudadania', 67823459, 'Distincion Investigativa', 'Investigativa'),
(14569713, 'Cedula de ciudadania', 72345689, 'Distincion de Emprendimiento', 'Emprendimiento'),
(14569714, 'Cedula de ciudadania', 72364578, 'Distincion de Impacto Social', 'Impacto Social'),
(14569715, 'Cedula de ciudadania', 72456789, 'Distincion Academica', 'Academica'),
(14569716, 'Cedula de ciudadania', 73456789, 'Distincion Investigativa', 'Investigativa'),
(14569717, 'Cedula de ciudadania', 74385692, 'Distincion de Emprendimiento', 'Emprendimiento'),
(14569718, 'Cedula de ciudadania', 75234567, 'Distincion de Impacto Social', 'Impacto Social'),
(14569719, 'Cedula de ciudadania', 75323456, 'Distincion Academica', 'Academica'),
(14569720, 'Cedula de ciudadania', 76248593, 'Distincion Investigativa', 'Investigativa'),
(14569721, 'Cedula de ciudadania', 76345678, 'Distincion de Emprendimiento', 'Emprendimiento'),
(14569722, 'Cedula de ciudadania', 76823495, 'Distincion de Impacto Social', 'Impacto Social'),
(14569723, 'Cedula de ciudadania', 78346578, 'Distincion Academica', 'Academica'),
(14569724, 'Cedula de ciudadania', 78453628, 'Distincion Investigativa', 'Investigativa'),
(14569725, 'Cedula de ciudadania', 78456234, 'Distincion de Emprendimiento', 'Emprendimiento'),
(14569726, 'Cedula de ciudadania', 78923485, 'Distincion de Impacto Social', 'Impacto Social'),
(14569727, 'Cedula de ciudadania', 80345678, 'Distincion Academica', 'Academica'),
(14569728, 'Cedula de ciudadania', 81234567, 'Distincion Investigativa', 'Investigativa');


INSERT INTO ADMINISTRATIVO_PARTICIPA_COMITE (ADPARCOM_TIPO_DOCUMENTO, ADPARCOM_NUM_DOCUMENTO, ADPARCOM_COMI_IDENTIFICADOR) VALUES
('Cedula de ciudadania', 60420141, 3500),
('Cedula de ciudadania', 147253699, 3501),
('Cedula de ciudadania', 147257411, 3502),
('Cedula de ciudadania', 147392588, 3503),
('Cedula de ciudadania', 148523699, 3504),
('Cedula de ciudadania', 149632588, 3500),
('Cedula de ciudadania', 157534866, 3501),
('Cedula de ciudadania', 190820141, 3502),
('Cedula de ciudadania', 257413699, 3503),
('Cedula de ciudadania', 258143699, 3504),
('Cedula de ciudadania', 258391477, 3500),
('Cedula de ciudadania', 258637411, 3501),
('Cedula de ciudadania', 258938522, 3502),
('Cedula de ciudadania', 287419633, 3503),
('Cedula de ciudadania', 326549877, 3504),
('Cedula de ciudadania', 369179633, 3500),
('Cedula de ciudadania', 369281477, 3501),
('Cedula de ciudadania', 369412588, 3502),
('Cedula de ciudadania', 369589633, 3503),
('Cedula de ciudadania', 369851477, 3504),
('Cedula de ciudadania', 391472588, 3500),
('Cedula de ciudadania', 456791233, 3501),
('Cedula de ciudadania', 654983211, 3502),
('Cedula de ciudadania', 741259633, 3503);

#DROP TABLE `egresados`.`acceso`, `egresados`.`actividad`, `egresados`.`actividad_academica`, `egresados`.`actividad_bolsa_empleo`, `egresados`.`actividad_emprendimiento`, `egresados`.`actividad_investigacion`, `egresados`.`actividad_sociocultural`, `egresados`.`administrativo`, `egresados`.`administrativo_participa_comite`, `egresados`.`aplicacion`, `egresados`.`comite`, `egresados`.`convocatoria`, `egresados`.`departamento`, `egresados`.`directorio_empresa`, `egresados`.`distincion`, `egresados`.`egresado`, `egresados`.`egresado_estudio_programa`, `egresados`.`empresa`, `egresados`.`estudiante`, `egresados`.`estudiante_estudio_programa`, `egresados`.`facultad`, `egresados`.`grupo_artistico`, `egresados`.`hojadevida`, `egresados`.`oferta_laboral`, `egresados`.`participacion_actsoc_gru`, `egresados`.`persona`, `egresados`.`postulacion`, `egresados`.`programa`, `egresados`.`sede`, `egresados`.`sede_brinda_servicios`, `egresados`.`servicios`, `egresados`.`acta`;
