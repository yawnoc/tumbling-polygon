# zVectorInitial = parse_initial_vertices (initialVertices)
#
# Parse initialVertices argument of tumbling_trajectory.

function zVectorInitial = parse_initial_vertices (initialVertices)
  
  if (! isnumeric (initialVertices))
    error ("initialVertices must be numeric");
  endif
  
  if (ndims (initialVertices) > 2)
    error ("initialVertices must be a column vector or matrix");
  endif
  
  rowCount = rows (initialVertices);
  columnCount = columns (initialVertices);
  
  if (rowCount == 0 || columnCount == 0)
    error ("initialVertices must not be an empty matrix");
  elseif (columnCount == 1)
    zVectorInitial = initialVertices;
  elseif (columnCount == 2)
    if (isreal (initialVertices))
      zVectorInitial = real_rows_to_complex (initialVertices);
    else
      error ("initialVertices as a matrix must be real-valued");
    endif
  else
    error ("initialVertices as a matrix must have 2 columns")
  endif
  
endfunction


%!error parse_initial_vertices ("not numeric");
%!error parse_initial_vertices (ones (3, 4, 5));
%!error parse_initial_vertices (ones (3, 0));
%!error parse_initial_vertices (ones (0, 3));
%!error parse_initial_vertices ([]);
%!error parse_initial_vertices ([0, 0; 0, i]);
%!error parse_initial_vertices ([1, 1, 1]);

%!assert (parse_initial_vertices ([1; 2; 3; 4]), [1; 2; 3; 4]);
%!assert (parse_initial_vertices ([1 2; 3 4; 5 6]), [1 + 2i; 3 + 4i; 5 + 6i]);
