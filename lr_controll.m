function [ record ,lr ,stop_flag ] = lr_controll(record, valid, rnn, lr, rate, i)
 stop_flag = 0;
 if record.trn_loss < record.min_trn_loss || record.min_trn_loss == -1
     record.min_trn_loss = record.trn_loss;
     record.min_round = i;  
 end;
 if record.trn_loss < record.all_min_trn_loss || record.all_min_trn_loss == -1
     record.all_min_trn_loss = record.trn_loss;
 end;

if i - record.min_round > record.confirm_rounds
    record.max_lr =record.max_lr*rate;
    if record.max_lr<lr
        lr = record.max_lr;
    end;
    record.min_trn_loss = record.trn_loss;
    record.min_round = i;
end

%�����ݶȱ�ը
if( record.trn_loss> record.all_min_trn_loss*1.5 && record.bom == 0 )
     % record.bom_rnn = rnn;
      record.bom = 1;
end;
if record.bom == 1
	if record.trn_loss> record.all_min_trn_loss*1.5 && record.trn_loss>record.last_ls
        lr = lr*0.1;
        %rnn = record.bom_rnn;
    else
       if record.trn_loss<record.all_min_trn_loss*1.5 && record.trn_loss<record.last_ls
            lr = lr * 1.1;
            % record.bom_rnn = rnn;
        end
    end;
end;
if lr>=record.max_lr
    lr = record.max_lr;
    record.bom = 0;
end
if lr<0.000001
    record.reset_flag = 0;
    return;
end; 
record.last_ls = record.trn_loss;    
    
 ls = norm(valid.Y(:)-valid.T(:));
 ls = ls * ls;
 c = corrcoef(valid.Y(:),valid.T(:));
 corr = c(2);
 if(record.all_min_loss > ls || record.all_min_loss == -1)
        record.max_rnn = rnn;
        record.max_valid = valid;    
        record.max_corr=corr; 
        record.all_min_loss = ls;
        record.all_count = 0;
 end;

if record.max_lr < 0.0000001
        stop_flag = 1;
        return;
end
if record.all_count > record.max_confirm_rounds
         stop_flag = 1;
         return;
end;           
if record.all_min_loss < ls 
        record.all_count = record.all_count + 1;
end;
fprintf('%i min_mse %f max_corr %f mse %f corr %f\n',i, record.all_min_loss/record.mse,    record.max_corr, ls/record.mse, corr);
fprintf('trn_min %f trn_mse %f lr%f max_lr %f bom %i r_left %i',record.all_min_trn_loss,record.trn_loss, lr,record.max_lr,record.bom, record.all_count);

end

