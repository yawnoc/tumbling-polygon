# pivot = parse_initial_pivot (initialPivot, zVectorInitial)
# 
# Parse initialPivot argument of tumbling_trajectory.
# Here, zVectorInitial is the result of parse_initial_vertices.

function pivot = parse_initial_pivot (initialPivot, zVectorInitial = 0)
  
  initialPivotErrorString = ...
    "initialPivot must be \"first\" or of the form [x, y] or [z]";
  
  if (isnumeric (initialPivot))
    
    initialPivotSize = size (initialPivot);
    
    if (isequal (initialPivotSize, [1, 2]))
      
      if (isreal (initialPivot))
        pivot = real_rows_to_complex (initialPivot);
      else
        error ("initialPivot as a pair [x, y] must be real-valued");
      endif
      
    elseif (isequal (initialPivotSize, [1, 1]))
      
      pivot = initialPivot;
      
    else
      
      error (initialPivotErrorString);
      
    endif
    
  else
    
    if (ischar (initialPivot) && strcmpi (initialPivot, "first"))
      
      pivot = zVectorInitial(1);
      
    else
      
      error (initialPivotErrorString);
      
    endif
    
  endif
  
endfunction

%!error parse_initial_pivot ([1, i]);
%!error parse_initial_pivot (ones (2, 2));
%!error parse_initial_pivot ([1; 2; 3; 4; 5]);
%!error parse_initial_pivot (ones (0, 2));
%!error parse_initial_pivot ("string but not first");

%!assert (parse_initial_pivot (7), 7);
%!assert (parse_initial_pivot ([3, 4]), 3 + 4i);
%!assert (parse_initial_pivot ("first", [3, 4, 5]), 3);
