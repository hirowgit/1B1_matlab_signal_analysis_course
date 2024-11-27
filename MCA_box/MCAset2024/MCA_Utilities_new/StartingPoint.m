function delta = StartingPoint(C)

nbdicts = length(C);

for nb=1:nbdicts
 tmp = [];
 coeffs = C{nb};
 scaleindex = length(coeffs);

 for j = 2:scaleindex
  	  tmp = [tmp;coeffs(j).coeff(:)];
 end
 buf(nb)=max(abs(tmp(:)));
end

%
buf=flipud(sort(buf(:),1))';
delta=buf(2);

    
