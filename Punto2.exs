defmodule Punto2 do
  @moduledoc """
  Sistema simple de **control de reservas de salas**.

  Este módulo permite:
  - Definir un inventario inicial de salas con sillas disponibles.
  - Solicitar al usuario una sala y la cantidad de sillas a reservar.
  - Validar la reserva:
    - Si la sala existe y tiene suficientes sillas → se descuenta del inventario.
    - Si no hay suficientes sillas → se rechaza la reserva.
    - Si la sala no existe → se muestra un mensaje de error.
  - Mostrar el estado actualizado del inventario.

  ## Flujo de uso
  1. El programa carga el inventario inicial (`salas/0`).
  2. Pide al usuario la sala a reservar y la cantidad de sillas.
  3. Llama a `reservar_sillas/3` para procesar la solicitud.
  4. Muestra el mensaje de confirmación o error y el inventario actualizado.
  """

  @doc """
  Punto de entrada del programa.
  Llama a las funciones auxiliares para:
  - Obtener el inventario inicial.
  - Solicitar los datos de reserva al usuario.
  - Procesar la reserva.
  - Mostrar el resultado y el estado final del inventario.
  """
  def main do
    mapa_salas = salas()

    Util.mostrar_mensaje("--- Control de Reservas ---")

    sala_a_reservar =
      Util.ingresar("Ingrese el número de la sala (sala1, sala2, sala3): ", :texto)

    cantidad_a_reservar =
      Util.ingresar("Ingrese la cantidad de sillas a reservar: ", :entero)

    {nuevo_mapa, mensaje} = reservar_sillas(mapa_salas, sala_a_reservar, cantidad_a_reservar)

    Util.mostrar_mensaje(mensaje)

    Util.mostrar_mensaje("\nEstado del inventario de salas:")
    IO.inspect(nuevo_mapa)
  end

  @doc """
  Devuelve un mapa con las salas disponibles y la cantidad de sillas iniciales.

  ## Ejemplo
      iex> Punto2.salas()
      %{"sala1" => 10, "sala2" => 25, "sala3" => 5}
  """
  def salas do
    %{
      "sala1" => 10,
      "sala2" => 25,
      "sala3" => 5
    }
  end

  @doc """
  Procesa una solicitud de reserva de `cantidad` sillas en la `sala`.

  - Si la sala existe y tiene suficientes sillas → devuelve el mapa actualizado y un mensaje de éxito.
  - Si la sala existe pero no hay suficientes sillas → devuelve el mapa original y un mensaje de error.
  - Si la sala no existe → devuelve el mapa original y un mensaje de error.

  ## Parámetros
    - `salas`: mapa con el inventario actual.
    - `sala`: cadena con el nombre de la sala (`"sala1"`, `"sala2"`, etc.).
    - `cantidad`: número entero con la cantidad de sillas a reservar.

  ## Retorna
    Una tupla `{nuevo_mapa, mensaje}`:
    - `nuevo_mapa`: mapa con el inventario actualizado (o igual si no se pudo reservar).
    - `mensaje`: string con el resultado de la operación.

  ## Ejemplo
      iex> Punto2.reservar_sillas(%{"sala1" => 10}, "sala1", 5)
      {%{"sala1" => 5}, "Se reservaron 5 sillas en la sala sala1. Sillas libres restantes: 5"}
  """
  defp reservar_sillas(salas, sala, cantidad) do
    if Map.has_key?(salas, sala) do
      sillas_disponibles = Map.get(salas, sala)

      if cantidad <= sillas_disponibles do
        nuevo_mapa_salas = Map.put(salas, sala, sillas_disponibles - cantidad)

        {nuevo_mapa_salas,
         "Se reservaron #{cantidad} sillas en la sala #{sala}. " <>
           "Sillas libres restantes: #{sillas_disponibles - cantidad}"}
      else
        {salas,
         "No hay suficientes sillas disponibles en la sala #{sala}. " <>
           "Sillas libres: #{sillas_disponibles}"}
      end
    else
      {salas, "Sala no encontrada."}
    end
  end
end

Punto2.main()

