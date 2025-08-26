defmodule EcoMensaje do
  def main do
    "Ingrese un mensaje: "
    |> Util.ingresarPorVentana(:texto)
    |> generar_mensaje()
    |> Util.mostrar_mensaje()
  end
  defp generar_mensaje(mensaje) do
    mensaje
    |> String.upcase()
  end
end

EcoMensaje.main()
