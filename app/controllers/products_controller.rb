class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
    # @products = current_user.products
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:notice] = "Successfully created new product!"
      redirect_to @product
    else
      flash[:alert] = @product.errors.full_messages
      render :new
    end
  end

  def edit
    @product = current_user.products.find_by(id: params[:id])
  end

  def update
    @product = current_user.products.find_by(id: params[:id])
    if @product.update(product_params)
      flash[:notice] = "Successfully updated product!"
      redirect_to @product
    else
      flash[:alert] = @product.errors.full_messages
      render :edit
    end
  end

  def show
    # @product = current_user.products.find_by(id: params[:id])
    @product = Product.find_by(id: params[:id])
  end

  def destroy
    product = current_user.products.find_by(id: params[:id])
    if product.destroy
      flash[:notice] = "Successfully deleted product!"
      redirect_to products_path
    else
      flash[:alert] = "Failed to delete product!"
      redirect_to product
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
