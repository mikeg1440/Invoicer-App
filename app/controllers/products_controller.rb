class ProductsController < ApplicationController
  before_action :authenticate_user!

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
      render :new
    end
    flash[:notice] = "Successfully created new product!"
    redirect_to @product
  end


  def edit
    @product = current_user.products.find_by(id: params[:id])
  end

  def update
    @product = current_user.products.find_by(id: params[:id])
    unless @product.update(product_params)
      flash[:alert] = @product.errors.full_messages
      render :edit
    end
    flash[:notice] = "Successfully updated product!"
    redirect_to @product
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def destroy
    product = current_user.products.find_by(id: params[:id])
    unless product && product.destroy
      flash[:alert] = "You can only delete products that YOU create!"
      @product = Product.find_by(id: params[:id])
      render :show
    end
    flash[:notice] = "Successfully deleted product!"
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
