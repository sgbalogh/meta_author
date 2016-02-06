module RecordsHelper

  def fullname(key)

    hash = {"id" => "ID", "schema" => "Metadata Schema", "dc_description_s" => "Description",  "dc_rights_s" => "Access Rights", "dct_provenance_s" => "Provenance", "dc_title_s" => "Title", "uuid" => "Unique Identifier"}
    return hash[key]
  end

end
