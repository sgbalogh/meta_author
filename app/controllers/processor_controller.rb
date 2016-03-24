class ProcessorController < ApplicationController
  def pursue
    if !current_user.nil?
      if is_admin?(current_user)
        flash[:success] = "Processing thread initiated..."
        redirect_to datasets_index_path
        path = 'storage/dataset/multiattach/' + params[:id] + '/' + params[:basename] + '.' + params[:extension]
        rename = get_uuid(params[:id])
        dataset = SingleDataset.new(path, rename, params[:id])
        dataset.delay.move_to_stage
        dataset.delay.decompress_upload
        dataset.delay.find_and_christen
        dataset.delay.make_WGS84
        dataset.delay.get_extent
        dataset.delay.make_SQL

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
    if record.uuid.blank?
      return 'default_' + record.id.to_s
    else
      return record.uuid
    end
  end

end
