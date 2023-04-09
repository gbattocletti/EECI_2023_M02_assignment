function plot_results(X,R,varargin)
% PLOT_RESULTS  Plot the states' evolution.
%   PLOT_RESULTS(x,R) plots 1) the states evolutions, represented by the
%   rows of X, and the reference R, 2) the evolution of the error, computed
%   as the distance from the reference; T is the title of the figures. In
%   varargin enter the name of the file to save the plot to, if not
%   specified the figure is not saved.
%
%   Author: Nicola Bastianello


[N,K] = size(X); % number of nodes and iterations
ln_width = 1.5; % line width

%% states trajectories
figure('Units', 'centimeters','Position',[0 0 25 10]);

subplot(1,2,1)
hold on
box on
grid on

% plot nodes' states
for i = 1:N

    plot(0:K-1,X(i,:),'LineWidth',ln_width)

end

% plot reference
plot(0:K-1,R*ones(K,1),'k--','LineWidth',ln_width)

xlabel('Iteration','Interpreter','latex')
ylabel('Nodes states','Interpreter','latex')
if nargin == 3
    title(varargin{1},'Interpreter','latex')
end
hold off

if nargin == 4
    filePath = strcat(varargin{2},'_state');
    print('-dpdf','-r200',filePath)
    system(strcat('pdfcrop --noverbose ./',filePath,'.pdf ./',filePath,'.pdf'));
end

%% error

subplot(1,2,2)
hold on
box on
grid on

% compute error
e = zeros(1,K); % distance from reference

for k = 1:K

    e(k) = norm(X(:,k)-R*ones(N,1));

end

plot(0:K-1,log(e),'LineWidth',ln_width)

xlabel('Iteration','Interpreter','latex')
ylabel('Error','Interpreter','latex')
if nargin == 3
    title(varargin{1},'Interpreter','latex')
end

if nargin == 4
    filePath = strcat(varargin{1},'_error');
    print('-dpdf','-r200',filePath)
    system(strcat('pdfcrop --noverbose ./',filePath,'.pdf ./',filePath,'.pdf'));
end

end
