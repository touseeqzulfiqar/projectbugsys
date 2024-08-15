class UserMailer < ApplicationMailer
  default from: 'touseeqzulfiqar@gmail.com'
  def new_user(qa_user, project)
    @qa_user = qa_user
    @project = project
    mail to: "touseeqzulfiqar@gmail.com", subject: "New Post add by touseeq"

  end
end
