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

  # Renames files, replacing basename of .shp file with UUID, across occurrences in all files
  def brand
    `cd #{@quarantine_path}/#{@rename_id}
    shapefile=$(ls *.shp)
    shapebase=${shapefile%.*}
    RUB_uuid='#{@rename_id}'
    for file in *.*; do
      if [[ $file == *$shapebase* ]]; then
        newfile="${file/$shapebase/$RUB_uuid}"
        mv $file $newfile
      fi
    done`
  end


end

