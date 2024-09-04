require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without a role' do
      user = build(:user, role: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'duplicate@example.com')
      user = build(:user, email: 'duplicate@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end
  end

  context 'associations' do
    it 'has many projects' do
      association = described_class.reflect_on_association(:projects)
      expect(association.macro).to eq :has_many
    end

    it 'has many bugs' do
      association = described_class.reflect_on_association(:bugs)
      expect(association.macro).to eq :has_many
    end
  end

  context 'devise modules' do
    it { should respond_to(:email) }
    it { should respond_to(:encrypted_password) }
  end
end
