require 'rails_helper'

describe Api::V1::FeedsController, type: :controller do

  let(:json_parsed_response) { JSON.parse(response.body) }

  describe "GET #show" do
    before(:each) do
      @feed = FactoryGirl.create(:feed)
      @other_feed = FactoryGirl.create(:feed)
      @user = FactoryGirl.create(:user)
      @review_one = Review.create(
        message: "first review", feed: @feed, user: @user
      )
      @review_two = Review.create(
        message: "another review", feed: @feed, user: @user
      )
      @review_three = Review.create(
        message: "third review for test", feed: @other_feed, user: @user
      )
    end

    it "returns JSON" do
      get :show, params: { id: @feed.id }
      expect(response.status).to eq 200
      expect(json_parsed_response.keys).to eq ["reviews", "user"]
      expect(json_parsed_response["reviews"][0].keys).to eq [
        "id", "message", "username", "votes", "created_at"
      ]
    end

    describe "it returns review data" do
      it "returns review data and sign-in status to an unsigned in user" do
        Updown.create(review: @review_one, user: @user, vote: true)
        get :show, params: { id: @feed.id }

        expect(json_parsed_response["reviews"].length).to eq 2
        expect(
          json_parsed_response["reviews"]
        ).to have_content(@review_one.message)
        expect(
          json_parsed_response["reviews"].first
        ).to_not have_content(@review_three.message)
        expect(
          json_parsed_response["reviews"].first["votes"]
        ).to have_content(@review_one.updowns.first.user.id)
        expect(json_parsed_response["user"]).to eq false
      end
      it "when signed in it returns review data and id of signed-in user" do
        sign_in(@user)
        get :show, params: { id: @feed.id }

        expect(json_parsed_response["reviews"].length).to eq 2
        expect(
          json_parsed_response["reviews"]
        ).to have_content(@review_one.message)
        expect(
          json_parsed_response["reviews"].first
        ).to_not have_content(@review_three.message)
        expect(json_parsed_response["user"]).to eq(@user.id)
      end
    end
  end
end
