class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[products]
  end
end
