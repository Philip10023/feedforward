require 'rails_helper'

describe ChatRoomsController, type: :controller do

  describe "POST #create" do
    before(:each) do
      @correct_chatroom_params = {
        title: "This chatroom rocks", chat_room_id: @chat_room_id
      }
    end
    let(:wrong_params) { {  chat_room_id: @chat_room.id }.JSON }

    it " user creates chatrooms" do
      bob = FactoryGirl.create(:user)
      sign_in bob
      post :create, params: { chat_room: @correct_chatroom_params }

      expect(response.status).to eq 302
      expect(response.committed?).to eq true
    end
  end
end
