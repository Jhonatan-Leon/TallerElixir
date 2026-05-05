defmodule Producto do
  @derive [Jason.Encoder]
  @enforce_keys [:codigo,:nombre,:precio,:cantidad]
  defstruct [:codigo,:nombre,:precio,:cantidad]

  def nuevo(codigo, nombre, precio, cantidad)
    when precio >= 0
          and cantidad >= 0
          and byte_size(codigo) >= 5
          and is_number(cantidad)
          and cantidad >= 0 do
    {:ok, %__MODULE__{codigo: codigo,nombre: nombre,precio: precio,cantidad: cantidad}}
  end

  def nuevo(_codigo,_nombre,_precio,_cantidad), do: {:error, :precio_cantidad_codigo_invalida}

end
