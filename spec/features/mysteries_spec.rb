require 'rails_helper'

describe 'mysteries_controller' do
  let(:user) { User.create(username: 'john', email: 'john@j.j', password: '12345678') }
  before(:each) { login_as user }

  context '#show' do
    let(:mystery) { Mystery.create(name: 'test mystery 1', description: 'description testing', admin: user) }

    it 'displays admin username on mystery view' do
      login_as user
      visit "/mysteries/#{mystery.id}"
      expect(page).to have_content 'john'
    end

    it 'displays proper mystery title' do
      visit "/mysteries/#{mystery.id}"
      expect(page).to have_content 'test mystery 1'
    end

    it 'displays proper mystery description' do
      visit "/mysteries/#{mystery.id}"
      expect(page).to have_content 'description testing'
    end

    it 'doesnt display badge if mystery isnt solved' do
      visit "/mysteries/#{mystery.id}"
      expect(page).not_to have_content 'Solved'
    end

    it 'displays badge if mystery is solved' do
      mystery.update(is_solved: true)
      visit "/mysteries/#{mystery.id}"
      expect(page).to have_content 'Solved'
    end
  end

  context '#new' do
    it 'displays error for mystery name' do
      visit '/mysteries/new'
      click_button 'Create a mystery'
      expect(page).to have_content "Name can't be blank"
    end

    it 'displays error for mystery description' do
      visit '/mysteries/new'
      click_button 'Create a mystery'
      expect(page).to have_content "Description can't be blank"
    end

    it 'is redirecting to a new mystery show view' do
      visit '/mysteries/new'
      fill_in 'Mystery name', with: 'Test abc'
      fill_in 'Mystery description', with: 'Desc xyz'
      click_button 'Create a mystery'
      expect(page).to have_content 'Test abc'
      expect(page).to have_content 'Desc xyz'
    end
  end

  context '#join' do
    let(:user_2) { User.create(username: 'john2', email: 'john2@j.j', password: '12345678') }
    let(:mystery) { Mystery.create(name: 'test mystery 1', description: 'description testing', is_published: true, admin: user_2) }

    it 'displays success message after creating' do
      visit "/mysteries/#{mystery.id}"
      click_link 'Join!'
      expect(Participant.where(user: user, mystery: mystery).any?).to be true
      expect(page).to have_content "You've successfully joined the mystery :)"
    end
  end

  context '#leave' do
    let(:user_2) { User.create(username: 'john2', email: 'john2@j.j', password: '12345678') }
    let(:mystery) { Mystery.create(name: 'test mystery 1', description: 'description testing', is_published: true, admin: user_2) }

    it 'displays success message after creating' do
      visit "/mysteries/#{mystery.id}"
      click_link 'Join!'
      click_link 'Leave!'
      expect(Participant.where(user: user, mystery: mystery).any?).to be false
      expect(page).to have_content "You're no longer solving this mystery."
    end
  end
end
