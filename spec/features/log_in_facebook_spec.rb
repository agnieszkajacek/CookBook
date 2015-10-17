require "rails_helper"

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({"provider"=>"facebook",
 "uid"=>"1053460708021024",
 "info"=>{"email"=>"agnieszka.jacek90@gmail.com"}})

describe "log in facebook" , type: :feature do
	before do 
		visit "/users/sign_in"
	end

	it "logs me in facebook" do
		click_link 'Zaloguj z Facebook'
    expect(page).to have_content 'Zalogowano poprawnie'
	end

	it "conect user to facebook account" do
		user = User.create!(email: 'agnieszka.jacek90@gmail.com', password: 'agnieszka')
		click_link'Zaloguj z Facebook'
		user.reload
		expect(user.provider).to eq ("facebook")
		expect(user.uid).to eq("1053460708021024")
	end

end
