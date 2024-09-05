require 'rails_helper'

RSpec.describe 'bugs/index', type: :view do
  before do
    # Create a user to associate with the bug
    user = User.create!(name: 'Test User', email: 'user@example.com', password: 'password', role: :developer)

    # Set up a project with a description and associated bugs for testing
    @project = assign(:project, Project.create!(name: 'Test Project', description: 'Project Description'))

    assign(:bugs, [
             Bug.create!(title: 'Bug 1', description: 'Description 1', status: 'started', bug_type: 'bug', user:,
                         project: @project),
             Bug.create!(title: 'Bug 2', description: 'Description 2', status: 'completed', bug_type: 'feature', user:,
                         project: @project)
           ])
  end

  it 'renders a list of bugs with show links' do
    render

    # Check for the presence of bug titles and descriptions
    expect(rendered).to match(/Bug 1/)
    expect(rendered).to match(/Description 1/)
    expect(rendered).to match(/Bug 2/)
    expect(rendered).to match(/Description 2/)

    # Check that each bug has a "Show this bug" link
    expect(rendered).to have_link('Show this bug', href: project_bug_path(@project, Bug.first))
    expect(rendered).to have_link('Show this bug', href: project_bug_path(@project, Bug.second))
  end

  it 'includes a link to create a new bug' do
    render

    # Check for the "New bug" link
    expect(rendered).to have_link('New bug', href: new_project_bug_path(@project))
  end

  it 'renders the turbo frame for bug' do
    render

    # Check for the presence of the turbo frame tag
    expect(rendered).to have_css('turbo-frame[id="bug"]')
  end
end
