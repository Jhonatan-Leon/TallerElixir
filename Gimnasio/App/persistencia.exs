Mix.install([
  {:jason, "~> 1.4"}
])

defmodule Gimnasio.Persistencia do
  Code.require_file("socio.exs")
  @path_socios "../data/socio.json"

  def cargar_todos_socios do
    case File.read(@path_socios) do
      {:ok, ""} ->
        {}
      {:ok, content} ->
        {:ok, mapa} = Jason.decode(content)
        Map.new(mapa, fn m ->
          socio = map_a_socio(m)
          {socio.cedula, socio}
        end)
      {:error, razon} ->
        IO.puts("Error al cargar socios, razón: #{razon}")
    end
  end

  def guardar_socios(socios) do
      nuevos_datos = Map.values(socios)
      datos = Enum.map(nuevos_datos,fn s -> Map.from_struct(s) end)
      # Convertimos el mapa a Formato JSON
      jason = Jason.encode!(datos)
      #Guardamos
      File.write(@path_socios, jason)
      socios
  end

  def map_a_socio(mapa) do
    %Socio{
      cedula: mapa["cedula"],
      nombre: mapa["nombre"],
      edad: mapa["Edad"],
      clases: mapa["Clases"]
    }
  end


end
