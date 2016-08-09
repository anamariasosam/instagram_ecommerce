class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:index, :new, :edit]
  before_filter :require_store, only: [:index, :new, :edit]
  before_filter :pilot_store, only: [:index, :new, :edit]
  helper_method :sort_column, :sort_direction
  layout 'dashboard', :except => :show


  def create_comment(product)
    product_code = @product.shortened_urls.last.unique_key
    message = t('web.instagram_comment', code: product_code )
    client = Instagram.client(:access_token => current_user.user_token)
    result = client.create_media_comment(product.photo_id, message)
  end
  # GET /products
  # GET /products.json
  def index
    @products = current_user
                  .products
                  .search(params[:search])
                  .order(sort_column + " " + sort_direction)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    params.inspect
    @photo = params[:photo]
    @photo_id = params[:photo_id]

    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    if current_user.id != @product.store_id
      flash[:error] = t('product.edit_permissions')
      redirect_to root_url
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.store_id = current_user.id

    respond_to do |format|
      if @product.save
        create_comment(@product)
        @product.create_activity :create, owner: current_user
        format.html { redirect_to products_path, notice: "El producto ha sido creado exitosamente.<br>
          <a class='js_instagramLoad' href='/users/list' class='product_link'>Agregar otro producto</a>"}
        format.json { render :index, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.create_activity :update, owner: current_user
        format.html { redirect_to @product, notice: 'El producto ha sido actualizado exitosamente' }
        format.json { render :show, status: :ok, location: @product }
      else

        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.create_activity :destroy, owner: current_user, parameters: { last_name: @product.product_name }
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
      params.require(:product).permit(:product_name, :price, :quantity, :instagram_image, :description, :likes, :photo_id, :category_id)
    end

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def require_store
      if current_user.type == "Customer"
        flash[:error] = t('user.no_store')
        redirect_to root_url
      end
    end

    def pilot_store
      if !current_user.pilot?
        flash[:error] = t('user.no_pilot')
        redirect_to users_suscribe_path
      end
    end
end
