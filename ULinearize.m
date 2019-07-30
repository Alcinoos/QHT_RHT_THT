function I = ULinearize(J, m, n)

I = floor(zeros(m,n));

k = 1;
for i =1:m
   for j = 1:n
      I(i,j) = J(k); 
      k = k+1;
   end
    
end


end