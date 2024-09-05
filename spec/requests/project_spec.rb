# spec/requests/projects_spec.rb
require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:manager) { create(:user, role: :manager) }
  let(:developer) { create(:user, role: :developer) }
  let(:another_user) { create(:user, role: :developer) }
  let(:project) { create(:project, creator_id: manager.id) }

  before do
    sign_in manager
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a new project' do
      expect do
        post projects_path, params: { project: { name: 'New Project', description: 'Project description' } }
      end.to change(Project, :count).by(1)

      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include('Project was successfully created.')
    end

    it 'does not allow a non-manager to create a project' do
      sign_out manager
      sign_in developer

      expect do
        post projects_path, params: { project: { name: 'New Project', description: 'Project description' } }
      end.not_to change(Project, :count)

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes the project if the manager is the creator' do
      project_to_delete = create(:project, creator_id: manager.id)

      expect do
        delete project_path(project_to_delete)
      end.to change(Project, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include('Project was successfully destroyed.')
    end

    it 'does not allow a non-creator manager to delete the project' do
      other_manager = create(:user, role: :manager)
      sign_out manager
      sign_in other_manager

      project_to_delete = create(:project, creator_id: manager.id)

      expect do
        delete project_path(project_to_delete)
      end.not_to change(Project, :count)

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'PATCH /update' do
    it 'updates a project' do
      patch project_path(project), params: { project: { name: 'Updated Project Name' } }
      expect(project.reload.name).to eq('Updated Project Name')
    end

    it 'does not allow a non-manager to update a project' do
      sign_out manager
      sign_in another_user

      patch project_path(project), params: { project: { name: 'Updated Project Name' } }
      expect(project.reload.name).not_to eq('Updated Project Name')
      expect(response).to have_http_status(:forbidden)
    end
  end
end
