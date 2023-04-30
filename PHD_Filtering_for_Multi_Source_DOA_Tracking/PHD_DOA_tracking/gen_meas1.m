function meas= gen_meas1(model,truth)

%variables
meas.K= truth.K;
meas.Z= cell(truth.K,1);

%generate measurements
for k=1:truth.K
    %--------------extended co-prime array---------------%
    X = truth.X{k};
    K = size(X,2);
    M = model.M;
    N = model.N;
    d1 = (0:N-1)*M;
    d2 = (0:2*M-1)*N;
    model.d  = sort(unique([d1,d2]));
    twpi=model.twpi;
    L = model.v;
    theta = X(1,:);
    A = exp(-j*twpi*model.d.'*sin(theta*pi/180));
    S = randn(K,L);
    X1=A*S;
    Zk = awgn(X1,model.SNR,'measured');
    Rxx=Zk*Zk'/L;
    %%%%%MDL is used to estimate the number of information sources%%%%%%%%%%%%%
    K= MDL_method(model,Rxx,Zk);
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    H = size(model.d,2);
    z = reshape(Rxx,H*H,1);
    D = [];
    for i = 1:H
        for ii = 1:H
            D(i,ii) = model.d(i)-model.d(ii);
        end
    end
    Dv=reshape(D,H*H,1);

    c = 0;
    DOF = M*N+M-1;
    for i = -DOF:DOF
        c = c+1;
        vir_pos = find(Dv==i);
        zt(c,1) = mean(z(vir_pos));
    end
    Rz = zeros(DOF+1,DOF+1);
    %%%%%Toeplitz Matrix reconstruction%%%%
    L1 = DOF+1;
    for t = 1:L1
        for i = 1:L1
            Rz(i,t) = zt(i+L1-t);
        end
    end
    [V,value] = svd(Rz);
    value = diag(value);
    signal = [ ];
    for i=1:K
        Rxx1=V(:,i)*value(i)*V(:,i)';
        [EVV,DD]=svd(Rxx1);
        signal(:,:,i)=EVV;
    end
    meas.ZSSP{k}=zt;
    meas.Z{k}=Zk;
    meas.EVt{k}=signal;
    meas.sources_number{k}=K;
    meas.TopZ{k}=Rz;
    meas.ZZ{k}=zt;
    meas.DOF{k}=DOF;
end

