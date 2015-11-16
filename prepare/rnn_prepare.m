function [rnn, data] = rnn_prepare( X, T, set)

%切分序列，初始化数据
data = cut_serial( X, T,  set.groups, set.pre_len );
data.folds_groups =  set.groups/set.folds_num;
set.train_len = data.train_len;
data.stats = zeros(set.groups, set.nodes, set.train_len);
if set.type == 1
    data.g = zeros(set.groups, set.nodes, set.train_len);
    data.mem = zeros(set.groups, set.nodes, set.train_len); 
    data.i = zeros(set.groups, set.nodes, set.train_len);
    data.f = zeros(set.groups, set.nodes, set.train_len);
    data.o = zeros(set.groups, set.nodes, set.train_len);
end

%初始化网络，并设置folds
rnn.input_num = size(X, 2) ;
rnn.output_num = size(T, 2);
rnn.nodes = set.nodes;
rnn.folds_num = set.folds_num;
rnn.type = set.type;
tmp = rnn;
rnn.body = {};

for i = 1:set.folds_num   
    t = tmp;
    t.percO.f = 0;
    t.percO.W = (rand(rnn.nodes + 1, rnn.output_num) * 2 -1)/1000;
    t.grads.out = zeros(rnn.nodes + 1, rnn.output_num);  
    switch rnn.type
        case 1
            t.peephole = set.peephole;
            t.cell.g.W = (rand(rnn.input_num + rnn.nodes +1, rnn.nodes) * 2 -1)/1000;
            t.grads.g = zeros(rnn.input_num + rnn.nodes +1, rnn.nodes);
            t.cell.g.f = 1; %2tanh
            ipt_num  = rnn.input_num + rnn.nodes + 1;
            if set.peephole
                ipt_num  = ipt_num + rnn.nodes;
            end
            t.cell.i.W = (rand(ipt_num, rnn.nodes) * 2 -1)/1000;
            t.grads.i = zeros(ipt_num, rnn.nodes);
            t.cell.i.f = 2;
            t.cell.f.W = (rand(ipt_num, rnn.nodes) * 2 -1)/1000;
            t.grads.f = zeros(ipt_num, rnn.nodes);
            t.cell.f.f = 2;
            t.cell.o.W = (rand(ipt_num, rnn.nodes) * 2 -1)/1000;
            t.grads.o = zeros(ipt_num, rnn.nodes);
            t.cell.o.f = 2;
        case 0
            t.percI.f = 1;
            t.percI.W = (rand(rnn.input_num + rnn.nodes + 1, rnn.nodes) * 2 -1)/1000;
            t.grads.in = zeros(rnn.input_num + rnn.nodes + 1, rnn.nodes);  
    end;
    t.test = zeros(set.groups,1);  
    for j=1:set.groups
        if (j> (i-1) * data.folds_groups) && (j<= i * data.folds_groups)
            t.test(j ) = 1;
        end
    end
    t.test =(t.test == 1);
    t.train =~t.test;
    t.record = init_train_record(set);
    rnn.body{i} =t;
end



