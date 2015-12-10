require 'rails_helper'

describe 'navbar' do
  before(:each) { visit '/' }

  it 'finds app name' do
    expect(page).to have_content 'Mr E'
  end

  it 'can go to sign up page' do
    click_link 'Login'
    expect(page).to have_content 'Sign up'
  end

  it 'can go to login page' do
    click_button 'Sign up'
    expect(page).to have_content 'Log in'
  end
end