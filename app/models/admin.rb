class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
        :rememberable, :validatable

  before_create :registerable_count
  before_destroy :deleting_prohibited

  private

    def registerable_count
      if Admin.present?
        errors.add(:base, "Don't increase it!")
        throw(:abort)
      end
    end

    def deleting_prohibited
      if Admin.count == 1
        errors.add(:base, "No way, you can't remove that away!")
        throw(:abort)
      end
    end
end
