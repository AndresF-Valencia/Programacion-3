defmodule Punto1 do
  @moduledoc """
  Módulo para calcular el costo de envío de un paquete
  según el peso, el tipo de cliente y el tipo de servicio.

  Flujo:
    1. El usuario ingresa el peso del paquete.
    2. Selecciona el tipo de cliente:
       - 1: Corporativo (15% de descuento).
       - 2: Estudiante (10% de descuento).
       - 3: Regular (sin descuento).
    3. Selecciona el tipo de servicio:
       - 1: Express (25% de recargo).
       - 2: Estandar (sin recargo).
    4. Se calcula:
       - Tarifa base por peso.
       - Costo con descuento.
       - Costo final con recargo.
    5. Se muestra un desglose del cálculo.
  """

  @doc """
  Punto de entrada del programa.
  Solicita los datos al usuario, calcula el costo final del envío y muestra
  un desglose con la tarifa base, descuentos y recargos aplicados.
  """
  def main do
    peso = Util.ingresar("Ingrese el peso del paquete: ", :real)

    Util.mostrar_mensaje("\nSeleccione el tipo de cliente:")
    Util.mostrar_mensaje("1. Corporativo")
    Util.mostrar_mensaje("2. Estudiante")
    Util.mostrar_mensaje("3. Regular")
    tipo_cliente_num = Util.ingresar("Opción: ", :entero)

    Util.mostrar_mensaje("\nSeleccione el tipo de servicio:")
    Util.mostrar_mensaje("1. Express")
    Util.mostrar_mensaje("2. Estandar")
    tipo_servicio_num = Util.ingresar("Opción: ", :entero)

    # Convertir selección numérica en átomos o strings internos
    tipo_cliente =
      case tipo_cliente_num do
        1 -> :corporativo
        2 -> :estudiante
        3 -> :regular
        _ -> :regular
      end

    tipo_servicio =
      case tipo_servicio_num do
        1 -> "express"
        2 -> "estandar"
        _ -> "estandar"
      end

    tarifa_base = calcular_tarifa_base(peso)
    costo_con_descuento = aplicar_descuento(tarifa_base, tipo_cliente)
    costo_final = aplicar_recargo(costo_con_descuento, tipo_servicio)

    Util.mostrar_mensaje("\n--- Desglose de Cálculo ---")
    Util.mostrar_mensaje("Tarifa base por peso: $#{tarifa_base}")
    Util.mostrar_mensaje("Costo con descuento: $#{Float.round(costo_con_descuento, 2)}")
    Util.mostrar_mensaje("Costo con recargo: $#{Float.round(costo_final, 2)}")
    Util.mostrar_mensaje("--- Total ---")
    Util.mostrar_mensaje("El costo total del envío es: $#{Float.round(costo_final, 2)}")
  end

  @doc """
  Calcula la tarifa base del envío según el peso en kilogramos.

  - Si `peso <= 1` → $8000.
  - Si `1 < peso <= 5` → $12000.
  - Si `peso > 5` → $20000.

  Lanza un error si el peso es `<= 0`.
  """
  defp calcular_tarifa_base(peso) when peso > 0 do
    cond do
      peso == 1 -> 8000
      peso <= 5 && peso > 1 -> 12000
      peso > 5 -> 20000
    end
  end

  defp calcular_tarifa_base(peso) do
    raise ArgumentError, "El peso debe ser mayor que 0, se ingresó: #{peso}"
  end

  @doc """
  Aplica un descuento sobre la tarifa base según el tipo de cliente:

  - `:corporativo` → 15% de descuento (paga 85%).
  - `:estudiante` → 10% de descuento (paga 90%).
  - `:regular` → sin descuento.

  Devuelve el costo después del descuento.
  """
  defp aplicar_descuento(costo, :corporativo), do: costo * 0.85
  defp aplicar_descuento(costo, :estudiante), do: costo * 0.90
  defp aplicar_descuento(costo, :regular), do: costo
  defp aplicar_descuento(costo, _), do: costo

  @doc """
  Aplica un recargo sobre el costo (ya con descuento aplicado) según el servicio:

  - `"express"` → 25% de recargo (paga 125%).
  - `"estandar"` → sin recargo.

  Devuelve el costo después del recargo.
  """
  defp aplicar_recargo(costo, "express"), do: costo * 1.25
  defp aplicar_recargo(costo, "estandar"), do: costo
  defp aplicar_recargo(costo, _), do: costo
end

Punto1.main()
