# Preview all emails at http://localhost:3000/rails/mailers/application_approval_mailer
class ApplicationApprovalMailerPreview < ActionMailer::Preview
  # https://405780c3fc5a426aa317dcac083a252d.vfs.cloud9.us-east-2.amazonaws.com/rails/mailers/application_approval_mailer/send_confirm_to_user
  def send_confirm_to_user
    guide = User.find(27)
    request = guide.passive_requests.first
    ApplicationApprovalMailer.send_confirm_to_user(guide, request)
  end
end
