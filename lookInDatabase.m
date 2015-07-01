function retVal = lookInDatabase( A, Database )

    % >> Internal fuction. Not really to be used directly.. unless you have
    % a Masters in Messing-Around.
    % Takes an image A, computes its SURF points and descriptors, and
    % matches them with any of those present in `Database` (which is a
    % cell-array).
    
   pointsA = detectSURFFeatures( A, 'MetricThreshold', 500 );
   [featA, validpointsA] = extractFeatures( A, pointsA, 'SURFSize', 128 );
   
   isMatch = @(D) size( matchFeatures(featA, D), 1) > 0.5*size(A,1) ;
   retVal = cellfun( isMatch, Database );
   if length( retVal == 1 ) > 0
       retVal = A;
   else
       retVal = [];
   end
end
