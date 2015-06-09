class Event < ActiveRecord::Base
  belongs_to :match
  belongs_to :player

  def self.create_event match_obj,type,player_id,team_id
    e = Event.new
    e.player_id  = player_id
    e.match_id = match_obj.id
    e.team_id = team_id
    e.team1_score = match_obj.team1_score
    e.team2_score = match_obj.team2_score
    e.event = type
    e.save!
  end

end
