function handles= plot_results_new(truth,meas,est)

[X_track,k_birth,k_death]= extract_tracks(truth.X,truth.track_list,truth.total_tracks);


%plot ground truths
% figure;
truths= gcf; hold on;
%plot x measurement
for i=1:truth.total_tracks
    Px= X_track(:,k_birth(i):1:k_death(i),i); Px=Px(1,:);
    hline1= line(k_birth(i):1:k_death(i),Px(1,:),'LineStyle','-','Marker','none','LineWidth',1,'Color',0*ones(1,3));
end

% plot x estimate
for k=1:meas.K
    if ~isempty(est.X{k})
        P= est.X{k}(1,:);
        hline2= line(k*ones(size(est.X{k},2),1),P(1,:),'LineStyle','none','Marker','*','Markersize',4,'Color','b');
    end
end
xlabel('time(s)'); ylabel('DOA(бу)');box on;
set(gca, 'YLim',[-90 90]);
legend([ hline1,hline2], 'True tracks','PHD-CA(DOA-tracking)');
handles=1;

function [X_track,k_birth,k_death]= extract_tracks(X,track_list,total_tracks)

K= size(X,1);
x_dim= size(X{K},1);
k=K-1; while x_dim==0, x_dim= size(X{k},1); k= k-1; end;
X_track= zeros(x_dim,K,total_tracks);
k_birth= zeros(total_tracks,1);
k_death= zeros(total_tracks,1);

max_idx= 0;
for k=1:K
    if ~isempty(X{k})
        X_track(:,k,track_list{k})= X{k};
    end
    if max(track_list{k})> max_idx %new target born?
        idx= find(track_list{k}> max_idx);
        k_birth(track_list{k}(idx))= k;
    end
    if ~isempty(track_list{k}), max_idx= max(track_list{k}); end
    k_death(track_list{k})= k;
end