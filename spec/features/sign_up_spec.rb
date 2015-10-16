require "rails_helper"

describe "sign up" , type: :feature do
	before do 
		visit "/users/sign_up"
	end

	it "sign me up" do
		expect(page).to have_content 'Załóż konto'
		fill_in 'Twój e-mail', with: 'user@example.com'
		fill_in 'Hasło', with:'agnieszka'
		fill_in 'Potwierdź hasło', with: 'agnieszka'
		click_button 'Załóż konto'
	  expect(page).to have_content 'Zarejestrowano poprawnie'
	end
end