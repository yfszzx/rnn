function loss = real_loss( label, val ,scl )
s=sign(val);
loss = dot(label(:), s(:))/length(s(:));
%REAL_LOSS 此处显示有关此函数的摘要
%   此处显示详细说明
end

