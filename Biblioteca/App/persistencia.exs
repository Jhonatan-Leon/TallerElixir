defmodule Biblioteca.Persistencia do
@path_libros ""
  def cargar_libros do
    case File.read(@path_libros) do
      {:ok, result } ->
        datos = Jason.decoded!(result)
        |> Enum.map(fn d ->
          map_struct(d)
        end)
      {:error, ""} ->
        {}
      {:error, razon} ->
        IO.puts("Error en la carga de libros #{razon}")
    end
  end

  defp map_struct(libros) do
    %Libros {

    }
  end
end
