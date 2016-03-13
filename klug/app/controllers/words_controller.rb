class WordsController < ApplicationController


 	def show
    	respond_with Word.find(params[:id])
  	end


end
