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
    guess == @answer
  end
  
end

class Dealer
  def initialize(file)
    @deck = Deck.new(file)
    @viewer = Viewer.new
  end
  
  def run 
    @viewer.print_welcome
    @viewer.print_question
    check_answer(gets.chomp.upcase)
    
  end
  
  def check_answer(guess)
    # if 
  end
end   

class Viewer
  def initialize
  end
  
  def print_welcome
    
  end

  def print_question
    
  end
  
  def print_correct
    
  end

  def print_incorrect
    
  end

  def print_exit
    
  end

end

# Dealer.new(ARGV[0]).run
