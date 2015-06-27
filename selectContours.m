function retC = selectContours( C )

	% function to prune out all contours which don't look like a mine.
	% does this by analysing the shape of the contours-
	% 	: if it is longer than it is wide (elongated cylinder), keep it.
	% use PCA over the contour points, and,
	% if ratio of eigen-energies of two components is within a range (not too wide, not too long)
	% and if the contour is long enough, then it is probably a mine -- retain it.
	
	% the returned thing, `C` is a cell-array (for a very good reason, stay tuned!)
	
	ii = 1;
	counter = 0;
	while ii <= size(C,2)
	
		cur_len = C(2,ii);
		cur_contour = C(:, ii+1: ii+cur_len);
		[~, ~, LAT] = princomp( cur_contour' );
		elongation = LAT(1)/LAT(2);
		
		if elongation > 6 && elongation < 70 && cur_len > 50
			counter = counter+1;
			retC{1, counter} = cur_contour;
		end
		
		ii = ii + cur_len + 1;
	end
end
