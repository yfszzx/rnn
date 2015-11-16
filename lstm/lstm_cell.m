function [ data ] = lstm_cell( lstm, data, i)
if i>1
    stats = data.stats(:,:,i-1);
    meml = data.mem(:,:,i-1);
else
     stats = zeros(data.groups,lstm.nodes);%size(data.stats,1),size(data.stats,2));
     meml = zeros(data.groups,lstm.nodes);%zeros(size(data.mem,1),size(data.mem,2));
end;

input = [stats, data.X(:,:,i)];
data.g(:,:,i) = perc_run(lstm.cell.g, input);
if lstm.peephole
    input = [meml, input];
end
data.i(:,:,i)  = perc_run(lstm.cell.i, input);
data.f(:,:,i)  = perc_run(lstm.cell.f, input);
data.mem(:,:,i) = data.g(:,:,i) .* data.i(:,:,i) + meml .* data.f(:,:,i);
data.o(:,:,i) = perc_run(lstm.cell.o, input);
data.stats(:,:,i) = tanh(data.mem(:,:,i)) .* data.o(:,:,i);
end

