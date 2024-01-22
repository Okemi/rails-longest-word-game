require 'json'
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) {Array('A'..'Z').to_a.sample }.join
    # @grid = generate_grid
    # @word = params[:word]
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
