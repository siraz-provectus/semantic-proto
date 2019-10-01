class  HomeController < ApplicationController
  expose (:words) { [] }
  def index
  end

  def search
    if search_params[:word].blank? || search_params[:count].blank?
      flash[:danger] = 'Нужно заполнить поля слово и количество'
      return render 'index'
    end

    service = SemanticWordsService.new
    response = service.find_similar(search_params[:word], search_params[:count])

    if response[:error]
      flash[:danger] = 'Данное слово не найдено'
    else
      self.words = response[:data]['similar'].map{|x, k| {word: x.split('_')[0], percent: k.round(2)}}
    end

    render 'index'
  end

  private

  def search_params
    params[:search] || {}
  end
end