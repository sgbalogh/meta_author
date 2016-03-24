require 'fileutils'
require 'find'
require 'gdal-ruby/ogr'
class SingleDataset

  attr_accessor :bbox

  def initialize(path, rename_id, dataset_id)
    @path = path
    @path_parent = File.expand_path('..', path)
    @dataset_record_id = dataset_id
    @rename_id = rename_id
    @root_path = Rails.root
    @quarantine_path = "#{Rails.root}/quarantine"
    @path_to_staged_zip = "#{@quarantine_path}/#{@rename_id}/zip/#{@rename_id}.zip"
    @path_to_unzip_dir = "#{@quarantine_path}/#{@rename_id}/unzip"
    @path_to_christened_dir = "#{@quarantine_path}/#{@rename_id}/christened"
    @path_to_output_dir = "#{@quarantine_path}/#{@rename_id}/output"
    @path_to_shapefile = "#{@quarantine_path}/#{@rename_id}/#{@rename_id}.shp"
    @bbox = {}
  end

  def move_to_stage
    FileUtils.mkdir_p "#{@quarantine_path}/#{@rename_id}/zip"
    FileUtils.mkdir_p @path_to_unzip_dir
    FileUtils.mkdir_p @path_to_christened_dir
    FileUtils.mkdir_p "#{@path_to_output_dir}/#{@rename_id}"
    FileUtils.mkdir_p "#{@path_to_output_dir}/#{@rename_id}_WGS84"
    FileUtils.mkdir_p "#{@path_to_output_dir}/#{@rename_id}_SQL"

    FileUtils.cp(@path, "#{@quarantine_path}/#{@rename_id}/zip/#{@rename_id}.zip")
  end

  def decompress_upload
    `unzip #{@path_to_staged_zip} -d #{@path_to_unzip_dir}`
  end

  def find_and_christen
    shapefile_original_basename = ''
    Find.find(@path_to_unzip_dir) do |path|
      shapefile_original_basename = File.basename(path, '.*') if path =~ /.*\.(shp)$/i
    end
    upload_paths = []
    Find.find(@path_to_unzip_dir) do |path|
      upload_paths << path if path =~ /.*\.(shp|xml|sbn|shx|sbx|prj|dbf|csv|cst|txt|json)$/i
    end
    upload_paths.each do |path|
      orig_filename = File.basename(path) # e.g. 'my_map'
      new_filename = ''
      if orig_filename.include? shapefile_original_basename
        new_filename = orig_filename.gsub(shapefile_original_basename, @rename_id)
      else
        new_filename = orig_filename
      end
      FileUtils.cp(path, "#{@path_to_christened_dir}/#{new_filename}")
    end

    # Copy christened files (original projection) to output folder for 'archival' version
    upload_paths = []
    Find.find(@path_to_christened_dir) do |path|
      upload_paths << path if path =~ /.*\.(shp|xml|sbn|shx|sbx|prj|dbf|csv|cst|txt|json)$/i
    end

    upload_paths.each do |path|
      FileUtils.cp(path, "#{@path_to_output_dir}/#{@rename_id}")
    end

  end

  # At some point this should use GDAL Ruby bindings instead of running system command
  def make_WGS84
    Find.find(@path_to_christened_dir) do |path|
      `ogr2ogr -t_srs EPSG:4326 "#{@path_to_output_dir}/#{@rename_id}_WGS84/#{File.basename(path)}" "#{path}"` if path =~ /.*\.(shp)$/i
    end
  end

  # Find layer extent using WGS84 version
  def get_extent
    Find.find("#{@path_to_output_dir}/#{@rename_id}_WGS84") do |path|
      if path =~ /.*\.(shp)$/i
        shapefile = Gdal::Ogr.open(File.join(path))
        ex = shapefile.get_layer(@rename_id).get_extent
        @bbox=({:w => ex[0], :e => ex[1], :s => ex[2], :n => ex[3]})
      end
    end

    ds = Dataset.find(@dataset_record_id)
    Record.update(ds.record_id, :solr_geom => "ENVELOPE(#{bbox[:w]}, #{bbox[:e]}, #{bbox[:n]}, #{bbox[:s]})")
  end

  # Convert WGS84 version to SQL
  def make_SQL
    Find.find("#{@path_to_output_dir}/#{@rename_id}_WGS84") do |path|
      if path =~ /.*\.(shp)$/i
      `
      shp2pgsql -I -s 4326 "#{path}" "#{File.basename(path)}" > "#{@path_to_output_dir}/#{@rename_id}_SQL/#{File.basename(path, '.*')}.sql"
    			if [ "$?" != "0" ]; then
    				shp2pgsql -I -s 4326 -W "latin1" "#{path}" "#{File.basename(path)}" > "#{@path_to_output_dir}/#{@rename_id}_SQL/#{File.basename(path, '.*')}.sql"
				fi
      `
      end
    end
  end

  def move_and_zip_outputs
    FileUtils.mkdir_p "#{@path_parent}/generated"
    FileUtils.cp("#{@path_to_output_dir}/#{@rename_id}_SQL/#{@rename_id}.sql", "#{@path_parent}/generated") ## Copy SQL file
    `zip -r -j "#{@path_parent}/generated/#{@rename_id}_WGS84.zip" "#{@path_to_output_dir}/#{@rename_id}_WGS84" `
    `zip -r -j "#{@path_parent}/generated/#{@rename_id}.zip" "#{@path_to_output_dir}/#{@rename_id}" `
    `zip -r -j "#{@path_parent}/generated.zip" "#{@path_parent}/generated" `
  end

  def update_processor_count
    ds = Dataset.find(@dataset_record_id)
    Record.update(ds.record_id, :processor_count => 1)
  end



end

