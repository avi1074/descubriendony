class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :main_title
  field :position, type: Integer
  field :title, localize: true, type: String
  field :city, type: String 
  field :description, localize: true, type: String
  field :url
  field :is_free, type: Boolean, default: false
  field :price, type: String
  field :pricechange, localize: true, type: String 
  field :address
  field :address2
  field :phone_number
  field :video, localize: true, type: String
  field :meta_title, localize: true, type: String
  field :meta_keywords, localize: true, type: String
  field :meta_description, localize: true, type: String
  field :google_maps
  field :coordinates, type: Array, default: []
  field :banner_url
  field :banner_vertical
  field :banner_horizontal
  field :buy_now_url
  field :menu_url
  field :bannerurlchange, localize: true
  field :bannerverticalchange, localize: true
  field :bannerhorizontalchange, localize: true
  field :buynowurlchange, localize: true
  field :status, type: String, default: 'inactive'
  mount_uploader :activity_image, ActivityImageUploader

  belongs_to :category
  has_and_belongs_to_many :transportations, inverse_of: nil

  has_and_belongs_to_many :related_activities, :class_name => 'Activity', :inverse_of => :activity
  belongs_to :activity, :class_name => 'Activity', :inverse_of => :activities

  def permalink
    "#{self.id.to_s}-#{Utility.create_permalink(self.title)}"
  end

  def principal_category
    Category.all.each do |category|
      if category.activities.where("_id" => self.id).exists?
        return category.id
      end
    end
  end

end
