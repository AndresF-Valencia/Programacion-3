defmodule ContarLetras do
  def main do
    "Ingrese un mensaje: "
    |> Util.ingresarPorVentana(:texto)
    |> contar_letras()
    |> Util.mostrar_mensaje()
  end
  defp contar_letras(mensaje) do
    mensaje
    |> String.length()
    |> Integer.to_string()
  end
end

ContarLetras.main()
