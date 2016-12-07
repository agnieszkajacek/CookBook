require 'rails_helper'

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({ 'provider' => 'github',
                                                              'uid' => '4b897449cf22a8ffc7c5',
                                                              'info' => { 'email' => 'agnieszka.jacek90@gmail.com' } })

describe 'log in github', type: :feature do
  before do
    visit '/users/sign_in'
  end

  it 'logs me in github' do
    click_link 'Zaloguj z GitHub'
    expect(page).to have_content 'Zalogowano poprawnie'
  end
end
