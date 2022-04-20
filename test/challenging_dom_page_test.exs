Code.require_file("test/dry_data/data.exs")

defmodule ChallengingDomPageTest do
  use Hound.Helpers
  use ExUnit.Case, async: true
  use TestDataAndDry

  import TestDataAndDry
  import Data

  hound_session()

  #JUnit report will be written to your /tmp directory.
  #@default_username, @default_password, goto_page function are in test/dry_data/test_data_and_dry.ex

  setup_all do
    IO.puts("Starting challenging_dom_page_test")
    :ok
  end

  setup context do
    IO.puts("Running: #{context.test}")
    :ok

    on_exit(fn ->
      IO.puts("ENDED: #{context.test}")
    end)
  end

  test "Verify https://the-internet.herokuapp.com/challenging_dom page loads" do
      navigate_to @default_url_challenging_dom
      assert(@default_url_challenging_dom == current_url())
  end

  test "Verify text on challenging dom page" do
    navigate_to @default_url_challenging_dom
    assert visible_text({:xpath, "//div[@id='content']//h3"}) == "Challenging DOM"
    assert visible_text({:xpath, "//div[@id='content']//p"}) == "The hardest part in automated web testing is finding the best locators (e.g., ones that well named, unique, and unlikely to change). It's more often than not that the application you're testing was not built with this concept in mind. This example demonstrates that with unique IDs, a table with no helpful locators, and a canvas element."
  end

  test "Verify blue button" do
    navigate_to @default_url_challenging_dom
    assert {:ok, _} = search_element(:xpath, "//div[@id='content']/div[@class='example']/div/div/div[1]/a[1]")
  end

  test "Verify red button" do
    navigate_to @default_url_challenging_dom
    assert {:ok, _} = search_element(:xpath, "/html//div[@id='content']/div[@class='example']/div/div/div[1]/a[2]")
  end

  test "Verify green button" do
    navigate_to @default_url_challenging_dom
    assert {:ok, _} = search_element(:xpath, "/html//div[@id='content']/div[@class='example']/div/div/div[1]/a[3]")
  end

  #need to add code that reads ID before click of button and then reads it after the click and makes sure it's different
  test "Validate Ids in buttons != when clicked" do
    navigate_to @default_url_challenging_dom
  end

  test "Validate Table Header Row" do
    navigate_to @default_url_challenging_dom
    assert {:ok, _} = search_element(:xpath, "//div[@id='content']/div[@class='example']//table//th[.='Lorem']")
    assert {:ok, _} = search_element(:xpath, "//div[@id='content']/div[@class='example']//table//th[.='Ipsum']")
    assert {:ok, _} = search_element(:xpath, "//div[@id='content']/div[@class='example']//table//th[.='Dolor']")
    assert {:ok, _} = search_element(:xpath, "//div[@id='content']/div[@class='example']//table//th[.='Sit']")
    assert {:ok, _} = search_element(:xpath, "//div[@id='content']/div[@class='example']//table//th[.='Amet']")
    assert {:ok, _} = search_element(:xpath, "//div[@id='content']/div[@class='example']//table//th[.='Diceret']")
    assert {:ok, _} = search_element(:xpath, "//div[@id='content']/div[@class='example']//table//th[.='Action']")
  end

  test "Validate Row Count and Iterate Over Rows" do
    navigate_to @default_url_challenging_dom
    #need code to iterate over the rows and validate the text plus #
  end

  test "Verify Footer" do
    footer_check(@default_url_challenging_dom)
  end
  end