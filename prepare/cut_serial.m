function [ data] = cut_serial( X, T, groups ,pre_len)
%«–∑÷—µ¡∑–Ú¡–
train_length = floor((length(X) - pre_len)/groups) + pre_len;
data.X = ones(groups, size(X,2), train_length);
data.T = ones(groups, size(T,2) , train_length);
data.Y = ones(groups, size(T,2), train_length);

for i = 1:groups 
    for j = 1:train_length
        pos = (i - 1) * (train_length - pre_len) + j;
        data.X(i,:,j) = X(pos,:);
        data.T(i,:,j) = T(pos,:);       
    end
end
data.train_len = train_length;
data.groups = groups;
data.pre_len = pre_len;
end

