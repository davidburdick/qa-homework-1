defmodule HomeworkTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case

  # Start hound session and destroy when tests are run
  hound_session()

  setup_all do
    IO.puts("Starting homework test")
    :ok
  end

  setup context do
    IO.puts("Running: #{context.test}")
    :ok

    on_exit(fn ->
      IO.puts("ENDED: #{context.test}" )
    end)
  end

  test "goes to google" do
    navigate_to "http://google.com"
    assert Enum.count(window_handles()) == 1
  end
end