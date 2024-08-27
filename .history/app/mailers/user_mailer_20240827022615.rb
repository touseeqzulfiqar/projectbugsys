class UserMailer < ApplicationMailer
  default from: 'touseeqzulfiqar@gmail.com'
  def new_user(user, project)
    @user = user
    @project = project
    mail to: "touseeqzulfiqar@gmail.com", subject: "New Post add by touseeq"

  end
end
