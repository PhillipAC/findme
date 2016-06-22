class Match < ActiveRecord::Base
    belongs_to :target, class_name: "User"
    belongs_to :finder, class_name: "User"
end
