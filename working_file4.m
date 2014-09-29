clear; close all; clc;
U = 100;
S = 15;

m_area = zeros(U,U);
m_area(1,100) = 1;
m_area(100,100) = 1;
m_area(50,65) = 1;

m_number = f_numberWithinDistance_m(m_area,U,S);
imagesc(m_number)