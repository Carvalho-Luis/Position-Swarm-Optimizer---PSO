function [enxame, melhor, feval_media]=next_Interaction(enxame, x_min, x_max)

x_n=enxame(:,end-1);
% Evita que indivíduos fora dos limites predeterminados no inicio do código
for j=1:1:size(x_n,1)
    if x_n(j)>=x_max, x_n(j)=x_max; end 
    if x_n(j)<=x_min, x_n(j)=x_min; end 
end
feval_n=x_n.*sin(10*pi.*x_n)+1;
enxame = [x_n feval_n];


%% erro
feval_pior=min(enxame(:,end));   % Pior Fitness
feval_media=mean(enxame(:,end)); % Fitness médio
feval_melhor=max(enxame(:,end)); % Melhor Fitness

n_melhor=find(enxame(:,end)==feval_melhor); % Melhor Fitness
melhor=enxame(n_melhor(1),:); % Melhor indivíduo