class Image < ApplicationRecord
  has_many :groups

  def self.collection
    collection = []
    self.all.each do |image|
      collection << [image.url, image.id]
    end
    return collection
  end
end
