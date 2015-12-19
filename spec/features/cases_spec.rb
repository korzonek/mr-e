require 'rails_helper'

describe 'cases_controller' do
  let(:user) { User.create(username: 'john', email: 'john@j.j', password: '12345678') }
  before(:each) { login_as user }

  context '#show' do
    let(:casee) { Case.create(name: 'test case 1', description: 'description testing', admin: user) }

    it 'displays admin username on case view' do
      login_as user
      visit "/cases/#{casee.id}"
      expect(page).to have_content 'john'
    end

    it 'displays proper case title' do
      visit "/cases/#{casee.id}"
      expect(page).to have_content 'test case 1'
    end

    it 'displays proper case description' do
      visit "/cases/#{casee.id}"
      expect(page).to have_content 'description testing'
    end

    it 'doesnt display badge if case isnt solved' do
      visit "/cases/#{casee.id}"
      expect(page).not_to have_content 'Solved'
    end

    it 'displays badge if case is solved' do
      casee.update(is_solved: true)
      visit "/cases/#{casee.id}"
      expect(page).to have_content 'Solved'
    end
  end

  context '#new' do
    it 'displays error for case name' do
      visit '/cases/new'
      click_button 'Create a case'
      expect(page).to have_content "Name can't be blank"
    end

    it 'displays error for case description' do
      visit '/cases/new'
      click_button 'Create a case'
      expect(page).to have_content "Description can't be blank"
    end

    it 'is redirecting to a new case show view' do
      visit '/cases/new'
      fill_in 'Case name', with: 'Test abc'
      fill_in 'Case description', with: 'Desc xyz'
      click_button 'Create a case'
      expect(page).to have_content 'Test abc'
      expect(page).to have_content 'Desc xyz'
    end
  end
end