defmodule ApiTest do
  use Hound.Helpers
  use ExUnit.Case
  use TestDataAndDry

  import TestDataAndDry

  #JUnit report will be written to your /tmp directory.

  setup_all do
    IO.puts("Starting api_tests")
    :ok
  end

  setup context do
    IO.puts("Running: #{context.test}")
    :ok

    on_exit(fn ->
      IO.puts("ENDED: #{context.test}")
    end)
  end

  test "Test Login Successful" do
    request_headers = [{"Content-type", "application/json"}]
    request_body = %{email: "eve.holt@reqres.in",password: "cityslicka"} |> Jason.encode!()
    json_response = HTTPoison.post!("https://reqres.in/api/login", request_body, request_headers)
    decoded_response =Jason.decode!("#{json_response.body}")

    assert json_response.status_code == 200
    assert decoded_response == %{"token" => "QpwL5tke4Pnpja7X4"}
  end

  test "Test Login User Not Found" do
    request_headers = [{"Content-type", "application/json"}]
    request_body = %{email: "eve.ho@what.com",password: "citysl"} |> Jason.encode!()
    json_response = HTTPoison.post!("https://reqres.in/api/login", request_body, request_headers)
    decoded_response =Jason.decode!("#{json_response.body}")

    assert json_response.status_code == 400
    assert decoded_response == %{"error" => "user not found"}
  end
end