class Rover

  include DataMapper::Resource


  # Rover class will move the rover and return the currnet position 

  before :destroy, :confirm_destroy

  property :id,        Serial 
  property :x,         Integer, :max => 5, :min => 0
  property :y,         Integer,   :required  => true
  property :dir,       String


  validates_numericality_of :x, :y
  validates_with_method  :dir_is_ok?


  def confirm_destroy
    x = gets
    halt unless x == "Y"
  end

def destroy
end

  def dir_is_ok?
    return true if ["N","S","E","W"].include?(dir)
    return [false, "dir is invalid"]
  end

  # Public: Intialize the state of rover.
  # state: a String of the form "1 2 N"
 
  MOVE = {"N" => [0,1], "S" => [0,-1], "E" => [1,0],"W" => [-1,0] }
  L = {"N" => "W", "W" => "S", "S"=> "E", "E"=> "N" }
  R = L.invert
  TURN = {"L" => L, "R" => R}

  # Public: returns the position of the Rover as an Array i.e. [1, 2, "N"]
  def pos
    [@x, @y, @dir]
    
  end
  
  # Public: moves the rover as commands according to commands provided.
  # commands: a String like "MMLMR" 
  # returns the current postion of rover.
  # example: #process("MMLMM")
  
  
  def process(input_str)
    input_str.split(//).each do |p|
      p == "M" ? move : turn(p)
    end
  end
  
  #public: move the rover forward
  # returns to its current position
  
  def move
    x1, y1 = MOVE[@dir]
    @x = @x + x1
    @y = @y + y1
  end
  
  # Public: turns the rover right or left
  # direction: A String, either "L" to left or "R" to Right.
  # returns: the current position of the rover
  # Does nothing if input is neither "L" nor "R"
  def turn(direction)
    @dir = TURN[direction][@dir]
  end

end

