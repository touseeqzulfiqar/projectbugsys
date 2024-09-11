require 'rails_helper'

RSpec.describe 'Bugs', type: :request do
  let(:project) { FactoryBot.create(:project, creator: user) }
  let(:bug) { FactoryBot.create(:bug, project:, user:) }

  context 'when user is a Manager' do
    let(:user) { FactoryBot.create(:user, :manager) }

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
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'DELETE /destroy' do
      before do
        # Ensure the bug belongs to the correct project and the manager has permission to delete
        bug.update(project:)
      end

      it 'deletes the bug' do
        expect do
          delete project_bug_path(project, bug)
        end.to change(Bug, :count).by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'PUT /update' do
      it 'updates the bug' do
        put project_bug_path(project, bug), params: { bug: { status: 'completed' } }
        expect(response).to have_http_status(:redirect)
        expect(bug.reload.status).to eq('completed')
      end
    end
  end

  context 'when user is a QA' do
    let(:user) { FactoryBot.create(:user, :QA) }

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
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'DELETE /destroy' do
      before do
        # Ensure the bug belongs to the correct project and the manager has permission to delete
        bug.update(project:)
      end

      it 'deletes the bug' do
        expect do
          delete project_bug_path(project, bug)
        end.to change(Bug, :count).by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'PUT /update' do
      it 'updates the bug' do
        put project_bug_path(project, bug), params: { bug: { status: 'completed' } }
        expect(response).to have_http_status(:redirect)
        expect(bug.reload.status).to eq('completed')
      end
    end
  end

  context 'when user is a Developer' do
    let(:user) { FactoryBot.create(:user, :developer) }
    before do
      sign_in user
      puts "#{bug}"
    end

    describe 'GET /index' do
      it 'returns a successful response' do
        get project_bugs_path(project)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /create' do
      it 'does not allow creating a bug' do
        expect do
          post project_bugs_path(project),
               params: { bug: { title: 'New Bug', description: 'Bug description', status: 'started', bug_type: 'bug' } }
        end.not_to change(Bug, :count)
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'DELETE /destroy' do
      it 'does not allow deleting a bug' do
        expect do
          delete project_bug_path(project, bug)
        end.not_to change(Bug, :count)

        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'PUT /update' do
      it 'updates the bug' do
        put project_bug_path(project, bug), params: { bug: { status: 'completed' } }
        expect(response).to have_http_status(:redirect)
        expect(bug.reload.status).to eq('completed')
      end
    end
  end
end
