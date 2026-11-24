class Customer < ApplicationRecord
  # Devise hashes and salts the password (bcrypt)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province
  has_many :orders, dependent: :destroy

  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :address, length: { maximum: 150 }, allow_blank: true
  validates :city, length: { maximum: 80 }, allow_blank: true
  validates :postal_code, allow_blank: true,
            format: { with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/, message: "must look like R3T 2N2" }

  validates :address, :city, :postal_code, presence: true, on: :checkout

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id first_name last_name email city postal_code province_id created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[province]
  end
end
