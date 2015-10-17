require "rails_helper"

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({"provider"=>"google",
 "uid"=>"cookbook-1101",
 "info"=>{"email"=>"agnieszka.jacek90@gmail.com"}})

describe "log in google" , type: :feature do
	before do 
		visit "/users/sign_in"
	end

	it "logs me in google" do
		click_link 'Zaloguj z Google'
    expect(page).to have_content 'Zalogowano poprawnie'
	end
end