class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale, :set_city

  def set_city
    if request.host.include?("discoveringnyc.com") || request.host.include?("discoveringnewyorkcity.com") || request.host.include?("descobrindonovayork.com") || request.host.include?("descobrindo.nyc") || request.host.include?("descubriendo.nyc") || request.host.include?("descubriendonevayork.com") || request.host.include?("descubriedonewyorkcity.com") || request.host.include?("descubrenyc.com") || request.host.include?("descubriendonuevayork.com") || request.host.include?("descubriendony.com") || request.host.include?("descubriendonewyork.com")

    Rails.application.config.city = 'newyorkcity'
    Rails.application.config.city_name = 'New York'

    elsif request.host.include?("miamidiscover.com") || request.host.include?("miamidiscover.com") || request.host.include?("miamidiscover.com")

    Rails.application.config.city = 'miami'
    Rails.application.config.city_name = 'Miami'

  elsif request.host.include?("losangelesdiscover.com") || request.host.include?("descubriendolosangeles.com")

    Rails.application.config.city = 'losangeles'
    Rails.application.config.city_name = 'Los Angeles'

    end

    # TEST CITY
    if Rails.env.development?
      Rails.application.config.city = 'newyorkcity'
      Rails.application.config.city_name = 'New York'
      # Rails.application.config.city = 'miami'
      # Rails.application.config.city_name = 'Miami'
      # Rails.application.config.city = 'losangeles'
      # Rails.application.config.city_name = 'Los Angeles'
    end

    @city_id = Rails.application.config.city
    @city_name = Rails.application.config.city_name
    @mio=I18n.locale

  end

  def set_locale
    if extract_locale_from_subdomain == nil

      languages = ["en", "es", "pt"]
      # logger.debug "locale"
      # logger.debug extract_locale_from_accept_language_header
      if request.host.include?("discoveringnyc.com") || request.host.include?("discoveringnewyorkcity.com")
        I18n.locale = "en"
      elsif request.host.include?("descobrindonovayork.com") || request.host.include?("descobrindo.nyc")
        I18n.locale = "pt"
      elsif request.host.include?("descubriendo.nyc") || request.host.include?("descubriendonuevayork.com") || request.host.include?("descubriedonewyorkcity.com") || request.host.include?("descubrenyc.com") || request.host.include?("descubriendonuevayork.com") || request.host.include?("descubriendony.com") || request.host.include?("descubriendonewyork.com")
        I18n.locale = "es"
      else
        if languages.include?(extract_locale_from_accept_language_header)
          I18n.locale = extract_locale_from_accept_language_header
        else
          I18n.locale = I18n.default_locale
        end
      end
    else
      I18n.locale = extract_locale_from_subdomain || I18n.default_locale
    end
  end

  # Get locale code from request subdomain (like http://it.application.local:3000)
  # You have to put something like:
  #   127.0.0.1 gr.application.local
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    if parsed_locale != nil
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
    else
      return nil
    end
  end

  def extract_locale_from_accept_language_header
    @request = request.env['HTTP_ACCEPT_LANGUAGE']
    if @request
      @request = @request.scan(/^[a-z]{2}/).first
    else
      @request = I18n.default_locale
    end
  end

  def get_city
    if params.has_key?(:city) || session[:city].nil?
      session[:city] = params[:city]
      @city = session[:city]
    else
      @city = session[:city]
    end
    return @city
  end
end
