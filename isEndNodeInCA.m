function true_or_false = isEndNodeInCA(CA)


true_or_false=0;
[rows, cols] =size(CA);

for ix=1:rows
    for jx=1:cols
       if ~isempty(CA{ix,jx}) & CA{ix,jx}==6
          true_or_false=1;
          return
       end
    end
end
