function [A,L, pos] = random_graph(N,R,varargin)
% RANDOM_GRAPH  Build a random geometric graph.
%   [A,L] = RANDOM_GRAPH(N,R) generates a random geometric graph with N
%   nodes and radius R. Outputs the adjacency matrix A and the Laplacian L.
%   Setting the third, optional argument to 'true' will provide a plot of
%   the graph as well.
%
%   Author: Nicola Bastianello


% adjacency matrix
flag = true;
while(flag)
    
    % generate random positions on the plane, with x and y in (0,1)
    pos = rand(N,2);
    
    % compute distances between all nodes, along x and y
    II = ones(N,1);
    X = pos(:,1)*II' - II*pos(:,1)';
    Y = pos(:,1)*II' - II*pos(:,1)';
    
    % compute distances
    dist = sqrt(X.^2 + Y.^2);
    
    % two nodes are neighbors if they are closer than radius
    A = dist <= R;
    
    % if the graph is connected conclude, otherwise try a new graph
    flag = ~all(all(A^N));
    
end

A = A - diag(diag(A)); % remove self-loops

% Laplacian matrix
D = sum(A,2); % nodes degrees
L = diag(D) - A;


% plot the graph if required
if nargin == 3 && varargin{1} == true
    
    G = graph(A); % create graph object
    
    figure
    h = plot(G);
    
    % set position of nodes
    h.XData = pos(:,1);
    h.YData = pos(:,2);
    
    xlim([-0.1 1.1])
    ylim([-0.1 1.1])
    title('Communication graph','Interpreter','latex')
    
end

end