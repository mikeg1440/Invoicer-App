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
    @invoice = current_user.invoices.find_by(id: params[:id])
    @invoice.invoice_products.build
  end

  def update
    @invoice = current_user.invoices.find_by(id: params[:id])
    if @invoice.update(invoice_params)
      flash[:notice] = "Updated invoice successfully!"
      redirect_to account_invoice_path(@invoice)
    else
      flash[:alert] = "Failed to update invoice!"
      render :edit
    end
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

  def add_field
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def send_invoice
    @invoice = Invoice.find_by(id: params[:id])
    @invoice.status = 'sent'
    @invoice.save
    binding.pry
  end

  private

  def invoice_params
    params.require(:invoice).permit(:account_id, :created_at, :due_time, invoice_products_attributes: [:product_id, :quantity, :_destroy])
  end
end
