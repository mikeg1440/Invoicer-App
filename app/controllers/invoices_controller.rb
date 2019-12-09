class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    if !!params[:account_id]
      @invoices = current_user.accounts.find_by(id: params[:account_id]).invoices
    else
      @invoices = current_user.invoices
    end
  end

  def new
    @invoice = current_user.invoices.build
  end

  def create
    binding.pry
    @invoice = current_user.invoices.build(invoice_params)
    if @invoice.save
      @invoice.calculate_product_totals
      flash[:notice] = "Invoice created successfully!"
      redirect_to invoice_path(@invoice)
    else
      flash[:alert] = @invoice.errors.full_messages.uniq
      render :new
    end
  end

  def show
    @invoice = current_user.invoices.find_by(id: params[:id])
    binding.pry
  end

  def edit
    binding.pry

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

  private

  def invoice_params
    params.require(:invoice).permit(:id, :account_id, :created_at, :due_time, invoice_products_attributes: [:product_id, :quantity])
  end
end
