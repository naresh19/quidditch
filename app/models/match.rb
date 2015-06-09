class Match < ActiveRecord::Base
  attr_accessible :team1_id,:team2_id,:team1_score,:team2_score
  has_one :team1,class_name: Team.name,primary_key: 'team1_id',foreign_key: "id"
  has_one :team2,class_name: Team.name,primary_key: 'team2_id',foreign_key: "id"
  has_one :current_event, class_name: Event.name,primary_key: 'event_id'
  has_many :events

  state_machine :status, :initial => :started do
    event :complete do
      transition :started=> :completed
    end
  end

  def quaffle team_id
    if team_id == team1_id
      update_attributes(team1_score: team1_score + 10)
    elsif team_id == team2_id
      update_attributes(team2_score: team2_score + 10)
    else
      raise "Invalid Team Id #{team_id}"
    end

    self
  end

  def end_match
    complete!
  end

  def reset_match
    update_attributes(team1_score: 0,team2_score: 0)
  end

  # @ball_type ={
  #     bludger: "Bludger"
  # }
  # class << self
  #   attr_reader :ball_types
  # end

end
