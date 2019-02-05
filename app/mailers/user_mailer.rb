class UserMailer < ActionMailer::Base
  default from: "descubriendony@gmail.com", :content_type => "multipart/mixed"
  def send_email(subscriber)    
    mail( :to => subscriber.email, :subject => "descubriendony.com subcription")
    end
end
