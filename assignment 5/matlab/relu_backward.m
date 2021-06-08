function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
input_od = zeros(size(input.data));

ind = find(output.data>0);
input_od(ind) = output.diff(ind);

end
