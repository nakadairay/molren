class PracticesController < ApplicationController
  before_action :find_practice, only: [:edit, :show, :update, :destroy, :apply]

  def index
    @practices = Practice.includes(:user)
  end

  def new
    @practice = Practice.new
  end

  def create
    Practice.create(practice_params)
  end

  def show
  end

  def edit
    
  end

  def update
    if @practice.update(practice_params)
      redirect_to practice_path(@practice.id)
    else
      render action: :edit
    end
  end

  def destroy
    @practice.destroy
    redirect_to root_path
  end

  def apply
    redirect_to new_card_path and return unless current_user.card.present?

    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
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

  def practice_params
    params.require(:practice).permit(:name, :price, :practice_on, :practice_at, :place, :comment,:capacity).merge(user_id: current_user.id)
  end
end

