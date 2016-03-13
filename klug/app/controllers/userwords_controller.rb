class UserwordsController < ApplicationController
  before_action :authenticate_user!

  def show
    respond_with Userword.find_by(:user_id => current_user.id) #params[:id]
  end

  def all
    respond_with Userword.find_by(:user_id => current_user.id) #params[:id]
  end

  def add
    userword = params[:userword]
    puts userword
    respond_with Userword.find_or_create_by(:user_id => current_user.id, :word_id => userword["word_id"].to_i)

    #puts "----------> #{Userword}"
  end

  def remove
    userword = params[:userword]
    respond_with Userword.update_all({:strength => -1}, {:user_id => current_user.id, :word_id => userword["word_id"].to_i})
  end

  # def strengthen
  #   Userword = Userword.find(params[:id])
  #   Userword.increment!(:strength)

  #   respond_with Userword
  # end

  # def weaken
  #   Userword = Userword.find(params[:id])
  #   Userword.increment!(:strength)

  #   respond_with Userword
  # end

  private
  def post_params
    params.require(:userword).permit(:user_id, :word_id)
  end

end
