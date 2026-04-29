defmodule Producto do
  @enforce_keys [:codigo,:nombre,:precio,:cantidad]
  defstruct [:codigo,:nombre,:precio,:cantidad]

  def nuevo(codigo, nombre, precio, cantidad)
    when precio >= 0
          and cantidad >= 0
          and byte_size(codigo) >= 5
          and is_number(cantidad)
          and cantidad >= 0 do
    {:ok, %__MODULE__{codigo: codigo,nombre: nombre,precio: precio,cantidad: cantidad}}
  end

  def nuevo(codigo, nombre, precio, cantidad)
    when is_binary(codigo) and byte_size(codigo) >= 5 and
         is_number(precio) and precio >= 0 and
         is_number(cantidad) and cantidad >= 0 do
    {:ok, %__MODULE__{codigo: codigo, nombre: nombre, precio: precio, cantidad: cantidad}}
  end

  def nuevo(_codigo,_nombre,_precio,_cantidad), do: {:error, :precio_cantidad_codigo_invalida}

end

defmodule Gestion_archivo do
  @ruta "inventario.txt"

  def cargar_datos do
    case File.read(@ruta) do
      {:ok, contenido} ->
        contenido
        |> String.split("\n", trim: true)
        |> Enum.reduce(%{}, fn linea, acc ->
          case String.split(linea, ",") do
            [c, n, p, can] ->
              {:ok, prod} = Producto.nuevo(c, n, String.to_integer(p), String.to_integer(can))
              Map.put(acc, c, prod)
            _ -> acc
          end
        end)
      {:error, _} -> %{}
    end
  end

  def guardar_datos(productos) do
    contenido = Map.values(productos)
                |> Enum.map(fn p -> "#{p.codigo},#{p.nombre},#{p.precio},#{p.cantidad}" end)
                |> Enum.join("\n")
    File.write(@ruta, contenido)
  end
end

defmodule Inventario do
  alias Metodos_aux
  alias Gestion_archivo

  def iniciar do
    productos = Gestion_archivo.cargar_datos()
    main(productos)
  end

  def main(productos) do
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

        case Producto.nuevo(cod, nom, pre, can) do
          {:ok, p} ->
            IO.puts("¡Agregado exitosamente!")
            main(Map.put(productos, cod, p))
          {:error, _} ->
            IO.puts("Error: Datos no válidos.")
            main(productos)
        end

      "2" ->
        IO.puts("\n--- PRODUCTOS CON 2 O MÁS VOCALES ---")
        IO.inspect(listar_productos_dos_vocales(productos))
        main(productos)

      "3" ->
        IO.puts("\n--- NOMBRES QUE EMPIEZAN Y TERMINAN IGUAL ---")
        IO.inspect(listar_nombre_misma_letra(productos))
        main(productos)

      "4" ->
        IO.puts("\n--- LOS 3 MÁS CAROS ---")
        IO.inspect(tres_productos_mas_caros(productos))
        main(productos)

      "5" ->
        IO.puts("\n--- REPORTE AGRUPADO POR PRECIO ---")
        reporte = reporte_agrupacion(productos)
        Enum.each(reporte, fn {rango, lista} ->
          nombres = Enum.map(lista, & &1.nombre) |> Enum.join(", ")
          IO.puts("#{rango}: [ #{nombres} ]")
        end)
        main(productos)

      "6" ->
        Gestion_archivo.guardar_datos(productos)
        IO.puts("¡Archivo actualizado correctamente!")
        main(productos)

      "7" ->
        # Guardar automáticamente antes de cerrar
        Gestion_archivo.guardar_datos(productos)
        IO.puts("¡Datos guardados! Hasta luego.")

      _ ->
        IO.puts("Opción inválida.")
        main(productos)
    end
  end

   def agregar_producto(productos, codigo, nombre, precio, cantidad) do
    case Producto.nuevo(codigo, nombre, precio, cantidad) do
      {:ok, nuevo_producto} ->
        if Map.has_key?(productos, codigo) do
          {:error, :codigo_duplicado}
        else
          {:ok, Map.put(productos, codigo, nuevo_producto)}
        end
      {:error, razon} -> {:error, razon}
    end
  end

  def actualizar_producto(productos,codigo,nombre,precio,cantidad) do
    case Map.get(productos,codigo) do
      nil ->
        {:error, :no_encontrado}
      producto ->
        actualizado = %{producto | codigo: codigo, nombre: nombre, precio: precio, cantidad: cantidad}
        {:ok, Map.put(productos,codigo,actualizado)}
    end
  end

  def eliminar_producto(productos, codigo) do
    if Map.has_key?(productos, codigo) do
      {:ok, Map.delete(productos,codigo)}
    else
      {:error, :no_encontradow}
    end
  end

  # Listado de productos cuyo nombre contenga al menos dos vocales.
  # Devoler una tupla con su código y nombre por cada producto que cumpla con esta condición.
  def listar_productos_dos_vocales(productos) do
    Map.values(productos)
    |> Enum.filter(fn producto -> Metodos_aux.tiene_al_menos_dos_vocales?(producto.nombre) end)
    |> Enum.map(fn producto -> {producto.codigo, producto.nombre} end)
  end

  # Listado de productos cuyo nombre comience y termine con la misma letra.
  def listar_nombre_misma_letra(productos) do
    Map.values(productos)
    |> Enum.filter(fn producto -> String.downcase(String.first(producto.nombre)) == String.downcase(String.last(producto.nombre)) end)
    |> Enum.map(fn p -> {p.codigo, p.nombre} end)
  end

  # Listado de productos por debajo de un precio dado.
  def listar_debajo_precio(productos, precio) do
    Map.values(productos)
    |> Enum.filter(fn producto -> producto.precio < precio end)
    |> Enum.map(fn p -> {p.codigo, p.nombre} end)
  end

  # Retornar los tres productos más caros del inventario.
  def tres_productos_mas_caros(productos) do
    Map.values(productos)
    |> Enum.sort_by(fn producto -> producto.precio end)
    |> Enum.take(3)
    |> Enum.map(fn p -> {p.codigo, p.nombre} end)
  end

  # Retornar una cadena de caracteres con el nombre y precio de cada producto,
  # separados por comas de aquellos productos cuyo precio esté entre dos valores dados.

  def separacion_comas_precio(productos, limite_menor, limite_mayor) do
    Map.values(productos)
    |> Enum.filter(fn producto -> limite_menor <= producto.precio and producto.precio <= limite_mayor end)
    |> Enum.map(fn producto -> {producto.nombre, producto.precio} end)
    |> Enum.join(", ")
  end

  # Crear un reporte de productos agrupados por rango de precio,
  # ej.: Menores de $50000, Entre $50000 y $100000, Mayores de $100000.

  def reporte_agrupacion(productos) do
    limite_inferior = 50_000
    limite_mayor = 100_000
    Map.values(productos)
    |> Enum.group_by(fn producto ->
      cond do
        producto.precio < limite_inferior -> "Menores de $50.000"
        producto.precio > limite_inferior and producto.precio < limite_mayor -> "Entre $50.000 y $100.000"
        producto.precio > limite_mayor -> "Mayores de $100.000"
      end
    end)
  end


end

defmodule Metodos_aux do
  @vocales ["a", "e", "i", "o", "u"]

  def tiene_al_menos_dos_vocales?(x) when is_binary(x) do
    conteo =
      String.downcase(x)
      |> String.graphemes()
      |> Enum.count(fn letra -> letra in @vocales end)

      conteo >= 2
  end

end

Inventario.iniciar()
