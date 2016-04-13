class TasksController < ApplicationController
  before_action :set_list

  def index
    render json: {
      meta: {
        count: @list.tasks.count,
        page: 0
      },
      tasks: @list.tasks.order(:finished, :id)
    }
  end

  def create
    task = Task.new(task_params)
    task.list = @list

    if task = task.save
      render json: { task: task }
    else
      render json: {
        message: "Could not create Task",
        errors: task.errors,
      }, status: :unprocessible_entity
    end
  end

  def update
    task = @list.tasks.find(params[:id])

    if task.update(task_params)
      render json: { task: task }
    else
      render json: {
        message: "Could not update Task",
        errors: task.errors,
      }, status: :unprocessible_entity
    end
  end

  def destroy
    task = @list.tasks.find(params[:id])

    if task.destroy
      render json: { task: nil }
    else
      render json: {
        message: "Could not destroy Todo, please try again",
      }, status: :unprocessible_entity
    end
  end

  private

  def set_list
     @list = List.find(params[:list_id])
   end

  def task_params
    params.require(:task).permit(:title, :finished)
  end
end
