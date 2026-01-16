syms m1 g m2 M L1 L2

A = [0 1 0 0 0 0; 0 0 -m1*g/M 0 -m2*g/M 0; 0 0 0 1 0 0; 0 0 -((M*g)+(m1*g))/(M*L1) 0 -g*m2/(M*L1) 0; 0 0 0 0 0 1; 0 0 -m1*g/(M*L2) 0 -((M*g)+(m2*g))/(M*L2) 0];
B = [0; 1/M; 0; 1/(L1*M); 0; 1/(L2*M)];

% Define observation matrices
C = {[1 0 0 0 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0], [0 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0], ...
    [1 0 0 0 0 0; 0 0 0 0 1 0; 0 0 0 0 0 0], [1 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0]};

% Initialize array to store ranks
Ranks = zeros(1, numel(C));

% Calculate ranks for each observation matrix
for i = 1:numel(C)
    Ranks(i) = rank([C{i}' A'*C{i}' ((A')^2)*C{i}' ((A')^3)*C{i}' ((A')^4)*C{i}' ((A')^5)*C{i}']);
end

% Display results
disp(Ranks);
