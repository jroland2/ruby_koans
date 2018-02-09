# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
#def triangle(a, b, c)
#  if a == b && b == c && a == c
#    :equilateral
#  elsif a != b && b != c && a != c
#    :scalene
#  elsif a != b || b != c || a != c
#    :isosceles
#  end
#end

# HINT: for tips, see http://stackoverflow.com/questions/3834203/ruby-koan-151-raising-exceptions
#def triangle(a, b, c)
#  raise TriangleError if [a,b,c].min <= 0
#  x, y, z = [a,b,c].sort
#  raise TriangleError if x + y <= z
#  [:equilateral,:isosceles,:scalene].fetch([a,b,c].uniq.size - 1)
#end

def triangle(a, b, c)
  a, b, c = [a, b, c].sort
  raise TriangleError if a <= 0 || a + b <= c
  [nil, :equilateral, :isosceles, :scalene][[a, b, c].uniq.size]
end

#def triangle(a, b, c)
  # WRITE THIS CODE
  # raise TriangleError, "All sides must be positive number" if a <= 0 || b <= 0 || c <= 0
  # raise TriangleError, "Impossible triangle" if ( a + b + c - ( 2 *  [a,b,c].max ) <= 0  )
  # OR
#  raise TriangleError, "impossible triangle" if [a,b,c].min <= 0
#  x, y, z = [a,b,c].sort
#  raise TriangleError, "no two sides can be < than the third" if x + y <= z
#
#  if(a == b && a == c)
#    :equilateral
#  elsif (a == b || b == c || a == c)
#    :isosceles
#  else
#    :scalene
#  end
#end

# Iwanted a method that parsed all arguments effectively instead of relying on the order given in the test assertions.
#def triangle(a, b, c)
#  # WRITE THIS CODE
#  [a,b,c].permutation { |p| 
#     if p[0] + p[1] <= p[2]
#       raise TriangleError, "Two sides of a triangle must be greater than the remaining side."
#     elsif p.count { |x| x <= 0} > 0
#       raise TriangleError, "A triangle cannot have sides of zero or less length."
#     end
#  }
#
#  if [a,b,c].uniq.count == 1
#    return :equilateral
#  elsif [a,b,c].uniq.count == 2
#    return :isosceles
#  elsif [a,b,c].uniq.count == 3
#    return :scalene
#  end
#end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
