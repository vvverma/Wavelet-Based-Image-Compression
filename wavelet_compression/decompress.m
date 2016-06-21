function d_img = decompress(i_path)

load(i_path, '-mat');

dict1=H(1).dict1;
dict2=H(2).dict2;
dict3=H(3).dict3;
i_name=H(4).i_name;
r=H(5).r;
c=H(6).c;
h_LLr1=H(7).h_LLr1;
h_LLg1=H(8).h_LLg1;
h_LLb1=H(9).h_LLb1;
comp1=H(10).comp1;
comp2=H(11).comp2;
comp3=H(12).comp3;
h_LLr=H(13).h_LLr;
h_LLg=H(14).h_LLg;
h_LLb=H(15).h_LLb;

%% Huffman decoding

 h_Data1 = huffmandeco(comp1,dict1);
 h_Data2 = huffmandeco(comp2,dict2);
 h_Data3 = huffmandeco(comp3,dict3);
 
 
%% Converting to 2D vector as input to De quantisation 

DCT_Quantized1 = ReZigzag(h_Data1,r,c);

DCT_Quantized2 = ReZigzag(h_Data2,r,c);

DCT_Quantized3 = ReZigzag(h_Data3,r,c);

%% De-Quantization
 
fun = @DeQuantization;
dct_dequantized1 = blkproc(DCT_Quantized1,[8,8],fun);

fun = @DeQuantization;
dct_dequantized2 = blkproc(DCT_Quantized2,[8,8],fun);

fun = @DeQuantization;
dct_dequantized3 = blkproc(DCT_Quantized3,[8,8],fun);

data_img1 = dct_dequantized1;

data_img2 = dct_dequantized2;

data_img3 = dct_dequantized3;


%% IDWT

d_img11=IDWT2(h_LLr1,data_img1,data_img1,data_img1,'haar');
d_img21=IDWT2(h_LLg1,data_img1,data_img2,data_img1,'haar');
d_img31=IDWT2(h_LLb1,data_img1,data_img3,data_img1,'haar');

d_img1=IDWT2(h_LLr,d_img11,d_img11,d_img11,'haar');
d_img2=IDWT2(h_LLg,d_img21,d_img21,d_img21,'haar');
d_img3=IDWT2(h_LLb,d_img31,d_img31,d_img31,'haar');

%% Reconstructing Image

d_img(:,:,1) = d_img1;
d_img(:,:,2) = d_img2;
d_img(:,:,3) = d_img3;

d_img = uint8(d_img);






        
