module Api
  class BuildingsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :update]

    def index
      buildings = Building.includes(:client, :building_custom_fields).all

      buildings_json = buildings.map do |building|
        building_json = {
          id: building.id,
          client_name: building.client.name,
          address: building.address
        }

        building.building_custom_fields.each do |custom_field|
          name = custom_field.name
          value = custom_field.value

          building_json[name] = value
        end

        building_json
      end

      render status: 200, json: buildings_json
    end

    def create
      if params[:client_id].blank?
        render status: 404, json: {}
        return
      end

      validate_custom_fields!(params[:client_id])

      building = Building.new(building_params)
      custom_fields = begin
        if params[:custom_fields]
          params[:custom_fields].map do |custom_field|
            BuildingCustomField.new(name: custom_field[:name], value: custom_field[:value])
          end
        else
          []
        end
      end

      ActiveRecord::Base.transaction do
        building.save!
        building.building_custom_fields = custom_fields
      end

      render status: 201, json: {}
    end

    def update
      building = Building.find(params[:id])

      validate_custom_fields!(building.client_id)

      if params[:custom_fields].present?
        custom_fields = begin
          if params[:custom_fields]
            params[:custom_fields].map do |custom_field|
              BuildingCustomField.new(name: custom_field[:name], value: custom_field[:value])
            end
          else
            []
          end
        end

        ActiveRecord::Base.transaction do
          building.update!(building_params)
          building.building_custom_fields = custom_fields
        end
      else
        building.update!(building_params)
      end

      render status: 200, json: {}
    end

    private

    def building_params
      params.permit(:id, :client_id, :address, :city, :state, :zip_code, :custom_fields).slice(:client_id, :address, :city, :state, :zip_code)
    end

    def validate_custom_fields!(client_id)
      if params[:custom_fields].present?
        params[:custom_fields].each do |custom_field|
          field = CustomField.where(client_id: client_id, name: custom_field[:name]).first

          if field.blank?
            render status: 404, json: {}
            return
          end

          if field[:field_type] === 'number' && /\A\d+(\.\d+)?\Z/.match(custom_field[:value]).blank?
            render status: 404, json: {}
            return
          end

          if field[:field_type] === 'enum' && CustomFieldValue.where(custom_field_id: field.id, value: custom_field[:value]).first.blank?
            render status: 404, json: {}
            return
          end
        end
      end
    end
  end
end