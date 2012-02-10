class UserMailer < ActionMailer::Base
 default from: "info@buckpile.com"

  def invite(product,email,message)
    @product = product
    @email=email
    @message=message
    #attachments[@product.image_url.to_s]=File.read(@product.image_url.to_s)
    @url  = "http://example.com/login"
    mail(:to =>@email, :subject => "Ecommerce Lottery Invitation")
  end
end
