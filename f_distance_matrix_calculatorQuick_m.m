function m_distance = f_distance_matrix_calculatorQuick_m(m_area,U)
% A function which calculates the distance of all points from the nearest
% pixels based on a torus.

% Make a wrap around area
m_areaBig = [m_area, m_area, m_area; m_area, m_area, m_area; m_area, m_area, m_area];

% Get the distances for the big area
m_distanceBig = bwdist(m_areaBig);

% Get the distances for the area in question
m_distance = double(m_distanceBig(U+1:2*U,U+1:2*U));

