require 'rails_helper'

describe 'Pundit::NotAuthorizedError' do
  it 'rescues error with proper message' do
    visit "/mysteries/new"
    expect(page).to have_content 'You are not authorized to perform this action'
  end
end
