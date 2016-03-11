class ProcessorController < ApplicationController
  def pursue
    if !current_user.nil?
      if is_admin?(current_user)
        flash[:success] = "Processing thread initiated..."
        redirect_to datasets_index_path
        path = 'storage/dataset/multiattach/' + params[:id] + '/' + params[:basename] + '.' + params[:extension]
        rename = get_uuid(params[:id])
        dataset = SingleDataset.new(path, rename, params[:id])
        dataset.delay.stage()
        dataset.delay.unzip()
        dataset.delay.baptise()
        dataset.delay.get_extent()

      else
        flash[:danger] = "Nice try."
        redirect_to datasets_index_path
      end
    else
      flash[:danger] = "Nice try."
      redirect_to datasets_index_path
    end


  end

  private


  def get_uuid(datasetId)
    dataset = Dataset.find(datasetId)
    record = Record.find(dataset.record_id)
    if record.uuid.nil?
      return record.id
    else
      return record.uuid
    end
  end

end
