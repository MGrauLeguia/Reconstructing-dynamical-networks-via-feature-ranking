function mapscluster(points,epsi,nodes,rho,llav2)
%%%
%%% Function to compute RreliefF from coupled logistic maps
%%% It saves the scores of the RreliefF,the time series of the maps and the
%%% adjacency matrix
%%%
%%% points= max length from we will compute RreliefF
%%% epsi = coupling strength between maps (\epsilon in the paper)
%%% nodes = number of nodes in the network
%%% rho = link density of the random network
%%% llav2=seed for replication
%%%
%%%
%%% Place where you want to save your data%%%%%%%%%%%%

directori='/homedtic/mgrau/home_old/RandomForest/savesmaps/Paper/';
cd(directori);
%%%%%%%%Check if data is already there%%%%%%%%%%%%%%%%%

name=sprintf('time-series%0.0fstr%0.1fden%0.1f%0.0f.mat',llav2,epsi,rho,nodes);
if exist(name)==0
    
rng(llav2);
nlinks=1;
N=nodes;
%%%% distribution of epsilons if it is wanted
% pd = makedist('Normal','mu',1,'sigma',0);
% r = random(pd,N*N,1);

%Matrices of the scores
FeaRRL50=zeros(N,N);
FeaRRL200=zeros(N,N);
FeaRRL800=zeros(N,N);
FeaRRL3200=zeros(N,N);
FeaRRL12800=zeros(N,N);


%adjacency matrix
problink=rho;
A=rand(N,N);
A=A<problink;
A(1:N+1:end)=0;
A=double(A);

% random initial conditions inicialitation of logistic
x0=rand(1,N);
length=points;
x=zeros(length+1,N);
x(1,:)=x0;
re=4;
%%%loop of the maps
for i=1:length
    for j=1:N
     
     d=sum(A(:,j));

     if d==0
        
     x(i+1,j)=(1)*(re*x(i,j)*(1-x(i,j)));
     else
     
     x(i+1,j)=(1-epsi)*(re*x(i,j)*(1-x(i,j)))+(epsi)*((1/d)*A(:,j)')*((re*x(i,:)).*(1-x(i,:)))';
    end
    end


end

%%% compute the ranks
for i=1:N
max=51;
[ranks, weights]=relieff(x(1:max-1,:),x(2:max,i),10);
FeaRRL50(:,i)=weights;
max=201;
[ranks, weights]=relieff(x(1:max-1,:),x(2:max,i),10);
FeaRRL200(:,i)=weights;
max=801;
[ranks, weights]=relieff(x(1:max-1,:),x(2:max,i),10);
FeaRRL800(:,i)=weights;
max=3201;
[ranks, weights]=relieff(x(1:max-1,:),x(2:max,i),10);
FeaRRL3200(:,i)=weights;

[ranks, weights]=relieff(x(1:end-1,:),x(2:end,i),10);
FeaRRL12800(:,i)=weights;

end
%%%%%%save the ranks%%%%%%%%%%

%  savedir=''; Put your own path 
%  name=sprintf('time-series%0.0fstr%0.1fden%0.1fN%0.0f.mat',llav2,epsi,rho,nodes);
%  name2=sprintf('time-series%0.0fstr%0.1fden%0.1fN%0.0f.txt',llav2,epsi,rho,nodes);
%  name3=sprintf('A%0.0fden%0.1fN%0.0f.txt',llav2,rho,nodes);
%  save([savedir, name2],'x','-ascii');
%  save([savedir, name3],'A','-ascii');
%  save([savedir, name ],'A','epsi','x','FeaRRL50','FeaRRL200','FeaRRL800','FeaRRL3200','FeaRRL12800');
end
end


