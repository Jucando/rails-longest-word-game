class GamesController < ApplicationController
  def new
    @letters = []
    10.times { |_num| @letters << ("A".."Z").to_a.sample }
  end

  def score
    @word = params[:word]
    word_include = check_word_include
    word_dict = check_word_dict
    if word_include && word_dict
      @score = @word.length
      @message = "<strong>Congratulations!</strong> #{@word} is a valid English word!"
    elsif !word_include
      @score = 0
      @message = "Sorry but <strong>#{@word}</strong> can't be built out of #{params[:letters].chars.join(",")}."
    elsif !word_dict
      @score = 0
      @message = "Sorry but <strong>#{@word}</strong> is not an English word."
    end
  end

  private

  def check_word_dict
    url = "https://wagon-dictionary.herokuapp.com/" + @word
    response = RestClient.get url
    json_content = JSON.parse(response)
    json_content["found"]
  end

  def check_word_include
    letters = params[:letters].chars
    random_count = count_letters(letters)
    word_count = count_letters(@word.chars)
    word_count.each_key do |letter|
      return false if word_count[letter] > random_count[letter]
    end
    return true
  end

  def count_letters(letters)
    letters_count = Hash.new(0);
    letters.each do |letter|
      letters_count[letter.upcase] += 1
    end
    return letters_count
  end
end
