class Recipe < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def self.search(query)
    where("title like ?", "%#{query}%")
  end

end
