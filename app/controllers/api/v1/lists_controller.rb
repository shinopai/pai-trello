class Api::V1::ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_list, only: %i(destroy update)

  def index
    all_lists = List.includes(:cards).where(user_id: params[:user_id])

    render json: all_lists
  end

  def show
    list = List.find(params[:id])

    render json: list.cards
  end

  def create
    user = User.find(params[:user_id])
    list = user.lists.new(list_params)

    if list.save
      render json: { status: 'SUCCESS', message: 'New list has been created successfully' }
    else
      render json: { status: 'ERROR', message: 'There is something wrong' }
    end
  end

  def destroy
    if @list.delete
      render json: { status: 'SUCCESS', message: 'List has been deleted successfully' }
    else
      render json: { status: 'ERROR', message: 'There is something wrong' }
    end
  end

  def update
    if @list.update(list_params)
      render json: { status: 'SUCCESS', message: 'List has been updated successfully' }
    else
      render json: { status: 'ERROR', message: 'There is something wrong' }
    end
  end

  private
  def list_params
    params.require(:list).permit(:title)
  end

  def find_list
    @list = List.find(params[:id])
  end
end
