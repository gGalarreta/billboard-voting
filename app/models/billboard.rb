class Billboard < ApplicationRecord
  has_many :billboard_interactions, dependent: :destroy
  has_many :users, through: :billboard_interactions

  def likes
    billboard_interactions.where(reaction: 1).count
  end

  def dislikes
    billboard_interactions.where(reaction: -1).count
  end
end
