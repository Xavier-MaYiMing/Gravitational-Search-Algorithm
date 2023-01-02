clear all;
clc;

pop = 50;
iter = 1000;
lb = ones(1, 30) .* (-100);
ub = ones(1, 30) .* 100;
[gbest, gbest_pos, iter_best, con_iter] = GSA(pop, iter, lb, ub);

% Plot the convergence curve
x = 1 : iter;
loglog(x, iter_best);
grid on;
title('Convergence curve');
xlabel('Iteration');
ylabel('Objective value');