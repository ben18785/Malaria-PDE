clear; close all; clc;
c_n = 100000;
v_x = zeros(c_n,1);
U = 1500;
c_pa_thetaB = 0.000064;
for i = 1:c_n
    v_x(i) = round(U*rand()+0.5);
end

m_areaBreed = f_breedOrFeedCreateInitial_m(U,c_pa_thetaB);
sum(sum(m_areaBreed))
imagesc(m_areaBreed)