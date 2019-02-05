class SitemapController < ApplicationController
  
  respond_to :xml
  def index
  	@categories=Category.all
  end
end
