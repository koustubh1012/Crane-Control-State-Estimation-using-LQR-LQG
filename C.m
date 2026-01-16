syms m1 g m2 M L1 L2
A = [0 1 0 0 0 0; 0 0 -m1*g/M 0 -m2*g/M 0; 0 0 0 1 0 0; 0 0 -((M*g)+(m1*g))/(M*L1) 0 -g*m2/(M*L1) 0; 0 0 0 0 0 1; 0 0 -m1*g/(M*L2) 0 -((M*g)+(m2*g))/(M*L2) 0];
B = [0; 1/M; 0; 1/(L1*M); 0; 1/(L2*M)];
n = 6; 
Mc = sym(zeros(size(A, 1), n*size(B, 2))); 

for i = 1:n
    Mc(:, (i-1)*size(B, 2)+1:i*size(B, 2)) = A^(i-1) * B;
end

disp('Controllability matrix Mc:');
disp(Mc);

% Rank calculation
Rank = rank([B A*B (A^2)*B (A^3)*B (A^4)*B (A^5)*B]);
disp('Rank:');
disp(Rank);

% Determinant calculation
d = det([B A*B (A^2)*B (A^3)*B (A^4)*B (A^5)*B]);
disp('Determinant:');
disp(d);
