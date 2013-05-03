require 'debugger'

class Deck
  attr_reader :deck

  def initialize(file)
     @file = file
     @deck = []    
     import_deck
     add_flashcards
  end

  def import_deck
    @imported_deck =  File.read(@file).split("\n\n")
  end

  def add_flashcards
    @imported_deck.each do |pair| 
      card = pair.split("\n")
      @deck << Flashcard.new(card[0], card[1])
    end
  end

  def shuffle
    @deck.shuffle!
  end

  def next_question
    @deck.first
  end

  def finished?
    @deck.empty?
  end

  def remove_answered_question
    @deck.shift
  end
end

class Flashcard
  attr_reader :question, :answer

  def initialize(question, answer)
    @question = question
    @answer = answer
  end
  
  def is_correct?(guess)
    guess.upcase == @answer.upcase
  end
  
end

class Dealer
  
  def initialize(file)
    @deck = Deck.new(file)
    @viewer = Viewer.new
  end
  
  def run 
    @viewer.print_welcome
    @deck.shuffle
    ask_question
  end

  def ask_question
    unless @deck.finished?
      @question = @deck.next_question.question
      @viewer.print_question(@question)
      guess = STDIN.gets.chomp
      check_answer(guess)
    end
    @viewer.print_exit
    exit  
  end

  def check_answer(guess)
    if @deck.next_question.is_correct?(guess)
      @viewer.print_correct
      @deck.remove_answered_question
      ask_question
    else
      @viewer.print_incorrect
      ask_question
    end
  end
end   

class Viewer
  def print_welcome
    puts "Welcome to Ruby Flashcards!\n\n"  
  end

  def print_question(question)
    puts "Definition:\n#{question}\n\n"
    print "Guess: "
  end
  
  def print_correct
    puts "\nThat's Correct!\n\n"
  end

  def print_incorrect
    puts "\nTry again...\n\n"
  end

  def print_exit
    puts "\nThank you for playing."
  end

end


filename = ARGV[0]
Dealer.new(filename).run
