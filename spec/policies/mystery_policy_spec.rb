require 'rails_helper'

RSpec.describe MysteryPolicy do
  let(:user) { User.new }
  subject { described_class }

  permissions :index? do
    it "allows access to guest" do
      expect(subject).to permit(nil)
    end
  end

  permissions :my_mysteries?, :new? do
    it "denies access to guest" do
      expect(subject).not_to permit(nil)
    end

    it "allows access to logged in user" do
      expect(subject).to permit(user)
    end
  end

  permissions :show? do
    it "denies access if mystery is not published" do
      expect(subject).not_to permit(user, Mystery.new(is_published: false))
    end

    it "allows access if mystery is published" do
      expect(subject).to permit(user, Mystery.new(is_published: true))
    end

    it "allows access if user is and admin of a mystery" do
      expect(subject).to permit(user, Mystery.new(is_published: false, admin: user))
    end
  end

  permissions :edit?, :update?, :destroy? do
    it 'denies access if user is not an admin of a mystery' do
      expect(subject).not_to permit(user, Mystery.new())
    end

    it 'allows access if user is an admin of a mystery' do
      expect(subject).to permit(user, Mystery.new(admin: user))
    end
  end
end
