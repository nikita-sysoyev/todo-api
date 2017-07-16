class TasksController < ApplicationController
  before_action :set_board
  before_action :set_task, only: [:show, :update, :destroy, :complete]

  def index()
    @collection = Task.where(board_id: params[:board_id])

    case params[:type].try(:to_sym)
    when :completed
      @collection = @collection.where("completed_at is not null")
    when :incompleted
      @collection = @collection.where(completed_at: nil)
    end
   
    render json: @collection
  end

  def show()
    render json: @resource
  end

  def create()
    @resource = @board.tasks.create!(resource_params)
    render json: @resource
  end

  def complete
    @resource.update(completed_at: Time.now)
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
    params.permit(:title, :description, :completed_at)
  end

  def set_task
    @resource = Task.find(params[:id])
  end

  def set_board
    @board = Board.find(params[:board_id])
  end
end
