class Offer < ApplicationRecord
    belongs_to :role
    has_one :compensation, dependent: :destroy
  
    validates :location, presence: true
    validates :employment_type, inclusion: { in: ['Full-Time Employee', 'Part-Time Employee', 'Contractor'] }
  end