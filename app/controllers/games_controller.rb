require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    session[:score] ||= 0
  end

  def score
    word = params[:word].upcase
    letters = params[:letters].split(' ')
    word.each_char do |letter|
      letters.include?(letter) ? letters.delete_at(letters.index(letter)) : @message = "Sorry but #{word} cannot be built out of #{letters}"
    end
    unless @message
      @message = "Sorry but #{word} does not seems to be a valid English word..." unless valid_word?(word)
      session[:score] += word.length
    end
    @message ||= "Congratulations! #{word} is a valid English word!"
  end

  def valid_word?(word)
    response = JSON.parse(RestClient.get("https://wagon-dictionary.herokuapp.com/#{word}"))
    response['found']
  end
end
