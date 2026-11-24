class Order < ApplicationRecord
  STATUSES = %w[new paid shipped].freeze

  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, inclusion: { in: STATUSES }
  validates :address, :city, :postal_code, :province_name, presence: true
  validates :gst_rate, :pst_rate, :hst_rate, presence: true,
            numericality: { greater_than_or_equal_to: 0, less_than: 1 }
  validates :subtotal, :gst_amount, :pst_amount, :hst_amount, :total, presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id status customer_id province_name subtotal total created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[customer order_items products]
  end
end
