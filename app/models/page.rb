class Page < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true,
                   format: { with: /\A[a-z0-9-]+\z/, message: "only allows lowercase letters, numbers and dashes" }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id title content slug created_at updated_at]
  end
end
