function [out_var] = Zigzag(in_var)

[r c] = size(in_var);
cnt = 0;

out_var = zeros(1,r*c);

for i = 1:r
    for j = 1:c
        cnt = cnt + 1;
        out_var(1,cnt) = in_var(i,j);
    end
end

        
        