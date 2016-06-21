function [comp,dict]=Huff_Coding(Data)

HEAD=0;
%%%%%%%%%%%%%%%%%%%%
%--Compute Header--------
POS=0; 
S_=size(Data);        
for i=1:S_(2)
    if (POS~=0)
      S=size(HEAD); F=0;
      k=1;
      while (F==0 && k<=S(2))
         if (Data(i)==HEAD(k))  F=1; end;
         k=k+1;
      end;
    else F=0; 
    end;
    if (F==0)
      POS=POS+1;
      HEAD(POS)=Data(i);
    end;
end;
%%%%%%%%Compute probability for symbols%%%%%%%%%%%%
S_H=size(HEAD);
Count(1:S_H(2))=0;
for i=1:S_H(2)
    for j=1:S_(2)
        if (Data(j)==HEAD(i))
            Count(i)=Count(i)+1;
        end;
    end;
end;
Count=Count./S_(2);
%%% Sort accoridng to maximum number%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:S_H(2)-1
    for j=i+1:S_H(2)
        if (Count(j)>Count(i))
            T1=Count(i); Count(i)=Count(j); Count(j)=T1;
            T1=HEAD(i); HEAD(i)=HEAD(j); HEAD(j)=T1;
        end;
    end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[dict,avglen] = huffmandict(HEAD,Count); % Create dictionary.

comp = huffmanenco(Data,dict); % Encode the data.
