module Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :generate_slug
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug
    the_slug = to_slug(self.send(self.class.slug_column.to_sym))
    obj = self.class.find_by slug: the_slug
    if obj && obj != self
      obj = self.class.order(:created_at).last
      the_slug << "-#{obj.slug[/\d+$/].to_i + 1}"
    end
    self.slug = the_slug
  end

  def to_slug(column)
    str = column.strip.gsub /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, '-'
    str.downcase
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end