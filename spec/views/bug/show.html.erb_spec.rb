# spec/views/bugs/show.html.erb_spec.rb

require 'rails_helper'

RSpec.describe 'bugs/show.html.erb', type: :view do
  include Devise::Test::ControllerHelpers
  let(:project) { create(:project) }
  let(:bug) { create(:bug, project:, user:) }
  let(:user) { create(:user) }
  let(:manager) { create(:user, :manager) }
  let(:qa) { create(:user, :QA) }
  let(:developer) { create(:user, :developer) }

  before do
    assign(:project, project)
    assign(:bug, bug)
  end

  context 'when the user is a manager' do
    before do
      sign_in(manager)
      render
    end

    it 'renders the bug details' do
      expect(rendered).to include(bug.description) if bug.description.present?
      expect(rendered).to have_content(bug.status) if bug.status.present?
      expect(rendered).to have_content(bug.title) if bug.title.present?
    end

    it 'renders the destroy button' do
      expect(rendered).to have_button('Destroy this bug')
    end

    it 'renders the edit link' do
      expect(rendered).to have_link('Edit this bug', href: edit_project_bug_path(project, bug))
    end
  end

  context 'when the user is a QA' do
    before do
      sign_in(qa)
      render
    end

    context 'when the QA user created the bug' do
      let(:bug) { create(:bug, project:, user: qa) }

      it 'renders the bug details' do
        expect(rendered).to have_content(bug.description) if bug.description.present?
        expect(rendered).to have_content(bug.status) if bug.status.present?
        expect(rendered).to have_content(bug.title) if bug.title.present?
      end

      it 'renders the destroy button' do
        expect(rendered).to have_button('Destroy this bug')
      end

      it 'renders the edit link' do
        expect(rendered).to have_link('Edit this bug', href: edit_project_bug_path(project, bug))
      end
    end

    context 'when the QA user did not create the bug' do
      let(:bug) { create(:bug, project:, user: create(:user)) }

      it 'renders the bug details' do
        expect(rendered).to have_content(bug.description) if bug.description.present?
        expect(rendered).to have_content(bug.status) if bug.status.present?
        expect(rendered).to have_content(bug.title) if bug.title.present?
      end

      it 'does not render the destroy button' do
        expect(rendered).not_to have_button('Destroy this bug')
      end

      it 'renders the edit link' do
        expect(rendered).to have_link('Edit this bug', href: edit_project_bug_path(project, bug))
      end
    end
  end

  context 'when the user is a developer' do
    before do
      sign_in(developer)
      render
    end

    it 'renders the bug details' do
      expect(rendered).to have_content(bug.description) if bug.description.present?
      expect(rendered).to have_content(bug.status) if bug.status.present?
      expect(rendered).to have_content(bug.title) if bug.title.present?
    end

    it 'does not render the destroy button' do
      expect(rendered).not_to have_button('Destroy this bug')
    end
  end
end
