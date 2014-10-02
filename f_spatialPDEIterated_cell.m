function cell_all = f_spatialPDEIterated_cell(c_pa_thetaB,c_pa_thetaA,U,c_T,N)
    % A function which iterates through a number N iterations of the
    % spatial PDE
    
    cell_all = cell(N,1);
    for i = 1:N
        cell_all{i} = f_spatialPDE_m(c_pa_thetaB,c_pa_thetaA,U,c_T);
    end
        

