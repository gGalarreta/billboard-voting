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

  def increment(user)
    positive_interaction = billboard_interactions.find_by(user: user, reaction: 1)
    return if positive_interaction.present?

    negative_interaction = billboard_interactions.find_by(user: user, reaction: -1)
    return negative_interaction.destroy if negative_interaction.present?

    billboard_interactions.create(user: user, reaction: 1)
  end

  def decrement(user)
    negative_interaction = billboard_interactions.find_by(user: user, reaction: -1)
    return if negative_interaction.present?

    positive_interaction = billboard_interactions.find_by(user: user, reaction: 1)
    return positive_interaction.destroy if positive_interaction.present?

    billboard_interactions.create(user: user, reaction: -1)
  end
end
