function means = getCentres( contour_cell )

	findCentroid = @(A) mean( A' )';
	means = cellfun( findCentroid, contour_cell, 'UniformOutput', false );
	
end
