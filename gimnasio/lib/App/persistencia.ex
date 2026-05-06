defmodule Gimnasio.Persistencia do
  @path_socios "lib/data/socio.csv"

  # def cargar_todos_socios do
  #   case File.read(@path_socios) do
  #     {:ok, ""} ->
  #       %{}
  #     {:ok, content} ->
  #       {:ok, mapa} = Jason.decode(content)
  #       Map.new(mapa, fn m ->
  #         socio = map_a_socio(m)
  #         {socio.cedula, socio}
  #       end)
  #     {:error, razon} ->
  #       IO.puts("Error al cargar socios, razón: #{razon}")
  #   end
  # end

  def cargar_todos_socios do
    @path_socios
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.to_list()
    |> Enum.map(&map_a_socio/1)
    |> Map.new(fn socio -> {socio.cedula, socio} end)
  rescue
    e ->
      IO.puts("Error al cargar socios, razón: #{inspect(e)}")
      %{}
  end


  # def guardar_socios(socios) do
  #     nuevos_datos = Map.values(socios)
  #     datos = Enum.map(nuevos_datos,fn s -> Map.from_struct(s) end)
  #     # Convertimos el mapa a Formato JSON
  #     jason = Jason.encode!(datos)
  #     #Guardamos
  #     File.write(@path_socios, jason)
  #     socios
  # end

  def guardar_socios(socios) do
  rows =
    socios
    |> Map.values()
    |> Enum.map(fn socio ->
      [
        socio.cedula,
        socio.nombre,
        socio.edad,
        Enum.join(socio.clases || [], ";")
      ]
    end)

  csv_content = [["cedula", "nombre", "edad", "clases"] | rows]
    |> CSV.encode()
    |> Enum.join()

  File.write!(@path_socios, csv_content)
  socios
rescue
  e ->
    IO.puts("Error al guardar socios, razón: #{inspect(e)}")
    socios
end

  def map_a_socio(mapa) do
    clases = mapa["clases"]
    lista_clases = if clases, do: String.split(clases, ";"), else: []

    %Socio{
      cedula: mapa["cedula"],
      nombre: mapa["nombre"],
      edad: String.to_integer(mapa["edad"]),
      clases: lista_clases
    }
  end


end
