class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = Bookmark.all
    @list_bookmarks = []
    (1..@bookmarks.length).each do |i|
      if @bookmarks.find(i).list_id == params[:id].to_i
        @list_bookmarks << @bookmarks.find(i)
      end
    end
  end

  # View not needed for create
  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
