# [phiMin, phiMax] = parse_phi_range (phiRange)
# 
# Parse phiRange argument of tumbling_trajectory.

function [phiMin, phiMax] = parse_phi_range (phiRange)
  
  if (! isnumeric (phiRange))
    error ("phiRange must be numeric");
  endif
  
  if (! isreal (phiRange))
    error ("phiRange must be real-valued");
  endif
  
  phiRangeSize = size (phiRange);
  
  if (isequal (phiRangeSize, [1, 2]))
    
    phiMin = phiRange(1);
    phiMax = phiRange(2);
    if (! (phiMin < phiMax))
      error ("phiRange [phiMin, phiMax] must have phiMin < phiMax");
    endif
    
  elseif (isequal (phiRangeSize, [1, 1]))
    
    phiMin = 0;
    phiMax = phiRange;
    if (! (phiMax > 0))
      error ("phiRange [phiMax] must have phiMax > 0");
    endif
    
  else
    
    error ("phiRange must be of the form [phiMin, phiMax] or [phiMax]");
    
  endif
  
endfunction

%!error parse_phi_range ("not numeric");
%!error parse_phi_range ([1, i]);
%!error parse_phi_range ([10, 1]);
%!error parse_phi_range ([10, 10]);
%!error parse_phi_range ([-1]);
%!error parse_phi_range ([0]);
%!error parse_phi_range (ones (2, 2));
%!error parse_phi_range ([1; 2; 3; 4; 5]);

%!test
%!  [phiMin, phiMax] = parse_phi_range ([0, 10]);
%!  assert ([phiMin, phiMax], [0, 10]);
%!test
%!  [phiMin, phiMax] = parse_phi_range (10);
%!  assert ([phiMin, phiMax], [0, 10]);
