class HomeController < ApplicationController

  ELEMENTS_PER_PAGE = 10

  def index
    @per_page = ELEMENTS_PER_PAGE
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @total_billboards = Billboard.count
    @billboards = Billboard.limit(ELEMENTS_PER_PAGE).offset((@page - 1) * ELEMENTS_PER_PAGE)

    case params[:filter]
    when "trending"
      @billboards = Billboard.top.limit(ELEMENTS_PER_PAGE).offset((@page - 1) * ELEMENTS_PER_PAGE)
    when "fresh"
      @billboards = Billboard.fresh.limit(ELEMENTS_PER_PAGE).offset((@page - 1) * ELEMENTS_PER_PAGE)
    else
      @billboards = Billboard.recent.limit(ELEMENTS_PER_PAGE).offset((@page - 1) * ELEMENTS_PER_PAGE)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
