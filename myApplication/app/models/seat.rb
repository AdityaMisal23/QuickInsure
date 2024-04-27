class Seat < ApplicationRecord
  belongs_to :resource, polymorphic: true

  def as_json(options = {})
    super(only: [:id, :resource_id, :resource_type, :row, :column, :section])
  end
end
