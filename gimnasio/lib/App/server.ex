# defmodule Server do

#   def main do
#     Inicializar
#     socios = Gimnasio.Persistencia.cargar_todos_socios

#     Agregar socios
#     {:ok, socios} = Gimnasio.Services.agregar_socio(socios, "123", "Juan Pérez", 30)
#     {:ok, socios} = Gimnasio.Services.agregar_socio(socios, "456", "María García", 25)
#     {:ok, socios} = Gimnasio.Services.agregar_socio(socios, "789", "Carlos López", 35)

#     Intentar agregar duplicado
#     case Gimnasio.Services.agregar_socio(socios, "123", "Otro Juan", 28) do
#       {:error, :cedula_duplicada} ->
#         IO.puts("No se puede agregar: cédula duplicada")
#       {:ok, _} ->
#         IO.puts("Socio agregado")
#     end

#     Inscribir en clases
#     {:ok, socios} = Gimnasio.Services.inscribir_clase(socios, "123", "Yoga")
#     {:ok, socios} = Gimnasio.Services.inscribir_clase(socios, "123", "Pilates")
#     {:ok, socios} = Gimnasio.Services.inscribir_clase(socios, "456", "Spinning")

#     Intentar inscribir duplicado
#     case Gimnasio.Services.inscribir_clase(socios, "123", "Yoga") do
#       {:error, :ya_inscrito} ->
#         IO.puts("Ya está inscrito en esa clase")
#       {:ok, _} ->
#         IO.puts("Inscrito en clase")
#     end

#     Mostrar información
#     case Gimnasio.Services.obtener_socio(socios, "123") do
#       {:ok, socio} ->
#         IO.puts("\n=== Socio 123 ===")
#         IO.inspect(socio)
#       {:error, _} ->
#         IO.puts("Socio no encontrado")
#     end

#     Estadísticas
#     stats = Gimnasio.Services.obtener_estadisticas(socios)
#     IO.puts("\n=== Estadísticas ===")
#     IO.inspect(stats)

#     Listar socios en una clase
#     IO.puts("\n=== Socios en Yoga ===")
#     socios_yoga = Gimnasio.Services.socios_en_clase(socios, "Yoga")
#     Enum.each(socios_yoga, &IO.puts(&1.nombre))

#     Actualizar socio
#     {:ok, socios} = Gimnasio.Services.actualizar_socio(socios, "123", "Juan Pérez Gómez", 31)

#     Eliminar socio
#     {:ok, socios} = Gimnasio.Services.eliminar_socio(socios, "789")

#     Mostrar todos
#     IO.inspect(Gimnasio.Services.listar_socios(socios))
#   end
# end


# Server.main()
