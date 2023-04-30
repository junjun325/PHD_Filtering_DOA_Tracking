
function X= gen_newstate_fn(model,Xd,V)

if ~isnumeric(V)
    if strcmp(V,'noise')
        V= model.B*randn(1,size(Xd,2))* model.Bv;
    elseif strcmp(V,'noiseless')
        V= zeros(size(model.B,1),size(Xd,2));
    end
end

if isempty(Xd)
        X= [];
else 

    X= model.H*Xd+ V ; 
end