# Poyecto entrega 2
## Grupo 14
## Juan Pablo Montaño Díaz
## Nicolas Zuluaga

CREATE SCHEMA EGRESADOS;
USE EGRESADOS;


-- Procedimiento 1: Me permite ver los egresados por el código de programa
DELIMITER //
CREATE PROCEDURE ReporteEgresadosPorPrograma(
    IN programa_id INT
)
BEGIN
    SELECT P.PER_NOMBRE, P.PER_APELLIDO, E.EGR_SEMESTRE_EGRESO
    FROM PERSONA P
    JOIN EGRESADO E ON P.PER_TIPO_DOCUMENTO = E.EGR_TIPO_DOCUMENTO AND P.PER_NUM_DOCUMENTO = E.EGR_NUM_DOCUMENTO
    JOIN EGRESADO_ESTUDIO_PROGRAMA EP ON E.EGR_TIPO_DOCUMENTO = EP.EEP_TIPO_IDENTIFICACION AND E.EGR_NUM_DOCUMENTO = EP.EEP_IDENTIFICACION
    WHERE EP.EEP_PROGRAMA = programa_id;
END//
DELIMITER ;


call ReporteEgresadosPorPrograma(10021);


-- Procedimiento 2: Para publicar una oferta laboral

drop procedure PublicarOfertaLaboral;

DELIMITER //
CREATE PROCEDURE PublicarOfertaLaboral(
    IN feria_codigo INT,
    IN empresa_nit INT,
    IN nombre_empresa VARCHAR(150),
    IN cargo VARCHAR(150),
    IN salario INT,
    IN experiencia VARCHAR(550),
    IN lugar VARCHAR(150),
    IN modalidad VARCHAR(150),
    IN tipo_contrato VARCHAR(150),
    IN carrera VARCHAR(550)
)
BEGIN
    INSERT INTO OFERTA_LABORAL (OFE_CODIGO_FERIA, OFE_EMPRESA_NIT, OFE_NOMBRE_EMPRESA, OFE_CARGO, OFE_SALARIO, OFE_EXPERIENCIA, OFE_LUGAR, OFE_MODALIDAD_TRABAJO, OFE_TIPO_CONTRATO, OFE_CARRERA)
    VALUES (feria_codigo, empresa_nit, nombre_empresa, cargo, salario, experiencia, lugar, modalidad, tipo_contrato, carrera);
END//
DELIMITER ;


call PublicarOfertaLaboral()



-- Procedimiento 3: Consultar ofertas laborales por nit

DELIMITER //
CREATE PROCEDURE ConsultarOfertasPorEmpresa(
    IN nit INT
)
BEGIN
    SELECT * FROM OFERTA_LABORAL
    WHERE OFE_EMPRESA_NIT = nit;
END//
DELIMITER ;



-- Procedimiento 4: ver egresados con los mejores promedios
drop procedure VerEgresadosConMejorPromedio;


DELIMITER //

CREATE PROCEDURE VerEgresadosConMejorPromedio()
BEGIN
    DECLARE promedio_estudiantes DECIMAL(2,1);

    -- Calcular el promedio académico ponderado acumulado (PAPA) de todos los estudiantes
    SELECT AVG(EST_PAPA) INTO promedio_estudiantes
    FROM ESTUDIANTE;

    -- Seleccionar los egresados cuyo PAPA es mayor que el promedio de los estudiantes
    SELECT concat(P.PER_NOMBRE,' ',P.PER_APELLIDO), E.EGR_PAPA
    FROM EGRESADO E
    JOIN PERSONA P ON E.EGR_TIPO_DOCUMENTO = P.PER_TIPO_DOCUMENTO AND E.EGR_NUM_DOCUMENTO = P.PER_NUM_DOCUMENTO
    WHERE E.EGR_PAPA > promedio_estudiantes;
END//

DELIMITER ;

CALL VerEgresadosConMejorPromedio();


-- Procedimiento 5 -- 

DELIMITER //

CREATE PROCEDURE VerEstudiantesConMejorPromedio()
BEGIN
    DECLARE promedio_estudiantes DECIMAL(2,1);

    -- Calcular el promedio académico ponderado acumulado (PAPA) de todos los estudiantes
    SELECT AVG(EST_PAPA) INTO promedio_estudiantes
    FROM ESTUDIANTE;

    -- Seleccionar los estudiantes cuyo PAPA es mayor que el promedio de los estudiantes
    SELECT concat(P.PER_NOMBRE,' ',P.PER_APELLIDO), S.EST_PAPA
    FROM ESTUDIANTE S
    JOIN PERSONA P ON S.EST_TIPO_DOCUMENTO = P.PER_TIPO_DOCUMENTO AND S.EST_NUM_DOCUMENTO = P.PER_NUM_DOCUMENTO
    WHERE S.EST_PAPA > promedio_estudiantes;
END//

DELIMITER ;


-- Función 1: Promedios por carrera.

drop function PromedioEstudiantesPorCarrera;

DELIMITER //

CREATE FUNCTION PromedioEstudiantesPorCarrera(
    programa_id INT
) RETURNS DECIMAL(2,1) deterministic
BEGIN
    DECLARE promedio_carrera DECIMAL(2,1);

    -- Calcular el promedio académico ponderado acumulado (PAPA) de los estudiantes de la carrera especificada
    SELECT AVG(S.EST_PAPA) INTO promedio_carrera
    FROM ESTUDIANTE S
    JOIN ESTUDIANTE_ESTUDIO_PROGRAMA ESEP ON S.EST_TIPO_DOCUMENTO = ESEP.ESEP_TIPO_IDENTIFICACION AND S.EST_NUM_DOCUMENTO = ESEP.ESEP_IDENTIFICACION
    WHERE ESEP.ESEP_PROGRAMA = programa_id;

    RETURN promedio_carrera;
END//

DELIMITER ;


SELECT PromedioEstudiantesPorCarrera(10031) AS promedio_carrera;

select * from servicios;

-- Función 2: Me dice la cantidad de estudiantes por programa

DELIMITER //

CREATE FUNCTION CantidadEstudiantesPorPrograma(
    programa_id INT
) RETURNS INT deterministic
BEGIN
    DECLARE cantidad_estudiantes INT;

    SELECT COUNT(*)
    INTO cantidad_estudiantes
    FROM ESTUDIANTE_ESTUDIO_PROGRAMA
    WHERE ESEP_PROGRAMA = programa_id;

    RETURN cantidad_estudiantes;
END//

DELIMITER ;


SELECT CantidadEstudiantesPorPrograma(10031) AS promedio_carrera;


-- Función 3: servicios

DELIMITER //

CREATE FUNCTION CantidadServiciosRegistroYMatricula(
    num_documento INT
) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE cantidad_servicios INT;

    SELECT COUNT(*) INTO cantidad_servicios
    FROM ACCESO
    JOIN SERVICIOS ON ACCESO.ACC_CODIGO_SERVICIO = SERVICIOS.SERV_CODIGO
    WHERE ACCESO.ACC_CEDULA = num_documento
    AND SERVICIOS.SERV_AREA = 'Registro y Matrícula';

    RETURN cantidad_servicios;
END//

DELIMITER ;


-- Función 4: Bienestar


DELIMITER //

CREATE FUNCTION CantidadServiciosBienestar(
    num_documento INT
) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE cantidad_servicios INT;

    SELECT COUNT(*) INTO cantidad_servicios
    FROM ACCESO
    JOIN SERVICIOS ON ACCESO.ACC_CODIGO_SERVICIO = SERVICIOS.SERV_CODIGO
    WHERE ACCESO.ACC_CEDULA = num_documento
    AND SERVICIOS.SERV_AREA = 'Bienestar';

    RETURN cantidad_servicios;
END//

DELIMITER ;



-- función 5:Secretaria


DELIMITER //

CREATE FUNCTION CantidadServiciosSecretaria(
    num_documento INT
) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE cantidad_servicios INT;

    SELECT COUNT(*) INTO cantidad_servicios
    FROM ACCESO
    JOIN SERVICIOS ON ACCESO.ACC_CODIGO_SERVICIO = SERVICIOS.SERV_CODIGO
    WHERE ACCESO.ACC_CEDULA = num_documento
    AND SERVICIOS.SERV_AREA = 'Secretaria';

    RETURN cantidad_servicios;
END//

DELIMITER ; 

-- función 6: Bibliotecas

DELIMITER //

CREATE FUNCTION CantidadServiciosBibliotecas(
    num_documento INT
) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE cantidad_servicios INT;

    SELECT COUNT(*) INTO cantidad_servicios
    FROM ACCESO
    JOIN SERVICIOS ON ACCESO.ACC_CODIGO_SERVICIO = SERVICIOS.SERV_CODIGO
    WHERE ACCESO.ACC_CEDULA = num_documento
    AND SERVICIOS.SERV_AREA = 'Departamento de bibliotecas';

    RETURN cantidad_servicios;
END//

DELIMITER ; 

