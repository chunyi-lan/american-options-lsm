function LSM_payoff=solve_BS_American_LSM(S0,r,sigma,K,T,N_MC,Nt,k)
%**********************************************************
% Use LSM to compute the price
% of American put option in Black-Scholes model
%**********************************************************
% S0: Initial stock price
% K: Strike price
% r: Interest rate
% sigma: volatility
% T: maturity time
% N_MC: Number of Monte Carlo simulations
% Nt: Number of time steps (the option is exercisable only at the time steps)
% k: Number of basis functions for Laguerre polynomials
%**********************************************************

dt=T/Nt;
St=zeros(N_MC,Nt);

for i=1:N_MC
    St(i,:)=S0*exp((r-sigma^2/2)*(1:Nt)*dt+sigma*sqrt(dt)*cumsum(randn(1,Nt))); 
end

payoff=zeros(N_MC,Nt);
payoff(:,Nt) = max(K-St(:,Nt),0);

for j = Nt:-1:2

    path = find(K-St(:,j)>0); % find in the money paths
    X = St(path,j-1); % prices for the in the money paths
    Y = exp(-r*dt) * payoff(path,j); % discounted payoffs
    
    poly = zeros(size(X,1), k+1);

    for i = 0:k
        poly(:,i+1) = laguerreL_optimized(i,X);
    end
    
    % Solve poly * coeff = Y
    coeff = lsqminnorm(poly,Y);
    
    value_continuation = poly*coeff; 
    value_exercise = K - X;

    path_exercise = path(value_continuation < value_exercise); % paths that are better to exercise
    path_continue = setdiff(transpose(1:N_MC), path_exercise);

    payoff(path_exercise,j-1) = value_exercise(value_continuation < value_exercise);
    payoff(path_exercise,j:Nt) = 0; % once the option is exercised there are no further cash flows since the option can only be exercised once

    payoff(path_continue,j-1) = payoff(path_continue,j)*exp(-r*dt);
end

final_payoff = zeros(N_MC,1);

for i=1:N_MC
    if max(payoff(i,:))==0
        final_payoff(i) = 0;
    else
        for j=1:Nt
            if payoff(i,j)>0
                final_payoff(i) = payoff(i,j)*exp(-r*dt*j);
                break
            end
        end
    end
end

LSM_payoff = mean(final_payoff);



