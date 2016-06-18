% File: romberg.m
% Name: Alex Golub
% Romberg method for numerical integration

function [] = romberg()
    format long
    [f, a, b, n] = data1();
    h=(b-a)./(2.^(0:n-1));
    r(1,1)=(b-a)*(f(a)+f(b))/2;
    for j=2:n
        subtotal = 0;
        for i=1:2^(j-2)
            subtotal = subtotal + f(a+(2*i-1)*h(j));
        end
        r(j,1) = r(j-1,1)/2+h(j)*subtotal;
        for k=2:j
            r(j,k)=(4^(k-1)*r(j,k-1)-r(j-1,k-1))/(4^(k-1)-1);
        end
    end
    disp(r)
end

% Initial data
function [f, a, b, n] = data1()
    f = @f;							% Which function to integrate
    a = 0;							% Lower boundary
    b = 2*sqrt(3);					% Upper boundary
    n = 4;							% Number of steps
end

% function f=1/sqrt(x^2+4)
function[f] = f(x)
    f = 1/sqrt(x^2+4);
end
