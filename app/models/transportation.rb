class Transportation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :transport_type
  field :city

  belongs_to :activity
  has_and_belongs_to_many :lines, inverse_of: nil
end
