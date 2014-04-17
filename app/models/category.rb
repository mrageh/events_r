class Category < ActiveRecord::Base
  has_many :categorisations, dependent: :destroy
  has_many :events, through: :categorisations

  validates :name, presence: :true, uniqueness: :true
end
