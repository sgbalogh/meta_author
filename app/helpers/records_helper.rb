module RecordsHelper

  def translate(key)

    hash = {"id" => "ID",
            "schema" => "Metadata Schema",
            "created_at" => "Date Created",
            "updated_at" => "Last Modified Date",
            "dc_identifier_s" => "Unique Identifier",
            "dc_description_s" => "Description",
            "dct_references_s" => "External References",
            "dc_rights_s" => "Access Rights",
            "dct_provenance_s" => "Provenance",
            "dc_title_s" => "Title",
            "uuid" => "Unique Identifier",
            "georss_box_s" => "GeoRSS Bounding Box",
            "layer_id_s" => "Layer Name (GeoServer)",
            "layer_geom_type_s" => "Geometry Type",
            "layer_modified_dt" => "Layer Modified Date",
            "layer_slug_s" => "Slug for Record",
            "solr_geom" => "Solr Bounding Box (Envelope)",
            "solr_year_i" => "Solr Year",
            "dc_creator_sm" => "Creator",
            "user_id" => "User ID (TorchedEarth)",



    }
    return hash[key]
  end

end
