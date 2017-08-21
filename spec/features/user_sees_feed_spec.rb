require "rails_helper"
# [] Visiting the `/feeds` path should contain a list of feeds.
# [] Visiting the `/feeds/10` path should show the feed details for a feed with
#    the ID of 10.
feature "visitor sees feed details" do
  scenario "clicks link from index page and goes to details page" do
    @user = FactoryGirl.create(:user)
    thefeed = Feed.create(
      description: 'hi', url: "youtube.com/iqnifniwenfnw", user_id: @user.id
    )
    visit root_path
    expect(page).to have_content 'comments'
    click_on('comments')
    expect(page).to have_content thefeed.description
    expect(page).to have_content "Website"
  end

  scenario "visits a specific feed's path and shows only that feed's details" do
    @user = FactoryGirl.create(:user)
    chrono_trigger = Feed.create(
      description: "It's an awesome feed",
      url: "youtube.com/shouldntshow",
      user_id: @user.id
    )
    thefeed = Feed.create(
      url: 'youtube.com/shouldntshow', description: 'You hit a dot back and forth',
      user_id: @user.id
    )
    visit feed_path(thefeed)

    expect(page).to have_content thefeed.description
    expect(page).to_not have_content thefeed.url
    expect(page).to_not have_content chrono_trigger.description
  end
end
