defmodule Util do
  @moduledoc """
  Modulo con funciones que se reutilizan
  - autor : Andres
  - fecha : 19/08/2025
  - licencia : GNU GPL v3
  """
  def mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end

  def ingresar(mensaje, :entero), do: ingresar(mensaje, &String.to_integer/1, :entero)

  def ingresar(mensaje, :real), do: ingresar(mensaje, &String.to_float/1, :real)

  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  defp ingresar(mensaje, parser, tipo_dato) do
    try do
      mensaje
      |> ingresar(:texto)
      |> parser.()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un número #{tipo_dato}\n"
        |> mostrar_error()

        mensaje
        |> ingresar(parser, tipo_dato)
    end
  end

  def mostrar_error(mensaje) do
    IO.puts(:standard_error, mensaje)
  end

  def ingresarPorVentana(mensaje, :texto) do
    case System.cmd("java", ["-cp", ".", "Mensaje1", "input", mensaje]) do
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
