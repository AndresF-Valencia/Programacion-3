defmodule SalarioNeto do
  def main do
    nombre = "Ingrese el nombre del empleado: "
    |> Util.ingresarPorVentana(:texto)
    horas = "Ingrese las horas trabajadas: "
    |> Util.ingresarPorVentana(:texto)
    |> String.to_integer()
    valor = "Ingrese el valor de la hora: "
    |> Util.ingresarPorVentana(:texto)
    |> String.to_integer()
    mostrar_salario({nombre,horas,valor})
  end
  defp calcular_salario_neto(horas_totales, valor_hora) do
    if horas_totales > 160 do
      horas_extra = horas_totales - 160
      salario_base = valor_hora * horas_totales
      pago_extra = horas_extra * valor_hora * 1.25
      salario_base + pago_extra
    else
      horas_totales * valor_hora
    end
  end
  def mostrar_salario({nombre, horas, valor}) do
    salario = calcular_salario_neto(horas, valor)
    mensaje =
    "Empleado: #{nombre}, Horas trabajadas: #{horas}, Salario neto: #{salario}"
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])
  end
end

SalarioNeto.main()
