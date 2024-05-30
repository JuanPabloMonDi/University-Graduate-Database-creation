# Poyecto entrega 2
## Grupo 14
## Juan Pablo Montaño Díaz
## Nicolas Zuluaga Galindo


-- Crear usuarios
CREATE USER 'Estudiante'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'Egresado'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'Administrativo'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'Empresa'@'localhost' IDENTIFIED BY '1234';

-- Crear perfil
CREATE ROLE 'estudiante';
CREATE ROLE 'egresado';
CREATE ROLE 'administrativo';
CREATE ROLE 'empresa';

-- Asignar permisos a los roles

-- Vista 1: Registro y matricula 
GRANT SELECT ON EGRESADOS.G14View1 TO 'estudiante';
GRANT SELECT ON EGRESADOS.G14View1 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View1 TO 'administrativo';

-- Vista 2: Orientación Ocupacional
GRANT SELECT ON EGRESADOS.G14View2 TO 'estudiante';
GRANT SELECT ON EGRESADOS.G14View2 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View2 TO 'administrativo';

-- Vista 3: Secretaria
GRANT SELECT ON EGRESADOS.G14View3 TO 'estudiante';
GRANT SELECT ON EGRESADOS.G14View3 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View3 TO 'administrativo';

-- Vista 4: Bibliotecas

GRANT SELECT ON EGRESADOS.G14View4 TO 'estudiante';
GRANT SELECT ON EGRESADOS.G14View4 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View4 TO 'administrativo';

-- Vista 5: Actividades acádemicas

GRANT SELECT ON EGRESADOS.G14View5 TO 'estudiante';
GRANT SELECT ON EGRESADOS.G14View5 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View5 TO 'administrativo';

-- Vista 6: Actividades Emprendimiento

GRANT SELECT ON EGRESADOS.G14View6 TO 'estudiante';
GRANT SELECT ON EGRESADOS.G14View6 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View6 TO 'administrativo';

-- Vista 7: Actividades Investigación

GRANT SELECT ON EGRESADOS.G14View7 TO 'estudiante';
GRANT SELECT ON EGRESADOS.G14View7 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View7 TO 'administrativo';

-- Vista 8: Actividades Sociocultural

GRANT SELECT ON EGRESADOS.G14View8 TO 'estudiante';
GRANT SELECT ON EGRESADOS.G14View8 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View8 TO 'administrativo';

-- Vista 9: Ofertas laborales

GRANT SELECT ON EGRESADOS.G14View9 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View9 TO 'empresa';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View9 TO 'administrativo';

-- Vista 10: Distinciones

GRANT SELECT ON EGRESADOS.G14View10 TO 'estudiante';
GRANT SELECT ON EGRESADOS.G14View10 TO 'egresado';
GRANT SELECT, INSERT, UPDATE, DELETE ON EGRESADOS.G14View10 TO 'administrativo';


-- Procedimientos y Funciones

-- Procedimiento 1 
GRANT EXECUTE ON PROCEDURE EGRESADOS.G14PA1 TO 'administrativo';

-- Procedimiento 2
GRANT EXECUTE ON PROCEDURE EGRESADOS.G14P2 TO 'administrativo';
GRANT EXECUTE ON PROCEDURE EGRESADOS.G14P2 TO 'empresa';

-- Procedimiento 3
GRANT EXECUTE ON PROCEDURE EGRESADOS.G14P3 TO 'administrativo';
GRANT EXECUTE ON PROCEDURE EGRESADOS.G14P3 TO 'egresado';

-- Procedimiento 4
GRANT EXECUTE ON PROCEDURE EGRESADOS.G14P4 TO 'administrativo';

-- Procedimiento 5
GRANT EXECUTE ON PROCEDURE EGRESADOS.G14P5 TO 'administrativo';

-- Función 1
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F1 TO 'administrativo';

-- Función 2
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F2 TO 'administrativo';

-- Función 3
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F3 TO 'administrativo';
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F3 TO 'estudiante';
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F3 TO 'egresado';

-- Función 4
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F4 TO 'administrativo';
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F4 TO 'estudiante';
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F4 TO 'egresado';

-- Función 5
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F5 TO 'administrativo';
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F5 TO 'estudiante';
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F5 TO 'egresado';

-- Función 6
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F6 TO 'administrativo';
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F6 TO 'estudiante';
GRANT EXECUTE ON FUNCTION EGRESADOS.G14F6 TO 'egresado';



-- Asignar roles a los usuarios
GRANT 'estudiante' TO 'Estudiante'@'localhost';
GRANT 'egresado' TO 'Egresado'@'localhost';
GRANT 'administrativo' TO 'Administrativo'@'localhost';
GRANT 'empresa' TO 'Empresa'@'localhost';



