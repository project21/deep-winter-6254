class UserMailer < ActionMailer::Base
 default from: "info@buckpile.com"

  def invite(product)
    @product = product
    @url  = "http://example.com/login"
    mail(:to =>"davidm1921@yahoo.com", :subject => "Ecommerce Lottery Invitation")
  end
end
