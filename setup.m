% Run this script to setup all the necessary paths

% Adding all folders
addpath approaches;
addpath AR_realisations;
addpath figs;
addpath outputs;
addpath package_emd;
addpath real_ts;
addpath simulated_ts;
addpath simulated_ts/simfuns;
addpath thresholds;
addpath utils;

% Installing the EMD package
install_emd;

savepath;