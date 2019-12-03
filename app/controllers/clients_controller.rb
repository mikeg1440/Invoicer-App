class ClientsController < ApplicationController
  def index
    @clients = current_users_clients
  end

  def show
    @client = Client.find_by(id: params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    client = current_user.clients.build(client_params)
    if client.valid?
      client.save
      flash[:notice] = "Client successfully created!"
      redirect_to client_path(client)
    else
      flash[:alert] = client.errors.full_messages
      render :new
    end
  end

  def edit
    @client = Client.find_by(id: params[:id])
    binding.pry
  end

  def update
    binding.pry
  end

  def destroy
    @client = Client.find_by(id: params[:id])
    if @client.destroy
      flash[:notice] = "Client deleted successfully!"
      redirect_to clients_path
    else
      flash[:alert] = "Client could not be deleted!"
      render :show
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :business_name, :email, :phone_number, :address)
  end

end
