defmodule Interfaz do
  alias TallerInventario
  alias Gestion_archivo

  def iniciar do
    productos = Gestion_archivo.cargar_datos()
    menu(productos)
  end

  def menu(productos) do
    IO.puts """
    \n======= MENÚ DE INVENTARIO =======
    1. Agregar producto
    2. Listar productos (2+ vocales)
    3. Listar por nombre (empieza/termina igual)
    4. Ver 3 productos más caros
    5. Reporte agrupado por Rango de Precio
    6. Guardar cambios en archivo
    7. Salir
    ==================================
    """
    opcion = IO.gets("Selecciona una opción: ") |> String.trim()

    case opcion do
      "1" ->
        cod = IO.gets("Código (min 5): ") |> String.trim()
        nom = IO.gets("Nombre: ") |> String.trim()
        {pre, _} = IO.gets("Precio: ") |> Integer.parse()
        {can, _} = IO.gets("Cantidad: ") |> Integer.parse()

        case TallerInventario.agregar_producto(productos, cod, nom, pre, can) do
          {:ok, nuevos_productos} ->
            IO.puts("¡Agregado exitosamente!")
            menu(nuevos_productos)
          {:error, _} ->
            IO.puts("Error: Datos no válidos o código duplicado.")
            menu(productos)
        end

      "2" ->
        IO.puts("\n--- PRODUCTOS CON 2 O MÁS VOCALES ---")
        IO.inspect(TallerInventario.listar_productos_dos_vocales(productos))
        menu(productos)

      "3" ->
        IO.puts("\n--- NOMBRES QUE EMPIEZAN Y TERMINAN IGUAL ---")
        IO.inspect(TallerInventario.listar_nombre_misma_letra(productos))
        menu(productos)

      "4" ->
        IO.puts("\n--- LOS 3 MÁS CAROS ---")
        IO.inspect(TallerInventario.tres_productos_mas_caros(productos))
        menu(productos)

      "5" ->
        IO.puts("\n--- REPORTE AGRUPADO POR PRECIO ---")
        reporte = TallerInventario.reporte_agrupacion(productos)
        Enum.each(reporte, fn {rango, lista} ->
          nombres = Enum.map(lista, & &1.nombre) |> Enum.join(", ")
          IO.puts("#{rango}: [ #{nombres} ]")
        end)
        menu(productos)

      "6" ->
        Gestion_archivo.guardar_datos(productos)
        IO.puts("¡Archivo actualizado correctamente!")
        menu(productos)

      "7" ->
        Gestion_archivo.guardar_datos(productos)
        IO.puts("¡Datos guardados! Hasta luego.")

      _ ->
        IO.puts("Opción inválida.")
        menu(productos)
    end
  end
end
