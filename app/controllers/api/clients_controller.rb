class Api::ClientsController < ApplicationController
  # GET /clients
  def index
    clients = Client.all
    render json: clients
  end

  # POST /clients
  def create
    client = Client.new(client_params)
    if client.save
      render json: client, status: :created
    else
      render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /clients/:id
  def show
    client = Client.find(params[:id])
    render json: client
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  # PUT /clients/:id
  def update
    client = Client.find(params[:id])
    if client.update(client_params)
      render json: client
    else
      render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  # DELETE /clients/:id
  def destroy
    client = Client.find(params[:id])
    client.destroy
    render json: client
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  private

  def client_params
    params.require(:client).permit(:name)
  end
end