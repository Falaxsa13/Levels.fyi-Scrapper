class Company < ApplicationRecord
    has_many :roles, dependent: :destroy  # Add this if the roles table exists
  end