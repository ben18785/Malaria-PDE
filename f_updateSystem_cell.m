function [m_areaBreed,m_areaFeed,cell_densities] = f_updateSystem_cell(m_areaBreed,m_areaFeed,cell_densities,v_parameters,c_T)
    % A function which updates the breeding site density, feeding site
    % density, and (most importantly) the cell densities of the various
    % agents in the model
    
    % Dependent on whether we allow for variance in the breeding site
    % density, update the breeding site
    if v_parameters(1) == 0
        m_areaBreed = m_areaBreed;
    else
        m_areaBreed = f_updateBreed_m(m_areaBreed,cell_densities,v_parameters);
    end
    
    % Same for feeding sites
     if v_parameters(1) == 0
        m_areaFeed= m_areaFeed;
    else
        m_areaFeed = f_updateFeed_m(m_areaFeed,cell_densities,v_parameters);
     end
    
    % Update the densities of the various components
    cell_densities = f_updateDensities_ODEPDETogether_cell(m_areaBreed,m_areaFeed,cell_densities,v_parameters,c_T);