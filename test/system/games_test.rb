require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test 'fill in invalid letters kkk' do
    visit new_url
    fill_in "word",	with: "kkk" 
    click_on "Play"
    assert_text "cannot be built out of"
  end
end