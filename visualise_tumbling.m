# figureHandle = visualise_tumbling (initialVertices, phiRange, initialPivot)
# 
# Visualise a tumbling polygon in the unit disk,
# producing a static plot of the trajectory and final position.

function figureHandle = ...
  visualise_tumbling ( ...
    initialVertices, ...
    phiRange = 2 * pi, ...
    initialPivot = "first" ...
  )
  
  # Compute the tumbling trajectory
  [~, zVectorValues] = ...
    tumbling_trajectory (initialVertices, phiRange, initialPivot);
  
  # Assign figure handle
  figureHandle = figure;
  hold on;
  
  # Plot unit circle (tumbling region boundary)
  angleValues = linspace (0, 2 * pi, 50);
  xCircleValues = cos (angleValues);
  yCircleValues = sin (angleValues);
  plot (xCircleValues, yCircleValues, "k");
  
  # Loop over vertices
  vertexCount = columns (zVectorValues);
  for n = 1 : vertexCount
    
    # Extract z values for this vertex
    zValues = zVectorValues(:,n);
    
    # Convert to real x and y values
    xValues = real (zValues);
    yValues = imag (zValues);
    
    # Plot trajectory
    plot (xValues, yValues);
    
  endfor
  
  # Extract final position of polygon
  zValuesFinal = zVectorValues(end,:);
  xValuesFinal = real (zValuesFinal);
  yValuesFinal = imag (zValuesFinal);
  fill (xValuesFinal, yValuesFinal, "k");
  
  # Set aspect ratio to unity
  daspect ([1, 1, 1]);
  hold off;
  
endfunction

%!demo
%!  visualise_tumbling ([0.8; -0.2; -0.2 - 0.5i], 10)
