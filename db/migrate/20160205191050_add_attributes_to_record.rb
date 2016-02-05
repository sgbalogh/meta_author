class AddAttributesToRecord < ActiveRecord::Migration
  def change
    add_column :records, :uuid, :string
    add_column :records, :dc_identifier_s, :string
    add_column :records, :dc_title_s, :string
    add_column :records, :dc_description_s, :text
    add_column :records, :dc_rights_s, :string
    add_column :records, :dct_provenance_s, :string
    add_column :records, :dct_references_s, :text
    add_column :records, :georss_box_s, :text
    add_column :records, :layer_id_s, :string
    add_column :records, :layer_geom_type_s, :string
    add_column :records, :layer_modified_dt, :timestamps
    add_column :records, :layer_slug_s, :string
    add_column :records, :solr_geom, :text
    add_column :records, :solr_year_i, :text
    add_column :records, :dc_creator_sm, :text
  end
end
