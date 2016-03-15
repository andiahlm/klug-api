class WordsController < ApplicationController

  def index
    respond_with Word.all, :except => [:rank, :level, :dispersion, :wordtype, :created_at, :updated_at, :active]
  end

 	def show
    respond_with Word.find(params[:id]), :except => [:rank, :level, :dispersion, :wordtype, :created_at, :updated_at, :active]
  end

	def update
    @word = Word.find(params[:id])
    @word.update(post_params)
    respond_with @word
  end

  private

  def post_params
    params.require(:word).permit(:id, :word, :translation)
  end

end
