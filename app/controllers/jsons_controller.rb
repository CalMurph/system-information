class JsonsController < ApplicationController
  def index
  end

  def data
    @raw_data = Json.find(params[:id])

    @name = Sysinfo.find(@raw_data.sysinfo_id).name

    @json_data = JSON.parse(@raw_data.json) unless @raw_data.nil?
  end

  def handle_click
    flash[:response] = "You clicked the button"
    redirect_to root_path
  end


  def show
     @sysinfo = Sysinfo.find(params[:sysinfo_id])

     @sysinfo_id = params[:sysinfo_id]

     @index = params[:id].to_i

     full_data = @sysinfo.jsons.order(created_at: :desc)

     @json_length = full_data.length


    @raw_data = full_data[@index - 1]

    begin
       @json_data = JSON.parse(@raw_data.json) unless @raw_data.nil?


    rescue TypeError
      puts "Invalid data"


    end

    return if @raw_data.nil?

    @json_id = @raw_data.id
    @created_on = @raw_data.created_at unless @raw_data.nil?
    @updated_on = @raw_data.updated_at unless @raw_data.nil?
  end
end
