# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :organization

  validates :name,
            presence: true

  validates_uniqueness_of :name, scope: :organization_id
end
