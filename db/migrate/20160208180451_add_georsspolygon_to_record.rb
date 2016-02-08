class AddGeorsspolygonToRecord < ActiveRecord::Migration
  def change
    add_column :records, :georss_polygon_s, :text
  end
end
