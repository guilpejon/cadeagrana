class BankAccount < ApplicationRecord
  belongs_to :user

  TYPES = %w[checking savings other].freeze
  COLORS = %w[#6C63FF #00D4AA #F7B731 #FF6B6B #A78BFA #34D399 #60A5FA #F472B6].freeze

  validates :name, presence: true
  validates :account_type, inclusion: { in: TYPES }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :interest_rate, numericality: { greater_than_or_equal_to: 0 }

  def monthly_interest
    balance * interest_rate / 100 / 12
  end

  def yearly_interest
    balance * interest_rate / 100
  end
end
