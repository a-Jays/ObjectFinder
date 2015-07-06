function ROIs = getBoundingBox( img, C, input_type )

	% function to obtain a bounding box ROI around the detected object.
	% 
	% there are two implementations of the function, depending on `input_type`:
	% 	1. `C` is a cell-array of centroid points, in which case a constant-size ROI is returned.
	%	2. `C` is a cell-array of contours, in which case a bounding box must be found.
	% NOTE: each of the locations in `C` is an [x y] pair; y being used for rows, and x for columns.
	
	if input_type == 1
	
		binder = @(A) img( round(max(1,A(2)-60)):round(min(A(2)+60,size(img,1))),
					round(max(1,A(1)-60)):round(min(A(1)+60,size(img,2))) );
		ROIs = cellfun( binder, C, 'UniformOutput', false );
	
	else
	
		binder = @(A) img( max(1,round(min(A(2,:))-5)):min(round(max(A(2,:))+5),size(img,1)),
					max(1,round(min(A(1,:))-5)):min(round(max(A(1,:))+5),size(img,2)) );
		ROIs = cellfun( binder, C, 'UniformOutput', false );
	
	end
end
