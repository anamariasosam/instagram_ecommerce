class StoresController < ApplicationController

  def show

    @user = User.find(params[:id])
    @products = @user.products.page(params[:page]).per(4)

  end

  def index

    @users = User.all

  end

end
