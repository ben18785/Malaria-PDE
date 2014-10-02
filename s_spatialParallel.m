clear; close all; clc;

U = 100;
c_T = 120;
v_pa_thetaB = zeros(7,1);
v_pa_thetaA = zeros(7,1);
N = 1;

for i = 0:6
    v_pa_thetaB(i+1) = 2^(4+0.5*i) * 10^(-4);
    v_pa_thetaA(i+1) = 2^(1+0.5*i) * 10^(-4);
end

% Now stack parameter vectors into one linear parameter vector
m_pa_thetaBoth = zeros(49,2);
k = 1;
for i = 1:7
    for j = 1:7
        m_pa_thetaBoth(k,:) = [v_pa_thetaB(i),v_pa_thetaA(j)];
        k = k + 1;
    end
end

cell_all = cell(49,1);
if matlabpool('SIZE') < 8
    matlabpool OPEN
end
parfor i = 1:49
    i
    cell_all{i} = f_spatialPDEIterated_cell(m_pa_thetaBoth(i,1),m_pa_thetaBoth(i,2),U,c_T,N);
end

save('cell_all','cell_all')
    