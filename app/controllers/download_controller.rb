class DownloadController < ApplicationController
  def download
    dataset = Dataset.find(params[:id])
    record = Record.find(dataset.record_id)
    user = User.find(record.user_id)

    if current_user == user
      path = 'storage/dataset/multiattach/' + params[:id] + '/' + params[:basename] + '.' + params[:extension]
      send_file path
    else
      flash[:danger] = "Insufficient access privileges"
      redirect_to datasets_index_path
    end


  end
end
