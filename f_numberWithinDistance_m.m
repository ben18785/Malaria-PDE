function m_number = f_numberWithinDistance_m(m_areaSites,U,S)
    % A function which calculates the number of sites witin a distance of
    % S, for all squares
    
    m_number = zeros(U,U);
    for i = 1:U
        for j = 1:U
            m_number(i,j) = f_numberFromSquare(i,j,m_areaSites,U,S);
        end
    end
    
    
    
        