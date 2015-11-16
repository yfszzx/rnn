function [ data ] = rnn_forward( rnn, data )
switch rnn.type
    case 0
        stats = zeros(data.groups, rnn.nodes);
        for i = 1:data.train_len 
            input = [stats , data.X(:,:,i)];
            stats = perc_run(rnn.percI, input); 
            data.stats(:, :, i) =  stats;
            data.Y(:,:,i) = perc_run(rnn.percO,  stats);  
        end;
    case 1
       for i = 1:data.train_len 
         data =  lstm_cell( rnn, data, i);
         data.Y(:,:,i) = perc_run(rnn.percO,  data.stats(:, :, i));  
       end;
end;


