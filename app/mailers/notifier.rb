class Notifier < ActionMailer::Base
  default :from => "7.scott.j@gmail.com" # your email address here
  
  def welcome_new_member(user)
    from "7.scott.j@gmail.com"  # your email address here
    subject "YCP Welcome"    
    recipients user.email
    
    text = "Welcome to the YCP contacts site!\n\n"
    text << "Put in more stuff you want to say to new members\n"

    body text
  end
  
  
  def send_member_admin_message(user, sub, message="")
    from "7.scott.j@gmail.com"  # your email address here
    subject sub    
    recipients user.email

    body message
  end
  
end