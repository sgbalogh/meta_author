class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.all
  end

  def new
    @dataset = Dataset.new
  end

  def create
    @dataset = Dataset.new(dataset_params)

    if @dataset.save
      redirect_to datasets_path, notice: "The dataset #{@dataset.name} has been uploaded."
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
  def dataset_params
    params.require(:dataset).permit(:name, :attachment)
  end
end
