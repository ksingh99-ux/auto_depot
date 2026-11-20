class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :on_sale, inclusion: { in: [true, false] }
  validate :image_must_be_an_image_file

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description price stock_quantity on_sale category_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category]
  end

  private

  def image_must_be_an_image_file
    return unless image.attached?
    return if image.content_type.in?(%w[image/jpeg image/png image/webp image/gif])

    errors.add(:image, "must be a JPG, PNG, WEBP or GIF file")
  end
end
