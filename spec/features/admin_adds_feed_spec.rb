require "rails_helper"
require 'pry'

feature "registered admin can add feeds" do
  scenario "signed in admins can go to a form to add a feed" do
    bob = FactoryGirl.create(:admin)
    visit new_user_session_path
    fill_in 'Email', with: bob.email
    fill_in 'Username', with: bob.username
    fill_in 'Password', with: bob.password
    click_button 'Log in'

    expect(page).to have_content('Add Feed')
  end
  scenario "admins not signed in don't see add feed link" do
    visit "/"
    expect(page).to_not have_content('Add feed')
  end
  scenario "admins not signed in can't go to the add a feed form" do
    visit new_feed_path
    expect(page).to have_content('You must be an admin to add a feed')
    expect(page).to_not have_content('New feed Form')
  end
  scenario "signed in admins can successfully add a feed without a description" do
    bob = FactoryGirl.create(:admin)
    visit new_user_session_path
    fill_in 'Email', with: bob.email
    fill_in 'Username', with: bob.username
    fill_in 'Password', with: bob.password
    click_button 'Log in'

    visit new_feed_path


    fill_in 'Description', with: 'Some kind of description'

    click_button 'Add this feed fam'

    expect(page).to have_content('url not used!')

  end
  scenario "signed in admins can successfully add a feed" do
    bob = FactoryGirl.create(:admin)
    visit new_user_session_path
    fill_in 'Email', with: bob.email
    fill_in 'Username', with: bob.username
    fill_in 'Password', with: bob.password
    click_button 'Log in'

    visit new_feed_path

    fill_in 'Description', with: 'Some kind of description'
    fill_in 'Url', with: 'youtube.com/somevideohihd1i1'

    click_button 'Add this feed'

    expect(page).to have_content('Feed successfully saved!')
  end
  scenario "signed in admins don't add feed if information is invalid" do
    bob = FactoryGirl.create(:admin)
    visit new_user_session_path
    fill_in 'Email', with: bob.email
    fill_in 'Username', with: bob.username
    fill_in 'Password', with: bob.password
    click_button 'Log in'

    visit new_feed_path

    click_button 'Add this feed'
    expect(page).to have_content("url not used!")
  end
  scenario "new feed appears on list on main page" do
    bob = FactoryGirl.create(:admin)
    visit new_user_session_path
    fill_in 'Email', with: bob.email
    fill_in 'Username', with: bob.username
    fill_in 'Password', with: bob.password
    click_button 'Log in'

    visit new_feed_path

    fill_in 'Url', with: 'url of a feed'
    fill_in 'Description', with: 'Some kind of description'
    click_button 'Add this feed'

    visit root_path
    expect(page).to have_content("Website")
  end
end
