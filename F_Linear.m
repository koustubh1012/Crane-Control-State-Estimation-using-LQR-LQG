% Clearing all the previous outputs
clc
clear

% Defining constants
cartMass = 1000;        % Mass of the cart (kg)
pendulum1Mass = 100;    % Mass of Pendulum 1 (kg)
pendulum2Mass = 100;    % Mass of Pendulum 2 (kg)
pendulum1Length = 20;   % Length of the string of Pendulum 1 (m)
pendulum2Length = 10;   % Length of the string of Pendulum 2 (m)
gravity = 9.81;         % Acceleration due to gravity (m/s^2)

% State-space matrices
A = [0 1 0 0 0 0;
     0 0 -(pendulum1Mass*gravity)/cartMass 0 -(pendulum2Mass*gravity)/cartMass 0;
     0 0 0 1 0 0;
     0 0 -((cartMass+pendulum1Mass)*gravity)/(cartMass*pendulum1Length) 0 -(pendulum2Mass*gravity)/(cartMass*pendulum1Length) 0;
     0 0 0 0 0 1;
     0 0 -(pendulum1Mass*gravity)/(cartMass*pendulum2Length) 0 -(gravity*(cartMass+pendulum2Mass))/(cartMass*pendulum2Length) 0];
B = [0; 1/cartMass; 0; 1/(cartMass*pendulum1Length); 0; 1/(cartMass*pendulum2Length)];

% Output matrices for observable states
C_x = [1 0 0 0 0 0];                        % Output measurement for x component
C_x_theta2 = [1 0 0 0 1 0];                  % Output measurement for x and theta2
C_x_theta1_theta2 = [1 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0]; % Output measurement for x, theta1 and theta2
D = 0;

% LQR design
Q = 100*eye(6);
R = 0.01; 
initialState = [0, 0, 30, 0, 60, 0, 0, 0, 0, 0, 0, 0];
poles = -1:-1:-6;
K = lqr(A, B, Q, R);

% Observer design
L_x = place(A', C_x', poles)'; 
L_x_theta2 = place(A', C_x_theta2', poles)'; 
L_x_theta1_theta2 = place(A', C_x_theta1_theta2', poles)'; 

% Closed-loop systems
A_cl_x = [(A-B*K) B*K; zeros(size(A)) (A-L_x*C_x)];
B_cl = [B; zeros(size(B))];
C_cl_x = [C_x zeros(size(C_x))];
system_x = ss(A_cl_x, B_cl, C_cl_x, D);

A_cl_x_theta2 = [(A-B*K) B*K; zeros(size(A)) (A-L_x_theta2*C_x_theta2)];
C_cl_x_theta2 = [C_x_theta2 zeros(size(C_x_theta2))];
system_x_theta2 = ss(A_cl_x_theta2, B_cl, C_cl_x_theta2, D);

A_cl_x_theta1_theta2 = [(A-B*K) B*K; zeros(size(A)) (A-L_x_theta1_theta2*C_x_theta1_theta2)];
C_cl_x_theta1_theta2 = [C_x_theta1_theta2 zeros(size(C_x_theta1_theta2))];
system_x_theta1_theta2 = ss(A_cl_x_theta1_theta2, B_cl, C_cl_x_theta1_theta2, D);

% Simulation
figure, initial(system_x, initialState)
figure, step(system_x)
figure, initial(system_x_theta2, initialState)
figure, step(system_x_theta2)
figure, initial(system_x_theta1_theta2, initialState)
figure, step(system_x_theta1_theta2)
