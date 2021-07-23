class Micropost < ApplicationRecord
  MICROPOST_PARAMS = %i(content image).freeze
  belongs_to :user
  has_one_attached :image

  delegate :name, to: :user, prefix: :user

  validates :user_id, presence: true
  validates :content, presence: true,
                      length: {maximum: Settings.max_content_length}
  validates :image, content_type: {in: Settings.image_type,
                                   message: :invalid_format_image},
                    size: {less_than: Settings.max_image_size.megabytes,
                           message: :should_smaller}

  scope :recent_posts, ->{order(created_at: :desc)}

  def display_image
    image.variant resize_to_limit: Settings.image_size_limit
  end
end
