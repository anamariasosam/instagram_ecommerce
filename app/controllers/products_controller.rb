class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:index, :new, :edit]

  # GET /products
  # GET /products.json
  def index
    @products = current_user.products
    if @products.count == 0
      flash[:notice] = "Aún no tienes productos, crea tus productos <a href='/users/dashboard'>aquí</a>".html_safe
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    if current_user.user_token
      params.inspect
      @photo = params[:photo]
      @photo_id = params[:photo_id]

      @product = Product.new
    else
      redirect_to :controller => 'sessions', :action => 'connect'
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'El producto ha sido creado exitosamente'}
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if current_user.user_token
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to @product, notice: 'El producto ha sido actualizado exitosamente' }
          format.json { render :show, status: :ok, location: @product }
        else

          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
        redirect_to :controller => 'sessions', :action => 'connect'
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'El producto ha sido eliminado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      if Product.count > 0
        @product = Product.find(params[:id])
      else
        redirect_to "/404"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:product_name, :user_id,:price, :quantity, :instagram_image, :description, :likes, :photo_id)
    end
end
