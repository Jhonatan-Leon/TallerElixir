defmodule Gimnasio.Validacion do
  def validacion_datos({cedula, nombre, edad}) do
    IO.inspect({cedula, nombre, edad})
  if cedula == "" || nombre == "" || edad == "" do
    {:error, "Se necesitan todos los datos o el formato de edad es incorrecto"}
  else
    {:ok, {cedula, nombre, edad |> String.to_integer()}}
  end
end

  def validacion_cedula(cedula) do
  if cedula == "", do: {:error, "Se necesita la cedula"}, else: {:ok, cedula}
  end
end
