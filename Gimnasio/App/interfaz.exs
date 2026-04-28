defmodule Gimnasio.Interfaz do
  Code.require_file("gimnasio.exs")
  Code.require_file("persistencia.exs")

  def main do
    socios = Gimnasio.Persistencia.cargar_todos_socios()

    IO.puts("Bienvenido al sistema de gestión Gimnasio ")
    opcion = IO.gets(" Opción por las cuales puede navegar
    1. Registrar un usuario
    2. Actualizar usuario
    3. Eliminar usuario
    4. Listar socios
    5. Ver estadisticas
    ") |> String.trim() |>String.to_integer()

    case opcion do
      1 ->
        {cedula, nombre, edad} = solicitar_datos_registro()
        {:ok, socios} = Gimnasio.Services.agregar_socio(socios, cedula, nombre, edad)
        inscribir_clase?(socios)
        IO.puts("----- Proceso finalizado -----------")
        main()
      2->
        IO.puts("Actualización")
        solicitar_datos_actualizacion(socios)
        IO.puts("--- Usuario Actualizado -------")
        main()
      3->
        IO.puts("Eliminar usuarios ")
        {:ok, socios} = solicitar_datos(socios)
        IO.puts("---- Usuario eliminado --------")
        main()
      4 ->
        IO.puts("Lista de socios ")
        lista = Gimnasio.Services.listar_socios(socios)
        IO.inspect(lista, label: "Lista de socios ")
        main()
      5 -> IO.puts("Estadisitcias ")
      _ ->
        IO.puts("Valor no aceptado ")
        main()
    end
  end

  defp solicitar_datos_registro do
    cedula = IO.gets("Ingrese su Número de documento: ") |> String.trim()
    nombre = IO.gets("Ingrese su nombre: ") |> String.trim()
    edad = IO.gets("Ingrese su edad: ") |> String.trim() |> String.to_integer()
    {cedula, nombre, edad}
  end

  defp inscribir_clase?(socios) do
    opcion = IO.gets("¿Desea registrar alguna clase a un usuario?
    1. Si
    2. No
    ") |> String.trim() |> String.to_integer()

    case opcion do
      1 ->
        cedula = IO.gets("Ingerse la cédula del usuario: ") |> String.trim()
        clase = IO.gets("Ingrese el nombre de la clase: ") |> String.trim()
        {:ok, socios} = Gimnasio.Services.inscribir_clase(socios, cedula, clase)
        inscribir_clase?(socios)
      2 ->
        main()
    end

  end

  defp solicitar_datos(socios) do
    cedula = IO.gets("Ingrese la cédula del usuario: ") |>String.trim()
    Gimnasio.Services.eliminar_socio(socios, cedula)
  end

  defp solicitar_datos_actualizacion(socios) do
    IO.puts("Ingrese los datos para a actualizar")
    cedula = IO.gets("Ingrese la cedula, para buscar al usuario  ") |> String.trim()
    nombre = IO.gets("Ingrese a el nuevo nombre: ") |> String.trim()
    edad = IO.gets("Ingrese la nueva edad de ese usuario: ") |> String.trim() |> String.to_integer()

    Gimnasio.Services.actualizar_socio(socios, cedula, nombre, edad)
  end
end

Gimnasio.Interfaz.main()
