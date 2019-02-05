class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, localize: true, type: String
  field :position, type: Integer
  field :city, type: String 
  mount_uploader :category_image, CategoryImageUploader

  has_and_belongs_to_many :activities, inverse_of: nil
  has_many :categories, :class_name => 'Category', :inverse_of => :category
  belongs_to :category, :class_name => 'Category', :inverse_of => :categories

  def permalink
    "#{self.id.to_s}-#{Utility.create_permalink(self.name)}"
  end


end
