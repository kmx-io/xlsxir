defmodule Xlsxir.ConvertDate do
  @moduledoc """
  Converts an ISO 8601 date format serial number, in `char_list` format, to a date formatted in
  Erlang `:calendar.date()` type format (i.e. `{year, month, day}`).
  """

  @doc """
  Receives an ISO 8601 date format serial number and returns a date formatted in Erlang `:calendar.date()`
  type format.

  ## Parameters

  - `serial` - ISO 8601 date format serial in `char_list` format (i.e. 4/30/75 as '27514')

  ## Example

      iex> Xlsxir.ConvertDate.from_serial('27514')
      {1975, 4, 30}
  """
  def from_serial(serial) do
    f_serial = List.to_integer(serial)
    # Convert to gregorian days and get date from that
    gregorian = f_serial - 2 +               # adjust two days for first and last day since base year
                date_to_days({1900, 1, 1})   # Add days in base year 1900
    gregorian
    |> days_to_date
  end

  defp date_to_days(date), do: :calendar.date_to_gregorian_days(date)

  defp days_to_date(days), do: :calendar.gregorian_days_to_date(days)
end
