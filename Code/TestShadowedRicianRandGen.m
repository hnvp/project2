%Ref: https://www.mathworks.com/matlabcentral/fileexchange/60724-shadowed-rician-random-number-generator
clear;clc;
%% Parameters
N = 1e5;        % No. of trials
b = 0.279;      % a half of the average power of the multipath component, ref paper
m = 2;          % the Nakagami-m parameter ranging from 0 to infinity
Omega = 0.251;  % the average power of LOS component
%% Generate Shadowed Rician Random Number
X = ShadowedRicianRandGen(b,m,Omega,N); %refer IEEE TVT paper
%% Points for which distribution has to be evaluated
x = linspace(0,5,1000);
%% Estimate Distribution
[fsim,Fsim] = EstimateDistribution(X,x); %as Simulation 
%% Theoretical PDF & CDF
[fana,Fana] = ShadowedRicianDistribution(b,m,Omega,x); % checked D.T Do paper
%% Plot Results
Fsim
Fana
fsim
fana
subplot(121);plot(x(1:30:end),Fsim(1:30:end),'b*',x,Fana,'-');grid on;
xlabel('x');ylabel('F_X(x) = P(X<=x)');
subplot(122);plot(x(1:30:end),fsim(1:30:end),'b*',x,fana,'-');grid on;
xlabel('x');
ylabel('Probability Density Function');
legend('Simulated','Theoretical');