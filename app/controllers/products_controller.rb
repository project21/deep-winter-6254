class ProductsController < ApplicationController
   before_filter :authenticate_user!, :only=>:show
  def index
    @products=Product.where(:active=>true).order('created_at ASC').limit(30)
  end

  def show
      @token=Token.new
    @product=Product.find(params[:id])
    session[:product_id] = @product.id
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
    @sold=Product.where(:active=>false).limit(20)
end

def all_new
   @all_new=Product.where(:active=>true).order('created_at DESC').limit(30)
end

def my_account
  if user_signed_in?
     @my_games=current_user.tokens
     @my_credits=current_user.tokens.count - current_user.no_of_winning
    else
    redirect_to  :action=>"index"
   end
end

def buy_now
   @products=Product.where("active=? and price<?",true,1).limit(30)
   if user_signed_in?
     @my_credits=current_user.tokens.count - current_user.no_of_winning
    else
    redirect_to  :action=>"index"
   end
end

end
