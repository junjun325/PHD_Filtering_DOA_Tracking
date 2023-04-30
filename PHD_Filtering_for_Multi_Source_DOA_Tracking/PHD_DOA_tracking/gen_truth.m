function truth= gen_truth(model)

%variables
truth.K= 50;                   %length of data/number of scans
truth.X= cell(truth.K,1);             %ground truth for states of targets  
truth.N= zeros(truth.K,1);            %ground truth for number of targets
truth.track_list= cell(truth.K,1);    %absolute index target identities (plotting)
truth.total_tracks= 0;          %total number of appearing tracks

%target initial states and birth/death times
nbirths=4;
 xstart(:,1)  = [-60;2];   tbirth(1)  = 1;    tdeath(1)  = 30;
 xstart(:,2)  = [40;-3];    tbirth(2)  = 5;    tdeath(2)  = 35;
 xstart(:,3)  = [50;-1];   tbirth(3)  = 15;     tdeath(3)  =40;
 xstart(:,4)  = [80;-1.5];   tbirth(4)  = 25;     tdeath(4)  = 50;


%generate the tracks
for targetnum=1:nbirths
    targetstate = xstart(:,targetnum);
    for k=tbirth(targetnum):min(tdeath(targetnum),truth.K)
        targetstate = gen_newstate_fn(model,targetstate,'noiseless');
        truth.X{k}= [truth.X{k} targetstate];
        truth.track_list{k} = [truth.track_list{k} targetnum];
        truth.N(k) = truth.N(k) + 1;
     end
end
truth.total_tracks= nbirths;

