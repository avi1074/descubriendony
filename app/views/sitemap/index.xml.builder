xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  xml.url do
    xml.loc root_url
    xml.changefreq("hourly")
    xml.priority "1.0"
  end
  @categories.each do |category|  
    xml.url do
      xml.loc category_url(category)
      xml.changefreq("daily")
      xml.priority "0.8"
      xml.lastmod category.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end
end

