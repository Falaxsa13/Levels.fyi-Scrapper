class VestingSchedule < ApplicationRecord
    belongs_to :compensation
  
    validates :year, numericality: { only_integer: true, greater_than: 0 }
    validates :amount, numericality: { greater_than_or_equal_to: 0 }
    validates :percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  end