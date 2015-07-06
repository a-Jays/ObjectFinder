function mine_regions = findObjects( img, DB, Method )

	% top-level function to find mine & mine-like objects in SONAR image.
	% - takes `img` the colour-image as an argument, cleans it and applies
	% gamma correction to it. Converts to `double` for `contourc`.
	% - also takes a database, `DB`, which is a cell-array of features from
	% different images, to look into.
	
	% then follow this pipeline:
	% 	- find all level-1 contours in the image.
	% 	- threshold them on the basis of their shape [using PCA & length]
	% 	- obtain a region of interest around each contour.
	% 	- find SURF keypoint descriptors in each ROI.
	% 	- retain those ROIs which have some `N` matches.
	%
	% The argument `method` specifies which method to use: =0 for contour-based
	% and =1 for intensity-based thresholding. Defaulted to 1.
	% `mine_regions` is a cell-array of final ROIs.
	if nargin < 3
		Method = 1;
		if nargin < 2
			fprintf('Provide one (1) (ek) image and the database as argument. See help.\n');
		end
	end
	
	% The following is with the hope that one fine day, when the sun is bright,
	% the code can be separated for Octave, using the ENVT (environment) parameter.
	if exist( 'OCTAVE_VERSION', 'builtin' )
		ENVT = 'Octave';
	else
		ENVT = 'Matlab';
	end
	
	img = im2double( medfilt2( rgb2gray(img), [3 3] ) );
	img = img.^1.1;
	
	if Method == 1
		Components =  bwconncomp( wiener2( bwareaopen( im2bw( img, 0.4 ), 100 ), [5 5] ) );
        	retained_centres = struct2cell( regionprops( Components, 'Centroid' ) );
        else
		C = contourc( img, 1 );
		retained_C = selectContours( C );
		retained_centres = getCentres( retained_C );
	end
	boundingboxes = getBoundingBox( img, retained_centres, 1 );
	fprintf( 'Candidate ROIs: %d\n', size( boundingboxes, 2 ) );
	mine_indices = SURFTest( boundingboxes, DB );
	mine_regions = boundingboxes( mine_indices == 1 );
    	fprintf( 'SURF selected ROIs: %d\n', size( mine_regions, 2 ) );
	
end	
