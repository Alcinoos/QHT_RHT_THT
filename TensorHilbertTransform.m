% Tensor hilbert transform
% coded by lab646-06 21/07/2019
% author : lacinoos



function res = TensorHilbertTransform(a,n)
res = a;
b = floor(zeros(1, floor(4^n)));
    for i = 0:(n-1)
        for k = 0:(floor(4^(i))-1)
              for i1 = 0: (floor((2^(n - i - 1)))-1)
                 for j1 = 0: (floor((2^(n - i - 1)))-1)
                  % i0 = 0, j0 =0
                  b(k*(floor((4^(n - i)))) + j1*(floor(2^(n - i - 1))) + i1 +1) = res(k*(floor(4^(n - i))) + i1*(floor(2^(n - i))) + j1 +1);
                  
                  % i0 = 0, j0 = 1
                  b(k *(floor(4^(n - i))) + i1*(floor(2^(n - i - 1))) + j1 + (floor(4^(n - i - 1))) +1) = res(k*(floor(4^(n - i))) + i1*(floor(2^(n - i))) + j1+ (floor(2^(n - i - 1))) +1);
                  % i0 = 1, j0 = 0
                  b(k*(floor(4^(n - i))) + ((floor(2^(n - i - 1))) - 1 - j1)*(floor(2^(n - i - 1))) + (floor(2^(n - i - 1)) - 1 - i1) + 3*(floor(4^(n - i - 1))) +1) =res(k*(floor(4^(n - i))) + i1*(floor((2^(n - i)))) + j1+ floor(2^(2*(n - i) - 1)) +1);
                 % i0 = 1, j0 = 1
                 b(k*(floor(4^(n - i))) + i1*(floor(2^(n - i - 1))) + j1 + 2*(floor(4^(n - i - 1))) +1) = res(k*(floor(4^(n - i))) + i1*(floor(2^(n - i))) + j1 + (floor(2^(2*(n - i) - 1)))+(floor(2^(n - i - 1))) +1);
               % b[k*(int)pow(4, n - i) + i1*(int)(pow (2, n - i - I)) + j1 + 2*(int)pow(4, n - i - 1)] = a[k*(int)pow(4, n - i) + i1*(int)(pow (2, n - i)) + j1 + (int)pow (2, 2*(n - i) - 1)+(int)pow (2, n - i - 1)];
 
                 end 
              end

        end

       for p = 1:(floor(4^(n)))
         res(p ) = b(p); 
        end
    end
   
end