# spec/requests/bugs_spec.rb
require 'rails_helper'

RSpec.describe 'Bugs', type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, creator_id: user.id) }
  let(:bug) { create(:bug, project:, user:) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      get project_bugs_path(project)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a new bug' do
      expect do
        post project_bugs_path(project),
             params: { bug: { title: 'New Bug', description: 'Bug description', status: 'started', bug_type: 'bug' } }
      end.to change(Bug, :count).by(1)
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes the bug' do
      bug_to_delete = create(:bug, project:, user:)
      expect do
        delete project_bug_path(project, bug_to_delete)
      end.to change(Bug, :count).by(-1)
    end
  end
end
