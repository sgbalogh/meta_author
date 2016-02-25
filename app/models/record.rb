class Record < ActiveRecord::Base
=begin
  serialize :dc_description_s, Array
  serialize :solr_year_i, Array

=end
  serialize :dc_creator_sm, Array
  belongs_to :user

  validates :dc_title_s, presence: true
  has_many :datasets
  accepts_nested_attributes_for :datasets






end
