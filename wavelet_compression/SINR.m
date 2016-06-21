function SINR = SINR(A,B)

%PSNR(dB)

A = double(A);    
B = double(B);
[Row,Col] = size(A);
% [Row,Col] = size(B);
MSE = sum(sum((A - B).^2)) / (Row * Col);  
SINR = 10 * log10(255^2/MSE);              