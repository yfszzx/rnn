function [ set ] = basic_set( )
%ѵ������
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
set.step_mode = 0; %0 ��ͨ 1��������첽 2�ڵ��첽 3�������
if mod(set.groups,set.folds_num)
    fprintf('\n����ʾ���зֵ���������set.groups)���ǽ�����֤������set.folds_num)�������������ܻ�������⡣\n');
    pause;
end;
%����ṹ
set.nodes = 30;
set.type = 1;%0: rnn, 1, lstm
set.peephole = 1;

end

