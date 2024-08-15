class UseremailJob
  include Sidekiq::Job

  def perform(qa_user_id, project_id)
    qa_user = User.find(qa_user_id)
    project = Project.find(project_id)

    UserMailer.new_user(qa_user, project).deliver_now
  end
end
