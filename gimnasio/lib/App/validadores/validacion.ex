defmodule Gimnasio.Validacion do
  def validacion_datos({cedula, nombre, edad}) do
    IO.puts(edad)
    if cedula == "" && nombre == "" && edad == "" do
      {:error, "Error se necesitan los datos"}
    else
      {:ok, {cedula, nombre, edad |> String.to_integer()}}
    end
  end

end
