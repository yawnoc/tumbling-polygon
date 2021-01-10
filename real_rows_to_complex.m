# zVector = real_rows_to_complex (xyMatrix)
#
# Convert matrix of rows of [x, y] pairs to vector of complex z values,
# where each z == x + i * y.

function zVector = real_rows_to_complex (xyMatrix)
  
  if (! isnumeric (xyMatrix))
    error ("xyMatrix must be numeric");
  endif
  
  if (! isreal (xyMatrix))
    error ("xyMatrix must be real-valued");
  endif
  
  if (ndims (xyMatrix) > 2)
    error ("xyMatrix must be a matrix");
  endif
  
  if (columns (xyMatrix) != 2)
    error ("xyMatrix must have 2 columns");
  endif
  
  zVector = xyMatrix * [1; i];
  
endfunction

%!error real_rows_to_complex ("not numeric");
%!error real_rows_to_complex ([1, i]);
%!error real_rows_to_complex (ones (3, 4, 5));
%!error real_rows_to_complex ([1, 1, 1]);

%!assert (real_rows_to_complex (zeros (0, 2)), zeros (0, 1));
%!assert (real_rows_to_complex ([1 2; 3 4; 5 6]), [1 + 2i; 3 + 4i; 5 + 6i]);
