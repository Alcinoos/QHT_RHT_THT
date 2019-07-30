function [J, m,n] = Linearize(I)

[m,n]=size(I);
J = floor(zeros(1,m*n));

k = 1;
for i =1:m
   for j = 1:n
      J(k) = I(i,j); 
      k = k+1;
   end
    
end


end