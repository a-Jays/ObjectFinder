function mine_regions = findObjects( img, DB )

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
	
	% `mine_regions` is a cell-array of final ROIs.
	
	if nargin < 2
		fprintf('Provide one (1) (ek) image and the database as argument. See help.\n');
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
	
	C = contourc( img, 1 );
	
	retained_C = selectContours( C );
	retained_centres = getCentres( retained_C );
	boundingboxes = getBoundingBox( img, retained_centres, 1 );
	
	mine_regions = SURFTest( boundingboxes, DB );
	
end	
