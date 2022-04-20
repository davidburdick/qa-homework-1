Code.require_file("test/dry_data/data.exs")

defmodule AddRemoveElementsPageTest do
  use Hound.Helpers
  use ExUnit.Case, async: true
  use TestDataAndDry

  import TestDataAndDry
  import Data

  hound_session()

  #JUnit report will be written to your /tmp directory.
  #@default_username, @default_password, goto_page function are in test/dry_data/test_data_and_dry.ex

  setup_all do
    IO.puts("Starting add_remove_elements_page_test")
    :ok
  end

  setup context do
    IO.puts("Running: #{context.test}")
    :ok

    on_exit(fn ->
      IO.puts("ENDED: #{context.test}")
    end)
  end

  test "Verify https://the-internet.herokuapp.com/add_remove_elements/ page loads" do
    navigate_to @default_url_addremove_page
    assert(@default_url_addremove_page == current_url())
  end

  test "Verify Add/Remove Main Text" do
    navigate_to @default_url_addremove_page
    assert visible_text({:css, "div#content > h3"}) == "Add/Remove Elements"
  end

  test "Add element on add_remove_elements page" do
    navigate_to @default_url_addremove_page

    assert("The Internet" == page_title())
    click(find_element(:xpath, "//div[@id='content']//button[.='Add Element']"))
    assert {:ok, _} = search_element(:class, "added-manually")
  end

  test "Delete element on add_remove_elements page" do
    navigate_to @default_url_addremove_page

    click(find_element(:xpath, "//div[@id='content']//button[.='Add Element']"))

    assert {:ok, _} = search_element(:class, "added-manually")
    click(find_element(:xpath, "//div[@id='elements']/button[@class='added-manually']"))

    #Newly Added Button Got Deleted
    assert {:error, :no_such_element} = search_element(:class, "added-manually")
  end

  #More tests should be written to do multiple buttons and deletes. Also if there is a limit of button creates.

  test "Verify Footer" do
    footer_check(@default_url_addremove_page)
  end
end