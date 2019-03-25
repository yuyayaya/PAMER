class ApplicationApprovalMailer < ApplicationMailer

   def send_confirm_to_user(guide, request)
    @guide = guide
    @request = request
    mail to: guide.email, subject: "あなたのプランが申し込まれました。"
   end
  
end
