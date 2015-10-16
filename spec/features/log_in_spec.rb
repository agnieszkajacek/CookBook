require "rails_helper"

describe "log in", type: :feature do
	before do 
		User.create!(email: 'user@example.com', password: 'agnieszka')
		visit "/users/sign_in"
	end
		
	it "logs me in" do
		expect(page).to have_content 'Zaloguj się'
		fill_in 'Twój e-mail', with: 'user@example.com'
		fill_in 'Hasło', with: 'agnieszka'
		click_button 'Zaloguj się'
    expect(page).to have_content 'Zalogowano poprawnie'
	end
	it "do not log in if the password is wrong" do
		fill_in 'Twój e-mail', with: 'user@example.com'
		fill_in 'Hasło', with: 'agnieszka1'
		click_button 'Zaloguj się'
    expect(page).to have_content 'Konto bądź email jest nieważne.'
	end
end

