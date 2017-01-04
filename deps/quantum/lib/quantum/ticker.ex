defmodule Quantum.Ticker do

  # A ticker is a process that runs every N seconds

  @moduledoc false

  use GenServer

  @doc "Starts a job with sub-minute resolution"
  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end


  def timezone_function do
    case Application.get_env(:quantum, :timezone, :utc) do
      :utc ->
        &:calendar.now_to_universal_time/1
      :local ->
        &:calendar.now_to_local_time/1
      timezone ->
        raise "Unsupported timezone: #{timezone}"
    end
  end

  def tick do
    {d, {h, m, s}} = timezone_function.(:os.timestamp)
    Process.send_after(self, :tick, (60 - s) * 1000)
    {d, h, m}
  end

end
