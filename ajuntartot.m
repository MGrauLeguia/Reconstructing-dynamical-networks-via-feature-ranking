clear all
directori='/Users/mgrau/Desktop/RandomForest/saves/maps';
cd(directori);
cont=0;
cont2=0;
N=6;
indexes=[22,23,26,31,34,35,36,42,43,45,46,54,57,61,62,65,66,67,69,71,73,74,75,77,84,85,86,89,91,97,100,102,104,108,111,112,125,128,129,131,135,138,140];
Ni=length(indexes);
 for epsi=0.2:0.1:0.4
     cont=0;
     cont2=cont2+1;
 for num=1:Ni
         seed=indexes(num);
         cont=cont+1;
 name=sprintf('time-series%0.0fstr%0.1f.mat',seed,epsi);
 load(name)
 NLink(num)=sum(reshape(A,[],1));
 Fea=zeros(N,N,1);
 for reset=0:0
 name2=sprintf('Afea%0.0fstr%0.1frs%0.0f.txt',seed,epsi,reset);
 Fea(:,:,reset+1)=load(name2);
 end
 
 Feam=mean(Fea,3);
 Av=reshape(A,[],1);
 Feamv=reshape(Feam,[],1);
 [a,b,c,AUC]=perfcurve(Av,Feamv,'1');
 Av(1:N+1:end)=[];
 Feamv(1:N+1:end)=[];
 [a2,b2,c2,AUC2]=perfcurve(Av,Feamv,'1');
 Bo(:,cont,cont2)=[AUC AUC2 Sol];
     end
 end
 
figure;plot(squeeze(Bo(5,:,1)),squeeze(Bo(1,:,1)),'*');
hold on
plot(squeeze(Bo(5,:,2)),squeeze(Bo(1,:,2)),'*');
hold on
plot(squeeze(Bo(5,:,3)),squeeze(Bo(1,:,3)),'*g');
figure;plot(squeeze(Bo(5,:,1)),squeeze(Bo(2,:,1)),'*');
hold on
plot(squeeze(Bo(5,:,2)),squeeze(Bo(2,:,2)),'*');
hold on
plot(squeeze(Bo(5,:,3)),squeeze(Bo(2,:,3)),'*g');
%  save([savedir, name ], 'Sol','A','epsi','x');