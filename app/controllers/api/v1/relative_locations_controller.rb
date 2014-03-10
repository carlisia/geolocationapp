module Api
  module V1
    class RelativeLocationsController < ApplicationController
      respond_to :json

      def index
        locations = RelativeLocations.new(params)
        if locations.valid?  
          render :json => locations
        else
          render :json => {:error => errors_for(locations)}, :status => :unprocessable_entity
        end
      end

      private
      
      def errors_for(object)
        object.errors.map {|k, m| "#{k} #{m}" }
      end 

    end
  end
end