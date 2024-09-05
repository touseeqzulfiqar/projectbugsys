require 'rails_helper'

RSpec.describe 'bugs/edit.html.erb', type: :view do
  let(:project) { create(:project) }
  let(:bug) { create(:bug, project:) }
  let(:developer_users) { create_list(:user, 3, :developer) }

  before do
    assign(:project, project)
    assign(:bug, bug)
    assign(:developer_users, developer_users)
    render
  end

  it 'displays the correct heading' do
    expect(rendered).to have_content('Editing bug')
  end

  it 'renders the bug form' do
    expect(rendered).to have_selector("form[action='#{project_bug_path(project, bug)}'][method='post']")
  end

  it 'renders a link to show the bug' do
    expect(rendered).to have_link('Show this bug', href: project_bug_path(project, bug))
  end

  it 'renders a link to go back to the root' do
    expect(rendered).to have_link('Back', href: root_path)
  end

  it 'displays the bug title in the form' do
    expect(rendered).to have_field('bug_title', with: bug.title)
  end
end
