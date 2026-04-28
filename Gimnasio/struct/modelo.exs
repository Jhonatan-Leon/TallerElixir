defmodule Gimansio.Socio do
  @enforce_keys [:nombre, :edad]
  defstruct  [:cedula, :nombre, :edad, clases: []]
end
