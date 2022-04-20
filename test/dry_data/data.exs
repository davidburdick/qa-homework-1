defmodule Data do
  use Hound.Helpers
  use ExUnit.Case

  def footer_check(page) do
    navigate_to page
    assert visible_text({:css, "div#page-footer > div > div"}) == "Powered by Elemental Selenium"
    assert {:ok, _} = search_element(:css, "[href='http\:\/\/elementalselenium\.com\/']")
    click(find_element(:link_text, "Elemental Selenium"))
  end
end