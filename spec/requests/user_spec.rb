require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:manager) { create(:user, role: :manager) }
  let(:developer) { create(:user, role: :developer) }
  let(:qa) { create(:user, role: :QA) }

  describe 'POST /users/sign_up' do
    it 'creates a new user' do
      expect do
        post user_registration_path,
             params: { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123',
                               name: 'Test User', role: 'developer' } }
      end.to change(User, :count).by(1)

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Welcome! You have signed up successfully.')
    end
  end

  describe 'POST /users/sign_in' do
    it 'allows a user to sign in' do
      post user_session_path, params: { user: { email: user.email, password: user.password } }

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Signed in successfully.')
    end
  end

  context 'as manager' do
    before { sign_in manager }

    it 'allows access to view projects' do
      get projects_path
      expect(response).to have_http_status(:success)
    end

    it 'allows access to create a new project' do
      get new_project_path
      expect(response).to have_http_status(:success)
    end

    it 'allows access to edit a project' do
      project = create(:project, creator_id: manager.id) # Use creator_id instead of user
      get edit_project_path(project)
      expect(response).to have_http_status(:success)
    end

    it 'allows deleting a project' do
      project = create(:project, creator_id: manager.id)
      expect { delete project_path(project) }.to change(Project, :count).by(-1)
      expect(response).to redirect_to(projects_path)
    end
  end

  context 'as developer' do
    before { sign_in developer }

    it 'allows access to view projects' do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  context 'as QA' do
    before { sign_in qa }

    it 'allows access to view projects' do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end
end
