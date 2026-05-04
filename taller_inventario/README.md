# 📦 Punto 2: Gestión de Inventario


## 🛠️ Aspectos Técnicos
*   **Modelo de Datos:** Implementación de `Structs` con el protocolo `@derive [Jason.Encoder]` para serialización automática.
*   **Persistencia:** Gestión de archivos en formato **JSON** mediante la librería `Jason`.
*   **Eficiencia:** Uso de `Mapas` para garantizar búsquedas rápidas por código de producto.
*   **Robustez:** Manejo de errores con bloques `case` para prevenir fallos en la lectura de archivos o decodificación de datos.

## 🚀 Funcionalidades
*   Registro y validación de productos.
*   Filtros dinámicos por vocales y coincidencia de caracteres.
*   Reportes de precios y agrupación por rangos.
*   Sincronización automática con `inventario.json`.

## 🖥️ Ejecución
Para iniciar este módulo, sitúate en esta carpeta y ejecuta:
terminal ->
mix deps.get
mix run
