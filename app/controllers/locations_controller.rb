class LocationsController < ApplicationController
  helper_method :locations, :location

  def locations
    @_locations ||= Location.all
  end

  def import
    begin
      Location.import(params[:file])
      redirect_to locations_url, notice: "Location list imported."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end
end
