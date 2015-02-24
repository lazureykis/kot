class Dungeon < ActiveRecord::Base
  dragonfly_accessor :image

  scope :by_rating, -> { order('(upvotes - downvotes) DESC') }
  scope :latest, -> { order('created_at DESC') }

  def upvote!
    increment_by_sql(:upvotes)
  end

  def downvote!
    increment_by_sql(:downvotes)
  end

  def title
    [level, author_name.presence].compact.join(' : ')
  end

  private

  def increment_by_sql(attribute, by = 1)
    sql = %Q{UPDATE #{self.class.table_name} SET #{attribute} = #{attribute} + #{by} WHERE id = #{id}}
    self.class.connection.execute sql
    self.send("#{attribute}=", self.send(attribute) + by)
    self
  end
end
