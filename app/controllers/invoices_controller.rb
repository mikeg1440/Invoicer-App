class InvoicesController < ApplicationController
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
end
