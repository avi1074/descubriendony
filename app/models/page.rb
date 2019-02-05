class Page
  include Mongoid::Document

  field :page, type: String
  field :city, type: String
  field :content, localize: true, type: String

  #def permalink
   # "#{self.id.to_s}-#{Utility.create_permalink(self.content)}"
  #end

  end
