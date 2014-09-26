function cell_densities = f_updateDensities_cell(m_areaBreed,m_areaFeed,cell_densities,v_parameters)
    % A function which updates the various densities of cells across the
    % cell area using ODEs (Jx,Jy,My,Ox) and PDEs (Hx,Ox)
    
    % Find the breeding and feeding site locations
    [v_x1,v_y1] = find(m_areaBreed);
    m_breedIndices = [v_x1,v_y1];
    [v_x2,v_y2] = find(m_areaFeed);
    m_feedIndices = [v_x2,v_y2];
    
    % Update the various fields in a randomised order
    v_indices = 1:6;
    v_indicesRand = datasample(v_indices,6,'Replace',false);
    
    for i = v_indicesRand
        switch i
            case 1
                m_Jx = f_updateJx_m(m_breedIndices,m_feedIndices,cell_densities,v_parameters);
            case 2
                m_Jy = f_updateJy_m(m_breedIndices,m_feedIndices,cell_densities,v_parameters);
            otherwise
%             case 3
%                 m_My = f_updateMy_m(m_breedIndices,m_feedIndices,cell_densities,v_parameters);
%             case 4
%                 m_Ox = f_updateOx_m(m_breedIndices,m_feedIndices,cell_densities,v_parameters);
%             case 5
%                 m_Hx = f_updateHx_m(m_areaBreed,m_areaFeed,cell_densities,v_parameters);
%             case 6
%                 m_Ox = f_updateOx_m(m_areaBreed,m_areaFeed,cell_densities,v_parameters);
        end
    end

    % Put the fields into a cell array
    cell_densities{1} = m_Jx;
    cell_densities{2} = m_Jy;
%     cell_densities{3} = m_My;
%     cell_densities{4} = m_Ux;
%     cell_densities{5} = m_Hx;
%     cell_densities{6} = m_Ox;