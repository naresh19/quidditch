class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  around_filter :wrap_in_transaction
  def wrap_in_transaction
    begin
      ActiveRecord::Base.transaction do
        yield
      end
    rescue ActiveRecord::RecordNotFound => e
      message="Your query fetched no results. "
      flash.now[:error]= message
      @error = message
      log_error e
      render '/home/index'
    rescue ActiveRecord::RecordNotUnique => e
      message="Duplicate Data entered! "
      flash.now[:error] = message
      @error = message
      log_error e
      render '/home/index'
    rescue ActiveRecord::ActiveRecordError => e
      message="Record Not Found : "
      flash.now[:error]= message
      @error = message
      log_error e
      render '/home/index'
    rescue NoMethodError => e
      message="Attempt to access a page that does not exist."
      flash.now[:error]= message
      @error = message
      log_error e
      render '/home/index'
    rescue ActionView::Template::Error => e
      message="Some error occurred while loading the page."
      flash.now[:error]= message
      @error = message
      log_error e
      render '/home/index'
    rescue StateMachine::InvalidTransition => e
      message="Record already modified by some user. kindly refresh."
      flash.now[:error]= message
      @error = message
      log_error e
      render '/home/index'
    rescue Exception => e
      message = "Technical Error! "
      @error = message
      flash.now[:error] = message
      log_error e
      render '/home/index'
    end
  end
end
