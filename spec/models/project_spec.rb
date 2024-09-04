require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      project = build(:project)
      expect(project).to be_valid
    end

    it 'is not valid without a name' do
      project = build(:project, name: nil)
      expect(project).not_to be_valid
      expect(project.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without a description' do
      project = build(:project, description: nil)
      expect(project).not_to be_valid
      expect(project.errors[:description]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'has many users' do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq :has_many
    end

    it 'has many bugs' do
      association = described_class.reflect_on_association(:bugs)
      expect(association.macro).to eq :has_many
    end

    it 'belongs to a creator' do
      association = described_class.reflect_on_association(:creator)
      expect(association.macro).to eq :belongs_to
    end
  end

  context 'nested attributes' do
    it 'accepts nested attributes for users' do
      project = build(:project, users_attributes: [{ name: 'John Doe', email: 'john@example.com', role: 'developer' }])
      expect(project.users.map(&:name)).to include('John Doe')
    end
  end
end
