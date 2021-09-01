class PracticesController < ApplicationController
  before_action :find_practice, only: [:edit, :show, :update, :destroy, :apply]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :not_user_move_index, only: [:edit, :update, :destroy]
  require 'csv'

  def index
    @practice = Practice.includes(:user)
  end

  def new
    @practice = Practice.new
  end

  def create
    @practice = Practice.new(practice_params)
    if @practice.save
      redirect_to root_path
    else
      render action: :new
    end
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
    PracticeApply.create(practice_id: params[:id], user_id: current_user.id)

    redirect_to completion_practices_path
  end

  def csv_practice_user
    head :no_content

    practiceapply = PracticeApply.where(practice_id: params[:id]).includes(:user)
    practice = Practice.find(params[:id])

    filename = practice.name + Date.current.strftime('%Y%m%d')

    columns_ja = %w[ニックネーム 名字 名前 メールアドレス]
    columns = %w[nickname last_name first_name email]

    csv1 = CSV.generate do |csv|
      csv << columns_ja
      practiceapply.each do |apply|
        user_attributes = apply.attributes
        user_attributes['nickname'] = apply.user.nickname
        user_attributes['last_name'] = apply.user.last_name
        user_attributes['first_name'] = apply.user.first_name
        user_attributes['email'] = apply.user.email
        csv << user_attributes.values_at(*columns)
      end
    end
    create_csv(filename, csv1)
  end

  private

  def find_practice
    @practice = Practice.find(params[:id])
  end

  def practice_params
    params.require(:practice).permit(:name, :price, :practice_on, :practice_at, :place, :comment,
                                     :capacity).merge(user_id: current_user.id)
  end

  def not_user_move_index
    redirect_to root_path unless current_user.id == @practice.user_id
  end

  def create_csv(filename, csv1)
    File.open("./#{filename}.csv", 'w', encoding: 'SJIS') do |file|
      file.write(csv1)
    end
    stat = File.stat("./#{filename}.csv")
    send_file("./#{filename}.csv", filename: "#{filename}.csv", length: stat.size)
  end
end
