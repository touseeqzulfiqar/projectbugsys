require 'rails_helper'

RSpec.describe Bug, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      bug = build(:bug)
      expect(bug).to be_valid
    end

    it 'is not valid without a title' do
      bug = build(:bug, title: nil)
      expect(bug).not_to be_valid
      expect(bug.errors[:title]).to include("can't be blank")
    end

    it 'is not valid without a status' do
      bug = build(:bug, status: nil)
      expect(bug).not_to be_valid
      expect(bug.errors[:status]).to include("can't be blank")
    end

    it 'is not valid without a bug_type' do
      bug = build(:bug, bug_type: nil)
      expect(bug).not_to be_valid
      expect(bug.errors[:bug_type]).to include("can't be blank")
    end

    it 'is not valid with a duplicate title within the same project' do
      project = create(:project)
      create(:bug, title: 'Duplicate Title', project:)
      bug = build(:bug, title: 'Duplicate Title', project:)
      expect(bug).not_to be_valid
      expect(bug.errors[:title]).to include('must be unique within the project')
    end
  end

  context 'associations' do
    it 'belongs to a project' do
      association = described_class.reflect_on_association(:project)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a developer' do
      association = described_class.reflect_on_association(:developer)
      expect(association.macro).to eq :belongs_to
    end
  end
end
