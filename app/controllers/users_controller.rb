class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    @practices = current_user.practices
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    card = Card.find_by(user_id: current_user.id)

    redirect_to new_card_path and return unless card.present?

    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
  end
end
