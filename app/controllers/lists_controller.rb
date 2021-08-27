class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    # no need for app/views/restaurants/destroy.html.erb
    redirect_to lists_path(@list)
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = Bookmark.all
    @list_bookmarks = []
    @bookmarks.each do |bookmark|
      if bookmark.list_id == params[:id].to_i
        @list_bookmarks << bookmark
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
    params.require(:list).permit(:name, :photo)
  end
end
