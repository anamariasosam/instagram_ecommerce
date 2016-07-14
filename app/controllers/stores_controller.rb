class StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def show
    @store = Store.find(params[:id])
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      sign_in @store
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def store_params
      params.require(:store).permit(:info, :name, :email, :address,
                                   :phone_number, :user_token)
    end
end
