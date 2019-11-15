class Admin::ProfilesController < Admin::BaseController
  expose(:search)   { ProfileSearch.new(search_params) }
  expose(:profiles) { search.results }
  expose(:profile)  { Profile.find(params[:id]) }

  def index
  end

  def show
  end

  private

  def search_params
    params[:search] || {}
  end
end