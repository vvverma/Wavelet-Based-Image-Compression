function Quantized = Quant_of_DCTdata(Data)

[row,col]=size(Data);
        
Quant_matrix = zeros(8);

Quant_matrix(1,1) = 0.0625;
Quant_matrix(1,2) = 0.0909;
Quant_matrix(2,1) = 0.0833;
Quant_matrix(1,3) = 0.1000;
Quant_matrix(3,1) = 0.0714;
Quant_matrix(2,2) = 0.0833;
Quant_matrix(4,1) = 0.0714;
Quant_matrix(3,2) = 0.0769;
Quant_matrix(2,3) = 0.0714;
Quant_matrix(1,4) = 0.0625;
           
for x=1:row
    for y=1:col
        Quantized(x,y) = round(Data(x,y) * Quant_matrix(x,y));
    end
end