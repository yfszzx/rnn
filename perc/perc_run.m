function [ Y ] = perc_run(perc, X)
X = [X,ones(size(X,1),1)];
Y = X * perc.W ;
switch perc.f
    case 1 %tanh
    Y = tanh(Y);
    case 2 %sigm
    Y = sigmf(Y,[1,0]);
    case 3
    Y = 2 * tanh(Y);
end;
