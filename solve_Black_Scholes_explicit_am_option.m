function [f_result,boundary]=solve_Black_Scholes_explicit_am_option(S0,r,sigma,K,T,M,N,S_max)
%**********************************************************
% here we use an explicit finite difference scheme to compute the price
% of put option in Black-Scholes model
%**********************************************************
delta_t=T/M; %step in time variable
delta_s=S_max/N; %step in space variable
ind=floor(S0/delta_s);
delta_s=S0/ind;
%**********************************************************
f_old=zeros(1,N+1);
f_new=zeros(1,N+1);
payoff=zeros(1,N+1);
boundary=zeros(1,M);
%**********************************************************
% initial condition
for i=0:N
    si=i*delta_s; 
    payoff(i+1)=max(K-si,0);
end;
f_old=payoff;
%**********************************************************
% precompute the coefficients 
A1=zeros(1,N-1);
A2=zeros(1,N-1);
A3=zeros(1,N-1);
for i=1:(N-1)
    si=i*delta_s;
    A1(i)=-r*si*delta_t/(2*delta_s)+0.5*sigma^2*si^2*delta_t/delta_s^2; 
    A2(i)=1-sigma^2*si^2*delta_t/delta_s^2-r*delta_t;
    A3(i)=r*si*delta_t/(2*delta_s)+0.5*sigma^2*si^2*delta_t/delta_s^2;
end
%**********************************************************
% doing the iteration in time
for j=1:M
    for i=1:(N-1)
        f_new(i+1)=f_old(i)*A1(i)+...
            +f_old(i+1)*A2(i)...
            +f_old(i+2)*A3(i);
    end
    % set the boundary conditions
    f_new(1)=K*exp(-r*(delta_t*j));
    % sN=N*delta_s;
    f_new(N+1)=0;
    % f_new represents the continuation value
    f_old=max(f_new,payoff); % the price of american option = maximum of continuation and exercise value
    i=max(find(payoff>f_new)); % find the maximum stock price S_i at which the exercise value is greater than the continuation value
    boundary(j)=i*delta_s; % the exercise boundary at time t_j is equal to S_i
end
%**********************************************************
% return the result -- the prices of a call option at maturity 
f_result=f_new(ind+1);