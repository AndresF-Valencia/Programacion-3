defmodule Punto3 do
  @moduledoc """
  Módulo para validar contraseñas bajo ciertos criterios de seguridad.

  Reglas de validación:
  1. Debe tener al menos 8 caracteres.
  2. Debe contener al menos una letra mayúscula.
  3. Debe contener al menos un número.
  4. No debe contener espacios.

  El programa permite al usuario ingresar una contraseña y valida si cumple
  o no con las condiciones, mostrando mensajes específicos de error en caso contrario.
  """

  @doc """
  Método principal de ejecución.

  Flujo:
    1. Solicita al usuario ingresar una contraseña.
    2. Valida la contraseña usando `validar_contrasena/1`.
    3. Muestra el resultado:
       - Mensaje positivo si cumple todos los criterios.
       - Lista de errores en caso de que falle en uno o más criterios.
  """
  def main do
    Util.mostrar_mensaje("--- Validador de Contraseñas ---")

    contrasena_ingresada = Util.ingresar("Ingrese una contraseña para validar: ", :texto)
    resultado = validar_contrasena(contrasena_ingresada)

    case resultado do
      {:ok, mensaje} ->
        Util.mostrar_mensaje("\n✅ " <> mensaje)

      {:error, lista_errores} ->
        Enum.each(lista_errores, fn error ->
          Util.mostrar_mensaje("\n❌ " <> error)
        end)
    end
  end

  @doc """
  Valida una contraseña en base a las reglas definidas.

  ## Parámetros
    - `contrasena`: La contraseña ingresada como cadena de texto.

  ## Retorna
    - `{:ok, "Contraseña segura"}` si cumple con todas las reglas.
    - `{:error, lista_de_errores}` si falla en una o más validaciones.
  """
  def validar_contrasena(contrasena) do
    errores = []
    |> verificar_longitud(contrasena)
    |> verificar_espacios(contrasena)
    |> verificar_mayuscula(contrasena)
    |> verificar_numero(contrasena)

    if errores == [] do
      {:ok, "Contraseña segura"}
    else
      {:error, errores}
    end
  end

  @doc """
  Verifica si la contraseña tiene al menos 8 caracteres.

  ## Retorna
    - Lista de errores actualizada.
  """
  defp verificar_longitud(errores, contrasena) do
    if String.length(contrasena) < 8 do
      errores ++ ["La contraseña debe tener al menos 8 caracteres."]
    else
      errores
    end
  end

  @doc """
  Verifica si la contraseña contiene espacios.

  ## Retorna
    - Lista de errores actualizada.
  """
  defp verificar_espacios(errores, contrasena) do
    if String.contains?(contrasena, " ") do
      errores ++ ["La contraseña no debe contener espacios."]
    else
      errores
    end
  end

  @doc """
  Verifica si la contraseña contiene al menos una letra mayúscula.

  ## Retorna
    - Lista de errores actualizada.
  """
  defp verificar_mayuscula(errores, contrasena) do
    if String.downcase(contrasena) == contrasena do
      errores ++ ["La contraseña debe contener al menos una letra mayúscula."]
    else
      errores
    end
  end

  @doc """
  Verifica si la contraseña contiene al menos un número.

  ## Retorna
    - Lista de errores actualizada.
  """
  defp verificar_numero(errores, contrasena) do
    numeros = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    if Enum.any?(numeros, fn n -> String.contains?(contrasena, n) end) do
      errores
    else
      errores ++ ["La contraseña debe contener al menos un número."]
    end
  end
end

Punto3.main()
