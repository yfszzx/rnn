function [ grads ,train_loss] = rnn_backward(rnn, data )
%将训练组提取出来
resY =(data.Y - data.T);  
resY = resY(rnn.train,:,:); 
t = resY(:,:,(data.pre_len + 1):end); 
train_loss = norm(t(:));
train_loss = train_loss*train_loss;
data.X = data.X(rnn.train,:,:);
data.Y = data.Y(rnn.train,:,:);
data.stats = data.stats(rnn.train,:,:);
data.groups = size(data.X,1);
res =  zeros(data.groups, rnn.nodes);   
grads.out = zeros(size(rnn.percO.W));

%初始化梯度、残差
switch  rnn.type   
    case 0
        grads.in =  zeros(size(rnn.percI.W));
    case 1      
    res_mem = zeros(data.groups, rnn.nodes);
    grads.g = zeros(size(rnn.cell.g.W));
    grads.o = zeros(size(rnn.cell.o.W));
    grads.i = zeros(size(rnn.cell.i.W));
    grads.f = zeros(size(rnn.cell.f.W));
    %将训练组提取出来
    data.g = data.g(rnn.train,:,:);
    data.i = data.i(rnn.train,:,:);
    data.f = data.f(rnn.train,:,:);
    data.mem = data.mem(rnn.train,:,:);
    data.o = data.o(rnn.train,:,:);     
    case 2
        grads.in =  zeros(size(rnn.percI.W));

end;
for  i = data.train_len :-1:( data.pre_len + 1)
    [grad,  rest] = perc_grad_residual(rnn.percO, resY(:,:,i) ,data.stats(:,:,i));
     grads.out = grads.out + grad;    
     switch rnn.type
         case 0
             res = res + rest ;
             input = [data.stats(:,:,i -1), data.X(:,:,i)];
             [grad, rest] = perc_grad_residual(rnn.percI, res, input, data.stats(:,:,i));
             grads.in  = grads.in + grad;
            res = rest(:,1:rnn.nodes,:);
         case 1
             res =rest ;%+ res; %不用梯度截断去掉res
             [grad, res_mem, res] = lstm_grad_residual(rnn, res_mem, res,  data, i);
             grads.o = grads.o + grad.o;
             grads.i = grads.i + grad.i;
             grads.g = grads.g + grad.g;
             grads.f = grads.f + grad.f;   
          case 2
              res = res + rest ;
             input = [data.stats(:,:,i -1),data.stats(:,:,i-rnn.delay-1), data.X(:,:,i)];
             [grad, rest] = perc_grad_residual(rnn.percI, res, input, data.stats(:,:,i));
             grads.in  = grads.in + grad;
            res = rest(:,1:rnn.nodes,:);

     end
end


