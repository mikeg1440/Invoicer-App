class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def show
    @client = Client.find_by(id: params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    binding.pry
    client = Client.create(client_params)
    if client.valid?
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
    binding.pry
  end

  private

  def client_params
    params.require(:client).permit(:name, :business_name, :email, :phone_number, :address)
  end

end
