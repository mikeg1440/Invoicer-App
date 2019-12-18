class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts
  end

  def show
    @account = current_user.accounts.find_by(id: params[:id])
  end

  def new
    @account = current_user.accounts.build()
  end

  def create
    @account = current_user.accounts.find_or_build_by(account_params, current_user)
    if @account.save
      flash[:notice] = "Account created successfully!"
      redirect_to account_path(@account)
    else
      flash[:alert] = @account.errors.full_messages.uniq
      render :new
    end
  end

  def edit
    @account = current_user.accounts.find_by(id: params[:id])
  end

  def update
    @account = current_user.accounts.find_by(id: params[:id])
    if @account.update(account_params)
      flash[:notice] = "Account updated successfully!"
      redirect_to account_path(@account)
    else
      flash[:alert] = @account.errors.full_messages.uniq
      render :edit
    end

  end

  def destroy
    @account = current_user.accounts.find_by(id: params[:id])
    if @account.destroy
      flash[:notice] = "Successfully deleted account!"
      redirect_to accounts_path
    else
      flash[:alert] = "Failed to delete account!"
      render :show
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :user_id, :client_id, client_attributes: [:name, :business_name, :email, :phone_number, :address])
  end

end
