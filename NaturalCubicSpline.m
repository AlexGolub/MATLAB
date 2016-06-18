% File: NaturalCubicSpline.m
% Alex Golub

% Calculate coeficients of a cubic spline
function coeff = splinecoeff ()
    [x,y] = data;
    
    n = length(x);
    
    A = zeros(n,n);        % matrix A
    r = zeros(n,1);
    
    % define deltas
    for i=1:n-1             
        dx(i) = x(i+1)-x(i); dy(i)=y(i+1)-y(i);
    end
    
    % load the A matrix
    for i = 2 : n - 1
        A(i, i-1:i+1) = [dx(i-1) 2*(dx(i-1)+dx(i)) dx(i)];
        r(i) = 3*(dy(i)/dx(i)-dy(i-1)/dx(i-1));
    end
    
    % Set endpoint conditions
    A(1,1) = 1;         % natural spline conditions
    A(n,n) = 1;

    coeff = zeros(n,3);
    coeff(:,2) = A\r;       % solve for c coefficients
    
    for i=1:n-1             % solve for b and d
        coeff(i,3) = (coeff(i+1,2) - coeff(i,2))/(3*dx(i));
        coeff(i,1) = dy(i)/dx(i)-dx(i)*(2*coeff(i,2) + coeff(i+1,2))/3;
    end
    
    coeff=coeff(1:n-1,1:3);

    % Print out the coefficient table
    disp(' k           y              b               c               d')
    
    for i=1:n-1
       disp(sprintf('%2d   %15.5f %15.5f %15.5f %15.5f', i, y(i), coeff(i,1), coeff(i,2), coeff(i,3)))
    end
    
    % Cubic spline plot
    
    % Number of plotted points
    k=99;
    
    x1 = [];
    y1 = [];
    for i=1:n-1
        xs = linspace(x(i),x(i+1),k+1);
        dx = xs - x(i);
        ys = coeff(i,3)*dx;
        ys = (ys + coeff(i,2)).*dx;
        ys = (ys + coeff(i,1)).*dx + y(i);
        x1 = [x1; xs(1:k)'];
        y1 = [y1; ys(1:k)'];
    end
    x1 = [x1; x(end)];
    y1 = [y1;y(end)];
    plot(x,y,'o',x1,y1)
end
    

function [x,y] = data()
    x = [0 1 2];
    y = [3 -2  1];
end


