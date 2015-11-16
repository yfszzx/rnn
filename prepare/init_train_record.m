function [ record ] = init_train_record_init(set )
record.min_loss = -1;
record.max_corr = -1;
record.max_val=0;
record.all_min_loss = -1;
record.all_min_trn_loss = -1;
record.max_lr = set.init_lr;
record.confirm_rounds = set.confirm_rounds;
record.max_confirm_rounds = set.max_confirm_rounds;
record.bom = 0;
record.boomed = 0;
record.last_ls = 0;
record.min_trn_loss = -1;

end

