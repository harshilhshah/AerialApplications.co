class Contact < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true
end
