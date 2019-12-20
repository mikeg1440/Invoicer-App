class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    unless @product.save
      flash[:alert] = @product.errors.full_messages
      render :new and return
    end
    flash[:notice] = "Successfully created new product!"
    redirect_to @product
  end


  def edit
  end

  def update
    unless @product.update(product_params)
      flash[:alert] = @product.errors.full_messages
      render :edit and return
    end
    flash[:notice] = "Successfully updated product!"
    redirect_to @product
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def destroy
    unless @product && @product.destroy
      flash[:alert] = "You can only delete products that YOU create!"
      @product = Product.find_by(id: params[:id])
      render :show and return
    end
    flash[:notice] = "Successfully deleted product!"
    redirect_to products_path
  end

  def top_five
    @products = Product.top_five
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  def find_product
    @product = current_user.products.find_by(id: params[:id])
  end

end
