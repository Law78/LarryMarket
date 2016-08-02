class PagesController < ApplicationController
  def home
  end

  def about
  	@about = "Lorenzo Franceschini"
  end
end
