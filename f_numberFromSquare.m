function c_number = f_numberFromSquare(c_x,c_y,m_areaSites,U,S)
    % A function which counts the number of sites within a distance S of
    % squares
    
    % Take one from the indices to allow modula arithmetic
    c_x = c_x - 1;
    c_y = c_y - 1;
    
    c_number = 0;
    for i = -S:S
        for j = -S:S
            c_xtest = mod(i+c_x,U) + 1;
            c_ytest = mod(j+c_y,U) + 1;        
            if m_areaSites(c_xtest,c_ytest) == 1
                c_number = c_number + 1;
            end
        end
    end
            