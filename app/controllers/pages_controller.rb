require 'open-uri'
require 'json'
require 'net/http'
require 'dotenv'
Dotenv.load

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @results = find_movie_or_tv(params[:query])
    @popular_movies = find_popular_movies.take(5)
    @popular_tv = find_popular_tv.take(5)
  end

  private

  def find_movie_or_tv(search)
    query = search.split.join('%20')
    url = URI("https://api.themoviedb.org/3/search/multi?query=#{query}&include_adult=false&language=fr-FR&page=1")
    # si espace, le transformer en '%20'
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{ENV["TMDB_TOKEN"]}"

    response = http.request(request)
    result = JSON.parse(response.read_body)
    return result['results']
  end

  def find_popular_movies
    url = URI("https://api.themoviedb.org/3/trending/movie/week?language=fr-FR")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{ENV["TMDB_TOKEN"]}"

    response = http.request(request)
    result = JSON.parse(response.read_body)
    return result['results']
  end

  def find_popular_tv
    url = URI("https://api.themoviedb.org/3/trending/tv/week?language=fr-FR")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{ENV["TMDB_TOKEN"]}"

    response = http.request(request)
    result = JSON.parse(response.read_body)
    return result['results']
  end
end
