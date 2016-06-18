% File: GsNt.m
% Name: Alex Golub
% Gauss-Newton method for nonlinear least squares.

% Problem (a)
function[] = GsNt_a()
    format long
    disp('Problem (a)')
    disp(' ')
    disp('Initial Value')
    [x, eps] = Init1();
    nm = 1;
    k = 0;
    disp(' k x1               x2               x3              nm')
    disp(sprintf('%2d %15.12f %15.12f %15.12f %15.12f', k, x(1), x(2), x(3), nm))
    while nm >= eps
       [f Df] = data1(x);
       dx = -((Df.' * Df)^(-1)) * (Df.' * f);
       x = x + dx;
       k = k + 1;
       nm = norm(dx);
       disp(sprintf('%2d %15.12f %15.12f %15.12f %15.12f', k, x(1), x(2), x(3), nm))
    end
    disp('x = ')
    disp(x)
end

% Initial condition
function [x, eps] = Init1()
    x = [-50; 90; 0.05], eps = 10^(-3);
end

% Best least square fit y=x1+x2exp(x3t)
function[f Df] = data1(x)
    f = [x(1) + x(2)*exp(x(3) * 1) - 53.05;
         x(1) + x(2)*exp(x(3) * 6) - 73.04;
         x(1) + x(2)*exp(x(3) * 11) - 98.31;
         x(1) + x(2)*exp(x(3) * 16) - 139.78;
         x(1) + x(2)*exp(x(3) * 21) - 193.48;
         x(1) + x(2)*exp(x(3) * 26) - 260.20;
         x(1) + x(2)*exp(x(3) * 31) - 320.39;];
     
    Df = [1 exp(x(3)) x(2)*exp(x(3));
          1 exp(6*x(3)) 6*x(2)*exp(6*x(3));
          1 exp(11*x(3)) 11*x(2)*exp(11*x(3));
          1 exp(16*x(3)) 16*x(2)*exp(16*x(3));
          1 exp(21*x(3)) 21*x(2)*exp(21*x(3));
          1 exp(26*x(3)) 26*x(2)*exp(26*x(3));
          1 exp(31*x(3)) 31*x(2)*exp(31*x(3));];
end
