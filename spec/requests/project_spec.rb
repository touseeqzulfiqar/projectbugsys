# # spec/requests/projects_spec.rb
# require 'rails_helper'

# RSpec.describe 'Projects', type: :request do
#   let(:user) { create(:user) }
#   let!(:project) { create(:project, creator_id: user.id) }
#   let!(:bug) { create(:bug, project:) }

#   before do
#     sign_in user
#   end

#   describe 'GET /index' do
#     it 'returns a successful response' do
#       get projects_path
#       expect(response).to have_http_status(:success)
#     end

#     it 'displays the project in the response body' do
#       get projects_path
#       expect(response.body).to include(project.name)
#     end

#     it 'displays the bug in the response body' do
#       get projects_path
#       expect(response.body).to include(bug.title)
#     end

#     it 'renders the index template' do
#       get projects_path
#       expect(response).to render_template(:index)
#     end
#   end

#   describe 'GET /show' do
#     it 'returns a successful response' do
#       get project_path(project)
#       expect(response).to have_http_status(:success)
#     end

#     it "displays the project's bugs in the response body" do
#       get project_path(project)
#       expect(response.body).to include(bug.title)
#     end
#   end

#   describe 'GET /new' do
#     it 'returns a successful response' do
#       get new_project_path
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe 'POST /create' do
#     context 'with valid parameters' do
#       it 'creates a new project' do
#         expect do
#           post projects_path,
#                params: { project: { name: 'New Project', description: 'A new project', user_ids: [user.id] } }
#         end.to change(Project, :count).by(1)
#       end

#       it 'redirects to the newly created project' do
#         post projects_path,
#              params: { project: { name: 'New Project', description: 'A new project', user_ids: [user.id] } }
#         expect(response).to redirect_to(project_path(Project.last))
#       end
#     end

#     context 'with invalid parameters' do
#       it 'does not create a new project' do
#         expect do
#           post projects_path, params: { project: { name: '', description: 'A new project', user_ids: [user.id] } }
#         end.not_to change(Project, :count)
#       end

#       it 'renders the new template with unprocessable entity status' do
#         post projects_path, params: { project: { name: '', description: 'A new project', user_ids: [user.id] } }
#         expect(response).to render_template(:new)
#         expect(response).to have_http_status(:unprocessable_entity)
#       end
#     end
#   end

#   describe 'PATCH /update' do
#     context 'with valid parameters' do
#       it 'updates the project' do
#         patch project_path(project), params: { project: { name: 'Updated Project', description: 'An updated project' } }
#         project.reload
#         expect(project.name).to eq('Updated Project')
#         expect(response).to redirect_to(project_path(project))
#       end
#     end

#     context 'with invalid parameters' do
#       it 'does not update the project' do
#         patch project_path(project), params: { project: { name: '', description: 'An updated project' } }
#         project.reload
#         expect(project.name).not_to eq('')
#         expect(response).to render_template(:edit)
#         expect(response).to have_http_status(:unprocessable_entity)
#       end
#     end
#   end

#   describe 'DELETE /destroy' do
#     it 'destroys the project' do
#       expect do
#         delete project_path(project)
#       end.to change(Project, :count).by(-1)
#     end

#     it 'redirects to the projects index' do
#       delete project_path(project)
#       expect(response).to redirect_to(projects_path)
#     end
#   end
# end
