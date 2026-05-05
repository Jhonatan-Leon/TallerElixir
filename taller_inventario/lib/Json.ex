defmodule Json do
  @ruta "data/inventario.json"

  def mapa_json(mapa) do
    case Jason.encode(mapa) do
      {:ok, json_string} ->
        File.write(@ruta, json_string)
      {:error, _reason} ->
        IO.puts("Error al codificar")
    end
  end

  def json_mapa(json) do
    case Jason.decode(json) do
      {:ok, mapa} ->
        IO.inspect(mapa)
      {:error, _reason} ->
        IO.puts("JSON inválido")
    end
  end
end
