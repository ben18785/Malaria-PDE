clear; close all; clc;


%% Set parameters
% Simulation size
U = 100; % For now make actual distances be U x 10m. Therefore U=100 => 1km 

% Time length of simulation
c_T = 100; 

c_breedVariance = 0; % Governs whether the breeding site number varies
c_feedVariance = 0; % Governs whether the feeding site number varies
c_diffusion = 10; % Think that a parameter value of 10 means 10000m2/day
c_simple = 1; % Choose whether to use derived parameters from the ODE model, or allow spatial variance in breeding and feeding
c_randinitiate = 1; % Choose whether to allocate juveniles initially at a point in centre of domain (0); or randomly throughout the space (1)
c_initialJuveniles = 10000;
c_pa_thetaB = 128e-4;
c_pa_thetaA = 16e-4;
c_S0 = 15;
c_SH = 50;
c_SM = 30;
c_omega = 40;
c_kappa = 120;

if c_simple == 0
    %% Simple parameters
    c_O = c_pa_thetaB*c_S0*c_S0*pi*c_omega/c_kappa;
    c_H = (c_pa_thetaA*pi*c_SH*c_SH);
    c_nu_mean = 0.12*c_O;
    c_gamma_j = 0.1;
    c_mu_j = 0.1;
    c_alpha = (0.05/c_pa_thetaB)*1e-4;
    c_mu_m = 0.1;
    c_mu_u = 0.1;
    c_m = 0.01*pi*c_SM*c_SM*1e-4;
    c_mu_h = 0.1;
    c_gamma_h = 0.015*c_H;
    c_mu_o = 0.1;

else
    %% Spatial parameters
    c_O = 1;
    c_H = 1;
    c_nu_mean = 0.12;
    c_gamma_j = 0.1;
    c_mu_j = 0.1;
    c_alpha = 0.05*1e-4;
    c_mu_m = 0.1;
    c_mu_u = 0.1;
    c_m = 0.01*pi*c_SM*c_SM*1e-4;
    c_mu_h = 0.1;
    c_gamma_h = 0.015*c_H;
    c_mu_o = 0.1;
end

%% Stack parameters


v_parameters = zeros(21,1);
v_parameters(1) = c_breedVariance;
v_parameters(2) = c_feedVariance;
v_parameters(3) = c_pa_thetaB;
v_parameters(4) = c_pa_thetaA;
v_parameters(5) = c_S0;
v_parameters(6) = c_SH;
v_parameters(7) = c_SM;
v_parameters(8) = c_omega;
v_parameters(9) = c_kappa;
v_parameters(10) = c_O;
v_parameters(11) = c_H;
v_parameters(12) = c_nu_mean;
v_parameters(13) = c_gamma_j;
v_parameters(14) = c_mu_j;
v_parameters(15) = c_alpha;
v_parameters(16) = c_mu_m;
v_parameters(17) = c_mu_u;
v_parameters(18) = c_m;
v_parameters(19) = c_mu_h;
v_parameters(20) = c_gamma_h;
v_parameters(21) = c_mu_o;
v_parameters(22) = c_diffusion;
v_parameters(23) = c_simple;



%% Initialise the areas and fields
% Create breeding sites randomly
m_areaBreed = f_breedOrFeedCreateInitial_m(U,c_pa_thetaB);

% Create feeding sites randomly
m_areaFeed = f_breedOrFeedCreateInitial_m(U,c_pa_thetaA);


% Create the initial fields of Hx and Ox
m_Hx = zeros(U,U);
m_Ox = zeros(U,U);

% Create the initial fields of J,M,U. Each point in these matrices will be
% evolved according to ODE rules
m_Jx = zeros(U,U);
m_Jy = zeros(U,U);
m_My = zeros(U,U);
m_Ux = zeros(U,U);

% Allocate the juveniles
if c_randinitiate == 0 % Point distribute
    c_mid = round(U/2);
    m_areaBreed(c_mid,c_mid) = 1; % Create one breeding site in the middle of the domain to put in the initial juveniles
    m_Jx(c_mid,c_mid) = c_initialJuveniles;
    m_Jy(c_mid,c_mid) = c_initialJuveniles;
else % Distribute randomly
    m_Jx = f_initialJuveniles_m(m_areaBreed,c_initialJuveniles,U);
    m_Jy = f_initialJuveniles_m(m_areaBreed,c_initialJuveniles,U);
end

% Keep these in a cell array
cell_densities = cell(6,1);
cell_densities{1} = m_Jx;
cell_densities{2} = m_Jy;
cell_densities{3} = m_My;
cell_densities{4} = m_Ux;
cell_densities{5} = m_Hx;
cell_densities{6} = m_Ox;



%% Evolve system
[m_areaBreed,m_areaFeed,cell_densities] = f_updateSystem_cell(m_areaBreed,m_areaFeed,cell_densities,v_parameters,c_T);
m_Jx = cell_densities{1};
m_Jy = cell_densities{2};
m_My = cell_densities{3};
m_Ux = cell_densities{4};
m_Hx = cell_densities{5};
m_Ox = cell_densities{6};