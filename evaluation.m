function [G_best]=evaluation(enxame)
%% Fun��o de avalia��o

feval_melhor=max(enxame(:,end));            % Melhor Fitness
n_melhor=find(enxame(:,end)==feval_melhor); % Endere�o do Melhor Fitness
G_best=enxame(n_melhor(1),end-1);
Best_I=enxame(n_melhor(1),:);
