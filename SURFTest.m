function [select_ROIs] = SURFTest( ROIs, Database )

    % -- function [select_ROIs] = SURFTest( ROIs, Database )
    % Function to select the ROIs that have acertain number of matches from
    % the `Database`.
    % `ROIs` is a cell-array of regions of potential interest.
    % `Database` is a cell-array of SURF features collected from different
    %  images (probably 3-4).
    % Only those ROIs are retained which have a minimum number of matches
    % from any of the feature collection in `Database`.
    
    proxy_lookInDatabase = @(A) lookInDatabase( A, Database );
    select_ROIs = cellfun( proxy_lookInDatabase, ROIs, 'UniformOutput', false );
end
