defmodule Gimnasio.Services do
  Code.require_file("socio.exs")

  def agregar_socio(socios, cedula, nombre, edad) do
  case Socio.nuevo(nombre, edad) do
    {:ok, nuevo_socio} ->
      if Map.has_key?(socios, cedula) do
        {:error, :cedula_duplicada}
      else
        socio = %{nuevo_socio | cedula: cedula }
        lista_actualizada = Map.put(socios, cedula, socio)
        |> Gimnasio.Persistencia.guardar_socios()
        {:ok, lista_actualizada}
      end
    {:error, razon} ->
      {:error, razon}
  end
  end

  def obtener_socio(socios, cedula) do
    case Map.get(socios, cedula) do
      nil -> {:error, :no_encontrado}
      socio -> {:ok, socio}
    end
  end

  def actualizar_socio(socios, cedula, nombre, edad) do
  case Map.get(socios, cedula) do
    nil ->
      IO.puts("Entro por nil")
      {:error, :no_encontrado}

    socio ->
      actualizado = %{socio | nombre: nombre, edad: edad}
      valor  = Map.put(socios, cedula, actualizado)
      |> Gimnasio.Persistencia.guardar_socios()
      {:ok, valor}
    end
  end

  def eliminar_socio(socios, cedula) do
    if Map.has_key?(socios, cedula) do
      lista_actualizada = Map.delete(socios, cedula)
      |> Gimnasio.Persistencia.guardar_socios()
      {:ok, lista_actualizada }
    else
      {:error, :no_encontrado}
    end
  end

  def inscribir_clase(socios, cedula, clase) do
  case Map.get(socios, cedula) do
    nil ->
      {:error, :no_encontrado}
    socio ->
      case Socio.inscribir_clase(socio, clase) do
        {:ok, actualizado} ->
          lista_actualizada = Map.put(socios, cedula, actualizado)
          |> Gimnasio.Persistencia.guardar_socios()
          {:ok, lista_actualizada}
        {:error, razon} ->
          {:error, razon}
      end
    end
  end

  def desinscribir_clase(socios, cedula, clase) do
  case Map.get(socios, cedula) do
    nil ->
      {:error, :no_encontrado}
    socio ->
      case Socio.desinscribir_clase(socio, clase) do
        {:ok, actualizado} ->
          lista = Map.put(socios, cedula, actualizado)
          |> Gimnasio.Persistencia.guardar_socios()
          {:ok, lista}
      end
    end
  end

  def listar_socios(socios), do: Map.values(socios)

  def socios_en_clase(socios, clase) do
  socios
  |> Map.values()
  |> Enum.filter(&Socio.tiene_clase?(&1, clase))
end

  # Devuelve estadísticas básicas del gimnasio
  def obtener_estadisticas(socios) do
    %{
      total: map_size(socios),
      edad_promedio: calcular_edad_promedio(socios)
    }
  end

  defp calcular_edad_promedio(socios) when map_size(socios) == 0, do: 0
  defp calcular_edad_promedio(socios) do
    edades = socios |> Map.values() |> Enum.map(& &1.edad)
    Enum.sum(edades) / length(edades)
  end


end
