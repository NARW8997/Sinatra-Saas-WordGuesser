class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(guess_char)
    # context 'invalid'
    if guess_char.nil? or guess_char.empty? or not guess_char.match?(/[[:alpha:]]/)
      # throws an error when empty
      # throws an error when nil
      # throws an error when not a letter
      raise ArgumentError
    end
    # context 'correctly' & context 'incorrectly'
    # if word include the guess_char
    # guessing is case insensitive
    if @word.downcase.include?(guess_char.downcase)
      # if repeatedly guess
      unless @guesses.downcase.include?(guess_char.downcase)
        @guesses << guess_char
        return true
      end
      false
      # else guess incorrectly
    else
      unless @wrong_guesses.downcase.include?(guess_char.downcase)
        @wrong_guesses << guess_char
        return true
      end
      false
    end
  end

  # describe 'displayed word with guesses'
  def word_with_guesses
    result = ''
    index = 0
    while index < @word.length do
      if @guesses.include? @word[index]
        result << @word[index]
      else
        result << '-'
      end
      index += 1
    end
    result
  end

  # describe 'game status'
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    elsif word_with_guesses == @word
      :win
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
