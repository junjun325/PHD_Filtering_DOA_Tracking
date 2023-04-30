 function dEVD= MDL_method(model,Rxx,Zk)
%======================= MDL method ==============================
%         [Ke,N]=size(xt);
%         Rx = (xt*xt')./T;
         K=10; % Number of antenna 
         [Ke,N]=size(Zk);
        [u,s,v] = svd(Rxx);
        sd = diag(s);
        a = zeros(1,K);
        for m = 0:K-1
            negv = sd(m+1:K);
            Tsph = mean(negv)/((prod(negv))^(1/(Ke-m)));
            a(m+1) = model.v*(K-m)*log(Tsph) + m*(2*K-m)*log(model.v)/2;
        end
        [y,b] = min(a);
        dEVD = b - 1;