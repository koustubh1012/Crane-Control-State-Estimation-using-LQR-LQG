% Clearing workspace and command window
clear;
clc;

% System Parameters
cartMass = 1000;                % Mass of the cart (kg)
pendulumMass1 = 100;            % Mass of Pendulum 1 (kg)
pendulumMass2 = 100;            % Mass of Pendulum 2 (kg)
pendulumLength1 = 20;           % Length of Pendulum 1 (m)
pendulumLength2 = 10;           % Length of Pendulum 2 (m)
gravity = 9.81;                 % Gravity (m/s^2)

% State-Space Matrices
A = [0 1 0 0 0 0;
     0 0 -(pendulumMass1*gravity)/cartMass 0 -(pendulumMass2*gravity)/cartMass 0;
     0 0 0 1 0 0;
     0 0 -((cartMass+pendulumMass1)*gravity)/(cartMass*pendulumLength1) 0 -(pendulumMass2*gravity)/(cartMass*pendulumLength1) 0;
     0 0 0 0 0 1;
     0 0 -(pendulumMass1*gravity)/(cartMass*pendulumLength2) 0 -(gravity*(cartMass+pendulumMass2))/(cartMass*pendulumLength2) 0];
B = [0; 1/cartMass; 0; 1/(cartMass*pendulumLength1); 0; 1/(cartMass*pendulumLength2)];

% LQR Design Matrices
Q = 100*eye(6);
R = 0.001;

% Output Matrices
C1 = [1 0 0 0 0 0];
C3 = [1 0 0 0 0 0; 0 0 0 0 1 0];
C4 = [1 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0];
D = 0;

% Initial Conditions
initialState = [4; 0; 30; 0; 60; 0; 0; 0; 0; 0; 0; 0];

% Control and Observer Design
K = lqr(A, B, Q, R);
vd = 0.3*eye(6); % Process noise
vn = 1; % Measurement noise

% Kalman filter gains for different output matrices
K_pop1 = lqr(A', C1', vd, vn)';
K_pop3 = lqr(A', C3', vd, vn)';
K_pop4 = lqr(A', C4', vd, vn)';

% System Definitions
outputMatrices = {C1, C3, C4};
kalmanGains = {K_pop1, K_pop3, K_pop4};
systemTitles = {'System with C1', 'System with C3', 'System with C4'};

for i = 1:length(outputMatrices)
    sys = ss([(A-B*K) B*K; zeros(size(A)) (A-kalmanGains{i}*outputMatrices{i})], ...
             [B; zeros(size(B))], ...
             [outputMatrices{i} zeros(size(outputMatrices{i}))], D);
    
    figure;
    subplot(2,1,1);
    initial(sys, initialState);
    title(['Initial Response - ', systemTitles{i}]);
    
    subplot(2,1,2);
    step(sys);
    title(['Step Response - ', systemTitles{i}]);
    grid on;
end
