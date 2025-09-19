defmodule ListaEjemplo do
  def main do
    lista = [1,2,3,4,5,6]
    tupla = {:ok, "Exito", 200}
    mi_mapa = %{"nombre" => "Elixir", "version" => 1.15}
    mi_mapa_atom = %{nombre: "Elixir" , version: 1.15}

    Map.get(mi_mapa, "nombre")
    |> IO.inspect()
    Map.get(mi_mapa, "version")
    |> IO.inspect()

    mi_mapa_atom.nombre
    |> IO.inspect()
    mi_mapa_atom.version
    |> IO.inspect()

    Enum.filter(lista, fn x -> x < 4 end)
    |> IO.inspect()

    elem(tupla, 2)
    |> IO.puts()
    nueva_tupla = put_elem(tupla, 2, 404)
    IO.inspect(nueva_tupla)
  end
end

ListaEjemplo.main()
