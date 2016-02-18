require 'rails_helper'

RSpec.describe RequestPolicy do
  let(:user) { User.new }
  let(:mystery) { Mystery.new(admin: user) }
  subject { described_class }

  permissions :update?, :destroy? do
    it 'denies access if user is not an author of a request' do
      expect(subject).not_to permit(user, Request.new)
    end

    it 'allows access if user is an author of a request' do
      expect(subject).to permit(user, Request.new(user: user))
    end
  end
end
