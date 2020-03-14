class InvoicesController < ApplicationController
  before_action :authenticate_user!, except: [:accept, :decline]
  before_action :find_user_invoice, only: [:show, :edit, :update, :destroy]
  before_action :find_invoice, only: [:accept, :decline]


  def index
    if !!params[:account_id]
      @invoices = current_user.accounts.find_by(id: params[:account_id]).invoices
    else
      @invoices = current_user.invoices
    end
  end

  def new
    @invoice = current_user.invoices.build
    @invoice.account_id = params[:account_id] if  !!params[:account_id]
    @invoice.invoice_products.build
  end

  def create
    @invoice = current_user.invoices.build(invoice_params)
    invoice_params[:invoice_products_attributes].each do |num,product|
      @invoice.invoice_products.build(product)
    end
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
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      flash[:notice] = "Updated invoice successfully!"
      @invoice.calculate_product_totals
      redirect_to account_invoice_path(@invoice)
    else
      flash[:alert] = @invoice.errors.full_messages.uniq
      render :edit
    end
  end

  def destroy
    if @invoice.destroy
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
  end

  def accept
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
    params.require(:invoice).permit(:account_id, :created_at, :due_time, invoice_products_attributes: [:product_id, :quantity, :total, :_destroy])
  end

  def find_invoice
    @invoice = Invoice.find_by(id: params[:id])
  end

  def find_user_invoice
    @invoice = current_user.invoices.find_by(id: params[:id])
  end
end
