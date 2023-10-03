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
    @media = find_media(params[:id], 'movie')
    @genres = genres(@media)
    @credits = find_credits(params[:id], 'movie')
    @providers = find_providers(params[:id], 'movie')
  end

  def show_tv
    @media = find_media(params[:id], 'tv')
    @genres = genres(@media)
    @credits = find_credits(params[:id], 'tv')
    @providers = find_providers(params[:id], 'tv')
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

  def genres(media)
    @genres = []
    media['genres'].each { |genre| @genres << genre['name'].downcase }
    return @genres.join(', ')
  end

  def find_media(id, type)
    url = URI("https://api.themoviedb.org/3/#{type}/#{id}?language=fr-FR")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{ENV["TMDB_TOKEN"]}"

    response = http.request(request)
    result = JSON.parse(response.read_body)
    return result
  end

  def find_credits(id, type)
    url = URI("https://api.themoviedb.org/3/#{type}/#{id}/credits?language=fr-FR")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{ENV["TMDB_TOKEN"]}"

    response = http.request(request)
    result = JSON.parse(response.read_body)
    return { director: find_director(result['crew']), actors: find_actors(result['cast']) }
  end

  def find_director(crew)
    director = crew.select { |member| member['job'] == "Director" }
    return director.first.nil? ? "" : director.first['name']
  end

  def find_actors(cast)
    actors = []
    cast.each do |member|
      actors << member['name']
    end
    return actors
  end

  def find_providers(id, type)
    url = URI("https://api.themoviedb.org/3/#{type}/#{id}/watch/providers")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{ENV["TMDB_TOKEN"]}"

    response = http.request(request)
    result = JSON.parse(response.read_body)
    return result['results']['FR']['flatrate']
  end
end
