class Record < ActiveRecord::Base
=begin
  serialize :dc_description_s, Array
  serialize :solr_year_i, Array
  serialize :dc_creator_sm, Array
=end

  belongs_to :user




end
