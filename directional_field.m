function [X, Y, U, V] = directional_field(differential_equation, sq_min, sq_max, n_steps)
%DIRECTIONAL_FIELD Summary of this function goes here
%   Detailed explanation goes here

    if nargin < 4
        n_steps = 25;
        if nargin < 3
            sq_max = 10;
            if nargin < 2
                sq_min = -10;
            end
        end
    end
        
    x = linspace(sq_min, sq_max, n_steps);
    y = linspace(sq_min, sq_max, n_steps);
    
    
    
    [X, Y] = meshgrid(x, y);
    U = ones(size(X)); % Horizontal component of the slope vector
    V = differential_equation(X, Y);
    
    
    
    norm = sqrt(1 + V.^2);
    
    U = U./norm;
    V = V./norm;
    alpha = atan2(V, U);
    
    %quiver(X, Y, U, V, .45);
    %axis square tight
    %set(gcf, 'color', 'k')
    %set(gca, 'color', 'k')
          
        
    
    
    
    
    %% Let's make it so that the color of each vector changes based on the direction that it's pointing!
    theta = linspace(-pi, pi, 257);
    my_map = jet; %256 by 3 matrix, so let's make 256 different angles.
    theta_count = [ones(257,1) theta'];
    
    figure
    set(gcf, 'color', 'k')
    
    hold on
    colormap(my_map)
    scale = 0.5;
    
    for ii = 1:256
        this_color = my_map(ii,:);       
        id = and(alpha >= theta(ii), alpha < theta(ii + 1));
        %count = sum(id, 'all');
        %prop = count/(21*21);
        q = quiver(X(id), Y(id), U(id)*scale, V(id)*scale, 0);
        set(q, 'color', this_color);
        theta_count(ii, 1) = sum(id, 'all');
    end
    
    ax = gca;
    set(ax, 'color', 'k')
    set(ax, 'xcolor', my_map(128,:))
    set(ax, 'ycolor', my_map(128,:))
    
    
    f_char = char(differential_equation);
    f_name = f_char(7:end);
    f_name = strcat("$\frac{dy}{dx} = ", f_name, "$");
           
    title(f_name, 'interpreter', 'latex')
    xlabel('x', 'interpreter', 'latex')
    ylabel('y', 'interpreter', 'latex')
    
    ax.Title.Color = my_map(128,:);
    ax.TitleFontSizeMultiplier = 1.4;
    
    axis square tight
    %colorbar
    hold off
    
    
    
    
    
    %figure
    %bar(theta_count(:,2), theta_count(:,1))

end

