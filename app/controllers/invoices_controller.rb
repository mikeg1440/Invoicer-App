class InvoicesController < ApplicationController
  def index
    @invoices = current_user.invoices 
  end

  def new
  end

  def show
  end

  def edit
  end
end
