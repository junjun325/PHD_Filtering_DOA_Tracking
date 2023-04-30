function SP= compute_likelihood_MUSIC_coprime_PHD(model,X,EV,r)

theta = X(1,:); % 
EV1=EV(:,2:end);
En=EV1;
nspace = En*En';
M = model.M;
N = model.N;
DOF = M*N+M-1;
d0 = 0:DOF;
%MUSIC
for i = 1:size(theta,2)
    a=exp(-j*model.twpi*d0*sin(theta(i)*model.derad)).';
    SP(i)=1/(a'*nspace*a);
end
  SP=abs(SP).^r;




