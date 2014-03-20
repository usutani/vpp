class Content < ActiveRecord::Base
  has_many :licenses, foreign_key: "adam_id", primary_key: "adam_id"
end
