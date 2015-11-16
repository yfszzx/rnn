function main
clc;
clear all;
addpath('prepare');
addpath('perc');
addpath('lstm');
set = basic_set( );
[ trn, test] = load_data(0,1,[1:6,8:10],0);
%trn = load_min_data();
idx = 1;
while 1
    [rnn_bagging{idx}]= rnn_main(trn,set);
    rnn_bagging{idx}.valid = valid;
    if ~exist('Y')
        Y=valid.Y;
        T=valid.T;
    else
        Y=Y+valid.Y;
    end;
    idx = idx + 1;
    save rnn_mat rnn_bagging Y T idx;
end
