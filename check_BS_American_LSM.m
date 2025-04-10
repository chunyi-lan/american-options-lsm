clear all
S0=105; % 90, 95, 100, 105, 110
r=0.03;
T=1; % 0.25, 0.5, 1
K=100;
sigma=0.25;
k=3; % no. of basis functions (Laguerre polynomials)

Nt=365;% number of time points
M=10000;

N_MC=1000000;

LSM_price = solve_BS_American_LSM(S0,r,sigma,K,T,N_MC,Nt,k);

[explicit_price,boundary] = solve_Black_Scholes_explicit_am_option(S0,r,sigma,K,T,M,Nt,200); % Lecture March 26

LSM_price
explicit_price
difference = abs(LSM_price-explicit_price)

