class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]


  enum sex: { man: 0, woman: 1}
  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :password, :password_confirmation, 
              format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/ }
    with_options format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

  has_one :card, dependent: :destroy
  has_many :sns_credentials

end
