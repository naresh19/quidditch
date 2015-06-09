class Team < ActiveRecord::Base
  has_many :players
  has_many :active_players,class_name: Player.name,foreign_key: "team_id",conditions: {status: :active}
  attr_accessible :name,:captain_id
end
