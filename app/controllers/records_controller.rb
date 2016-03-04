class RecordsController < ApplicationController
  def new
    @record = Record.new
  end

  def index
    if !current_user.nil?
      @user = current_user
      @records = @user.records.all
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
      begin
        @polygon = parse_polygon(@record.solr_geom)
      rescue NoMethodError
        flash.now[:danger] = "Unable to parse bounding box coordinates. Defaulting to world extent."
        @polygon = [[90, -180], [90, 180], [-90, 180], [-90, -180]]
      end
      @centroid = find_centroid(@polygon)
      @zoom = 8
    else
      @centroid = [0, 0]
      @zoom = 1
    end
    # render json: @record
  end

  def edit
    @record = Record.find(params[:id])

    # Still need to work in some authentication dimension; i.e. only
    # users from the same institution can edit? Or more sophisticated?

  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy


  end


  def create
    if !current_user.nil?
      @user = current_user
      @record = @user.records.new(user_params)

      if @record.save
        flash[:success] = "Record saved successfully."
        redirect_to @record
      else
        flash[:danger] = "Unable to save record. Try again."
        redirect_to new_record_path
      end

    else
      flash[:danger] = "You aren't logged in!"
      redirect_to root_path
    end
  end

  def update
    @record = Record.find(params[:id])
    if @record.update_attributes(user_params)
      redirect_to @record
    else
      render 'edit'
    end
  end

  def json
    @record = Record.find(params[:id])
    render json: @record
  end


  private

  def user_params
    params.require(:record).permit(:schema, :uuid, :dc_title_s, :dc_identifier_s, :dc_description_s, :dc_rights_s, :dct_provenance_s, :dct_references_s, :georss_box_s, :georss_polygon_s, :layer_id_s, :layer_geom_type_s, :layer_modified_dt, :layer_slug_s, :solr_geom, :solr_year_i, :dc_creator_sm)
  end

end
