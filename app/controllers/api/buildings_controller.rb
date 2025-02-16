module Api
  class BuildingsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      if params[:client_id].blank?
        render status: 404, json: {}
        return
      end

      building = Building.new(building_params)
      building.save!

      render status: 201, json: {}
    end

    def update
      building = Building.find(params[:id])

      building.update!(building_params)

      render status: 200, json: {}
    end

    private

    def building_params
      params.permit(:id, :client_id, :address, :city, :state, :zip_code, :custom_fields).slice(:client_id, :address, :city, :state, :zip_code)
    end
  end
end