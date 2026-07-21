module Api
  class SysinfosController < ApplicationController
    skip_forgery_protection

    def index
      sysinfos = Sysinfo.all

      render json: sysinfos.as_json(
        only: [ :id, :name, :rack_pos, :slots, :notes, :json, :created_at, :updated_at ]
      )
    end

    def show
      sysinfo = Sysinfo.find(params[:id])

      render json: sysinfo.as_json(
        only: [ :id, :name, :rack_pos, :slots, :notes, :json, :created_at, :updated_at ]
      )
    end

    def create
      sysinfo = Sysinfo.new(sysinfo_params.except(:json))

      sysinfo[:json] = sysinfo_params[:json].read unless sysinfo_params[:json].nil?

      if sysinfo.save
        Json.create!(sysinfo: sysinfo, json: sysinfo[:json]) if sysinfo[:json].present?

        render json: sysinfo, status: :created
      else
        render json: { errors: sysinfo.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      sysinfo = Sysinfo.find(params[:id])
      attributes = sysinfo_params

      sysinfo.assign_attributes(attributes.except(:json))
      sysinfo[:json] = attributes[:json].read unless attributes[:json].nil?

      if sysinfo.save
        Json.create!(sysinfo: sysinfo, json: sysinfo[:json]) if attributes[:json].present?

        render json: sysinfo
      else
        render json: { errors: sysinfo.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      sysinfo = Sysinfo.find(params[:id])
      sysinfo.destroy

      head :no_content
    end


    private

    def sysinfo_params
      params.expect(sysinfo: [ :name, :rack_pos, :slots, :notes, :json ])
    end
  end
end
