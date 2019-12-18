class InvoicesController < ApplicationController
  before_action :authenticate_user!, except: [:accept, :decline]

  def index
    if !!params[:account_id]
      @invoices = current_user.accounts.find_by(id: params[:account_id]).invoices
    else
      @invoices = current_user.invoices
    end
  end

  def new
    @invoice = current_user.invoices.build
    @invoice.invoice_products.build
  end

  def create
    @invoice = current_user.invoices.build(invoice_params)
    if @invoice.save
      @invoice.calculate_product_totals
      flash[:notice] = "Invoice created successfully!"
      redirect_to account_invoice_path(@invoice.account, @invoice)
    else
      flash[:alert] = @invoice.errors.full_messages.uniq
      render :new
    end
  end

  def show
    @invoice = current_user.invoices.find_by(id: params[:id])
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
      flash[:alert] = @invoice.errors.full_messages.uniq
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

  def unsent
    @invoices = current_user.invoices.where(status: 'unsent')
    binding.pry
  end

  def accept
    @invoice = Invoice.find_by(id: params[:id])
    if @invoice
      flash[:notice] = "Thank you for accepting the invoice!  Payment instructions will be sent shortly."
      @invoice.status = "accepted"
      @invoice.save
    else
      flash[:alert] = "There seems to have been a issue accepting that invoice, please contact support"
    end
    render :'application/notice'
  end


  def decline
    @invoice = Invoice.find_by(id: params[:id])
    if @invoice
      flash[:notice] = "You have successfully declined the invoice, please fill the forms below so we can understand why."
      @invoice.status = "declined"
      @invoice.save
    else
      flash[:alert] = "There seems to have been a issue accepting that invoice, please contact support"
    end
    render :'application/notice'
  end

  private

  def invoice_params
    params.require(:invoice).permit(:account_id, :created_at, :due_time, invoice_products_attributes: [:product_id, :quantity, :_destroy])
  end
end
