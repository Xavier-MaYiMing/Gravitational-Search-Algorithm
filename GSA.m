% @Time    : 2023/1/2 7:33
% @Author  : Xavier Ma
% @Email   : xavier_mayiming@163.com
% @File    : GSA.m
% @Statement : Gravitational Search Algorithm
% @Reference : Rashedi E, Nezamabadi-Pour H, Saryazdi S. GSA: a gravitational search algorithm[J]. Information Sciences, 2009, 179(13): 2232-2248.
function [gbest, gbest_pos, iter_best, con_iter] = GSA(pop, iter, lb, ub)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %param pop: population size
    %param iter: the maximum number of iterations
    %param lb: the lower bound (list)
    %param ub: the upper bound (list)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Step 1. Initialization
    dim = length(lb);  % dimension
    pos = zeros(pop, dim);  % the position of agents
    vel = zeros(pop, dim);  % the velocity of agents
    for i = 1 : dim
        pos(:, i) = rand(pop, 1) .* (ub(i) - lb(i)) + lb(i);
    end
    gbest = 1e10;
    gbest_pos = zeros(pop, 1);
    iter_best = zeros(iter, 1);
    con_iter = 0;
    
    % Step 2. The main loop
    for t = 1 : iter
        % Step 2.1. Boundary check
        score = zeros(pop, 1);
        for i = 1 : pop
            up = pos(i, : ) > ub;
            low = pos(i, : ) < lb;
            pos(i, : ) = pos(i, : ) .* (~(up + low)) + (rand(1, dim) .* (ub - lb) + lb) .* (up + low);
            score(i) = obj(pos(i, : ));
            if score(i) < gbest
                gbest = score(i);
                con_iter = t;
                gbest_pos = pos(i, : );
            end
        end

        % Step 2.2. Calculate mass
        min_score = min(score);
        max_score = max(score);
        iter_best(t) = gbest;
        mass = (score - max_score) ./ (min_score - max_score);
        mass = mass ./ sum(mass);

        
        % Step 2.3. Calculate gravitational constant
        alpha = 20;
        G0 = 100;
        G = G0 * exp(-alpha * t / iter);
        
        % Step 2.4. Calculate acceleration
        kbest = round((2 + (1 - t / iter) * 98) * pop / 100);
        [~, sorted_index] = sort(mass, 'descend');
        acc = zeros(pop, dim);  % the acceleration of agents
        for i = 1 : pop
            for j = 1 : kbest
                ind = sorted_index(j);
                if ind ~= i
                    R = norm(pos(i, : ) - pos(ind, : ), 2);
                    for k = 1 : dim
                         acc(i, k) = acc(i, k) + rand * mass(ind) * (pos(ind, k) - pos(i, k)) / (R + eps);
                    end
                end
            end
        end
        acc = acc .* G;
         
        % Step 2.5. Update position
        vel = rand(pop, dim) .* vel + acc;  % the velocity of agents
        pos = pos + vel;
    end
end