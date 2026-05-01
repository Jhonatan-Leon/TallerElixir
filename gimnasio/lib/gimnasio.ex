defmodule GimnasioApp do
  use Application
  def start(_type, _args) do
    Gimnasio.Interfaz.main()
    {:ok, self()}
  end
end
