
  class SingleDataset

    def initialize(path, rename_id)
      @path = path
      @rename_id = rename_id
      @root_path = '/Users/stephen/git/torchedearth'
      @quarantine_path = '/Users/stephen/git/torchedearth/quarantine'
    end

    def stage
      `cp #{@root_path}/#{@path} #{@quarantine_path}/#{@rename_id}.zip`
    end

    def unzip
      `unzip #{@quarantine_path}/#{@rename_id}.zip -d #{@quarantine_path}/#{@rename_id}`
    end


  end

