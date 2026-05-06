# 📦 Punto 2: Gestión de Gimnasio


## 🛠️ Aspectos Técnicos
*   **Modelo de Datos:** Implementación de `Structs` con el protocolo `[CSV]` para serialización automática.
*   **Persistencia:** Gestión de archivos en formato **CSV** mediante la librería `CSV`.
*   **Eficiencia:** Uso de `Mapas` para garantizar búsquedas rápidas por código de producto.
*   **Robustez:** Manejo de errores con bloques `case` para prevenir fallos en la lectura de archivos o decodificación de datos.

## 🚀 Funcionalidades
*   Crear un socio
*   Eliminar un socio
*   Inscribir a un socio en una clase
*   Desinscribir a un socio de una clase
*   Buscar un socio por cédula
*   Listar todos los socios
*   Listar todos los socios que estén inscritos en una clase específica
*   Listar todas las clases de un socio dada su cédula


## 🖥️ Ejecución
Para iniciar este módulo, sitúate en esta carpeta y ejecuta:
terminal ->
mix deps.get
mix run

# Uso de IA
LA IA fue implementada para confirmar y darnos información de metodos de la libreria CSV que no entendiamos del todo, 
tambien nos ayudo a crear las funcionalidades de cargar y guardar los datos, ya que al principio se intento de la misma forma que con los JSON
y no funciono como se esperaba, tocaba hacer algunos pasos extra para poder hacer bien las conversiones a el formato de datos solicitado. 
