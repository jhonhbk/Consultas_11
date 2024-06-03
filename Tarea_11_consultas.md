# TAREA 11
## EJERCICIOS PROPUESTOS
## 1. Consulta de Proyectos:
¿Cuáles son los identificadores y nombres de todos los proyectos existentes en la empresa?

**Solucion:**
Este código selecciona el identificador y el nombre de todos los proyectos de la tabla "Proyecto".
```sql
SELECT IDProyecto, NombreProyecto
FROM Proyecto;
```
| ID Proyecto | NombreProyecto |
| ------: | ----: |
| 1 | P1 |
| 2 | P2 |
| 3 | P3 |
| 4 | P4 |
| 5 | P5 |

## 2. Consulta de Proyectos por Ubicación:
¿Cuáles son los proyectos que se desarrollan en 'CHICAGO'?

**Solucion:**
Este código selecciona el ID y el nombre de todos los proyectos de la tabla "Proyecto".
```sql
SELECT NombreProyecto
FROM Proyecto
WHERE Ubicacion = 'CHICAGO';
```
| NombreProyecto |
| ---- |
| P4 |
| P5 |

## 3. Consulta de Proyectos por Departamento:
¿Cuáles son los proyectos que pertenecen al departamento con identificador 2?

**Solucion:**
Este código SQL selecciona todos los datos de la tabla "Proyecto" donde el valor en la columna "IDDepartamento" es igual a 2.
```sql
SELECT *
FROM Proyecto
WHERE IDDepartamento = 2;
```
| IDProyecto   | NombreProyecto | Ubicacion | IDDepartamento
|:--------:|:-----|:----------:|:--------|
| 1     | P1   | BOSTON    |2    |


## 4. Consulta de Proyectos y Departamentos:
¿Cuáles son los nombres y ubicaciones de los proyectos junto con los nombres de sus departamentos asociados?

**Solucion:**
Este código realiza una consulta que combina datos de las tablas "Proyecto" y "Departamento" utilizando la cláusula INNER JOIN. Se seleccionan el nombre y la ubicación del proyecto, así como el nombre y la ubicación del departamento al que pertenece cada proyecto. 
```sql
SELECT Proyecto.NombreProyecto, Proyecto.Ubicacion AS UbicacionProyecto, Departamento.NombreDepartamento, Departamento.Ubicacion AS UbicacionDepartamento
FROM Proyecto
INNER JOIN Departamento ON Proyecto.IDDepartamento = Departamento.IDDepartamento;
```
| NombreProyecto   | UbicacionProyecto | NombreDepartamento | UbicacionDepartamento
|:--------:|:-----|:----------|:--------|
| P1     | BOSTON   | RESEARCH    |DALLAS    |
| P1     | CHICAGO   | SALES    |CHICAGO    |
| P1     | CHICAGO   | SALES    |CHICAGO    |
| P1     | LOS ANGELES   | SALES    |CHICAGO    |
| P1     | NEW YORK   | SALES    |CHICAGO    |

## 5. Consulta de Empleados por Proyecto:
¿Qué empleados están asignados al proyecto identificado con el número 4, y cuáles son sus nombres?
```sql
SELECT E.NombreEmpleado
FROM EmpleadoProyecto EP
JOIN Empleado E ON EP.IDEmpleado = E.IDEmpleado
WHERE EP.IDProyecto = 4;
```
| NombreEmpleado |
| ---- |
| MARTIN |

## 6. Consulta de Proyectos por Empleado:
¿En qué proyectos está participando el empleado con el identificador 4, y cuáles son los nombres de esos proyectos?

## 7. Consulta de Horas Trabajadas por Proyecto:
¿Cuántas horas han trabajado en total los empleados en el proyecto con identificador 2?
```sql
SELECT SUM(HorasTrabajadas) AS TotalHorasTrabajadas
FROM EmpleadoProyecto
WHERE IDProyecto = 2;
```
| TotalHorasTrabajadas |
| ----: |
| 25 |

## 8. Consulta de Empleados con Horas Trabajadas:
¿Cuáles son los empleados que han trabajado más de 10 horas en el proyecto con identificador 2?
```sql
SELECT e.NombreEmpleado
FROM Empleado e
JOIN EmpleadoProyecto ep ON e.IDEmpleado = ep.IDEmpleado
WHERE ep.IDProyecto = 2 AND ep.HorasTrabajadas > 10;
```
| NombreEmpleado |
| :---- |
| ALLEN |

## 9. Consulta de Total de Horas por Empleado:
¿Cuál es el total de horas trabajadas por cada empleado en todos los proyectos?
```SQL
SELECT EP.IDEmpleado, E.NombreEmpleado, SUM(EP.HorasTrabajadas) AS TotalHorasTrabajadas
FROM EmpleadoProyecto EP
JOIN Empleado E ON EP.IDEmpleado = E.IDEmpleado
GROUP BY EP.IDEmpleado, E.NombreEmpleado;
```
| IDEmpleado | NombreEmpleado | TotalHorasTrabajadas |
| ------ | ---- | ----  |
| 8 | ALLEN | 27 |
| 9 | WARD | 18 |
| 10 | MARTIN | 36 |
| 11 | TURNER | 6 |
| 12 | ADAMS | 4 |

## 10. Consulta de Empleados con Múltiples Proyectos:
¿Cuáles son los empleados que trabajan en más de un proyecto?
```sql
SELECT e.NombreEmpleado
FROM Empleado e
JOIN EmpleadoProyecto ep ON e.IDEmpleado = ep.IDEmpleado
GROUP BY e.IDEmpleado, e.NombreEmpleado
HAVING COUNT(DISTINCT ep.IDProyecto) > 1;
```
| NombreEmpleado |
| :---- |
| ALLEN |
| WARD |
| MARTIN |

## 11. Consulta de Empleados y Horas Totales:
¿Cuáles son los empleados que han trabajado más de 30 horas en total en todos los proyectos?
```SQL
SELECT E.IDEmpleado, E.NombreEmpleado, SUM(EP.HorasTrabajadas) AS TotalHoras
FROM Empleado E
JOIN EmpleadoProyecto EP ON E.IDEmpleado = EP.IDEmpleado
GROUP BY E.IDEmpleado, E.NombreEmpleado
HAVING SUM(EP.HorasTrabajadas) > 30;
```
| IDEmpleado | NombreEmpleado | TotalHoras |
| ------ | ---- | ----  |
| 10 | MARTIN | 36 |

## 12. Consulta de Proyectos y Horas Promedio:
¿Cuál es el promedio de horas trabajadas por proyecto?
```SQL
SELECT Proyecto.IDProyecto, Proyecto.NombreProyecto, Proyecto.Ubicacion, AVG(EmpleadoProyecto.HorasTrabajadas) AS PromedioHorasTrabajadas
FROM Proyecto
JOIN EmpleadoProyecto ON Proyecto.IDProyecto = EmpleadoProyecto.IDProyecto
GROUP BY Proyecto.IDProyecto, Proyecto.NombreProyecto, Proyecto.Ubicacion;
```
| IDProyecto | Nombre¨Proyecto | Ubicacion | PromedioHorasTrabajadas |
| ------ | ---- | ----  | ----  |
| 1 | P1 | BOSTON | 10 |
| 2 | P2 | CHICAGO | 12.5 |
| 3 | P3 | CHICAGO | 9 |
| 4 | P4 | LOS ANGELES | 15 |
| 5 | P5 | NEW YORK | 6.5 |

# Consultas Avanzadas
## Pregunta 1: Empleados en Proyectos Específicos y con Salario Alto
¿Cuáles son los empleados que trabajan en proyectos ubicados en 'CHICAGO' y que tienen un salario (con o sin comisión) superior a 2000?
```SQL
SELECT NombreEmpleado, Salario, Comision, NombreProyecto
FROM Empleado
JOIN EmpleadoProyecto ON Empleado.IDEmpleado = Empleado.IDEmpleado
JOIN Proyecto ON Proyecto.IDProyecto = EmpleadoProyecto.IDProyecto
WHERE Ubicacion = 'CHICAGO' AND (Salario + COALESCE(Comision, 0)) > 2000;
```

## Pregunta 2: Empleados con Jefe y en Proyectos Múltiples
¿Cuáles son los empleados que tienen un jefe, están asignados a más de un proyecto, y han trabajado más de 15 horas en total en todos los proyectos combinados?
```SQL
SELECT E.IDEmpleado, E.NombreEmpleado, SUM(EP.HorasTrabajadas) AS TotalHorasTrabajadas
FROM Empleado E
JOIN EmpleadoProyecto EP ON E.IDEmpleado = EP.IDEmpleado
WHERE  E.IDJefe IS NOT NULL
GROUP BY E.IDEmpleado, E.NombreEmpleado
HAVING COUNT(EP.IDProyecto) > 1 AND SUM(EP.HorasTrabajadas) > 15;
```

## Pregunta 3: Empleados sin Comisión en Departamentos Específicos
¿Cuáles son los empleados que no reciben comisión y trabajan en departamentos ubicados en 'DALLAS' o 'NEW YORK'?
```SQL
SELECT E.IDEmpleado, E.NombreEmpleado, D.NombreDepartamento, D.Ubicacion
FROM Empleado E
JOIN Departamento D ON  E.IDDepartamento = D.IDDepartamento
WHERE E.Comision IS NULL AND (D.Ubicacion = 'DALLAS' OR D.Ubicacion = 'NEW YORK')
```

| IDEmpleado   | NombreEmpleado | NombreDepartamento | Ubicacion |
|:--------:|-----:|----------:|----------:|
| 1    | KING   | ACCOUNTING    | NEW YORK |
| 2    | JONES   | RESEARCH    | DALLAS |
| 4    | CLARK   | ACCOUNTING    | NEW YORK |
| 5    | SCOTT   | RESEARCH    | DALLAS |
| 6    | FORD   | RESEARCH    | DALLAS |
| 7    | SMITH   | RESEARCH    | DALLAS |
| 12    | ADAMS   | RESEARCH    | DALLAS |
| 14   | MILLER  | ACCOUNTING    | NEW YORK |

