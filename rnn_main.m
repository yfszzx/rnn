function [rnn] = rnn_main(trn,set)
[rnn, data] = rnn_prepare( trn.X, trn.T, set);
for i = 1:set.folds_num
   rnn.body{i} =  rnn_train(rnn.body{i},data, set);
end;