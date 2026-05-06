defmodule Gimnasio.Interfaz do

  def main do
    socios = Gimnasio.Persistencia.cargar_todos_socios()
    main(socios)
  end

  def main(socios) do
    IO.puts("Bienvenido al sistema de gestión Gimnasio ")
    opcion = IO.gets(" Opción por las cuales puede navegar
    1. Registrar un socio
    2. Actualizar socio
    3. Eliminar socio
    4. Listar socios
    5. Buscar a un socio
    6. Listar socios de una clase en específico
    7. Listar todas las clases de un socio
    8. Desincribir de una clase
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
            IO.inspect("Error: #{razon}")
            IO.puts("------------------------")
            main()
        end
      2->
        IO.puts("Actualización")
        {cedula, nombre, edad} = Gimnasio.Solicitud.solicitar_actualizacion()
        case Gimnasio.Services.actualizar_socio(socios, cedula, nombre, edad) do
          {:ok, socios} ->
              IO.puts("--- Usuario Actualizado -------")
              main(socios)
          {:error, razon} ->
            IO.puts("Error al actualizar socio: #{razon}")
            main(socios)
        end

      3->
        IO.puts("Eliminar usuarios ")
        {:ok, cedula} = Gimnasio.Solicitud.solicitar_cedula()
        case Gimnasio.Services.eliminar_socio(socios, cedula) do
          {:ok, socios} ->
            IO.puts("---- Usuario eliminado --------")
            main(socios)
          {:error, razon} ->
          IO.puts("Error al eliminar socios: #{razon}")
          main(socios)
        end

      4 ->
        IO.puts("Lista de socios ")
        lista = Gimnasio.Services.listar_socios(socios)
        IO.inspect(lista)
        main()
      5 ->
        IO.puts("---- Buscar socio -------")
        {:ok, cedula} = Gimnasio.Solicitud.solicitar_cedula()
        case Gimnasio.Services.obtener_socio(socios, cedula) do
          {:ok, socio} ->
            IO.puts("==== Socio ====")
            IO.inspect(socio)
            IO.puts("---------------")
            main(socios)
          {:error, razon} ->
            IO.inspect( "Error al buscar socio: #{razon}")
            main(socios)
        end
      6 ->
        IO.puts("Listar a socios de una clase en especifico ")
        clase = IO.gets("ingrese una clase: ") |> String.trim()
        case Gimnasio.Services.socios_en_clase(socios, clase) do
          socio ->
            IO.puts("--------Socios ------------")
              Enum.each(socio, fn s -> IO.puts(s.nombre) end)
              IO.puts("---------------------------")
              main(socios)
        end

      7 ->
        IO.puts("Listar las clases de un socio")
        {:ok, cedula} = Gimnasio.Solicitud.solicitar_cedula()
        case Gimnasio.Services.obtener_socio(socios, cedula) do
          {:error, razon} ->
            IO.puts("Error al buscar socio: #{razon}")
            main(socios)
          {:ok, socio} ->
            IO.puts("---- #{socio.nombre}-----")
            IO.puts("----- Clases -------")
            Enum.each(socio.clases, fn clase -> IO.puts(clase) end)
            main(socios)
        end
      8->
        IO.puts("Desinscribir deu na clase: ")
        cedula = IO.gets("Ingrese la cedula del socio: ") |> String.trim()
        clase = IO.gets("Ingrese el nombre de la clase: ") |> String.trim()
        case Gimnasio.Services.obtener_socio(socios, cedula) do
          {:ok, socio} ->
            case Socio.desinscribir_clase(socio, clase) do
              {:ok, socios} ->
                IO.puts("---- Socio desinscrito de la clase ---------")
                main(socios)
            end
          {:error, razon} ->
            IO.puts("Error al desinscribir un socio #{razon}")
            main(socios)
        end

      _ ->
        IO.puts("Valor no aceptado ")
        main(socios)
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
            inscribir_clase?(socios)
          {:error, razon} ->
            IO.puts("Error al ejecutar el registro: #{razon} ")
            main(socios)
        end
      2 ->
        {:ok, socios}
    end

  end

end
