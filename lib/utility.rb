# encoding: utf-8

module Utility
  extend self

  def create_token
    SecureRandom.urlsafe_base64
  end

  def get_password
    "This8En8Oab"
  end

  def create_permalink(string, separator = '-', max_size = 160)
    ignore_words = ['a', 'an', 'the']
    ignore_re = String.new
    ignore_words.each{ |word| ignore_re << word + '\b|\b' }
    ignore_re = '\b' + ignore_re + '\b'
    permalink = string.gsub("'", separator)
    permalink.gsub!(ignore_re, '')
    permalink = permalink.parameterize
    permalink.gsub!(/[^a-z0-9]+/, separator)
    permalink = permalink.to(max_size)
    return permalink.gsub(/^\\#{separator}+|\\#{separator}+$/, '')
  end

  def genre_length
    Genre.all.each do |genre|
      genre.update_attributes(name_length: genre.name.length)
      puts genre.name.length
    end
  end

  def convert_activities
    Category.where(:category_id.ne => nil).each do |category|
      puts category.name
      array = []
      category.activities.each do |activity|
        # puts activity.main_title
        array << activity.id
      end
      puts array
      category.update_attributes(plin_ids: array)
    end
    
  end

end