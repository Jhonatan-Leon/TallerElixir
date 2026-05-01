defmodule Gimnasio.Solicitud do
  def solicitud_registro do
    cedula = IO.gets("Ingrese su cédula: ") |> String.trim()
    nombre = IO.gets("Ingrese su nombre: ") |> String.trim()
    edad = IO.gets("Ingrese su edad: ") |> String.trim()

    case Gimnasio.Validacion.validacion_datos({cedula, nombre, edad}) do
      {:ok, {cedula, nombre, edad}} ->
        {cedula, nombre, edad}
      {:error, razon} ->
        IO.inspect(razon, label: "Error: ")
        solicitud_registro()
    end
  end

end
