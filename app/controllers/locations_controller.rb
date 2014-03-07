class LocationsController < ApplicationController
  helper_method :locations, :location

  def locations
    @_locations ||= Location.all
  end

  def location
    @_location ||= locations.find(params[:id])
  end
end
