defmodule Inventario.Productoo do
  @enforce_keys [:codigo, :nombre, :precio, :cantidad]
  defstruct [:codigo, :nombre, :precio, :cantidad]
  # Nota: Mapa para clave: código y valor: struct producto
end
