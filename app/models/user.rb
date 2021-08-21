class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favorited_products, through: :favorites, source: :product # 中間テーブルを通じて他のテーブルにアクセスする

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :confirmable, :trackable,
          :omniauthable, omniauth_providers: [:google_oauth2]

  validates :name, length: { maximum: 20 }

  # def favorite(product)
  #   favorites.find_or_create_by(product_id: product.id)
  # end

  # def unfavorite(product)
  #   favorite = favorites.find_by(poduct_id: product.id)
  #   favorite.destroy if favorite
  # end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data['name'],
        email: data['email'],
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
