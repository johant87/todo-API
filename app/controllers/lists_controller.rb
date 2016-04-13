class ListsController < ApplicationController
  def index
    render json: {
      meta: {
        count: List.count,
        page: 0
      },
      lists: List.order(:title)
    }
  end

    def show
      list = List.find(params[:id])
      render json: {
        list: list,
        tasks: list.tasks
      }
    end

  def create
    if list = List.create(list_params)
      render json: { list: list }
    else
      render json: {
        message: "Could not create List",
        errors: list.errors,
      }, status: :unprocessible_entity
    end
  end

  def update
    list = List.find(params[:id])

    if list.update(list_params)
      render json: { list: list }
    else
      render json: {
        message: "Could not update List",
        errors: list.errors,
      }, status: :unprocessible_entity
    end
  end

  def destroy
    list = List.find(params[:id])

    if list.destroy
      render json: { list: nil }
    else
      render json: {
        message: "Could not destroy List, please try again",
      }, status: :unprocessible_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :body, :finished, :end_date)
  end
end
