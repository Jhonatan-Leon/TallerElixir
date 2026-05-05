defmodule Gestion_archivo do
  @ruta "data/inventario.json"

 def cargar_datos do
    case File.read(@ruta) do
      {:ok, contenido} ->
        case Jason.decode(contenido, keys: :atoms) do
          {:ok, lista} ->
            Enum.into(lista, %{}, fn p -> {p.codigo, p} end)
          {:error, _} -> %{}
        end
      {:error, _} -> %{}
    end
  end

  def guardar_datos(productos) do
    lista = Map.values(productos)
    Json.mapa_json(lista)
  end
end
