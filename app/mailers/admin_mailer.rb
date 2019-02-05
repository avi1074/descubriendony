class AdminMailer < ActionMailer::Base
  default from: "descubriendony@gmail.com", :content_type => "multipart/mixed"
  def send_email(subscriber)
    @subscriber = subscriber    
    mail( :to => "descubriendony@gmail.com", :subject =>subscriber.email + " has been subscribed!")
  end
end
