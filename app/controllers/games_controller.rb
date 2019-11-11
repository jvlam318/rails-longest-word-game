class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times {
      @letters << alphabet.sample
    }
  end

  def check_grid(word)
    @word = word.split(//)
    @letters.each_with_index { |letter, index|
      if @word.include?(letter)
        @letters.delete_at(index)
        return true
      else
        return false
      end
    }
  end

  def check_english(word)
    require 'json'
    require 'open-uri'
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_check_serialized = open(url).read
    word_check = JSON.parse(word_check_serialized)
    return word_check["found"]
  end

  def score
    word = params[:word]
    @letters = params[:letters].split.to_a
    if check_grid(word) == false
      @result = "Sorry but \"#{word}\" cannot be created from #{@letters}"
    elsif check_english(word) == false
      @result = "Sorry but #{word} is not a valid english word..."
    else
      @score = word.length
      @result = "Congratulations! #{word} is a valid english word"
    end
    @result
  end
end
