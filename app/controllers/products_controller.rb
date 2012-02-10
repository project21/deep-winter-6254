class ProductsController < ApplicationController
   before_filter :authenticate_user!, :only=>:show
   before_filter :authenticate, :only=>:new

  def index
    @products=Product.where("price=? AND active=?",1,true).order('created_at ASC').limit(30)
  end

  def show
    @invite=Product.new
    @token=Token.new
    @product=Product.find(params[:id])
    session[:product_id] = @product.id
     @price=@product.minimum_price 
     @user_credits=current_user.tokens.where(:used=>false).count 
     @amount_difference=(@price - @user_credits ).to_f
  end

  def new
    @product=Product.new
  end

  def create
    @product=Product.new(params[:product])
    if @product.save
      redirect_to :action=>"index"
    else
      redirect_to :action=>"new"
    end
  end

  def edit
    @product=Product.find(params[:id])
  end

  def delete
     @product=Product.find(params[:id])
     @product.destroy
     redirect_to :controller=>"products",:action=>"index"
   end

def sold
    @sold=Product.where("price=? AND active=?",1,false).limit(20)
    
end

def all_new
   @all_new=Product.where(:active=>true).order('created_at DESC').limit(30)
end

def my_account
  @invite=Product.new
  if user_signed_in?
     @my_games=current_user.tokens
     @my_credit=current_user.tokens.where(:used=>false).count 
     current_user.update_attribute(:my_credit,@my_credit)
     @my_credits=current_user.my_credit
    else
    redirect_to  :action=>"index"
   end
end

def invite_people
  @email=Product.new(:email_recepient=>params[:product][:email_recepient])
 @email_recepient=@email.email_recepient.to_s
  @message=Product.new(:message=>params[:product][:message])
  @email_message=@message.message.to_s
  @product=Product.find(session[:product_id])
  UserMailer.invite(@product,@email_recepient,@email_message).deliver
   redirect_to :back
end

def buy_now
   @products=Product.where("active=? and price>?",true,1).limit(30)
   if user_signed_in?
     @my_credit=current_user.tokens.where(:used=>false).count
      current_user.update_attribute(:my_credit,@my_credit)
      @my_credits=current_user.my_credit
    else
    redirect_to  :action=>"index"
   end
end

def buy 
     @product=Product.find(session[:product_id])
    if user_signed_in?
     @my_credits=current_user.tokens.where(:used=>false).count 
     @left_credits=@my_credits - @product.minimum_price
     current_user.tokens.where(:used=>false).limit(@product.minimum_price).update_all(:used=>true)
     current_user.update_attribute(:my_credit,@left_credits)
     @product.update_attribute(:active,false)
    else
    redirect_to  :action=>"index"
   end 
end

def shipping_address
    @user=current_user
end

def update_address
     @user=current_user
    if @user.update_attributes(params[:user])
       redirect_to :controller=>'products',:action => 'my_account'
       flash[:notice]="Your address have been updated"
    else
      render :shipping_address
    end
end

def skip
    redirect_to :controller=>"products",:action=>"my_account"
end

def direct_to_update_address
    redirect_to :controller=>"products",:action=>"shipping_address"
end

def basic_info
    @user=current_user
end

def update_basic_info
     @user=current_user
    if @user.update_attributes(params[:user])
       redirect_to :controller=>'products',:action => 'my_account'
       flash[:notice]="Your informations have been updated"
    else
      render :basic_info
    end
end

def authenticate
     authenticate_or_request_with_http_basic do |username, password|
     username == "buckpile_beta" && password == "password"
   end
end

end
