class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :on_sale, inclusion: { in: [true, false] }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description price stock_quantity on_sale category_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category]
  end
end
