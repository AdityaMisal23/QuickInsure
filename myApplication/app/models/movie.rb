class Movie < ApplicationRecord
  has_many :shows

  has_one_attached :image

  def attach_image(image_file)
    image.attach(io: File.open(image_file), filename: "self.name.jpg")
  end


  validates :name, presence: true

  def as_json(options = {})
    super(only: [:id, :name, :release_date, :genre, :is_active])
  end
end
