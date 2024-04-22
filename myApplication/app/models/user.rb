class User < ApplicationRecord
  has_many :theaters
  has_many :bookings

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true # format: {with: /\A[a-zA-Z]\z/ , message: "Special characters are not allowed"}
  validates :password, format: { with: /(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*()\-_=+{};:,<.>ยง~]).{8,}/, message: "must include at least one uppercase letter, one lowercase letter, and one special character and length must be greater than 7" }
  validates :role, inclusion: { in: ["customer", "admin", "theater"], message: "%{value} is not a valid value" }

  def as_json(options = {})
    super(only: [:id, :name, :email, :role])
  end

  after_update :update_log

  def update_log
    log = Log.create(user_id: self.id, name: self.name, action: "Password updated")
  end

  after_create :create_log

  def create_log
    log = Log.create(user_id: self.id, name: self.name, action: "created")
  end

  after_destroy :delete_log

  def delete_log
    log = Log.create(user_id: self.id, name: self.name, action: "destroyed")
  end
end
