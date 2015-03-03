class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  before_save :generate_slug, on: :create

  def generate_slug
      the_slug = to_slug(self.name)
      category = Category.find_by slug: the_slug
      if category && category != self
        category = Category.order(:created_at).last
        the_slug << "-#{category.slug[/\d+$/].to_i + 1}"
      end
      self.slug = the_slug
    end

    def to_slug(cat)
      str = cat.strip.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
      str.gsub! /-+/, '-'
      str.downcase
    end

  def to_param
    self.slug
  end
end