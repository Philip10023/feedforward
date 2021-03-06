require "rails_helper"
require 'pry'
feature "visitor can search feeds" do
  scenario "user sees search" do
    visit root_path

    expect(page).to have_content('')
    expect(page).to have_button('search🔎')
  end

  scenario "user searches for feed and sees results" do
    first_feed = FactoryGirl.create(:feed)
    second_feed = FactoryGirl.create(:feed, description: "Whee")
    third_feed = FactoryGirl.create(:feed, description: "Bobby")
    fourth_feed = FactoryGirl.create(:feed)
    visit root_path

    fill_in :placeholder => "", :with => second_feed.description
    click_button "search🔎"

    expect(page).to have_content("Whee")
    expect(page).to_not have_content(third_feed.description)

    fill_in '', with: ""
    click_button "search🔎"

    expect(page).to have_content(first_feed.description)
    expect(page).to have_content(fourth_feed.description)
  end
end
