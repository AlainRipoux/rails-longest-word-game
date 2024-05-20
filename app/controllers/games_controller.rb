require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    url = URI.open("https://dictionary.lewagon.com/#{params[:word]}").read
    @search = JSON.parse(url)
    if params[:word].upcase.chars.all? {| element | params[:letters].split(" ").include?(element)} === false
      @result = "Sorry but #{params[:word]} can't be built out of #{params[:letters].split(' ').join(', ')}"
    elsif params[:word].upcase.chars != params[:letters].split(" ") && @search["found"] === false
      @result = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{params[:word]} is a valid English word!"
    end
  end
end
