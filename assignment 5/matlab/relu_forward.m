function [output] = relu_forward(input)
output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;

% Replace the following line with your implementation.
output.data = zeros(size(input.data));
ind = find(input.data>0);
output.data(ind) = input.data(ind);
end