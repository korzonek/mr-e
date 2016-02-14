require 'rails_helper'

RSpec.describe MysteryPolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions :index?, :my_mysteries? do
    it "allows access to all users" do
      expect(subject).to permit(user)
    end
  end

  permissions :show? do
    it "denies access if mystery is not published" do
      expect(subject).not_to permit(user, Mystery.new(is_published: false))
    end

    it "allows access if user is and admin of a mystery" do
      expect(subject).to permit(user, Mystery.new(is_published: false, admin: user))
    end

    it "denies access if mystery is not published" do
      expect(subject).to permit(user, Mystery.new(is_published: true))
    end
  end

  permissions :update?, :destroy? do
    it 'denies access if user is not an admin of a mystery' do
      expect(subject).not_to permit(user, Mystery.new())
    end

    it 'allows access if user is an admin of a mystery' do
      expect(subject).to permit(user, Mystery.new(admin: user))
    end
  end
end
