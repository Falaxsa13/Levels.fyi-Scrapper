class Role < ApplicationRecord
    belongs_to :company
    has_many :offers, dependent: :destroy
  
    validates :title, presence: true
  end