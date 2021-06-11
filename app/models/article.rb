class Article < ApplicationRecord
  validates :Title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :Description, presence: true, length: { minimum: 10, maximum: 100 }

end
