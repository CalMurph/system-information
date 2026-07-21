require "net/http"
require "json"
class SysinfosController < ApplicationController
  # before_action :set_product, only: %i[ show edit update ]
  def index
    @sysinfo = Sysinfo.all
  end

  def new
    @sysinfo = Sysinfo.new
  end

  def destroy
    @sysinfo = Sysinfo.find(params[:id])
    @sysinfo.destroy
    redirect_to sysinfos_path
  end

  def show
    redirect_to sysinfo_json_path(params[:id], 1)
  end

  def edit
    @sysinfo = Sysinfo.find(params[:id])
  end

  def update
    @sysinfo = Sysinfo.find(params[:id])
    # @sysinfo[:json] = sysinfo_params[:json].read unless sysinfo_params[:json].nil?
    if @sysinfo.update(sysinfo_params.except(:json))
       @sysinfo[:json] = sysinfo_params[:json].read unless sysinfo_params[:json].nil?
        @sysinfo.jsons.create(json: @sysinfo[:json]) if @sysinfo[:json].present?


      redirect_to @sysinfo
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @sysinfo = Sysinfo.new(sysinfo_params.except(:json))




    @sysinfo[:json] = sysinfo_params[:json].read unless sysinfo_params[:json].nil?

    if @sysinfo.save
      @sysinfo.jsons.create(json: @sysinfo[:json]) if @sysinfo[:json].present?
      redirect_to @sysinfo
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def sysinfo_params
    params.expect(sysinfo: [ :name, :rack_pos, :slots, :notes, :json ])
  end
end
