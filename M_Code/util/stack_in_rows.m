function outputMatrix = stack_in_rows(inputMatrix)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
    sr = size(inputMatrix,1);   % size of inputMatrix rows
    sc = size(inputMatrix,2);
    nbr = size(inputMatrix,3);
    
    outputMatrix = zeros(sr*nbr, sc);
    for i = 1:nbr
        outputMatrix((i-1)*sr+1:i*sr,:) = inputMatrix(:,:,i);
    end
end

