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


  def solicitar_actualizacion() do
    cedula = IO.gets("¿Que socio desea actualizar?,
    por favor, ingrese su cédula: ") |> String.trim()

    nombre = IO.gets("Ingrese el nuevo nombre del socio: ") |> String.trim()
    edad = IO.gets("Ingrese la nueva edad del socio: ") |> String.trim()

    case Gimnasio.Validacion.validacion_datos({cedula, nombre, edad}) do
      {:ok, {cedula, nombre, edad}} ->
        {cedula, nombre, edad}
      {:error, razon} ->
        IO.inspect(razon, label: "Error: ")
        solicitar_actualizacion()
    end

  end

  def solicitar_cedula() do
    cedula = IO.gets("Ingrese la cédula del socio que desea buscar: ") |> String.trim()

    case Gimnasio.Validacion.validacion_cedula(cedula) do
      {:ok, cedula} ->
        {:ok, cedula}
      {:error, razon} ->
        IO.inspect(razon, label: "Hay un error al ingresar la cédula #{razon}")
        solicitar_cedula()
    end
  end
end
