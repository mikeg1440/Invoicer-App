class ClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @clients = Client.all
  end

  def show
    @client = Client.find_by(id: params[:id])
  end

  def new
    @client = Client.new
    @client.accounts.build
  end

  def create
    @client = current_user.clients.find_or_build_by(client_params, current_user)
    if params[:account]
      @client.save
      account = current_user.accounts.build(name: params[:account][:name], user: current_user, client: @client)
      account.save
    end

    unless @client.valid?
      flash[:alert] = client.errors.full_messages
      render :new and return
    end
    @client.save
    flash[:notice] = "Client successfully created!"
    redirect_to client_path(@client)
  end

  def edit
    @client = current_user.clients.where(id: params[:id]).first
  end

  def update
    @client = Client.find_by(id: params[:id])
    if @client.update(client_params)
      flash[:notice] = "Client updated successfully!"
      redirect_to @client
    else
      flash[:alert] = "Failed to update client!"
      render edit
    end
  end

  def destroy
    @client = current_user.clients.find_by(id: params[:id])
    if @client && @client.destroy
      flash[:notice] = "Client deleted successfully!"
      redirect_to clients_path
    else
      flash[:alert] = "You can only delete clients that YOU create!"
      @client = Client.find_by(id: params[:id])
      render :show
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :business_name, :email, :phone_number, :address, account_attributes: [:name] )
  end

end
