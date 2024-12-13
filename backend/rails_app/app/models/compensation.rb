class Compensation < ApplicationRecord
    belongs_to :offer
    has_many :vesting_schedules, dependent: :destroy
  
    validates :base_salary, numericality: { greater_than_or_equal_to: 0 }
    validates :stock_total, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  end