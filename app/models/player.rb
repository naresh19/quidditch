class Player < ActiveRecord::Base
  belongs_to :team

  before_create :validate_no_of_players
  attr_accessible :name, :age, :team_id

  state_machine :status, :initial => :active do
    event :knock_out do
      transition :active => :knocked
    end
    event :reset do
      transition :knocked=> :active
    end
  end

  def bludger
    knock_out!
  end

  private
  def validate_no_of_players
    raise "A team cannot have more players than 7" if team.players.count > 6

  end




end
