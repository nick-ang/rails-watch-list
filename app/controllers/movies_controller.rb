require "open-uri"
require "json"

class MoviesController < ApplicationController
  def index
    url = "http://tmdb.lewagon.com/search/movie?&language=en-US&query=#{params[:title]}&page=1&include_adult=false"
    user_serialized = URI.open(url).read
    parsed = [JSON.parse(user_serialized)]
    json = parsed.first
    @results = json["results"]
  end

  def search
    # url = "http://tmdb.lewagon.com/search/movie?&language=en-US&query=#{params[:title]}&page=1&include_adult=false"
    # user_serialized = URI.open(url).read
    # parsed = [JSON.parse(user_serialized)]
    # json = parsed.first
    # @results = json["results"]
  end

  def new
    @movie = Movie.new
    url = "http://tmdb.lewagon.com/search/movie?&language=en-US&query=#{params[:title]}&page=1&include_adult=false"
    user_serialized = URI.open(url).read
    parsed = [JSON.parse(user_serialized)]
    json = parsed.first
    $results = json["results"]
  end

  # View not needed for create
  def create
    index = params[:movie][:overview].to_i
    @movie = Movie.new(title: $results[index]["original_title"], overview: $results[index]["overview"], poster_url: $results[index]["poster_path"], rating: $results[index]["vote_average"])
    if @movie.save
      redirect_to lists_path
    else
      render :new
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:overview)
  end

  def find_movie(name)
    request_api(
      "http://tmdb.lewagon.com/search/movie?&language=en-US&query=#{name}&page=1&include_adult=false"
    )
  end

  def request_api(url)
    user_serialized = URI.open(url).read
    parsed = [JSON.parse(user_serialized)]
    json = parsed.first
    results = json["results"]
    return results
  end
end
