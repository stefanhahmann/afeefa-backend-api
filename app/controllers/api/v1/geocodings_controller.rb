class Api::V1::GeocodingsController < ApplicationController
  include EnsureToken
  include Cors

  def index
    location = Location.new(geocoding_params)
    # address search using google geocoder
#    results = Geocoder.search(location.address_for_geocoding)
#    if results && results.any? && result = results.first
#      street = result.address.split(',').first
#      render json: {
#        latitude: result.latitude,
#        longitude: result.longitude,
#        street: street,
#        city: result.city,
#        full_address: result.address
#      }
    
    # address search using nominatim (openstreetmap) geocoder
    # see https://www.rubydoc.info/gems/nominatim
    # see https://www.rubydoc.info/gems/nominatim/Nominatim/Place
    # see https://www.rubydoc.info/gems/nominatim/Nominatim/Address
    places = Nominatim.search(location.address_for_geocoding).limit(1).address_details(true)
    if places && places.any? && place = places.first
      render json: {
        latitude: place.lat,
        longitude: place.lon,
        street: place.address.road,
        city: place.address.city,
        full_address: place.address
      }
    else
      render json: 'geocoding failed for address', status: :unprocessable_entity
    end
  rescue => exception
    render json: "error of type #{exception.class.to_s} occured, please try again", status: :internal_server_error
  end

  private

  def geocoding_params
    params.permit(:address, :street, :zip, :city, :country)
  end

  # for EnsureToken
  def token_to_ensure
    Settings.geocoding.api_token
  end
end
