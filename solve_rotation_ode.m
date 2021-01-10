# [phiValues, zVectorValues, eventIndex] = ...
#   solve_rotation_ode (pivot, zVectorInitial, phiMin, phiMax, eventFunction)
# 
# Solve rotation ODE d(zVector) / d(phi) == i (zVector - pivot)
# for trajectory zVector == zVector (phi),
# representing rotation around the pivot point pivot.

function [phiValues, zVectorValues, eventIndex] = ...
  solve_rotation_ode (pivot, zVectorInitial, phiMin, phiMax, eventFunction)
  
  if (phiMin == phiMax)
    
    phiValues = phiMin;
    zVectorValues = zVectorInitial;
    
    phiEnd = phiMin;
    zVectorEnd = zVectorInitial;
    
    return;
    
  endif
  
  odeRHS = @(phi, zVector) i * (zVector - pivot);
  odeStructure = odeset ("Events", eventFunction);
  
  [phiValues, zVectorValues, ~, ~, eventIndex] = ...
    ode45 (odeRHS, [phiMin, phiMax], zVectorInitial, odeStructure);
  
endfunction
