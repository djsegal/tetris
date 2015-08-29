class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def _raise(message)
    if Rails.env.development?
      binding.pry
    else
      raise message
    end
  end

end
