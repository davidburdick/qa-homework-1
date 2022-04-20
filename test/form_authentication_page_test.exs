defmodule FormAuthenticationTest do
  use Hound.Helpers
  use ExUnit.Case, async: true
  use TestDataAndDry

  import TestDataAndDry

  hound_session()

  #JUnit report will be written to your /tmp directory.
  #@default_username, @default_password, goto_page function are in test/dry_data/test_data_and_dry.ex

  setup_all do
    IO.puts("Starting form_authentication_page_test")
    :ok
    end

   setup context do
     IO.puts("Running: #{context.test}")
      :ok

      on_exit(fn ->
       IO.puts("ENDED: #{context.test}" )
      end)
    end

  test "Verify user can go to the form authentication page" do
    navigate_to @default_url_login_page
    assert(@default_url_login_page == current_url())
  end

  test "Verify user can sign in as existing user" do
    navigate_to @default_url_login_page
    assert(@default_url_login_page == current_url())

    fill_field(find_element(:id, "username"), @default_username)
    assert attribute_value({:id, "username"}, "value") == @default_username

    fill_field(find_element(:id, "password"), @default_password)
    assert attribute_value({:id, "password"}, "value") == @default_password

    submit_element(find_element(:id, "login"))

    #assert(@default_url"/secure" == current_url())
    assert {:ok, _} = search_element(:id, "flash")
    assert visible_text({:id, "flash"}) == "You logged into a secure area!\n×"
    assert("https://the-internet.herokuapp.com/secure" == current_url())
    end

  test "Verify logged in user can log out" do
    navigate_to @default_url_login_page
    assert(@default_url_login_page == current_url())

    fill_field(find_element(:id, "username"), @default_username)
    assert attribute_value({:id, "username"}, "value") == @default_username

    fill_field(find_element(:id, "password"), @default_password)
    assert attribute_value({:id, "password"}, "value") == @default_password

    submit_element(find_element(:id, "login"))

    assert {:ok, _} = search_element(:id, "flash")
    assert visible_text({:id, "flash"}) == "You logged into a secure area!\n×"

    find_element(:link_text, "Logout")|> click
    assert visible_text({:id, "flash"}) == "You logged out of the secure area!\n×"
    end

    test "Verify invalid username cannot login" do
    navigate_to @default_url_login_page
    assert(@default_url_login_page == current_url())

    fill_field(find_element(:id, "username"), "5432543265$@$")
    assert attribute_value({:id, "username"}, "value") == "5432543265$@$"

    fill_field(find_element(:id, "password"), @default_password)
    assert attribute_value({:id, "password"}, "value") == @default_password

    submit_element(find_element(:id, "login"))

    assert(@default_url_login_page == current_url())
    assert {:ok, _} = search_element(:id, "flash")
    assert visible_text({:id, "flash"}) == "Your username is invalid!\n×"
    end

  test "Verify invalid password cannot login" do
    navigate_to @default_url_login_page
    assert(@default_url_login_page == current_url())

    fill_field(find_element(:id, "username"), @default_username)
    assert attribute_value({:id, "username"}, "value") == @default_username

    fill_field(find_element(:id, "password"), "fdsjkalf4243")
    assert attribute_value({:id, "password"}, "value") == "fdsjkalf4243"

    submit_element(find_element(:id, "login"))

    assert(@default_url_login_page == current_url())
    assert {:ok, _} = search_element(:id, "flash")
    assert visible_text({:id, "flash"}) == "Your password is invalid!\n×"
    end

  test "Verify really long username cannot login" do
    navigate_to @default_url_login_page
    assert(@default_url_login_page == current_url())

    fill_field(find_element(:id, "username"), @random_string)

    fill_field(find_element(:id, "password"), @default_password)
    assert attribute_value({:id, "password"}, "value") == @default_password

    submit_element(find_element(:id, "login"))

    assert(@default_url_login_page == current_url())
    assert {:ok, _} = search_element(:id, "flash")
    assert visible_text({:id, "flash"}) == "Your username is invalid!\n×"
  end

  test "Verify really long password cannot login" do
    navigate_to @default_url_login_page
    assert(@default_url_login_page == current_url())

    fill_field(find_element(:id, "username"), @default_username)
    assert attribute_value({:id, "username"}, "value") == @default_username

    fill_field(find_element(:id, "password"), @random_string)

    submit_element(find_element(:id, "login"))

    assert(@default_url_login_page == current_url())
    assert {:ok, _} = search_element(:id, "flash")
    assert visible_text({:id, "flash"}) == "Your password is invalid!\n×"
  end
  end