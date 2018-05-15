require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end
  test "Random letters submit" do
    visit new_url
    assert test: "New game"
    fill_in "word", with: "apoaziepaozeiapzei"
    take_screenshot
    click_on "PLAY"
    assert_text "can't be built out of"
  end

  test "Find all letters and make an english word" do
    visit new_url
    all('li').each { |a| p a }
  end
end
