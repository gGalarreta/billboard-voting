class Billboard < ApplicationRecord
  has_many :billboard_interactions, dependent: :destroy
  has_many :users, through: :billboard_interactions

  scope :recent, -> { order(created_at: :desc) }
  scope :top, -> {
    joins(:billboard_interactions)
      .where(billboard_interactions: { reaction: 1 })
      .group(:id)
      .order(Arel.sql('COUNT(billboard_interactions.id) DESC'))
  }
  scope :fresh, -> {
    order(Arel.sql('RANDOM()'))
  }

  def likes
    billboard_interactions.where(reaction: 1).count
  end

  def dislikes
    billboard_interactions.where(reaction: -1).count
  end
end
