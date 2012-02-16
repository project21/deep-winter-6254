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
       Player.create(:email=>current_user.email,:product_id=>@product.id)
       @current_tokens=@product.tokens.count 
        if @current_tokens >= @product.minimum_price
        @winner_token=@product.tokens.sample.unique_token
        @winner=Token.find_by_unique_token(@winner_token).user.username
        @product.update_attribute(:winner,@winner)
        UserMailer.notify_all(@product.players.map{|f| f.email,@product}).deliver
        UserMailer.notify_winner(User.find_by_username(@winner)).deliver
        Token.find_by_unique_token(@winner_token).update_attribute(:used,true)
        User.increment_counter(:no_of_winning, Token.find_by_unique_token(@winner_token).user.id)
        @product.update_attribute(:active,false)
        #redirect_to "products#index"
        end
           if current_user.address.nil? 
             return redirect_to :controller=>"products",:action=>"shipping_address"
           else
             return redirect_to :controller=>"products",:action=>"my_account"
            end
        return redirect_to :controller=>"products",:action=>"my_account"   
    else
       redirect_to :back
       flash[:notice]="Sorry ,an error occured, please try again"
    end

  else
      redirect_to :controller=>"products",:action=>"index"
    end
  end

def pay
     if user_signed_in?
     @token=Token.new(params[:token])
     unless session[:product_id].nil? || session[:product_id].blank?
     @product=Product.find(session[:product_id])
     @price=@product.minimum_price 
     @user_credits=current_user.tokens.where(:used=>false).count 

     @amount_difference=(@price - @user_credits )*100
     if @token.pay_difference(@amount_difference )
          current_user.tokens.where(:used=>false).update_all(:used=>true)
          @product.update_attribute(:active,false)
            if current_user.address.nil? 
             return redirect_to :controller=>"products",:action=>"shipping_address"
            else
             return redirect_to :controller=>"products",:action=>"my_account"
            end
      else
        redirect_to "products#show" 
    end
  end
end
end

end
