function [  grads,  residual_out] = perc_grad_residual(perc, residual_in , input, output)
switch perc.f
	case 1 % tanh
		residual_in =  residual_in .* (1 - output .*  output) ;
	case 2 % sigm
		residual_in =  residual_in .* output .* (1 -   output);   
	case 3 % 2tanh
		residual_in =  2 * residual_in .* (1 - output .*  output) ;
end
input = [input,ones(size(input,1),1)];
grads = input' * residual_in / length(input);
if nargout == 2
    residual_out = residual_in * perc.W(1:(end-1),:)'; 
end

