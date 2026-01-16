% Define system parameters
M = 1000; % Cart mass
m1 = 100; % Pendulum 1 mass
m2 = 100; % Pendulum 2 mass
l1 = 20;  % Pendulum 1 length
l2 = 10;  % Pendulum 2 length
g = 9.81; % Gravity

% Initial conditions
x0 = [0, 0, 10*pi/180, 0, 20*pi/180, 0]; % [position, velocity, angle1, angular velocity1, angle2, angular velocity2]

% Time span for the simulation
tspan = [0 30]; % Simulate for 30 seconds

% Numerical integration using ode45
[t, x] = ode45(@(t, x) nonlinearCartDoublePendulumDynamics(t, x, M, m1, m2, l1, l2, g), tspan, x0);

% Plotting results
figure;

% Plotting cart position vs time
subplot(3,2,1);
plot(t, x(:,1));
title('Cart Position vs Time');
xlabel('Time (s)');
ylabel('Position (m)');

% Plotting cart velocity vs time
subplot(3,2,2);
plot(t, x(:,2));
title('Cart Velocity vs Time');
xlabel('Time (s)');
ylabel('Velocity (m/s)');

% Plotting pendulum 1 angle vs time
subplot(3,2,3);
plot(t, x(:,3) * 180/pi); % Converting radians to degrees
title('Pendulum 1 Angle vs Time');
xlabel('Time (s)');
ylabel('Angle (degrees)');

% Plotting pendulum 1 angular velocity vs time
subplot(3,2,4);
plot(t, x(:,4) * 180/pi); % Converting radians to degrees
title('Pendulum 1 Angular Velocity vs Time');
xlabel('Time (s)');
ylabel('Angular Velocity (degrees/s)');

% Plotting pendulum 2 angle vs time
subplot(3,2,5);
plot(t, x(:,5) * 180/pi); % Converting radians to degrees
title('Pendulum 2 Angle vs Time');
xlabel('Time (s)');
ylabel('Angle (degrees)');

% Plotting pendulum 2 angular velocity vs time
subplot(3,2,6);
plot(t, x(:,6) * 180/pi); % Converting radians to degrees
title('Pendulum 2 Angular Velocity vs Time');
xlabel('Time (s)');
ylabel('Angular Velocity (degrees/s)');
