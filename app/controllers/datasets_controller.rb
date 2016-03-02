class DatasetsController < ApplicationController
  def index


    if !current_user.nil?
      @user = current_user
      @datasets = @user.datasets.all
    else
      flash[:danger] = "You must be logged in to access this resource."
      redirect_to root_path
    end

  end

  def new
    if !current_user.nil?
      @user = current_user
      @record = @user.records.new
      @dataset = @record.datasets.new
    else
      flash[:danger] = "You must be logged in to access this resource."
      redirect_to root_path
    end

  end

  def create

    @user = current_user
    @record = @user.records.new(record_params)
    @dataset = @record.datasets.new(dataset_params)

    if @dataset.save && @record.save
      flash[:success] = "The dataset \"#{@dataset.name}\" has been uploaded successfully."
      redirect_to datasets_path
    else
      render "new"
    end

  end

  def destroy
    @dataset = Dataset.find(params[:id])
    @dataset.destroy
    redirect_to resumes_path, notice:  "The dataset #{@dataset.name} has been deleted."
  end

  private

  def record_params
    params.require(:record).permit(:schema, :uuid, :dc_title_s, :dc_identifier_s, :dc_description_s, :dc_rights_s, :dct_provenance_s, :dct_references_s, :georss_box_s, :georss_polygon_s, :layer_id_s, :layer_geom_type_s, :layer_modified_dt, :layer_slug_s, :solr_geom, :solr_year_i, :dc_creator_sm)
  end

  def dataset_params
    params.require(:dataset).permit(:name, { multiattach: [] })
  end
end
