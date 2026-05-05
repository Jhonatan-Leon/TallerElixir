defmodule Inventario.Persistencia do
  @path_productos "../data/productos.json"

  def cargar_productos do
    case File.read(@path_productos) do
      {:ok, result}
        data = Jason.decoded!(result)
        |> Map.new(fn d -> map_to_struct(d)
            {.codigo, d}
          end)

    end
  end

  def guardar_productos(productos) do
    case
  end

  def map_to_struct(mapa) do
    %Inventario.Producto {
      codigo: mapa["codigo"],
      nombre: mapa["nombre"],
      precio: mapa["precio"],
      cantidad: mapa["cantidad"]
    }
  end
end
