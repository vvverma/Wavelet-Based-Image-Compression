function [out_var] = ReZigzag(in_var,r,c)



out_var = zeros(r,c);
cnt = 0;
for i = 1:r
    for j = 1:c
        cnt = cnt + 1;
        out_var(i,j) = in_var(1,cnt);
    end
end