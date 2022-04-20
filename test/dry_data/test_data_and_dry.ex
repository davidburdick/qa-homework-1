defmodule TestDataAndDry do
  use Hound.Helpers

  defmacro __using__(_) do
    quote do
      @default_username "tomsmith"
      @default_password "SuperSecretPassword!"
      @random_string Enum.to_list(?A..?Z) ++ Enum.to_list(?a..?z) ++ Enum.to_list(?0..?9) |> Enum.take_random(300)
      @default_url "https://the-internet.herokuapp.com"
      @default_url_login_page "https://the-internet.herokuapp.com/login"
      @default_url_addremove_page "https://the-internet.herokuapp.com/add_remove_elements/"
      @default_url_challenging_dom "https://the-internet.herokuapp.com/challenging_dom"
    end
    end
  end