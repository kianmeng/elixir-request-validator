defmodule Request.Validator.Rules do

  @spec required(any(), nil, binary()) :: true|binary()
  def required(value, _, field) do
    cond do
      is_number(value) || !is_nil(value) && String.length(value) > 0 -> true
      is_nil(value) || true -> "The #{field} is required."
    end
  end

  @spec email(binary(), nil, binary()) :: true|binary()
  def email(value, _, field) do
    if EmailChecker.valid?(value || ""), do: true, else: "The #{field} is an invalid email or doesn't exists."
  end

  @spec string(binary(), nil, binary()) :: true|binary()
  def string(value, _, field) do
    if is_binary(value), do: true, else: "The #{field} must be a string."
  end

  @spec numeric(number(), nil, binary()) :: true|binary()
  def numeric(value, _, field) do
    if is_number(value), do: true, else: "The #{field} must be a number."
  end

  @spec max(binary()|number()|list(), integer(), binary()) :: true|binary()
  def max(value, max, field) do
    cond do
      is_number(value) && value > max ->
        "The #{field} may not be greated than #{max}"
      is_binary(value) && String.length(value) > max ->
        "The #{field} may not be greated than #{max} characters"
      is_list(value) && Enum.count(value) > max ->
        "The #{field} may not have more than #{max} items"
      true -> true
    end
  end

  @spec min(binary()|number()|list(), integer(), binary()) :: true|binary()
  def min(value, min, field) do
    cond do
      is_number(value) && value < min ->
        "The #{field} must be at least #{min}"
      is_binary(value) && String.length(value) < min ->
        "The #{field} must be at least #{min} characters"
      is_list(value) && Enum.count(value) < min ->
        "The #{field} must have at least #{min} items"
      true -> true
    end
  end
end
