defmodule Metodos_aux do
  @vocales ["a", "e", "i", "o", "u"]

  def tiene_al_menos_dos_vocales?(x) when is_binary(x) do
    conteo =
      String.downcase(x)
      |> String.graphemes()
      |> Enum.count(fn letra -> letra in @vocales end)

      conteo >= 2
  end
end
