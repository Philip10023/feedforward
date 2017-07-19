require "rails_helper"

feature "user clicks the precreated chatroom, and successfully
        creates a message" do
          scenario "properly logged in users can see precreated chatroom.create a message on a
          precreated chatroom" do
          bob = FactoryGirl.create(:user)
          hello = FactoryGirl.create(:chat_room, title: "hello", user_id: bob.id)
          visit root_path
          click_link 'Log in'
          expect(page).to have_content "Log in"
          fill_in 'Email', with: bob.email
          fill_in 'Username', with: bob.username
          fill_in 'Password', with: bob.password
          click_button 'Log in'
          click_link("Chat Rooms")
          expect(page).to have_content "hello"
        end
        scenario "user can create a message on a precreated chatroom" do
          bob = FactoryGirl.create(:user)
          hello = FactoryGirl.create(:chat_room, title: "hello", user_id: bob.id)
          message = FactoryGirl.create(:message, body: "hello?", chat_room_id: hello.id, user_id: bob.id)
          visit root_path
          click_link 'Log in'
          expect(page).to have_content "Log in"
          fill_in 'Email', with: bob.email
          fill_in 'Username', with: bob.username
          fill_in 'Password', with: bob.password
          click_button 'Log in'

          click_link("Chat Rooms")
          click_link("hello")

          expect(page).to have_content "hello?"
        end
        scenario "unauthenticated user cannot see Chat Rooms button" do
          visit root_path

          expect(page).to_not have_content "Chat Rooms"
        end
      end
