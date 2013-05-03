class Deck
  attr_reader :deck

  def initialize(file)
     @file = file
     @deck = []     
     import_deck
  end

  def import_deck
    @deck << 
  end

  def shuffle
    
  end

  def next_question
    
  end

  def finished?
    
  end
  
  
end

class Flashcard
  attr_reader :question, :answer

  def initialize(question, answer)
    @question = question
    @answer = answer
  end
  
  def is_correct?(guess)
    true if guess == @answer
  end
  
end

class Dealer
  def initialize(file)
    @deck = Deck.new(file)
    @viewer = Viewer.new
  end
  
  def run 
    @viewer.print_welcome
    until @deck.finished?
      print_question
      check_answer(gets.chomp)
    end
    @viewer.print_exit    
  end

  def print_question
    @viewer.print_question(@deck.deck[0].question)
  end

  def check_answer(guess)
    if @deck.deck[0].is_correct?(guess.upcase)
      @viewer.print_correct
      @deck.next_question
    else
      @viewer.print_incorrect
      @viewer.print_question
    end
  end
end   

class Viewer
  def print_welcome
    puts "Welcome to Ruby Flashcards!"  
  end

  def print_question(question)
    puts "Definition:\n#{question}"
  end
  
  def print_correct
    puts "That's Correct!"
  end

  def print_incorrect
    puts "Try again..."
  end

  def print_exit
    puts "Thank you for playing."
  end

end

Dealer.new(ARGV[0]).run
