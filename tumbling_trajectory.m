# [phiValues, zVectorValues] = ...
#   tumbling_trajectory (initialVertices, phiRange, initialPivot)
# 
# Determine trajectory zVector == zVector (phi)
# for a tumbling polygon in the unit disk.
# Here, zVector is a complex column vector representing the vertices,
# while phi is the angle through which the polygon has rotated.
# 
# initialVertices
#   Initial positions of the vertices of the polygon, either:
#   (a) a complex-valued column vector [z(1); z(2); etc.], or
#   (b) a real-valued matrix [x(1), y(1); x(2), y(2); etc.].
# 
# phiRange (default: 2 * pi)
#   Range of the angle phi of rotation, either:
#   (a) a real pair [phiMin, phiMax], or
#   (b) a scalar [phiMax] for phiMin == 0.
# 
# initialPivot (default: "first")
#   Initial position of the pivot (i.e. the centre of rotation), either:
#   (a) a real pair [x, y],
#   (b) a complex scalar [z], or
#   (c) the string "first", for the first vertex of initialVertices.

function [phiValues, zVectorValues] = ...
  tumbling_trajectory ( ...
    initialVertices, ...
    phiRange = 2 * pi, ...
    initialPivot = "first" ...
  )
  
  # Parse input arguments
  zVectorInitial = parse_initial_vertices (initialVertices);
  [phiMin, phiMax] = parse_phi_range (phiRange);
  pInitial = parse_initial_pivot (initialPivot, zVectorInitial);
  
endfunction
