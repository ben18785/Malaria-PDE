function m_juveniles = f_initialJuveniles_m(m_areaBreed,c_initialJuveniles,U)
    % A function which places juveniles at random breed sites throughout
    % the domain
    m_juveniles = zeros(U,U);
    
    % Get the locations of the breed sites, and make a random list of them
    % with replacement
    [v_x,v_y] = find(m_areaBreed);
    m_xy = [v_x,v_y];
    m_randIndices = datasample(m_xy,c_initialJuveniles);
    
    for i = 1:c_initialJuveniles
        m_juveniles(m_randIndices(i,1),m_randIndices(i,2)) = m_juveniles(m_randIndices(i,1),m_randIndices(i,2)) + 1;
    end
    