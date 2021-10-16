class Notice < ApplicationRecord
  validates :posted_at, presence: true
  validates :text, presence: true, length: { maximum: 300 }
  validates :display, inclusion: { in: [true, false] }
end
