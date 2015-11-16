function [grads, res_mem, res_stats ] = lstm_grad_residual(lstm, res_mem, res_stats, data, i)
mem = data.mem(:,:,i);
in = data.i(:,:,i);
o = data.o(:,:,i);
g = data.g(:,:,i);
f = data.f(:,:,i);
meml = data.mem(:,:,i-1);
statsl = data.stats(:,:,i-1);
input = [statsl,data.X(:,:,i-1)];
input_inner = input;
if lstm.peephole
    input_inner = [meml, input];
end

%计算输出门
rest = res_stats .* tanh(mem);
[grads.o, res.o] = perc_grad_residual(lstm.cell.o, rest, input_inner, o);

res_mem = res_stats .* o .* (1 - mem .* mem) + res_mem;
%计算遗忘门
rest = res_mem .* meml;
[grads.f, res.f] = perc_grad_residual(lstm.cell.f, rest, input_inner, f);

%计算输入门
rest = res_mem .* g;
[grads.i, res.i] = perc_grad_residual(lstm.cell.i, rest, input_inner, in);

%计算g
rest = res_mem .* in;
[grads.g, res.g] = perc_grad_residual(lstm.cell.g, rest, input, g);

if lstm.peephole
    idx = (lstm.nodes + 1):(lstm.nodes * 2);
else
    idx = 1:lstm.nodes;
end
res_stats= res.g(:,1:lstm.nodes) + res.o(:,idx)  + res.i(:,idx)  + res.f(:,idx);
res_mem = res_mem .* f;
if lstm.peephole
   idx = 1:lstm.nodes;
   res_mem = res_mem + res.i(:,idx)  + res.f(:,idx) + res.o(:,idx) ; 
end
end

