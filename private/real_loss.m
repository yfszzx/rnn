function loss = real_loss( label, val ,scl )
s=sign(val);
loss = dot(label(:), s(:))/length(s(:));
%REAL_LOSS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
end

