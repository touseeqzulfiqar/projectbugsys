require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:manager) { create(:user, role: :manager) }
  let(:developer) { create(:user, role: :developer) }
  let(:qa) { create(:user, role: :QA) }
  let(:another_user) { create(:user, role: :developer) }
  let(:project) { create(:project, creator_id: manager.id) }

  before do
    sign_in manager
  end

  # Manager tests
  describe 'GET /index as Manager' do
    it 'returns a successful response' do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create as Manager' do
    it 'creates a new project' do
      expect do
        post projects_path, params: { project: { name: 'New Project', description: 'Project description' } }
      end.to change(Project, :count).by(1)

      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include('Project was successfully created.')
    end
  end

  describe 'DELETE /destroy as Manager' do
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

  describe 'PATCH /update as Manager' do
    it 'updates a project' do
      patch project_path(project), params: { project: { name: 'Updated Project Name' } }
      expect(project.reload.name).to eq('Updated Project Name')
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include('Project was successfully updated.')
    end
  end

  # QA tests
  describe 'GET /index as QA' do
    before { sign_in qa }

    it 'allows QA to view the projects index' do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update as QA' do
    before { sign_in qa }

    it 'does not allow a QA to update a project' do
      patch project_path(project), params: { project: { name: 'QA Update Project' } }
      expect(project.reload.name).not_to eq('QA Update Project')
      expect(response).to have_http_status(:forbidden)
    end
  end

 describe 'DELETE /destroy as QA' do
  before { sign_in qa }
  let!(:project) { create(:project) }  # Ensure the project is created before the test runs

  it 'does not allow a QA to delete a project' do
    expect do
      delete project_path(project)
    end.not_to change(Project, :count)  # Expect that the project count does not change

    expect(response).to have_http_status(:forbidden)
  end
end


  describe 'GET /show as QA' do
    before { sign_in qa }

    it 'allows a QA user to view a project' do
      get project_path(project)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(project.name)
    end
  end

  # Developer tests
  describe 'GET /index as Developer' do
    before do
     sign_in developer
     project.users << developer
    end

    it 'allows Developer to view the projects index' do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create as Developer' do
    before { sign_in developer }

    it 'does not allow a Developer to create a project' do
      expect do
        post projects_path, params: { project: { name: 'Dev Project', description: 'Developer cannot create projects' } }
      end.not_to change(Project, :count)

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'PATCH /update as Developer' do
    before { sign_in developer }

    it 'does not allow a Developer to update a project' do
      patch project_path(project), params: { project: { name: 'Dev Update Project' } }
      expect(project.reload.name).not_to eq('Dev Update Project')
      expect(response).to have_http_status(:forbidden)
    end
  end


  describe 'GET /show as Developer' do
    before do
      # Assign the developer to the project
      project.users << developer
      sign_in developer
    end

    it 'allows a Developer to view a project they are part of' do
      get project_path(project)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(project.name)
    end
  end

end
