class Dungeon < ActiveRecord::Base
  extend Dragonfly::Model::Validations
  validates_presence_of :image
  validates_size_of :image, maximum: 10.megabytes
  validates_property :mime_type, of: :image, in: %w(image/jpeg image/png)

  dragonfly_accessor :image

  has_many :photos, class_name: 'AdditionalPhoto'

  scope :best, -> { order('(upvotes - downvotes) DESC') }
  scope :latest, -> { order('created_at DESC') }

  def upvote!
    increment_by_sql(:upvotes)
  end

  def downvote!
    increment_by_sql(:downvotes)
  end

  LEVELS = {
    1 => 'Yellow',
    2 => 'Green',
    3 => 'Blue',
    4 => 'Pine green',
    5 => 'Red'
  }

  def level_name
    return unless LEVELS.key?(level)
    "[#{level}] #{LEVELS[level]}"
  end

  def title
    t = level_name.to_s
    t += ' by ' + author_name if author_name.present?
    t
  end

  private

  def increment_by_sql(attribute, by = 1)
    sql = %Q{UPDATE #{self.class.table_name} SET #{attribute} = #{attribute} + #{by} WHERE id = #{id}}
    self.class.connection.execute sql
    self.send("#{attribute}=", self.send(attribute) + by)
    self
  end
end
