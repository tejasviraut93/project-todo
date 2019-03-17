class Organization < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_many :projects, dependent: :destroy
end
