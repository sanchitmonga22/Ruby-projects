# Lines are defined by their two end points.
# Lines are immutable - once constructed the end
# points cannot be changed.

require './point'

class Line
  # Methods below are private.
  private

  # Initialize the Line end points from those
  # provided to Line.new.
  # The instance variables are @p1 and @c2
  def initialize(p1 = Point.new, p2 = Point.new)
    @p1 = p1
    @p2 = p2
  end

  # Methods below are public
  public

  # Allow read access to the two end points.
  attr_reader :p1, :p2

  # Compute the line length (the distance between its
  # end points)
  def length
    sum=0
    sum=(p2.x-p1.x)**2+(p2.y-p1.y)**2
    length=Math.sqrt(sum)
    return length
  end

  def to_s
    "Line from #{p1} to #{p2}"
  end
end
