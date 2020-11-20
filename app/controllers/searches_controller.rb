class SearchesController < ApplicationController

  def search
    @range = params[:range]
    search = params[:search]
    search_word = params[:search_word]

    if @range == '1'
      @user = User.search(search, search_word)
    else
      @book = Book.search(search, search_word)
    end
  end
end
