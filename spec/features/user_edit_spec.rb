require 'rails_helper'

describe 'user edit', type: :feature do
  before do
    test_login
  end

  it 'allows you to change settings' do
    visit '/users/edit'
    expect(page).to have_content 'Edycja Użytkownika'
    fill_in 'Twój e-mail', with: 'user@example.com'
    fill_in 'Hasło', with: 'agnieszka1'
    fill_in 'Potwierdź hasło', with: 'agnieszka1'
    fill_in 'Aktualne hasło', with: 'agnieszka'
    click_button 'Aktualizuj'
    expect(page).to have_content 'Dane zostały poprawnie zmienione'
  end
end
