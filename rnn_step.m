 function [ rnn ] = rnn_step( rnn, lr ,mode,i)
%     wo = rnn.percO.W(1:(end-1),:);
%     wi = rnn.percI.W(1:(end-1),:);
%     scl =sqrt(sqrt(length(wi(:))/length(wo(:))));
%     nwi = norm(wi(:));
%     nwo = norm(wo(:));
    switch mode
        case 0
            rnn.percO.W = rnn.percO.W - lr * rnn.grads.out;
        case 1
            if nwo*scl<nwi
                rnn.percO.W = rnn.percO.W - lr * rnn.grads.out;              
            end;
        case 2
            m = sum((wo .* wo)',1) + sum((wi .* wi),1);
            avg = mean(m);
            m = m<avg;
            m = randi(2,size(m))-1;
            mo = repmat([m';1],1,size(rnn.percO.W,2));
            mi = repmat(m,size(rnn.percI.W,1),1);
            rnn.percO.W = rnn.percO.W - lr * (rnn.grads.out .* mo);
        case 3
            mo = randi(3,size(rnn.percO.W))<2;            
            rnn.percO.W = rnn.percO.W - lr * (rnn.grads.out .* mo);
                 
    end
    switch rnn.type
        case 0
           switch mode
            case 0
                rnn.percI.W = rnn.percI.W - lr * rnn.grads.in;
            case 1
                if norm(wo)*scl>=norm(wi)
                    rnn.percI.W = rnn.percI.W - lr * rnn.grads.in;
                end;
            case 2
                  rnn.percI.W = rnn.percI.W - lr * (rnn.grads.in .* mi);
            case 3
                 mi = randi(3,size(rnn.percI.W))<2;
                 rnn.percI.W = rnn.percI.W - lr * (rnn.grads.in .* mi);
           end
%            fprintf('\n %f %f ',norm(rnn.grads.in(:)),norm(rnn.grads.out(:)));
%            fprintf(' %f %f %f %f\n',norm(rnn.percI.W(:)),norm(rnn.percO.W(:)),nwi,nwo);
        case 1
             switch mode
            case 0
                rnn.cell.g.W = rnn.cell.g.W  - lr *  rnn.grads.g;
                rnn.cell.i.W =  rnn.cell.i.W - lr * rnn.grads.i ;
                rnn.cell.f.W =  rnn.cell.f.W - lr * rnn.grads.f ;
                rnn.cell.o.W = rnn.cell.o.W - lr * rnn.grads.o;
            case 1
                if norm(wo)*scl>=norm(wi)
                    rnn.percI.W = rnn.percI.W - lr * rnn.grads.in;
                end;
            case 2
                  rnn.percI.W = rnn.percI.W - lr * (rnn.grads.in .* mi);
            case 3
                 mi = randi(3,size(rnn.percI.W))<2;
                 rnn.percI.W = rnn.percI.W - lr * (rnn.grads.in .* mi);
           end
            

    end;
    
end

