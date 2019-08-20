function mapsclusterikeda(points,epsi,nodes,rho,llav2,u)


directori='/homedtic/mgrau/home_old/RandomForest/savesmaps/Ikeda/';
cd(directori);
name=sprintf('time-series%0.0fstr%0.1fden%0.1fN%0.0fu%0.1f.mat',llav2,epsi,rho,nodes,u);
if exist(name)==0
directori='/homedtic/mgrau/home_old/RandomForest/programs/';
cd(directori);
rng(llav2);
pd = makedist('Normal','mu',1,'sigma',0);
nlinks=1;
N=nodes;
% r=20*rand(N*N)-10;
FeaRRL50=zeros(N,N,2);
FeaRRL200=zeros(N,N,2);
FeaRRL800=zeros(N,N,2);
FeaRRL3200=zeros(N,N,2);
FeaRRL12800=zeros(N,N,2);



problink=rho;
A=rand(N,N);
A=A<problink;
A(1:N+1:end)=0;
r = random(pd,N*N,1);
A=double(A);

eps=zeros(N,N);
for row=1:N
    for colum=1:N
        if A(row,colum) == 1
            eps(row,colum)=r(nlinks);
            nlinks=nlinks+1;
        end
    end
end

x0=rand(1,2*N);
length=points;
x=ikeda_trajectory_coupled(u,x0,length,N,epsi,A);
for kk=1:2
xc=x(:,kk:2:2*N);


for i=1:N
max=51;
% [ranks, weights]=relieff(xc(1:max-1,:),xc(2:max,i),10);
% FeaRRL50(:,i)=weights;
% max=201;
% [ranks, weights]=relieff(xc(1:max-1,:),xc(2:max,i),10);
% FeaRRL200(:,i)=weights;
% max=801;
% [ranks, weights]=relieff(xc(1:max-1,:),xc(2:max,i),10);
% FeaRRL800(:,i)=weights;
% max=3201;
% [ranks, weights]=relieff(xc(1:max-1,:),xc(2:max,i),10);
% FeaRRL3200(:,i)=weights;

[ranks, weights]=relieff(xc(1:end-1,:),xc(2:end,i),10);
FeaRRL12800(:,i,kk)=weights;

end

savedir='/homedtic/mgrau/home_old/RandomForest/savesmaps/Ikeda/';
 %savedir='/Users/mgrau/Documents/PhD/Randomforest/maps/Ikeda/';
 name=sprintf('time-series%0.0fstr%0.1fden%0.1fN%0.0fu%0.1f.mat',llav2,epsi,rho,nodes,u);
 name2=sprintf('time-series%0.0fstr%0.1fden%0.1fN%0.0fu%0.1f.txt',llav2,epsi,rho,nodes,u);
 name3=sprintf('A%0.0fden%0.1fN%0.0f.txt',llav2,rho,nodes);
 save([savedir, name2],'x','-ascii');
 save([savedir, name3],'A','-ascii');
 save([savedir, name ],'A','epsi','x','FeaRRL12800');
end
end


