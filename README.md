# Prueba Técnica

Solución completa para la prueba técnica de la convocatoria de la Facultad de Ingeniería.

---

## Contenido de la Prueba

Este repositorio contiene las soluciones a las dos pruebas solicitadas:

### Prueba Front-End
Maquetación responsive (mobile y desktop) de una landing page según diseño proporcionado.

### Prueba SQL
Base de datos relacional para una universidad con consultas y procedimientos almacenados.

---

## [Frontend](https://github.com/StoryChara/Prueba-Tecnica/tree/main/src)

### Demo en Vivo
Visita la aplicación desplegada: **https://prueba-tecnica-mjarah.vercel.app**

### Ejecución Local
1. Clona el repositorio:

   ```bash
   git clone https://github.com/StoryChara/Prueba-Tecnica.git
   cd Prueba-Tecnica
   ```

2. Instala las dependencias:
   ```bash
   npm install
   ```

3. Ejecuta el servidor de desarrollo:
   ```bash
   npm run dev
   ```

4. Abre tu navegador en `http://localhost:5173`

### Tecnologías Utilizadas
- React + Vite
- CSS/Bootstrap

---

## [Base de Datos SQL](https://github.com/StoryChara/Prueba-Tecnica/tree/main/sql)

Todos los archivos SQL se encuentran en la carpeta **`/sql`**

### Estructura de Archivos



#### `init.sql`
Archivo completo para crear la base de datos desde cero. Incluye:

- **CREATE TABLE**: Estructura de todas las tablas
  - `docentes` - Información de profesores
  - `estudiantes` - Información de estudiantes
  - `cursos` - Catálogo de cursos
  - `periodos_academicos` - Períodos académicos
  - `asignacion_docentes` - Asignación de cursos a docentes
  - `matriculas` - Inscripciones de estudiantes
  - `calificaciones` - Notas y evaluaciones
- **INSERT**: Datos de prueba para todas las tablas
- **CREATE VIEW**: Vistas para optimizar consultas frecuentes
  - `v_cursos_actuales` - Resumen de cursos del período actual
  - `v_promedios_estudiantes` - Promedios ponderados por estudiante y curso
  - `v_cursos_por_periodo` - Cursos por periodo con disponibilidad de cupos
  - `v_matriculas_detalle` - Detalle completo de matrículas con información relacionada

#### `queries.sql`
Contiene las respuestas SQL a las 5 preguntas solicitadas:

1. **¿Cuántos docentes activos hay en la Facultad de Ingeniería?**
2. **¿Cuáles son los cursos que se dictaron en un periodo dado?**
3. **¿Cuál es la lista de estudiantes para el periodo actual?**
4. **¿Cuál es el promedio de calificaciones obtenidas en un curso los últimos 5 años?**
5. **¿Cuál sería el procedimiento para crear un nuevo curso y asignarle un docente?** (Procedimiento almacenado)

---

## 📂 Estructura del Proyecto

```
Prueba-Tecnica/
├── sql/
│   ├── init.sql              # Creación de BD desde cero (CREATE, INSERT, VIEWS)
│   └── queries.sql           # Respuestas a las 5 preguntas SQL
├── src/
│   ├── assets/               
│   ├── routes/               # Componentes de las rutas
│   │   ├── Footer.css        # Estilos del footer
│   │   ├── Footer.jsx        # Componente footer
│   │   ├── Home.css          # Estilos de la página principal
│   │   ├── Home.jsx          # Componente principal
│   │   ├── Navbar.css        # Estilos de la barra de navegación
│   │   └── Navbar.jsx        # Componente navbar
│   ├── App.css               
│   ├── App.jsx               # Componente raíz
│   ├── index.css             
│   └── main.jsx              # Punto de entrada de React
├── public/                   
├── package.json              # Dependencias del proyecto
├── vite.config.js            # Configuración de Vite
└── README.md                 # Documentación
```
