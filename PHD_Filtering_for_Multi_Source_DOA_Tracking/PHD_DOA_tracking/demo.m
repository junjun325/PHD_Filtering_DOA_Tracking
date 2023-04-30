% J. Zhao, R. Gui and X. Dong, "PHD Filtering for Multi-Source DOA Tracking With Extended Co-Prime Array: An Improved MUSIC Pseudo-Likelihood,"
% in IEEE Communications Letters, vol. 25, no. 10, pp. 3267-3271, Oct. 2021.
% doi: 10.1109/LCOMM.2021.3099569.

close all;clear;clc;
tic
model = gen_model;
model.M = 3;
model.N =5;
model.twpi = pi;
model.v = 200;
model.SNR = 10;
truth= gen_truth(model);
meas=  gen_meas1(model,truth);
r=10;
est1=   run_filterPHD(model,meas,r);
handl1= plot_results_new(truth,meas,est1);
