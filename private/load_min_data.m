function [trn ]= load_min_data( )
[X, T] = make_min_data();
trn.T = T;
trn.X = X;
end

