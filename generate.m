function I = generate(n)
%generate linear matrix
    L = floor(zeros(1,n*n));
    for i =1:n*n
        L(i) = i;
    end
%%% Ulinearize
  I = ULinearize(L, n,n);
end