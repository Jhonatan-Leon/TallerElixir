defmodule TallerInventario do
  alias Metodos_aux

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

  def listar_productos_dos_vocales(productos) do
    Map.values(productos)
    |> Enum.filter(fn producto -> Metodos_aux.tiene_al_menos_dos_vocales?(producto.nombre) end)
    |> Enum.map(fn producto -> {producto.codigo, producto.nombre} end)
  end

  def listar_nombre_misma_letra(productos) do
    Map.values(productos)
    |> Enum.filter(fn producto ->
         String.downcase(String.first(producto.nombre)) == String.downcase(String.last(producto.nombre))
       end)
    |> Enum.map(fn p -> {p.codigo, p.nombre} end)
  end

  def tres_productos_mas_caros(productos) do
    Map.values(productos)
    |> Enum.sort_by(fn producto -> producto.precio end, :desc) # Añadí :desc para que sean los más caros
    |> Enum.take(3)
    |> Enum.map(fn p -> {p.codigo, p.nombre} end)
  end

  def reporte_agrupacion(productos) do
    limite_inferior = 50_000
    limite_mayor = 100_000
    Map.values(productos)
    |> Enum.group_by(fn producto ->
      cond do
        producto.precio < limite_inferior -> "Menores de $50.000"
        producto.precio >= limite_inferior and producto.precio <= limite_mayor -> "Entre $50.000 y $100.000"
        producto.precio > limite_mayor -> "Mayores de $100.000"
      end
    end)
  end
end
