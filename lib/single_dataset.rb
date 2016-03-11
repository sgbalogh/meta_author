require 'gdal-ruby/ogr'
class SingleDataset

  attr_accessor :bbox

  def initialize(path, rename_id, dataset_id)
    @path = path
    @dataset_record_id = dataset_id
    @rename_id = rename_id
    @root_path = '/Users/stephen/git/torchedearth'
    @quarantine_path = '/Users/stephen/git/torchedearth/quarantine'
    @path_to_shapefile = '/Users/stephen/git/torchedearth/quarantine/' + rename_id + '/' + rename_id + '.shp'
    @bbox = {}
  end

  def stage
    `cp #{@root_path}/#{@path} #{@quarantine_path}/#{@rename_id}.zip`
  end

  def unzip
    `unzip #{@quarantine_path}/#{@rename_id}.zip -d #{@quarantine_path}/#{@rename_id}`
  end

  # Renames files, replacing basename of .shp file with UUID, across occurrences in all files
  def baptise
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


  def get_extent
    shapefile = Gdal::Ogr.open(File.join(@path_to_shapefile))
    ex = shapefile.get_layer(@rename_id).get_extent
    @bbox=({:w => ex[0], :e => ex[1], :s => ex[2], :n => ex[3]})

    ds = Dataset.find(@dataset_record_id)
    Record.update(ds.record_id, :solr_geom => "ENVELOPE(#{bbox[:w]}, #{bbox[:e]}, #{bbox[:n]}, #{bbox[:s]})")
  end

end

