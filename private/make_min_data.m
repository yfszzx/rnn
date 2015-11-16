function [data, label] = make_min_data( )
if exist('min_data.mat')
    load min_data;
    %train_end =  round(size(data,1) * train_scl);
else
    [num,txt]=xlsread('data\sh000001.xlsx');    
    
    close = repmat(num([1,1:(end -1)],4),1,4);
    num(:,1:4) = (num(:,1:4) - close)./close*100;   
    
    numd=xlsread('data\sh999999.xls');
    amount = numd(:,6);
    amount = filter(ones(1,1200)/1200,1,amount);
    amount =  amount( 1300:(1300 + length(num)/48 -1));
    amount = repmat(amount,1,48)';
    amount = amount(1:size(num,1))';
    num(:,6) = (num(:,6) * 48 - amount) ./ amount;
    num(:,5) =[];
    date = txt(2:end,1);
    week = weekday(date);
    T = datevec(date);
    tm = T;
    tm =( (tm(:,4)-9) * 60 + tm(:,5)-30)/5;
    t=tm>24;
    tm = (tm - t * 18) - 24;
    num(:,end + 1) = tm ;
    num(:,end + 1) = week([2:end,end]) -3;
    for i = 1: size(num,2)
        s = std(num(:,i));
        num(:,i) = num(:,i)/s;
    end
    data = num;
    label = num([2:end,end],4);%1:(end-2));
    save min_data data label
end
end

