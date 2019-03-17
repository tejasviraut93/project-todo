class Todo < ApplicationRecord
  extend Enumerize
  belongs_to :project

  enumerize :status, in: %i[new in_progress done], default: :new
end
