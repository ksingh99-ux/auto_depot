class Province < ApplicationRecord
  has_many :customers, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :abbreviation, presence: true, uniqueness: true, length: { is: 2 }
  validates :gst_rate, :pst_rate, :hst_rate, presence: true,
            numericality: { greater_than_or_equal_to: 0, less_than: 1 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name abbreviation gst_rate pst_rate hst_rate]
  end
end
