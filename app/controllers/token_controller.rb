class TokenController < ApplicationController
	respond_to :js
   
  def new
  	@token=Token.new
  end

  def create
  	 @buck=Token.new(:buck=>params[:token][:buck])
     @quantity1=@buck.buck.to_s.to_i
     @quantity= @quantity1 / 100
  	 @token=Token.new(params[:token])
     unless session[:product_id].nil? || session[:product_id].blank? 
       if @token.save_with_payment(@quantity)
       @product=Product.find(session[:product_id])
       @current_tokens=@product.tokens.count 
        if @current_tokens >= @product.minimum_price
        @winner_token=@product.tokens.sample.unique_token
        @winner=Token.find_by_unique_token(@winner_token).user.username
        @product.update_attribute(:winner,@winner)
        User.increment_counter(:no_of_winning, Token.find_by_unique_token(@winner_token).user.id)
        @product.update_attribute(:active,false)
        #redirect_to "products#index"
        end
        redirect_to :controller=>"products",:action=>"index"
    
    else
        redirect_to :action=>"new"
    end

  else
      redirect_to :controller=>"products",:action=>"index"
    end
  end

end
