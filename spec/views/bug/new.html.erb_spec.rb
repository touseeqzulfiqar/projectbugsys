# spec/views/bugs/new.html.erb_spec.rb

require 'rails_helper'

RSpec.describe 'bugs/new.html.erb', type: :view do
  include Devise::Test::ControllerHelpers

  let(:project) { create(:project) }
  let(:bug) { build(:bug, project:) } # Build instead of create for new form
  let(:developer_users) { create_list(:user, 3, :developer) }

  before do
    assign(:project, project)
    assign(:bug, bug)
    assign(:developer_users, developer_users)
    render
  end

  it 'displays the correct form heading' do
    expect(rendered).to have_selector('h1', text: 'New bug')
  end

  it 'renders the form with the correct action and method' do
    expect(rendered).to have_selector("form[action='#{project_bugs_path(project)}'][method='post']")
  end

  it 'renders the title input field' do
    expect(rendered).to have_selector('input[name="bug[title]"]')
  end

  it 'renders the description input field' do
    expect(rendered).to have_selector('input[name="bug[description]"]')
  end

  it 'renders the bug type dropdown' do
    expect(rendered).to have_select('bug[bug_type]', with_options: %w[Feature Bug])
  end

  it 'renders the status dropdown without any initial options' do
    expect(rendered).to have_select('bug[status]', with_options: [])
  end

  it 'renders the deadline input field' do
    expect(rendered).to have_selector('select[name="bug[deadline(1i)]"]')  # year
    expect(rendered).to have_selector('select[name="bug[deadline(2i)]"]')  # month
    expect(rendered).to have_selector('select[name="bug[deadline(3i)]"]')  # day
    expect(rendered).to have_selector('select[name="bug[deadline(4i)]"]')  # hour
    expect(rendered).to have_selector('select[name="bug[deadline(5i)]"]')  # minute
  end

  it 'renders the screenshot file field' do
    expect(rendered).to have_selector('input[type="file"][name="bug[screenshot]"]')
  end

  it 'renders the submit button' do
    expect(rendered).to have_selector('input[type="submit"]')
  end

  it 'renders the back to bugs link' do
    expect(rendered).to have_link('Back to bugs', href: project_bugs_path(project))
  end

  context 'when there are validation errors' do
    before do
      bug.errors.add(:title, "can't be blank")
      render
    end

    it 'displays error messages' do
      expect(rendered).to have_content('1 error prohibited this bug from being saved')
      expect(rendered).to have_content("Title can't be blank")
    end
  end
end
