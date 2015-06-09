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
    end
  end
end
