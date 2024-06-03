-- EJERCICIOS PROPUESTOS
-- 1. Consulta de Proyectos:
SELECT IDProyecto, NombreProyecto
FROM Proyecto;

-- 2. Consulta de Proyectos por Ubicación:
-- ¿Cuáles son los proyectos que se desarrollan en 'CHICAGO'?
SELECT NombreProyecto
FROM Proyecto
WHERE Ubicacion = 'CHICAGO';

-- 3. Consulta de Proyectos por Departamento:
SELECT *
FROM Proyecto
WHERE IDDepartamento = 2;

-- 4. Consulta de Proyectos y Departamentos:
-- ¿Cuáles son los nombres y ubicaciones de los proyectos junto con los nombres de sus departamentos asociados?
SELECT Proyecto.NombreProyecto, Proyecto.Ubicacion AS UbicacionProyecto, Departamento.NombreDepartamento, Departamento.Ubicacion AS UbicacionDepartamento
FROM Proyecto
INNER JOIN Departamento ON Proyecto.IDDepartamento = Departamento.IDDepartamento;

-- 5. Consulta de Empleados por Proyecto:
-- ¿Qué empleados están asignados al proyecto identificado con el número 4, y cuáles son sus nombres?
SELECT E.NombreEmpleado
FROM EmpleadoProyecto EP
JOIN Empleado E ON EP.IDEmpleado = E.IDEmpleado
WHERE EP.IDProyecto = 4;

-- 6. Consulta de Proyectos por Empleado:
-- ¿En qué proyectos está participando el empleado con el identificador 4, y cuáles son los nombres de esos proyectos?
SELECT EP.IDProyecto, P.NombreProyecto
FROM EmpleadoProyecto EP
JOIN Proyecto P ON EP.IDProyecto = P.IDProyecto
WHERE EP.IDEmpleado = 4;

-- 7. Consulta de Horas Trabajadas por Proyecto:
-- ¿Cuántas horas han trabajado en total los empleados en el proyecto con identificador 2?
SELECT SUM(HorasTrabajadas) AS TotalHorasTrabajadas
FROM EmpleadoProyecto
WHERE IDProyecto = 2;

-- 8. Consulta de Empleados con Horas Trabajadas:
-- ¿Cuáles son los empleados que han trabajado más de 10 horas en el proyecto con identificador 2?
SELECT e.NombreEmpleado
FROM Empleado e
JOIN EmpleadoProyecto ep ON e.IDEmpleado = ep.IDEmpleado
WHERE ep.IDProyecto = 2 AND ep.HorasTrabajadas > 10;

-- 9. Consulta de Total de Horas por Empleado:
-- ¿Cuál es el total de horas trabajadas por cada empleado en todos los proyectos?
SELECT EP.IDEmpleado, E.NombreEmpleado, SUM(EP.HorasTrabajadas) AS TotalHorasTrabajadas
FROM EmpleadoProyecto EP
JOIN Empleado E ON EP.IDEmpleado = E.IDEmpleado
GROUP BY EP.IDEmpleado, E.NombreEmpleado;

-- 10. Consulta de Empleados con Múltiples Proyectos:
-- ¿Cuáles son los empleados que trabajan en más de un proyecto?
SELECT e.NombreEmpleado
FROM Empleado e
JOIN EmpleadoProyecto ep ON e.IDEmpleado = ep.IDEmpleado
GROUP BY e.IDEmpleado, e.NombreEmpleado
HAVING COUNT(DISTINCT ep.IDProyecto) > 1;

-- 11. Consulta de Empleados y Horas Totales:
-- ¿Cuáles son los empleados que han trabajado más de 30 horas en total en todos los proyectos?
SELECT E.IDEmpleado, E.NombreEmpleado, SUM(EP.HorasTrabajadas) AS TotalHoras
FROM Empleado E
JOIN EmpleadoProyecto EP ON E.IDEmpleado = EP.IDEmpleado
GROUP BY E.IDEmpleado, E.NombreEmpleado
HAVING SUM(EP.HorasTrabajadas) > 30;

-- 12. Consulta de Proyectos y Horas Promedio:
-- ¿Cuál es el promedio de horas trabajadas por proyecto?
SELECT Proyecto.IDProyecto, Proyecto.NombreProyecto, Proyecto.Ubicacion, AVG(EmpleadoProyecto.HorasTrabajadas) AS PromedioHorasTrabajadas
FROM Proyecto
JOIN EmpleadoProyecto ON Proyecto.IDProyecto = EmpleadoProyecto.IDProyecto
GROUP BY Proyecto.IDProyecto, Proyecto.NombreProyecto, Proyecto.Ubicacion;



-- CONSULTAS AVANZADAS
-- Pregunta 1: Empleados en Proyectos Específicos y con Salario Alto
-- ¿Cuáles son los empleados que trabajan en proyectos ubicados en 'CHICAGO' y que tienen un salario (con o sin comisión) superior a 2000?
SELECT NombreEmpleado, Salario, Comision, NombreProyecto
FROM Empleado
JOIN EmpleadoProyecto ON Empleado.IDEmpleado = Empleado.IDEmpleado
JOIN Proyecto ON Proyecto.IDProyecto = EmpleadoProyecto.IDProyecto
WHERE Ubicacion = 'CHICAGO' AND (Salario + COALESCE(Comision, 0)) > 2000;


-- Pregunta 2: Empleados con Jefe y en Proyectos Múltiples
-- ¿Cuáles son los empleados que tienen un jefe, están asignados a más de un proyecto, y han trabajado más de 15 horas en total en todos los proyectos combinados?

SELECT E.IDEmpleado, E.NombreEmpleado, SUM(EP.HorasTrabajadas) AS TotalHorasTrabajadas
FROM Empleado E
JOIN EmpleadoProyecto EP ON E.IDEmpleado = EP.IDEmpleado
WHERE  E.IDJefe IS NOT NULL
GROUP BY E.IDEmpleado, E.NombreEmpleado
HAVING COUNT(EP.IDProyecto) > 1 AND SUM(EP.HorasTrabajadas) > 15;

-- Pregunta 3: Empleados sin Comisión en Departamentos Específicos
-- ¿Cuáles son los empleados que no reciben comisión y trabajan en departamentos ubicados en 'DALLAS' o 'NEW YORK'?
SELECT E.IDEmpleado, E.NombreEmpleado, D.NombreDepartamento, D.Ubicacion
FROM Empleado E
JOIN Departamento D ON  E.IDDepartamento = D.IDDepartamento
WHERE E.Comision IS NULL AND (D.Ubicacion = 'DALLAS' OR D.Ubicacion = 'NEW YORK')