class PracticesController < ApplicationController
  before_action :find_practice, only: :apply

  def index
    @practices = Practice.all
  end

  def apply
    redirect_to new_card_path and return unless current_user.card.present?

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @practice.price,
      customer: customer_token,
      currency: 'jpy'
    )
    PracticeApply.create(practice_id: params[:id])
    redirect_to root_path
  end

  private

  def find_practice
    @practice = Practice.find(params[:id])
  end

end
