defmodule Util do
  @moduledoc """
  Modulo con funciones que se reutilizan
  - autor : Andres
  - licencia : GNU GPL v3
  """
  def mostrar_mensaje(mensaje) do
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])
  end
  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end
  def ingresarPorVentana(mensaje, :texto) do
    case System.cmd("java", ["-cp", ".", "EcoMensaje", "input", mensaje]) do
      {output, 0} ->
        IO.puts("Texto ingresado correctamente.")
        IO.puts("Entrada: #{output}")
        String.trim(output)
      {error, code} ->
        IO.puts("Error al ingresar el texto. Codigo: #{code}")
        IO.puts("Detalles: #{error}")
        nil
    end
  end
end
