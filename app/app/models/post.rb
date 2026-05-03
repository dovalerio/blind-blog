class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true

  scope :published, -> { where(published: true).order(published_at: :desc, created_at: :desc) }

  before_save :set_published_at

  private

  def set_published_at
    if published? && published_at.nil?
      self.published_at = Time.current
    elsif !published?
      self.published_at = nil
    end
  end
end
