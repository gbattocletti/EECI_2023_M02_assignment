function plot_error(X,R,varargin)
% PLOT_ERROR  Plot the distance of X from reference R, in log scale.
%
%   Author: Nicola Bastianello


K = size(X,2); % number of nodes and iterations
ln_width = 1.5; % line width


figure('Units', 'centimeters','Position',[0 0 25 10]);

hold on
box on
grid on

% compute error
e = zeros(1,K); % distance from reference

for k = 1:K

    e(k) = norm(X(:,k)-R);

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
