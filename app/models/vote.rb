class Vote < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: "User"
  belongs_to :voteable, polymorphic: true
end