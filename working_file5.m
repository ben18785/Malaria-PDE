clear; close all; clc;

% Simulation size
U = 100; % For now make actual distances be U x 10m. Therefore U=100 => 1km 

% Time length of simulation
c_T = 100; 

c_breedVariance = 0; % Governs whether the breeding site number varies
c_feedVariance = 0; % Governs whether the feeding site number varies
c_diffusion = 1; % Think that a parameter value of 10 means 10000m2/day. This is multiplied by the distance matrix for breeding sites.
c_simple = 1; % Choose whether to use derived parameters from the ODE model, or allow spatial variance in breeding and feeding
c_randinitiate = 1; % Choose whether to allocate juveniles initially at a point in centre of domain (0); or randomly throughout the space (1)
c_initialJuveniles = 10000;
c_pa_thetaB = 45e-4;
c_pa_thetaA = 11e-4;

% m_areaBreed = f_breedOrFeedCreateInitial_m(U,c_pa_thetaB);
m_areaBreed = zeros(U,U);
m_areaBreed(100,1) = 1;
m_distance = f_distance_matrix_calculatorQuick_m(m_areaBreed,U);
subplot(1,2,1),imagesc(m_areaBreed)
subplot(1,2,2),imagesc(m_distance)