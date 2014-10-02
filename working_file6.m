clear; close all; clc;

load('cell_all')

v_pa_thetaB = zeros(7,1);
v_pa_thetaA = zeros(7,1);

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

m_survive = zeros(7,7);
k = 1;
for i = 1:7
    for j = 1:7
        m_temp = cell_all{k}{1};
        v_temp = sum(m_temp,2);
        k = k + 1;
        if v_temp > 1000
            m_survive(i,j) = 1;
        end
    end
end

HeatMap(m_survive)