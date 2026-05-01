defmodule Gimnasio.Interfaz do

  def main do
    socios = Gimnasio.Persistencia.cargar_todos_socios()
    main(socios)
  end

  def main(socios) do
    IO.puts("Bienvenido al sistema de gestión Gimnasio ")
    opcion = IO.gets(" Opción por las cuales puede navegar
    1. Registrar un usuario
    2. Actualizar usuario
    3. Eliminar usuario
    4. Listar socios
    5. Ver estadisticas
    Seleccione la opción: ") |> String.trim() |>String.to_integer()

    case opcion do
      1 ->
        {cedula, nombre, edad} = Gimnasio.Solicitud.solicitud_registro()
        case Gimnasio.Services.agregar_socio(socios, cedula, nombre, edad) do
          {:ok, socios} ->
            {:ok, socios} = inscribir_clase?(socios)
            IO.puts("----- Proceso finalizado -----------")
            main(socios)
          {:error, razon} ->
            IO.puts("--------------------------")
            IO.inspect(razon, label: "Error:")
            IO.puts("------------------------")
            main()
        end
      2->
        IO.puts("Actualización")
        {:ok, socios} = solicitar_datos_actualizacion(socios)
        IO.puts("--- Usuario Actualizado -------")
        main(socios)
      3->
        IO.puts("Eliminar usuarios ")
        {:ok, socios} = solicitar_datos(socios)
        IO.puts("---- Usuario eliminado --------")
        main(socios)
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

  defp inscribir_clase?(socios) do
    opcion = IO.gets("¿Desea registrar alguna clase a un usuario?
    1. Si
    2. No
    ") |> String.trim() |> String.to_integer()

    case opcion do
      1 ->
        cedula = IO.gets("Ingerse la cédula del usuario: ") |> String.trim()
        clase = IO.gets("Ingrese el nombre de la clase: ") |> String.trim()
        case Gimnasio.Services.inscribir_clase(socios, cedula, clase) do
          {:ok, socios} ->
            main(socios)
          {:error, razon} ->
            IO.puts("Error al ejecutar el registro: #{razon} ")
            main(socios)
        end
        inscribir_clase?(socios)
        {:ok, socios}
      2 ->
        {:ok, socios}
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

  case Gimnasio.Services.actualizar_socio(socios, cedula, nombre, edad) do
    {:ok, socios} ->
      main(socios)
    {:error, razon} ->
      IO.puts("-----------------------------")
      IO.inspect(razon, label: "Error en el sistema: ")
      IO.puts("------------------------------")
      main(socios)
  end
  end

  # def validar_datos({cedula, nombre, edad}) do
  #   if cedula == "" && nombre == ""  && edad == "" do
  #   IO.inspect({:error, "No hay valores "})
  #   main()
  # else
  #   {cedula, nombre, edad}
  # end
  # end

end

Gimnasio.Interfaz.main()
