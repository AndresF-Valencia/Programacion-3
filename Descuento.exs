defmodule Aplicar_Descuento do
  def main do
    nombre =
      "Ingrese su nombre: "
      |> Util.ingresar(:texto)
    cedula =
      "Ingrese su cedula: "
      |> Util.ingresar(:entero)
      descuento = aplica_descuento?(cedula)
      if descuento == true do
        generar_mensaje(nombre)
        |> Util.mostrar_mensaje()
      end
  end

  defp aplica_descuento?(cedula) when rem(cedula, 1991) == 0, do: true
  defp aplica_descuento?(_, _), do: false

  defp generar_mensaje(nombre) do
    "Hola #{nombre} tienes un 50% de descuento"
  end
end

Aplicar_Descuento.main()
