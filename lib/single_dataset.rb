
  class SingleDataset

    def initialize(path, rename_id)
      @path = path
      @rename_id = rename_id
    end

    def stage
      `cp #{ENV['ROOT']}/#{@path} #{ENV['QUARANTINE_DIR']}/#{@rename_id}.zip`
    end

    def unzip
      `unzip #{ENV['QUARANTINE_DIR']}/#{@rename_id}.zip -d #{ENV['QUARANTINE_DIR']}/#{@rename_id}`
    end


  end

