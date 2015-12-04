function [ trn, test] = load_data(stock,train_scl,list, min)
if nargin == 0 
    stock=1;
end
switch stock
    case 1
if nargin == 3
    min = 0;
end;
[X, T, tr_end] = read_data('',train_scl,min);

%T = X([2:end,end],:);
trn.T = T(1:tr_end,:);
test.T = T(tr_end + 1:end,:) ;
trn.X = [];
test.X = [];
get.X = [];
gett.X = [];
[trn, test] = get_data(1, list, tr_end, X, trn, test);
[~,trn.X(:,2:end)] = princomp(trn.X(:,2:end));
trn.X=trn.X(:,1:(end));
    case 0
tt = csvread('data\mg_train.csv')*100;
t = tt(2:end)-tt(1:(end-1));
trn.X = t(1:(end-1));
  trn.X =zeros(length(t)-1,1);
trn.T = t(2:end);
tt = csvread('data\mg_test.csv')*100;
t = tt(2:end)-tt(1:(end-1));
test.X = t(1:(end-1));
test.T = t(2:end);
    case 2
     t = csvread('data\A.train.csv');  
     t=t(1:400);
      trn.X =zeros(length(t)-1,1);% t(1:(end-1));
      trn.T = t(2:end);
 t = csvread('data\A.test.csv');  
test.X = t(1:(end-1));
test.T = t(2:end);
end
end

