class AccountsController < ApplicationController
  def index
    @accounts = current_user.accounts
  end

  def show
    binding.pry
    @account = current_user.accounts.find_by(id: params[:id])
  end

  def new
    @account = current_user.accounts.build()
  end

  def create
    binding.pry
  end

  def edit
    binding.pry
    @account = current_user.accounts.find_by(id: params[:id])
  end

  def update
    binding.pry    
  end

end
