class DashboardController < ApplicationController
  def index()
    total_boards = Board.count
    
    total_tasks = Task.joins(:board).count

    total_incomplete_tasks = Task.joins(:board).where(completed_at: nil).count

    render json: { total_boards: total_boards, total_tasks: total_tasks, total_incomplete_tasks: total_incomplete_tasks }
  end
end
