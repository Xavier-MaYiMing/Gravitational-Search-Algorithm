### Gravitational Search Algorithm

##### Reference: Rashedi E, Nezamabadi-Pour H, Saryazdi S. GSA: a gravitational search algorithm[J]. Information Sciences, 2009, 179(13): 2232-2248.

| Variables | Meaning                                           |
| --------- | ------------------------------------------------- |
| pop       | Population size                                   |
| iter      | Iteration number                                  |
| lb        | The lower bound (list)                            |
| ub        | The upper bound (list)                            |
| pos       | The position of agents (list)                     |
| score     | The score of agents (list)                        |
| mass      | The mass of agents (list)                         |
| acc       | The acceleration of agents (list)                 |
| vel       | The velocity of agents (list)                     |
| G         | The gravitational constant                        |
| dim       | Dimension                                         |
| gbest     | The score of the global best agent                |
| iter_best | The global best score of each iteration (list)    |
| con_iter  | The last iteration number when "gbest" is updated |

#### Test problem

$$
f(x)=\sum_{i=1}^{30}x_i^2,\qquad -100\leq x_i\leq100, \quad
i=1,\cdots, 30.
$$


#### Example

```matlab
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
```

##### Output:

![convergence curve](C:\Users\dell\Desktop\研究生\个人算法主页\Gravitational Search Algorithm\convergence curve.jpg)

The GSA converges at its 999-th iteration, and the global best value is 2.1691e-17.
