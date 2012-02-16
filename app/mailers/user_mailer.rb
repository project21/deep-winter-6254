class UserMailer < ActionMailer::Base
 default from: "info@buckpile.com"

  def invite(product,email,message,user)
    @product = product
    @email=email
    @message=message
    @user=user
    #attachments[@product.image_url.to_s]=File.read(@product.image_url.to_s)
    @url  = "http://example.com/login"
    mail(:to =>@email, :subject => "Ecommerce Lottery Invitation",:from=>@user.email)
  end
 
  def notify_all(*email_array,product)
  	  @emails=email_array
  	  @product=product
  	  mail(:to =>@emails, :subject => "Buckpile Results")
  end

  def notify_winner(user,product)
    @user=user
    @product = product
     mail(:to =>@user.email, :subject => "Buckpile Results")
  end

end
