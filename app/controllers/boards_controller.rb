class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :update, :destroy]

  def index()
    @collection = Board.all
    render json: @collection
  end

  def show()
    render json: @resource
  end

  def create()
    @resource = Board.create(resource_params)
    render json: @resource
  end

  def update()
    @resource.update(resource_params)
    render json: @resource
  end

  def destroy()
    @resource.destroy
    render json: @resource
  end

  private # DRY

  def resource_params
    params.permit(:title, :description)
  end

  def set_board
    @resource = Board.find(params[:id])
  end
end
