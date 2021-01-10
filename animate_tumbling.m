# animate_tumbling (outputName, initialVertices, phiRange, initialPivot)
# 
# Produce animated GIF for a tumbling polygon in the unit disk.
# Uses carandraug's idea of reading and writing pages of a PDF;
# see <https://stackoverflow.com/a/29495882>.

function ...
  animate_tumbling (...
    outputName, ...
    initialVertices, ...
    phiRange = 2 * pi, ...
    initialPivot = "first" ...
  )
  
  # Parse output file name
  if (! ischar (outputName))
    error ("outputName must be a string")
  endif
  outputName = regexprep (outputName, "\.gif$", "");
  outputNameGIF = [outputName, ".gif"];
  outputNamePDF = [outputName, ".pdf"];
  
  # Compute the tumbling trajectory
  [phiValues, zVectorValues] = ...
    tumbling_trajectory (initialVertices, phiRange, initialPivot);
  
  # Remove existing PDF
  delete (outputNamePDF);
  
  # Assign figure handle
  figureHandle = figure;
  
  # Set up axes etc.
  axis nolabel;
  axis off;
  axis ([-1, 1, -1, 1]);
  daspect ([1, 1, 1]);
  hold on;
  
  # Plot unit circle (tumbling region boundary)
  angleValues = linspace (0, 2 * pi, 50);
  xCircleValues = cos (angleValues);
  yCircleValues = sin (angleValues);
  plot (xCircleValues, yCircleValues, "k");
  
  # Initialise plot handles (for removing plotted trajectories)
  frameCount = length (phiValues);
  vertexCount = columns (zVectorValues);
  trajectoryPlotHandle = zeros (vertexCount, 1);
  polygonFillHandle = zeros (1, 1);
  
  # Loop over frames (TODO: add argument for sampling rate)
  for frameIndex = 1 : frameCount
    
    # Current phi
    phi = phiValues(frameIndex);
    
    # Loop over vertices
    for vertexIndex = 1 : vertexCount
      
      # Extract z values for this vertex up to current phi
      zValues = zVectorValues(:,vertexIndex);
      zValues = zValues(phiValues <= phi);
      
      # Convert to real x and y values
      xValues = real (zValues);
      yValues = imag (zValues);
      
      # Plot trajectory
      trajectoryPlotHandle(vertexIndex) = plot (xValues, yValues);
      
    endfor
    
    # Extract current position of polygon
    zValuesPolygon = zVectorValues(frameIndex,:);
    xValuesPolygon = real (zValuesPolygon);
    yValuesPolygon = imag (zValuesPolygon);
    
    # Fill polygon
    polygonFillHandle = fill (xValuesPolygon, yValuesPolygon, "k");
    
    # Append current frame to PDF
    print (outputNamePDF, "-append", "-S120,120");
    
    # Delete trajectories and polygon for next frame
    for vertexIndex = 1 : vertexCount
      delete (trajectoryPlotHandle(vertexIndex));
    endfor
    delete (polygonFillHandle);
    
  endfor
  
  # Convert PDF to GIF
  frameDurations = diff(phiValues);
  frameDurations = [frameDurations; mean(frameDurations)];
  frames = imread (outputNamePDF, "Index", "all");
  imwrite (frames, outputNameGIF, "DelayTime", frameDurations);
  
  # Close figure
  close (figureHandle);
  
endfunction


%!demo
%!  animate_tumbling ("demo.gif", [0.8; -0.2; -0.2 - 0.5i], 5);
