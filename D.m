syms M m1 m2 l1 l2 g
%%Units of measurements taken in metric system 
M = 1000;
m1 = 100;
m2 = 100;
l1 = 20;
l2 = 10;
g = 9.81;

%% State space representation of the system as matrice A, B, C, D
%A Matrix
A = [0 1 0 0 0 0; 0 0 -m1*g/M 0 -m2*g/M 0; 0 0 0 1 0 0; 0 0 -((M+m1)*g)/(M*l1) 0 -g*m2/(M*l1) 0; 0 0 0 0 0 1; 0 0 -m1*g/(M*l2) 0 -((M+m2)*g)/(M*l2) 0];
disp("martix A is:")
disp(A)
%B Matrix
B = [0; 1/M; 0; 1/(l1*M); 0; 1/(l2*M)];
disp("martix B is:")
disp(B)
%C Matrix
C = [1 0 0 0 0 0; 
     0 1 0 0 0 0; 
     0 0 1 0 0 0; 
     0 0 0 1 0 0; 
     0 0 0 0 1 0; 
     0 0 0 0 0 1]
% D Matrix
D = [0; 0; 0; 0; 0; 0]


% Taking intial conditions assumption
X_init = [0; 0; deg2rad(45); deg2rad(0); deg2rad(45); deg2rad(0)]

%Q and R values assumption
Q = [5000 0 0 0 0 0;
     0 1000 0 0 0 0;
     0 0 5000 0 0 0;
     0 0 0 1000 0 0;
     0 0 0 0 5000 0;
     0 0 0 0 0 1000]
R = 0.02


disp("The response of the system without the LQR Controller for initial states\n")

ss_rep = ss(A, B, C, D)

% Ploting the Intial State without controller
figure("Name","Intial State without LQR controller")

initial(ss_rep, X_init,300)

disp("With LQR Controller \n")
% Calucukate LQR controoler
[K, S, P] = lqr(A, B, Q, R)
%Closed loop state space representation
ss_rep_closed = ss(A-(B*K), B, C, D)

figure("Name","Intial State with LQR controller")
initial(ss_rep_closed, X_init,300)

%Check for stablity
disp("The eigen values of closed loop A matrix is:")
disp(eig(A-B*K))



