  function [output] = pooling_layer_forward(input, layer)
 
    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    outData = zeros([h_out* w_out* c, batch_size]);
    for n=1:batch_size
        pooledData = zeros(h_out, w_out, c);
        inData = input.data(:,n);
        inData = reshape(inData, h_in, w_in, c);
        padded = padarray(inData, [pad pad]);
        for cc = 1:c
            countY = 1;
            for i = 1: stride: h_in - k + 1
                countX = 1;
                for j = 1: stride: w_in - k + 1
                    matrix = padded(i:i+k-1,j:j+k-1,cc);
                    pooledData(countY,countX,cc) = max(matrix(:));
                    countX = countX + 1;
                end
                countY = countY + 1;
            end
        end
        
        outData(:,n) = reshape(pooledData,h_out* w_out* c ,1);  
    end
    output.data = outData;
    

end

