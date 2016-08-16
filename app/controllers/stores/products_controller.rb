class Stores::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:edit, :update, :destroy]
  before_filter :pilot_store, only: [:index, :new, :edit]

  helper_method :sort_column, :sort_direction
  layout 'dashboard'

  def index
    @products = current_user
                  .products
                  .search(params[:search])
                  .order(sort_column + " " + sort_direction)
  end

  def new
    params.inspect
    @photo = params[:photo]
    @photo_id = params[:photo_id]
    @product = Product.new
  end

  def edit
    if current_user.id != @product.store_id
      flash[:error] = t('product.edit_permissions')
      redirect_to root_url
    end
  end

  def create
    @product = Product.new(product_params)
    @product.store_id = current_user.id

    respond_to do |format|
      if @product.save
        @product.create_activity :create, owner: current_user
        format.html { redirect_to stores_products_path, notice: "El producto ha sido creado exitosamente.<br>
          <a class='js_instagramLoad' href='/stores/list' class='product_link'>Agregar otro producto</a>"}
        format.json { render :index, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    if not Order.exists?(product_id: @product.id)
      @product.create_activity :destroy, owner: current_user, parameters: {
        last_name: @product.product_name
      }
      @product.destroy
      respond_to do |format|
        format.html { redirect_to stores_products_path, notice: 'El producto ha sido eliminado con éxito.' }
        format.json { head :no_content }
      end
    else
      flash[:error] = t('product.delete_permissions')
      redirect_to :back
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def product_params
      params.require(:product).permit(
        :product_name,
        :price,
        :quantity,
        :instagram_image,
        :description,
        :likes,
        :photo_id,
        :category_id
      )
    end

    def pilot_store
      if !current_user.pilot?
        flash[:error] = t('user.no_pilot')
        redirect_to stores_subscribe_path
      end
    end
end
