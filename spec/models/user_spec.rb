require 'rails_helper'

RSpec.describe User, type: :model do
  context '#create' do
    let(:user) { User.create(username: 'test@example.com', email: 'test@test.test', password: '12345678') }

    it 'adds error if user gave username the same as already existing e-mail' do
      User.create!(username: 'test', email: 'test@example.com', password: '12345678')
      expect(user.errors.first).to eq [:username, 'is invalid']
    end
  end

  context 'finding a user' do
    let(:user) { User.create(username: 'test@example.com', email: 'test@test.test', password: '12345678') }

    it 'can find by lower email' do
      expect(User.find_for_database_authentication( {login: user.email.downcase} )).to eq(user)
    end

    it 'can find by upper email' do
      expect(User.find_for_database_authentication( {login: user.email.upcase} )).to eq(user)
    end

    it 'can find by jumbled username' do
      scrambled_username = user.username.downcase.chars.map{|c| rand() > 0.5 ? c.capitalize : c}.join
      expect(User.find_for_database_authentication( {login: scrambled_username} )).to eq(user)
    end
  end

  context 'authenticating a user' do
    let(:user) { User.create(username: 'test@example.com', email: 'test@test.test', password: 'password123') }

    it 'will validate a correct password' do
      expect(user.valid_password?('password123')).to be true
    end

    it 'will not validate an incorrect password' do
      expect(user.valid_password?('bad-password')).to be false
    end
  end
end
