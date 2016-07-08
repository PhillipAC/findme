class Location < ActiveRecord::Base
    validates :target_x, :target_y, :target_id, :finder_id, :name, presence: true
    belongs_to :target, class_name: "User"
    belongs_to :finder, class_name: "User"
end
