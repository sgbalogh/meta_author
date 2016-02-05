class RecordsController < ApplicationController
  def new
    @record = Record.new
  end

  def show
    @record = Record.find(params[:id])
    render json: @record
  end

  def create
    if !current_user.nil?
    @user = current_user

    @record = @user.records.new(user_params)
    flash[:success] = "Record saved successfully."
    @record.save
    redirect_to root_path
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
    params.require(:record).permit(:schema, :uuid, :dc_title_s, :solr_year_i, :dc_creator_sm)
  end


end
