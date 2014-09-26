function m_areaBreed = f_breedOrFeedCreateInitial_m(U,c_pa_thetaB)
    % A function which creates breeding or feeding sites randomly thoroughout the
    % landscape according to their initial density
    
    % Create initial empty landscape
    m_areaBreed = zeros(U,U);
    
    % First calculate the number of breeding/feeding sites to create
    c_num = round(U*U*c_pa_thetaB);
    
    % Now go through, and while the count is less than the expected number, randomly create sites
    k = 0;
    while k < c_num
        c_x = round(U*rand()+0.5);
        c_y = round(U*rand()+0.5);
        
        % If the site is empty, create a site, and increment the counter
        if m_areaBreed(c_x,c_y) == 0
            m_areaBreed(c_x,c_y) = 1;
            k = k + 1;
        end
        
    end