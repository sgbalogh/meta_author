class RecordsController < ApplicationController
  def new
    @record = Record.new
  end

  def show
    @record = Record.find(params[:id])
    render json: @record
  end

  def create
    @record = Record.new(user_params)
    flash[:success] = "Record saved successfully."
    @record.save
    redirect_to root_path
  end

  def json
    @record = Record.find(params[:id])
    render json: @record
  end


  private

  def user_params
    params.require(:record).permit(:schema)
  end


end
