function m_distance = f_distance_matrix_calculator_m(m_area,U)
% A function which calculates the nearest distances of each cell from
% epithelium, returning this as a matrix of distances 

% Create a distance matrix starting with values all -1
% Iterate through making all cells of the distance matrix zero when there
% are epithelium at that location
m_distance = m_area-1;


% Now call the iterator which uses dynamic programming
m_distance = f_distance_iterator_m(m_distance,0,U);