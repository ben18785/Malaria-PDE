function dYdt = f_derivative_ODEPDESystem_vv(t,Y,v_parameters,v_areaBreed,v_areaFeed,N,m_lap,cell_numberVectors)
% A function which returns the derivative of the various components of both
% the ODEs (Jx,Jy,My,Ox) and PDEs (Hx,Ox)

v_Jx = Y(1:N,1); v_Jy = Y(N+1:2*N,1); v_My = Y(2*N+1:3*N,1); v_Ux = Y(3*N+1:4*N,1); v_Hx = Y(4*N+1:5*N,1);
v_Ox = Y(5*N+1:end,1);
t

c_breedVariance = v_parameters(1);
c_feedVariance = v_parameters(2);
c_pa_thetaB = v_parameters(3);
c_pa_thetaA = v_parameters(4);
c_S0 = v_parameters(5);
c_SH = v_parameters(6);
c_SM = v_parameters(7);
c_omega = v_parameters(8);
c_kappa = v_parameters(9);
c_O = v_parameters(10);
c_H = v_parameters(11);
c_nu = v_parameters(12);
c_gamma_j = v_parameters(13);
c_mu_j = v_parameters(14);
c_alpha = v_parameters(15);
c_mu_m = v_parameters(16);
c_mu_u = v_parameters(17);
c_m = v_parameters(18);
c_mu_h = v_parameters(19);
c_gamma_h = v_parameters(20);
c_mu_o = v_parameters(21);
c_diffusion = v_parameters(22);





if v_parameters(23) == 0 % If simple
    
    % Get the derivatives for the ODE variables (multiply the lot
    % by the breeding area vectors to make sure they stay localised there - makes derivative zero therefore no growing/shrinking)
    dJxdt = v_areaBreed.*(0.5*c_kappa*c_nu*v_Ox - c_gamma_j*v_Jx - c_mu_j*v_Jx - c_alpha*v_Jx.*(v_Jx + v_Jy));
    dJydt = v_areaBreed.*(0.5*c_kappa*c_nu*v_Ox - c_gamma_j*v_Jy - c_mu_j*v_Jy - c_alpha*v_Jy.*(v_Jx + v_Jy));
    dMydt = v_areaBreed.*(c_gamma_j*v_Jy - c_mu_m*v_My);
    dUxdt = v_areaBreed.*(c_gamma_j*v_Jx - c_mu_u*v_Ux - c_m*v_Ux.*v_My);
    
    % Work on the PDE components
    dHxdt = c_diffusion*m_lap*v_Hx + c_m*v_Ux.*v_My + c_nu*v_Ox - c_gamma_h*v_Hx - c_mu_h*v_Hx;
    dOxdt = c_diffusion*m_lap*v_Ox + c_gamma_h*v_Hx - c_nu*v_Ox - c_mu_o*v_Ox;
else
    % Get the distance matrices
    v_numberNu = cell_numberVectors{1};
    v_numberGammaH = cell_numberVectors{2};
    v_numberM = cell_numberVectors{3};
    v_numberAlpha = v_Jx + v_Jy;
    if v_parameters(24) == 0
        v_distanceBreed = ones(N,1);
        v_distanceFeed = ones(N,1);
    else
        v_distanceBreed = cell_numberVectors{4};
        v_distanceFeed = cell_numberVectors{5};
    end
    
    % Use distances to create localised egg laying rates, feeding rates,
    % competition amongst juveniles, and mating rates
    v_nu = c_nu*v_numberNu;
    v_gamma_h = c_gamma_h*v_numberGammaH;
    v_m = c_m*v_numberM;
    v_alpha = c_alpha*v_numberAlpha;
    
    % Dependent on the type of local diffusion processes calculate the
    % local diffusion rate
    if v_parameters(25) == 0
        v_diffusionBreed = c_diffusion*v_distanceBreed;
        v_diffusionFeed = c_diffusion*v_distanceFeed;
    else
        c_beta = v_parameters(26);
        v_diffusionBreed = (c_diffusion./(c_beta.^(v_numberGammaH-min(v_numberGammaH))));
        v_diffusionFeed = (c_diffusion./(c_beta.^(v_numberM-min(v_numberM))));
    end
        
    % Get the derivatives for the ODE variables (multiply the lot
    % by the breeding area vectors to make sure they stay localised there - makes derivative zero therefore no growing/shrinking)
    dJxdt = v_areaBreed.*(0.5*c_kappa*v_nu.*v_Ox - c_gamma_j*v_Jx - c_mu_j*v_Jx - v_alpha.*v_Jx.*(v_Jx + v_Jy));
    dJydt = v_areaBreed.*(0.5*c_kappa*v_nu.*v_Ox - c_gamma_j*v_Jy - c_mu_j*v_Jy - v_alpha.*v_Jy.*(v_Jx + v_Jy));
    dMydt = v_areaBreed.*(c_gamma_j*v_Jy - c_mu_m*v_My);
    dUxdt = v_areaBreed.*(c_gamma_j*v_Jx - c_mu_u*v_Ux - v_m.*v_Ux.*v_My);
    
    % Work on the PDE components
    dHxdt = v_diffusionFeed.*(m_lap*v_Hx) + v_m.*v_Ux.*v_My + v_nu.*v_Ox - v_gamma_h.*v_Hx - c_mu_h*v_Hx;
    dOxdt = v_diffusionBreed.*(m_lap*v_Ox) + v_gamma_h.*v_Hx - v_nu.*v_Ox - c_mu_o*v_Ox;
    
end
% Put all into a vector
dYdt = [dJxdt; dJydt; dMydt; dUxdt; dHxdt; dOxdt];


