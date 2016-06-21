function compress(Data,i_path,o_path)

%% Taking Image

i_name = Data;
%data = imread([i_path,Data]);
data = Data;

[drow dcol dframe] = size(data);   % row,col,no. of frames

%imview(data)
%% Calculating the total no. of data pixels
blocks = (drow * dcol)/64;
total_data_pixels = blocks * 10;

%% Seperate the RGB
data1=data(:,:,1);
data2=data(:,:,2);
data3=data(:,:,3);

%% take DWT of each color spaces
[h_LLr,h_LHr,h_HLr,h_HHr]=DWT2(data1,'haar');
[h_LLg,h_LHg,h_HLg,h_HHg]=DWT2(data2,'haar');
[h_LLb,h_LHb,h_HLb,h_HHb]=DWT2(data3,'haar');

[h_LLr1,h_LHr1,h_HLr1,h_HHr1]=DWT2(h_HLr,'haar');
[h_LLg1,h_LHg1,h_HLg1,h_HHg1]=DWT2(h_HLg,'haar');
[h_LLb1,h_LHb1,h_HLb1,h_HHb1]=DWT2(h_HLb,'haar');

%% SVD on Image

[U_imgr1,S_imgr1,V_imgr1]= svd(h_HLr1);
[U_imgg1,S_imgg1,V_imgg1]= svd(h_HLg1);
[U_imgb1,S_imgb1,V_imgb1]= svd(h_HLb1);

%% Reduced SVD
S_imgr1 = S_imgr1(1:25,1:25);
S_imgg1 = S_imgg1(1:25,1:25);
S_imgb1 = S_imgb1(1:25,1:25);
U_imgr1 = U_imgr1(:,1:25);
U_imgb1 = U_imgb1(:,1:25);
U_imgg1 = U_imgg1(:,1:25);
V_imgr1 = V_imgr1(:,1:25);
V_imgg1 = V_imgg1(:,1:25);
V_imgb1 = V_imgb1(:,1:25);


data_img1 = U_imgr1 * S_imgr1 * V_imgr1';
data_img2 = U_imgg1 * S_imgg1 * V_imgg1';
data_img3 = U_imgb1 * S_imgb1 * V_imgb1';


%% Quantization data image
fun = @Quantization;
quantized1 = blkproc(data_img1,[8,8],fun);


fun = @Quantization;
quantized2 = blkproc(data_img2,[8,8],fun);

fun = @Quantization;
quantized3 = blkproc(data_img3,[8,8],fun);
%% Converting to singular vector for Huffman coding
[r c] = size(quantized1);

 [ZigZag1] = Zigzag(quantized1);
 [ZigZag2] = Zigzag(quantized2);
 [ZigZag3] = Zigzag(quantized3);
 
%% Huffman coding


 
 [comp1,dict1]=Huff_Coding(ZigZag1);
 [comp2,dict2]=Huff_Coding(ZigZag2);
 [comp3,dict3]=Huff_Coding(ZigZag3);
 


H(1).dict1=dict1;
H(2).dict2=dict2;
H(3).dict3=dict3;
H(4).i_name=i_name;
H(5).r=r;
H(6).c=c;
H(7).h_LLr1=h_LLr1;
H(8).h_LLg1=h_LLg1;
H(9).h_LLb1=h_LLb1;
H(10).comp1=comp1;
H(11).comp2=comp2;
H(12).comp3=comp3;
H(13).h_LLr=h_LLr;
H(14).h_LLg=h_LLg;
H(15).h_LLb=h_LLb;




save(o_path, 'H');

