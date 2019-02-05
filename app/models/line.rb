class Line
  include Mongoid::Document

  field :name
  field :short_name
  field :color
  field :city

  belongs_to :transportation
end
