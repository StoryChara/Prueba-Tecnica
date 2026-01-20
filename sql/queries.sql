-- PREGUNTA 1: ¿Cuántos docentes activos hay en la Facultad de Ingeniería?
SELECT
  COUNT(*) AS total_docentes_activos
FROM
  docentes
WHERE
  estado = 'activo';

-- PREGUNTA 2: ¿Cuáles son los cursos que se dictaron en un periodo dado?
SET
  @periodo_buscar = '2025-1';

SELECT
  *
FROM
  v_cursos_por_periodo
WHERE
  periodo = @periodo_buscar
ORDER BY
  codigo_curso,
  horario;

-- PREGUNTA 3: ¿Cuál es la lista de estudiantes para el periodo actual?
SELECT
  codigo_estudiante,
  estudiante,
  email_estudiante,
  codigo_curso,
  curso,
  docente,
  horario,
  aula
FROM
  v_matriculas_detalle
WHERE
  estado_periodo = 'actual'
  AND estado_matricula = 'matriculado'
ORDER BY
  codigo_estudiante,
  codigo_curso;

-- PREGUNTA 4: ¿Cuál es el promedio de calificaciones obtenidas en un curso los últimos 5 años?
SET
  @codigo_curso_buscar = 'BDD301';

SET
  @anios = 5;

SELECT
  codigo_curso,
  curso,
  periodo,
  SUBSTRING(periodo, 1, 4) AS anio,
  SUBSTRING(periodo, -1) AS semestre,
  COUNT(*) AS total_estudiantes,
  ROUND(AVG(promedio_final), 2) AS promedio_ponderado
FROM
  v_promedios_estudiantes
WHERE
  codigo_curso = @codigo_curso_buscar
  AND SUBSTRING(periodo, 1, 4) >= YEAR(CURDATE()) - @anios
GROUP BY
  codigo_curso,
  curso,
  periodo
ORDER BY
  anio DESC,
  semestre DESC;

-- PREGUNTA 5: ¿Cuál sería el procedimiento para crear un nuevo curso y asignarle un docente?
DELIMITER $ $ CREATE PROCEDURE sp_crear_curso_y_asignar_docente(
  IN p_codigo_curso VARCHAR(20),
  IN p_nombre_curso VARCHAR(150),
  IN p_descripcion TEXT,
  IN p_creditos INT,
  IN p_id_docente INT,
  IN p_id_periodo INT,
  IN p_cupo_maximo INT,
  IN p_horario TEXT,
  IN p_aula VARCHAR(50),
  OUT p_id_curso_creado INT,
  OUT p_id_asignacion_creada INT,
  OUT p_mensaje VARCHAR(500)
) BEGIN DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
SET
  p_mensaje = 'ERROR: Ha ocurrido un error en el procedimiento.';

ROLLBACK;

END;

START TRANSACTION;

IF EXISTS (
  SELECT
    1
  FROM
    cursos
  WHERE
    codigo_curso = p_codigo_curso
) THEN
SET
  p_mensaje = CONCAT(
    'ERROR: El código de curso ',
    p_codigo_curso,
    ' ya existe.'
  );

ROLLBACK;

ELSEIF NOT EXISTS (
  SELECT
    1
  FROM
    docentes
  WHERE
    id_docente = p_id_docente
    AND estado = 'activo'
) THEN
SET
  p_mensaje = 'ERROR: El docente no existe o está inactivo.';

ROLLBACK;

ELSEIF NOT EXISTS (
  SELECT
    1
  FROM
    periodos_academicos
  WHERE
    id_periodo = p_id_periodo
) THEN
SET
  p_mensaje = 'ERROR: El periodo académico no existe.';

ROLLBACK;

ELSE
INSERT INTO
  cursos (
    codigo_curso,
    nombre,
    descripcion,
    creditos,
    estado
  )
VALUES
  (
    p_codigo_curso,
    p_nombre_curso,
    p_descripcion,
    p_creditos,
    'activo'
  );

SET
  p_id_curso_creado = LAST_INSERT_ID();

INSERT INTO
  asignacion_docentes (
    id_docente,
    id_curso,
    id_periodo,
    cupo_maximo,
    horario,
    aula
  )
VALUES
  (
    p_id_docente,
    p_id_curso_creado,
    p_id_periodo,
    p_cupo_maximo,
    p_horario,
    p_aula
  );

SET
  p_id_asignacion_creada = LAST_INSERT_ID();

SET
  p_mensaje = CONCAT(
    'ÉXITO: Curso creado (ID: ',
    p_id_curso_creado,
    ') y asignado al docente (Asignación ID: ',
    p_id_asignacion_creada,
    ')'
  );

COMMIT;

END IF;

END $ $ DELIMITER;

CALL sp_crear_curso_y_asignar_docente(
  'ING302',
  'Gerencia y Gestión de Proyectos',
  'Herramientas y metodologías ágiles',
  4,
  6,
  13,
  25,
  'Lun-Mie 14:00-16:00',
  'H-201',
  @curso_id,
  @asignacion_id,
  @resultado
);

SELECT
  @resultado AS resultado;

SELECT
  @curso_id AS id_curso_creado;

SELECT
  @asignacion_id AS id_asignacion_creada;