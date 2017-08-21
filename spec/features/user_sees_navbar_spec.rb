require "rails_helper"
# [] Navbar should be at the top of each page.
# [] Clicking home should send you to the '/' page.
feature "visitor sees a nav bar at the top of the page" do
  scenario "user sees nav bar at the top of the home page" do
    @user = FactoryGirl.create(:user)
    thefeed = Feed.create(
        description: 'thefeed', url: "youtube.com/hi", user_id: @user.id
    )
    visit root_path
    click_link 'FeedForward'

    expect(page).to have_content thefeed.description
    expect(page).to have_content("FeedForward! Where your opinion has value.")
  end

  scenario "visits a specific game's path and still sees nav bar" do
    @user = FactoryGirl.create(:user)
    thefeed = Feed.create(
      description: 'thefeed', url: "youtube.com/hi", user_id: @user.id
    )
    visit feed_path(thefeed)
    click_link 'FeedForward'

    expect(page).to have_content thefeed.description
    expect(page).to have_content("FeedForward! Where your opinion has value.")
  end
end
