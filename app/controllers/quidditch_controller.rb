class QuidditchController < ApplicationController
  after_filter :add_annotation, :only => [:process_event]
  def index
    # @search = Match.includes(team: :player).search(params[:search])
    @matches = Match.includes(team1: :players,team2: :players).all
    @matches.sort!{|a,b| [b.created_at] <=> [a.created_at]}
  end

  def match_details
    @match = Match.includes(:events=>:player,team1: :players,team2: :players).find params[:match_id]
    @events = @match.events.sort{|a,b| [b.created_at] <=> [a.created_at]}
  end


  def add_annotation
    Event.create_event @match,params[:ball],@p.id,@p.team_id
  end

  def simulate
    params
    @match = Match.includes(team1: :players,team2: :players).where(id: params[:match_id],status: :started).first
    raise "Match is already complete" if @match.nil?
    @players = Player.where(team_id: [@match.team1_id,@match.team2_id],status: :active)
  end

  def process_event
    @p = Player.includes(:team).where(id: params[:player_id],status: :active).first
    raise "Inactive Player cannot process this event" if @p.nil?
    @match = Match.find params[:match_id]
    case params[:ball]
      when "Quaffle"
        @match.quaffle @p.team_id
        @match.end_match if @match.team1_score >=250 || @match.team1_score >=250
      when "Bludger"
        @p.bludger
        team = Team.includes(:active_players).find @p.team_id
        @match.end_match if team.active_players.blank?
      when "Snitch"
        @match.end_match
      when "Reset"
        @match.reset_match
    end
    if @match.started?
      redirect_to :back
    else
      redirect_to action: "index"
    end

  end


end

