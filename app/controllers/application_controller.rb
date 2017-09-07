class ApplicationController < ActionController::Base
  protect_from_forgery

  def paginate(model, current, lim)
    model.skip(current).limit(lim).entries
  end
end
