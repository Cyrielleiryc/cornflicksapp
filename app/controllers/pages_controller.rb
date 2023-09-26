require 'open-uri'
require 'json'
require 'net/http'
require 'dotenv'
Dotenv.load

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @popular_movies = find_popular_movies.take(5)
    @popular_tv = find_popular_tv.take(5)
  end

  def results
    @results = find_movie_or_tv(params[:query])
  end

  def show_movie
    @media = find_movie(params[:id])
    @genres = []
    @media['genres'].each { |genre| @genres << genre['name'].downcase }
    @genres = @genres.join(', ')
  end

  def show_tv
    @media = find_tv(params[:id])
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

  def find_movie(id)
    url = URI("https://api.themoviedb.org/3/movie/#{id}?language=fr-FR")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{ENV["TMDB_TOKEN"]}"

    response = http.request(request)
    result = JSON.parse(response.read_body)
    return result
  end

  def find_tv(id)
    url = URI("https://api.themoviedb.org/3/tv/#{id}?language=fr-FR")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{ENV["TMDB_TOKEN"]}"

    response = http.request(request)
    result = JSON.parse(response.read_body)
    return result
  end
end
