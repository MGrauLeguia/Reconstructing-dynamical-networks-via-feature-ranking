function [X] = ikeda_trajectory_coupled(u,x0,L,N,epsi,A)
%%%% Number of nodes N
%%%% L points
%%%% 
    X = zeros(L,2*N);
    X(1,:) = x0;
    dx=zeros(2,N);
    
    for n = 2:L
        cont=0;
        for node = 1:2:2*N
        cont=cont+1;
        d=sum(A(:,cont));
        t = 0.4 - 6/(1 + X(n-1,node)^2 + X(n-1,node+1)^2);
        a=1 + u*(X(n-1,node)*cos(t) - X(n-1,node+1)*sin(t));
        b=u*(X(n-1,node)*sin(t) + X(n-1,node+1)*cos(t));
        if d==0
        dx(:,cont)=[a;b];
        else
        dx(:,cont) = [(1-epsi)*a+(epsi)*X(n-1,1:2:end)*((1/d)*A(:,cont));(1-epsi)*b+X(n-1,2:2:end)*epsi*((1/d)*A(:,cont))];
        end
        end
        z=reshape(dx,[],1);
        X(n,:) = z;
    end
    
end