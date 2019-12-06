class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @invoices = current_user.invoices
  end

  def new
  end

  def show
    @invoice = current_user.invoices.find_by(id: params[:id])
  end

  def edit
  end

  def destroy
    invoice = current_user.invoices.find_by(id: params[:id])
    if invoice.destroy
      flash[:notice] = "Invoice deleted successfully!"
      redirect_to invoices_path
    else
      flash[:alert] = "Invoice could not be deleted!"
      render :index
    end
  end
end
