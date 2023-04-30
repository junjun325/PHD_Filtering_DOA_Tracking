function model= gen_model

% basic parameters
model.x_dim= 2;   %dimension of state vector
model.z_dim= 8;   %dimension of observation vector
model.v_dim= 2;   %dimension of process noise
model.w_dim= 2;   %dimension of observation noise
model.twpi = pi;
model.T= 1;                         %sampling period
model.B= [model.T^2/2;model.T];
model.Bv=0.01;
model.H=[1 model.T;0 1];
model.derad = pi/180;
model.R=2;

model.kelm = 10;               % 
model.dd = 0.5;                %%  
model.twpi = 2*pi;
model.omiga = model.twpi*1e8;  % w/2pi = 100MHz
model.derad = pi/180; 
model.d2=0:model.dd:(model.kelm-1)*model.dd;     %  


model.P_S= .99;
model.Q_S= 1-model.P_S;

model.T_birth= 4;         %no. of LMB birth terms
model.L_birth= 1; 
model.w_birth(1)=0.02;                                                          %prob of birth                                                     %weight of Gaussians - must be column_vector
model.m_birth(:,1)= [-50;0];                                 %mean of Gaussians
model.B_birth(:,:,1)= diag([ 4;2]);                  %std of Gaussians
model.P_birth(:,:,1)= model.B_birth(:,:,1)*model.B_birth(:,:,1)';      %cov of Gaussians
                                                        %no of Gaussians in birth term 2
model.w_birth(2)=0.02;                                                          %prob of birth                                                    %weight of Gaussians - must be column_vector
model.m_birth(:,2)= [40;0];                                 %mean of Gaussians
model.B_birth(:,:,2)= diag([ 4;2]);                  %std of Gaussians
model.P_birth(:,:,2)= model.B_birth(:,:,2)*model.B_birth(:,:,2)';      %cov of Gaussians

                                                      %no of Gaussians in birth term 3
model.w_birth(3)=0.03;                                                          %prob of birth                                                      %weight of Gaussians - must be column_vector
model.m_birth(:,3)= [80;0];                                   %mean of Gaussians
model.B_birth(:,:,3)= diag([4;2]);                 %std of Gaussians
model.P_birth(:,:,3)= model.B_birth(:,:,3)*model.B_birth(:,:,3)';      %cov of Gaussians

 model.w_birth(4)= 0.03;                                                       %weight of Gaussians - must be column_vector
model.m_birth(:,4)= [-60;0];                                 %mean of Gaussians
model.B_birth(:,:,4)= diag([ 4;2]);                 %std of Gaussians
model.P_birth(:,:,4)= model.B_birth(:,:,4)*model.B_birth(:,:,4)';      %cov of Gaussians


% observation model parameters (noisy r/theta only)
% measurement transformation given by gen_observation_fn, observation matrix is N/A in non-linear case

% detection parameters
model.P_D= .98;   %probability of detection in measurements
model.Q_D= 1-model.P_D; %probability of missed detection in measurements

