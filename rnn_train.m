function rnn = rnn_train(rnn, data, set)

%³õÊ¼»¯
tmp = data.T(rnn.test,:,:);
tmp = norm(tmp(:));
rnn.record.mse = tmp * tmp;
lr = set.init_lr;

i = 0;
T = data.T;
X = data.X;
valid.T = data.T(rnn.test,:,(data.pre_len+1):end);
while 1
    tic;
    if set.noise>0        
        data.T =  T + normrnd(0,set.noise,size(T));
        data.X =  X + normrnd(0,set.noise,size(X));
    end;
    data = rnn_forward(rnn, data); 
    valid.Y = data.Y(rnn.test,:,(data.pre_len+1):end);
    [rnn.grads, rnn.record.trn_loss] = rnn_backward(rnn, data); 
    [ rnn.record ,lr ,stop_flag ] = lr_controll(rnn.record, valid, rnn, lr, set.decease_rate, i);
    if stop_flag
        break;
    end;
    if mod(i,set.show_img_freq)==set.show_img_freq-1
         figure(1);
         py = data.Y(rnn.train,:,(data.pre_len+1):end);
         pt = data.T(rnn.train,:,(data.pre_len+1):end);
          plot(py(:),pt(:),'.b');
         %plot(rnn.record.max_valid.Y(:),rnn.record.max_valid.T(:),'.r');
         figure(2);
         plot(valid.Y(:),valid.T(:),'.r');
    end;
    rnn = rnn_step( rnn, lr ,set.step_mode,i);
    i = i + 1;
    toc
end



