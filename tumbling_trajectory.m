# [phiValues, zVectorValues] = tumbling_trajectory (
#   initialVertices, phiRange, initialPivot, regionFunction
# )
# 
# Determine trajectory zVector == zVector (phi) for a tumbling polygon.
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
# 
# regionFunction (default: @(z) abs (z) - 1)
#   Function f == f (z) such that
#     f (z) < 0 represents the interior of the tumbling region,
#     f (z) == 0 represents the boundary, and
#     f (z) > 0 represents the exterior.
#   The tumbling region is assumed to be convex.
#   Collisions of the polygon with the boundary are handled
#   by detecting f (z) increasing past 0.

function [phiValues, zVectorValues] = ...
  tumbling_trajectory ( ...
    initialVertices, ...
    phiRange = 2 * pi, ...
    initialPivot = "first", ...
    regionFunction = @(z) abs (z) - 1 ...
  )
  
  zVectorInitial = parse_initial_vertices (initialVertices);
  [phiMin, phiMax] = parse_phi_range (phiRange);
  
endfunction
