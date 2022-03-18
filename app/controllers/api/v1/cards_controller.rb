class Api::V1::CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_card, only: %i(show edit_card update destroy)

  def index
    all_cards = Card.where(list_id: params[:list_id])

    render json: all_cards
  end

  def create
    list = List.find(params[:list_id])
    card = list.cards.new(card_params)

    if card.save
      render json: { status: 'SUCCESS', message: 'New card has been created successfully' }
    else
      render json: { status: 'ERROR', message: 'There is something wrong' }
    end
  end

  def detail
  end

  def show
    card_list = @card.list

    render json: {
                'card' => @card,
                'card_list' => card_list.title
    }
  end

  def edit
  end

  def edit_card
    render json: @card
  end

  def update
    if @card.update(card_update_params)
      render json: { status: 'SUCCESS', message: 'Card has been updated successfully' }
    else
      render json: { status: 'ERROR', message: 'There is something wrong' }
    end
  end

  def destroy
    if @card.destroy
      render json: { status: 'SUCCESS', message: 'Card has been deleted successfully' }
    else
      render json: { status: 'ERROR', message: 'There is something wrong' }
    end
    end

  private
  def card_params
    params.require(:card).permit(:title, :memo)
  end

  def card_update_params
    params.require(:card).permit(:title, :memo, :list_id)
  end

  def find_card
    @card = Card.find(params[:id])
  end
end
