class Token < ActiveRecord::Base
  require 'digest/sha1'
  
	attr_accessor :stripe_card_token,:buck,:name
   
   belongs_to :user
   belongs_to :product
   
def save_with_payment quantity
  if valid?
    customer = Stripe::Charge.create(amount:buck,:currency => "usd",card:stripe_card_token,:description => "Charge for bucks",name:name )
    self.stripe_customer_token = customer.id
    
    quantity.times do
    #self.attributes.merge!(unique_token: Digest::SHA1.hexdigest("foo"))
    Token.create!(user_id:self.user_id,product_id:self.product_id,unique_token: Digest::SHA1.hexdigest(self.product_id.to_s + self.user_id.to_s + Token.random_string))
    end 
    #save!
 end
rescue Stripe::InvalidRequestError => e
  logger.error "Stripe error while creating customer: #{e.message}"
  errors.add :base, "There was a problem with your credit card."
  false
end

def self.random_string
    (0...8).map{65.+(rand(25)).chr}.join
end

def pay_difference amount_difference
  if valid?
    customer = Stripe::Charge.create(amount:amount_difference,:currency => "usd",card:stripe_card_token,:description => "Pay the difference",name:name )
    self.stripe_customer_token = customer.id
    save!
 end
rescue Stripe::InvalidRequestError => e
  logger.error "Stripe error while creating customer: #{e.message}"
  errors.add :base, "There was a problem with your credit card."
  false
end

end
