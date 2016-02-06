class RecordsController < ApplicationController
  def new
    @record = Record.new
  end

  def index
    if !current_user.nil?
      @user = current_user
    else
      flash[:danger] = "You aren't logged in!"
      redirect_to login_path
    end
  end



  def show
    @record = Record.find(params[:id])

    if params[:format] == "json"
      render json: Record.find(params[:id])
    end

    if !@record.solr_geom.nil?
      @polygon = parse_polygon(@record.solr_geom)
      @centroid = find_centroid(@polygon)
      @zoom = 8
    else
      @centroid = [0,0]
      @zoom = 1
    end



    # render json: @record
  end

  def create
    if !current_user.nil?
    @user = current_user

    @record = @user.records.new(user_params)
    flash[:success] = "Record saved successfully."
    @record.save
    redirect_to @record
    else
      flash[:danger] = "You aren't logged in!"
      redirect_to root_path
    end

  end

  def json
    @record = Record.find(params[:id])
    render json: @record
  end


  private

  def user_params
    params.require(:record).permit(:schema, :uuid, :dc_title_s, :dc_identifier_s, :dc_description_s, :dc_rights_s, :dct_provenance_s,:dct_references_s, :georss_box_s, :layer_id_s, :layer_geom_type_s, :layer_modified_dt, :layer_slug_s, :solr_geom, :solr_year_i, :dc_creator_sm)
  end


end
