-- TABLA: DOCENTES
CREATE TABLE docentes (
    id_docente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    especialidad VARCHAR(100),
    estado ENUM ('activo', 'inactivo') DEFAULT 'activo',
    fecha_contratacion DATE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_estado (estado),
    INDEX idx_especialidad (especialidad)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- TABLA: ESTUDIANTES
CREATE TABLE estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    codigo_estudiante VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    direccion TEXT,
    estado ENUM ('activo', 'inactivo', 'egresado', 'suspendido') DEFAULT 'activo',
    fecha_ingreso DATE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_codigo (codigo_estudiante),
    INDEX idx_estado (estado)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- TABLA: PERIODOS ACADÉMICOS
CREATE TABLE periodos_academicos (
    id_periodo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    anio YEAR NOT NULL,
    semestre ENUM ('1', '2', 'verano') NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado ENUM ('actual', 'finalizado', 'programado') DEFAULT 'programado',
    UNIQUE KEY uk_periodo (anio, semestre),
    INDEX idx_estado (estado),
    INDEX idx_fecha (fecha_inicio, fecha_fin)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- TABLA: CURSOS
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    codigo_curso VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    creditos INT NOT NULL,
    estado ENUM ('activo', 'inactivo') DEFAULT 'activo',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_codigo (codigo_curso),
    INDEX idx_estado (estado)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- TABLA: ASIGNACIÓN DOCENTE-CURSO
CREATE TABLE asignacion_docentes (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_docente INT NOT NULL,
    id_curso INT NOT NULL,
    id_periodo INT NOT NULL,
    cupo_maximo INT DEFAULT 30,
    horario TEXT,
    aula VARCHAR(50),
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_docente) REFERENCES docentes (id_docente) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES cursos (id_curso) ON DELETE CASCADE,
    FOREIGN KEY (id_periodo) REFERENCES periodos_academicos (id_periodo) ON DELETE CASCADE,
    UNIQUE KEY uk_asignacion (id_docente, id_curso, id_periodo),
    INDEX idx_periodo (id_periodo),
    INDEX idx_curso (id_curso)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- TABLA: MATRÍCULAS
CREATE TABLE matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_asignacion INT NOT NULL,
    fecha_matricula TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado ENUM (
        'matriculado',
        'retirado',
        'aprobado',
        'reprobado'
    ) DEFAULT 'matriculado',
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante) ON DELETE CASCADE,
    FOREIGN KEY (id_asignacion) REFERENCES asignacion_docentes (id_asignacion) ON DELETE CASCADE,
    UNIQUE KEY uk_matricula (id_estudiante, id_asignacion),
    INDEX idx_estudiante (id_estudiante),
    INDEX idx_estado (estado)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- TABLA: CALIFICACIONES
CREATE TABLE calificaciones (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    nota DECIMAL(4, 2) NOT NULL CHECK (
        nota >= 0
        AND nota <= 5
    ),
    peso DECIMAL(3, 2) DEFAULT 1.00 CHECK (
        peso >= 0
        AND peso <= 1
    ),
    fecha_evaluacion DATE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_matricula) REFERENCES matriculas (id_matricula) ON DELETE CASCADE,
    INDEX idx_matricula (id_matricula)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- INSERTAR DATOS DE EJEMPLO
-- Insertar Docentes
INSERT INTO
    docentes (
        nombre,
        apellido,
        email,
        telefono,
        especialidad,
        estado,
        fecha_contratacion
    )
VALUES
    (
        'Carlos',
        'Mendoza',
        'carlos.mendoza@facultad.edu',
        '987654321',
        'Programación',
        'activo',
        '2018-03-15'
    ),
    (
        'María',
        'González',
        'maria.gonzalez@facultad.edu',
        '987654322',
        'Matemáticas',
        'activo',
        '2019-08-20'
    ),
    (
        'Jorge',
        'Ramírez',
        'jorge.ramirez@facultad.edu',
        '987654323',
        'Bases de Datos',
        'activo',
        '2020-01-10'
    ),
    (
        'Ana',
        'Torres',
        'ana.torres@facultad.edu',
        '987654324',
        'Física',
        'activo',
        '2017-05-12'
    ),
    (
        'Luis',
        'Vega',
        'luis.vega@facultad.edu',
        '987654325',
        'Electrónica',
        'inactivo',
        '2015-09-01'
    ),
    (
        'Patricia',
        'Silva',
        'patricia.silva@facultad.edu',
        '987654326',
        'Algoritmos',
        'activo',
        '2021-02-14'
    ),
    (
        'Roberto',
        'Castro',
        'roberto.castro@facultad.edu',
        '987654327',
        'Redes',
        'activo',
        '2019-11-05'
    );

-- Insertar Estudiantes
INSERT INTO
    estudiantes (
        codigo_estudiante,
        nombre,
        apellido,
        email,
        telefono,
        fecha_nacimiento,
        estado,
        fecha_ingreso
    )
VALUES
    (
        'E2020001',
        'Juan',
        'Pérez',
        'juan.perez@estudiante.edu',
        '912345678',
        '2002-05-15',
        'activo',
        '2020-03-01'
    ),
    (
        'E2020002',
        'Laura',
        'Martínez',
        'laura.martinez@estudiante.edu',
        '912345679',
        '2001-08-22',
        'activo',
        '2020-03-01'
    ),
    (
        'E2021001',
        'Diego',
        'López',
        'diego.lopez@estudiante.edu',
        '912345680',
        '2003-01-10',
        'activo',
        '2021-03-01'
    ),
    (
        'E2021002',
        'Sofía',
        'Hernández',
        'sofia.hernandez@estudiante.edu',
        '912345681',
        '2002-11-30',
        'activo',
        '2021-03-01'
    ),
    (
        'E2022001',
        'Miguel',
        'Vargas',
        'miguel.vargas@estudiante.edu',
        '912345682',
        '2003-07-18',
        'activo',
        '2022-03-01'
    ),
    (
        'E2022002',
        'Camila',
        'Rojas',
        'camila.rojas@estudiante.edu',
        '912345683',
        '2003-03-25',
        'activo',
        '2022-03-01'
    ),
    (
        'E2023001',
        'Andrea',
        'Flores',
        'andrea.flores@estudiante.edu',
        '912345684',
        '2004-09-12',
        'activo',
        '2023-03-01'
    ),
    (
        'E2023002',
        'Fernando',
        'Ríos',
        'fernando.rios@estudiante.edu',
        '912345685',
        '2004-02-28',
        'activo',
        '2023-03-01'
    ),
    (
        'E2024001',
        'Valentina',
        'Cruz',
        'valentina.cruz@estudiante.edu',
        '912345686',
        '2005-06-05',
        'activo',
        '2024-03-01'
    ),
    (
        'E2024002',
        'Sebastián',
        'Morales',
        'sebastian.morales@estudiante.edu',
        '912345687',
        '2005-12-14',
        'activo',
        '2024-03-01'
    );

-- Insertar Periodos Académicos
INSERT INTO
    periodos_academicos (
        nombre,
        anio,
        semestre,
        fecha_inicio,
        fecha_fin,
        estado
    )
VALUES
    (
        '2020-1',
        2020,
        '1',
        '2020-03-01',
        '2020-07-31',
        'finalizado'
    ),
    (
        '2020-2',
        2020,
        '2',
        '2020-08-01',
        '2020-12-20',
        'finalizado'
    ),
    (
        '2021-1',
        2021,
        '1',
        '2021-03-01',
        '2021-07-31',
        'finalizado'
    ),
    (
        '2021-2',
        2021,
        '2',
        '2021-08-01',
        '2021-12-20',
        'finalizado'
    ),
    (
        '2022-1',
        2022,
        '1',
        '2022-03-01',
        '2022-07-31',
        'finalizado'
    ),
    (
        '2022-2',
        2022,
        '2',
        '2022-08-01',
        '2022-12-20',
        'finalizado'
    ),
    (
        '2023-1',
        2023,
        '1',
        '2023-03-01',
        '2023-07-31',
        'finalizado'
    ),
    (
        '2023-2',
        2023,
        '2',
        '2023-08-01',
        '2023-12-20',
        'finalizado'
    ),
    (
        '2024-1',
        2024,
        '1',
        '2024-03-01',
        '2024-07-31',
        'finalizado'
    ),
    (
        '2024-2',
        2024,
        '2',
        '2024-08-01',
        '2024-12-20',
        'finalizado'
    ),
    (
        '2025-1',
        2025,
        '1',
        '2025-03-01',
        '2025-07-31',
        'finalizado'
    ),
    (
        '2025-2',
        2025,
        '2',
        '2025-08-01',
        '2025-12-20',
        'finalizado'
    ),
    (
        '2026-1',
        2026,
        '1',
        '2026-03-01',
        '2026-07-31',
        'actual'
    ),
    (
        '2026-2',
        2026,
        '2',
        '2026-08-01',
        '2026-12-20',
        'programado'
    );

-- Insertar Cursos
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
        'ING101',
        'Introducción a la Programación',
        'Fundamentos de programación y algoritmia',
        4,
        'activo'
    ),
    (
        'MAT201',
        'Cálculo Diferencial',
        'Límites, derivadas y aplicaciones',
        5,
        'activo'
    ),
    (
        'FIS101',
        'Física I',
        'Mecánica clásica',
        4,
        'activo'
    ),
    (
        'ING202',
        'Estructuras de Datos',
        'Listas, pilas, colas, árboles',
        4,
        'activo'
    ),
    (
        'BDD301',
        'Bases de Datos',
        'Diseño y gestión de bases de datos',
        4,
        'activo'
    ),
    (
        'ALG201',
        'Análisis de Algoritmos',
        'Complejidad y optimización',
        4,
        'activo'
    ),
    (
        'RED401',
        'Redes de Computadoras',
        'Protocolos y arquitecturas de red',
        4,
        'activo'
    ),
    (
        'ELE301',
        'Electrónica Digital',
        'Circuitos lógicos y sistemas digitales',
        4,
        'activo'
    );

-- Insertar Asignaciones
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
    -- Periodo 2020-1
    (1, 1, 1, 30, 'Lun-Mie 08:00-10:00', 'A-101'),
    (2, 2, 1, 35, 'Mar-Jue 10:00-12:00', 'B-201'),
    -- Periodo 2021-1
    (1, 1, 3, 30, 'Lun-Mie 08:00-10:00', 'A-101'),
    (3, 4, 3, 25, 'Mar-Jue 14:00-16:00', 'C-301'),
    -- Periodo 2022-1
    (1, 1, 5, 30, 'Lun-Mie 08:00-10:00', 'A-101'),
    (3, 5, 5, 28, 'Lun-Mie 16:00-18:00', 'D-401'),
    -- Periodo 2023-1
    (1, 1, 7, 30, 'Lun-Mie 08:00-10:00', 'A-101'),
    (6, 6, 7, 25, 'Vie 08:00-12:00', 'B-205'),
    (3, 5, 7, 28, 'Mar-Jue 14:00-16:00', 'D-401'),
    -- Periodo 2024-1
    (1, 1, 9, 30, 'Lun-Mie 08:00-10:00', 'A-101'),
    (3, 5, 9, 28, 'Lun-Mie 16:00-18:00', 'D-401'),
    (7, 7, 9, 20, 'Jue-Vie 10:00-12:00', 'E-501'),
    -- Periodo 2024-2
    (1, 1, 10, 30, 'Lun-Mie 08:00-10:00', 'A-101'),
    (3, 5, 10, 28, 'Lun-Mie 16:00-18:00', 'D-401'),
    (6, 4, 10, 25, 'Mar-Jue 08:00-10:00', 'C-301'),
    -- Periodo 2025-1
    (1, 1, 11, 30, 'Lun-Mie 08:00-10:00', 'A-101'),
    (3, 5, 11, 28, 'Lun-Mie 16:00-18:00', 'D-401'),
    (6, 6, 11, 25, 'Vie 08:00-12:00', 'B-205'),
    -- Periodo 2025-2
    (1, 1, 12, 30, 'Lun-Mie 08:00-10:00', 'A-101'),
    (3, 5, 12, 28, 'Lun-Mie 16:00-18:00', 'D-401'),
    (7, 7, 12, 20, 'Jue-Vie 10:00-12:00', 'E-501'),
    -- Periodo 2026-1 (ACTUAL)
    (1, 1, 13, 30, 'Lun-Mie 08:00-10:00', 'A-101'),
    (1, 4, 13, 25, 'Vie 14:00-18:00', 'A-102'),
    (2, 2, 13, 35, 'Mar-Jue 10:00-12:00', 'B-201'),
    (3, 5, 13, 28, 'Lun-Mie 16:00-18:00', 'D-401'),
    (4, 3, 13, 30, 'Lun-Mie 14:00-16:00', 'F-101'),
    (6, 6, 13, 25, 'Vie 08:00-12:00', 'B-205'),
    (7, 7, 13, 20, 'Jue-Vie 10:00-12:00', 'E-501');

-- Insertar Matrículas
INSERT INTO
    matriculas (id_estudiante, id_asignacion, estado)
VALUES
    -- Periodo 2020-1
    (1, 1, 'aprobado'),
    (2, 1, 'aprobado'),
    (1, 2, 'aprobado'),
    -- Periodo 2021-1
    (3, 3, 'aprobado'),
    (4, 3, 'aprobado'),
    (1, 4, 'aprobado'),
    (2, 4, 'aprobado'),
    -- Periodo 2022-1
    (5, 5, 'aprobado'),
    (6, 5, 'aprobado'),
    (3, 6, 'aprobado'),
    (4, 6, 'aprobado'),
    -- Periodo 2023-1
    (7, 7, 'aprobado'),
    (8, 7, 'aprobado'),
    (5, 8, 'aprobado'),
    (3, 9, 'aprobado'),
    -- Periodo 2024-1
    (9, 10, 'aprobado'),
    (10, 10, 'aprobado'),
    (7, 11, 'aprobado'),
    (8, 12, 'aprobado'),
    -- Periodo 2024-2
    (9, 13, 'aprobado'),
    (10, 13, 'aprobado'),
    (7, 14, 'aprobado'),
    (5, 15, 'aprobado'),
    -- Periodo 2025-1
    (1, 16, 'aprobado'),
    (2, 16, 'aprobado'),
    (3, 17, 'aprobado'),
    (4, 18, 'aprobado'),
    -- Periodo 2025-2
    (5, 19, 'aprobado'),
    (6, 19, 'aprobado'),
    (7, 20, 'aprobado'),
    (8, 21, 'aprobado'),
    -- Periodo 2026-1 (ACTUAL) - Estudiantes matriculados
    (1, 22, 'matriculado'),
    (2, 22, 'matriculado'),
    (3, 22, 'matriculado'),
    (4, 23, 'matriculado'),
    (5, 23, 'matriculado'),
    (6, 24, 'matriculado'),
    (7, 24, 'matriculado'),
    (8, 25, 'matriculado'),
    (9, 25, 'matriculado'),
    (10, 25, 'matriculado'),
    (1, 26, 'matriculado'),
    (2, 27, 'matriculado'),
    (3, 28, 'matriculado'),
    (4, 28, 'matriculado');

-- Insertar Calificaciones
INSERT INTO
    calificaciones (id_matricula, nota, peso, fecha_evaluacion)
VALUES
    -- 2022-1
    (7, 3.9, 0.25, '2022-04-15'),
    (7, 4.0, 0.25, '2022-05-20'),
    (7, 4.3, 0.50, '2022-07-10'),
    (8, 3.5, 0.25, '2022-04-15'),
    (8, 3.9, 0.25, '2022-05-20'),
    (8, 4.0, 0.50, '2022-07-10'),
    -- 2023-1
    (12, 4.1, 0.25, '2023-04-15'),
    (12, 4.3, 0.25, '2023-05-20'),
    (12, 4.5, 0.50, '2023-07-10'),
    -- 2024-1
    (14, 3.8, 0.25, '2024-04-15'),
    (14, 4.1, 0.25, '2024-05-20'),
    (14, 4.4, 0.50, '2024-07-10'),
    -- 2024-2
    (18, 4.3, 0.25, '2024-09-15'),
    (18, 4.5, 0.25, '2024-10-20'),
    (18, 4.6, 0.50, '2024-12-10'),
    -- 2025-1
    (19, 4.2, 0.25, '2025-04-15'),
    (19, 4.3, 0.25, '2025-05-20'),
    (19, 4.5, 0.50, '2025-07-10'),
    (20, 3.9, 0.25, '2025-04-15'),
    (20, 4.0, 0.25, '2025-05-20'),
    (20, 4.2, 0.50, '2025-07-10'),
    -- 2025-2
    (23, 4.0, 0.25, '2025-09-15'),
    (23, 4.2, 0.25, '2025-10-20'),
    (23, 4.4, 0.50, '2025-12-10'),
    (24, 3.7, 0.25, '2025-09-15'),
    (24, 3.9, 0.25, '2025-10-20'),
    (24, 4.1, 0.50, '2025-12-10'),
    -- 2026-1 (ACTUAL)
    (32, 4.0, 0.25, '2026-04-15'),
    (33, 3.9, 0.25, '2026-04-15'),
    (34, 4.3, 0.25, '2026-04-15'),
    (29, 3.6, 0.25, '2026-04-10'),
    (29, 3.8, 0.25, '2026-05-15'),
    (30, 4.0, 0.25, '2026-04-10'),
    (30, 4.1, 0.25, '2026-05-15'),
    (31, 3.3, 0.25, '2026-04-10'),
    (35, 4.5, 0.25, '2026-04-12'),
    (36, 4.4, 0.25, '2026-04-18');

-- VISTAS
-- Vista: Resumen de cursos actuales
CREATE
OR REPLACE VIEW v_cursos_actuales AS
SELECT
    c.codigo_curso,
    c.nombre AS nombre_curso,
    CONCAT (d.nombre, ' ', d.apellido) AS docente,
    p.nombre AS periodo,
    ad.aula,
    ad.horario,
    COUNT(m.id_matricula) AS total_estudiantes,
    ad.cupo_maximo
FROM
    asignacion_docentes ad
    INNER JOIN cursos c ON ad.id_curso = c.id_curso
    INNER JOIN docentes d ON ad.id_docente = d.id_docente
    INNER JOIN periodos_academicos p ON ad.id_periodo = p.id_periodo
    LEFT JOIN matriculas m ON ad.id_asignacion = m.id_asignacion
WHERE
    p.estado = 'actual'
GROUP BY
    ad.id_asignacion;

-- Vista: Promedio por estudiante
CREATE
OR REPLACE VIEW v_promedios_estudiantes AS
SELECT
    e.codigo_estudiante,
    CONCAT (e.nombre, ' ', e.apellido) AS estudiante,
    c.codigo_curso,
    c.nombre AS curso,
    p.nombre AS periodo,
    ROUND(SUM(cal.nota * cal.peso), 2) AS promedio_final
FROM
    estudiantes e
    INNER JOIN matriculas m ON e.id_estudiante = m.id_estudiante
    INNER JOIN asignacion_docentes ad ON m.id_asignacion = ad.id_asignacion
    INNER JOIN cursos c ON ad.id_curso = c.id_curso
    INNER JOIN periodos_academicos p ON ad.id_periodo = p.id_periodo
    INNER JOIN calificaciones cal ON m.id_matricula = cal.id_matricula
GROUP BY
    e.id_estudiante,
    c.id_curso,
    p.id_periodo
HAVING
    promedio_final IS NOT NULL;

-- Vista: Cursos por periodo
CREATE
OR REPLACE VIEW v_cursos_por_periodo AS
SELECT
    p.nombre AS periodo,
    c.codigo_curso,
    c.nombre AS nombre_curso,
    c.creditos,
    CONCAT (d.nombre, ' ', d.apellido) AS docente,
    ad.horario,
    ad.aula,
    ad.cupo_maximo,
    COUNT(m.id_matricula) AS estudiantes_matriculados,
    (ad.cupo_maximo - COUNT(m.id_matricula)) AS cupos_disponibles
FROM
    asignacion_docentes ad
    INNER JOIN cursos c ON ad.id_curso = c.id_curso
    INNER JOIN docentes d ON ad.id_docente = d.id_docente
    INNER JOIN periodos_academicos p ON ad.id_periodo = p.id_periodo
    LEFT JOIN matriculas m ON ad.id_asignacion = m.id_asignacion
GROUP BY
    ad.id_asignacion;

-- Vista: Detalles de matricula
CREATE
OR REPLACE VIEW v_matriculas_detalle AS
SELECT
    p.nombre AS periodo,
    p.estado AS estado_periodo,
    e.codigo_estudiante,
    CONCAT (e.nombre, ' ', e.apellido) AS estudiante,
    e.email AS email_estudiante,
    c.codigo_curso,
    c.nombre AS curso,
    c.creditos,
    CONCAT (d.nombre, ' ', d.apellido) AS docente,
    ad.horario,
    ad.aula,
    m.fecha_matricula,
    m.estado AS estado_matricula,
    m.id_matricula
FROM
    estudiantes e
    INNER JOIN matriculas m ON e.id_estudiante = m.id_estudiante
    INNER JOIN asignacion_docentes ad ON m.id_asignacion = ad.id_asignacion
    INNER JOIN periodos_academicos p ON ad.id_periodo = p.id_periodo
    INNER JOIN cursos c ON ad.id_curso = c.id_curso
    INNER JOIN docentes d ON ad.id_docente = d.id_docente;