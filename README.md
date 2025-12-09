[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/WgYJif60)
# BikeStores
## Información general
### Nombre y carné de los integrantes: 

- Sergio Montoya Badilla - 2023344598

- Johnsy López Aguilar - 2024178835

### Estado del proyecto: Excelente

## Instrucciones de uso

### Requerimientos previos

1. Tener Visual Studio 2019 instalado.
2. Tener SQL Server instalado.
3. Tener una instancia de SQL Server de tipo Developer con Analysis Services instalado de tipo multidimensional.
4. Tener SQL Server Management Studio instalado.
5. Tener SQL Server Data Tools instalado para Integration Services, Reporting Services y Analysis Services.

### Creación de las bases de datos

6. Ejecutar el script Create_BikeStores.sql para crear la base de datos principal.
7. Ejecutar el script Populate_BikeStores.sql para llenar la base de datos BikeStores.
8. Ejecutar el script Create_BikeStoresStage.sql para crear el stage de la base de datos.
9. Ejecutar el script Create_DimDate.sql para crear la dimensión DimDate para las fechas.
10. Ejecutar el script Populate_DimDate.sql para crear la base de datos DW e insertar la fecha por defecto.
11. Ejecutar el script Create_BikeStoresDW.sql para crear la base de datos DW.

### Proceso en Visual Studio

12. Abrir la solución PY3-BikeStores.sln en Visual Studio.
13. Abrir el proyecto PY3-BikeStores.
14. Ejecutar el orquestador.
15. Abrir el proyecto PY3-BikeStores-Cube.
16. Crear el cubo, procesar todo e implementarlo.
17. Abrirlo en SQL Server Management Studio mediante la conexión a Analysis Services.
18. Abrir el proyecto PY3-BikeStores-Reporting.
19. Abrir los reportes.
20. Publicarlos.


> [!IMPORTANT]
> Para evitar problemas de conexión, utilice la instancia localhost mediante la autenticación de Windows y cree las bases de datos, el cubo y todo lo necesario ahí, según el orden indicado.


👨🏻‍💻 Hecho con mucho esmero por [Sergio](https://github.com/sermontoya) y [Johnsy](https://github.com/johnsydev).
