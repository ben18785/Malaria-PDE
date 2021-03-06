function cell_densities = f_updateDensities_ODEPDETogether_cell(m_areaBreed,m_areaFeed,cell_densities,v_parameters,c_T)
% A function which updates the various densities of cells across the
% cell area using ODEs (Jx,Jy,My,Ox) and PDEs (Hx,Ox)

m_Jx = cell_densities{1};
m_Jy = cell_densities{2};
m_My = cell_densities{3};
m_Ux = cell_densities{4};
m_Hx = cell_densities{5};
m_Ox = cell_densities{6};

% Reshape the data into vectors
v_Jx = m_Jx(:);
v_Jy = m_Jy(:);
v_My = m_My(:);
v_Ux = m_Ux(:);
v_Hx = m_Hx(:);
v_Ox = m_Ox(:);

% And also the breeding and feeding site locations
v_areaBreed = m_areaBreed(:);
v_areaFeed = m_areaFeed(:);

% Get the length to pass on
c_len = length(v_Jx);

% Create the laplacian
c_N = sqrt(c_len);
[~,~,m_lap] = laplacian([c_N c_N], {'P','P'});
m_lap = -m_lap;

% Calculate the distance from breeding sites
disp('Calculating number and distance matrices...')
if v_parameters(23) == 1
    disp('Calculating number matrices...nu')
    m_numberNu = f_numberWithinDistance_m(m_areaBreed,c_N,v_parameters(5));
    disp('Calculating number matrices...gamma')
    m_numberGammaH = f_numberWithinDistance_m(m_areaFeed,c_N,v_parameters(6));
    disp('Calculating number matrices...mating')
    m_numberM = f_numberWithinDistance_m(m_areaBreed,c_N,v_parameters(7));
    disp('Calculating distance matrices...breeding')
    m_distanceBreed = f_distance_matrix_calculatorQuick_m(m_areaBreed,c_N);
    pause(0.1)
    disp('Calculating distance matrices...feeding')
    m_distanceFeed = f_distance_matrix_calculatorQuick_m(m_areaFeed,c_N);
    pause(0.1)
else
    m_numberNu = [];
    m_numberGammaH = [];
    m_numberM = [];
    m_distanceBreed = [];
    m_distanceFeed = [];
end



cell_numberVectors = cell(3,1);
cell_numberVectors{1} = m_numberNu(:);
cell_numberVectors{2} = m_numberGammaH(:);
cell_numberVectors{3} = m_numberM(:);
cell_numberVectors{4} = m_distanceBreed(:);
cell_numberVectors{5} = m_distanceFeed(:);

% Go through and update the various components
tspan = 0:1:c_T;
[t,Y] = ode45(@(t,Y)f_derivative_ODEPDESystem_vv(t,Y,v_parameters,v_areaBreed,v_areaFeed,c_len,m_lap,cell_numberVectors),tspan,[v_Jx,v_Jy,v_My,v_Ux,v_Hx,v_Ox]);

% Extract the solution

for i = 1:size(Y,1)
    v_Ytemp = Y(i,:);
    v_Ytemp = v_Ytemp';
    N = c_len;
    v_Jx = v_Ytemp(1:N,1); v_Jy = v_Ytemp(N+1:2*N,1); v_My = v_Ytemp(2*N+1:3*N,1); v_Ux = v_Ytemp(3*N+1:4*N,1); v_Hx = v_Ytemp(4*N+1:5*N,1);
    v_Ox = v_Ytemp(5*N+1:end,1);

    % Reshape
    m_Jx = reshape(v_Jx,c_N,c_N);
    m_Jy = reshape(v_Jy,c_N,c_N);
    m_My = reshape(v_My,c_N,c_N);
    m_Ux = reshape(v_Ux,c_N,c_N);
    m_Hx = reshape(v_Hx,c_N,c_N);
    m_Ox = reshape(v_Ox,c_N,c_N);
    
    cell_densities{i,1} = m_Jx;
    cell_densities{i,2} = m_Jy;
    cell_densities{i,3} = m_My;
    cell_densities{i,4} = m_Ux;
    cell_densities{i,5} = m_Hx;
    cell_densities{i,6} = m_Ox;
    
end
