function [ set ] = basic_set( )
%训练参数
set.pre_len = 5;
set.init_lr = 0.0000152;
set.decease_rate = 0.97;
set.confirm_rounds =30;
set.max_confirm_rounds=5000;
set.groups = 30;
set.folds_num = 5;
set.noise = 0.00;
set.show_img_freq = 400;
set.save_freq = 500;
set.step_mode = 0; %0 普通 1输入输出异步 2节点异步 3随机更替
if mod(set.groups,set.folds_num)
    fprintf('\n【提示】切分的序列数（set.groups)不是交叉验证组数（set.folds_num)的整数倍，可能会出现问题。\n');
    pause;
end;
%网络结构
set.nodes = 30;
set.type = 1;%0: rnn, 1, lstm
set.peephole = 1;

end

