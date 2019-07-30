function res = RecursiveHilbertTransform(a,n)

 %int b[(int)pow(4,n)];
 % if (n==1) {
 %  tmp = a[2];
 %  a[2] = a[3];
 %  a[3] = tmp; }
 %else {
 %       for (i1=0; i1<(int)pow(2,n-1); i1++) {
 %       for (j1=0; j1<(int)pow(2,n-1); j1++) {
 %      // i0=0, j0=0
 %      b[j1*(int)(pow(2,n-1))+i1]=a[i1*(int)(pow(2,n))+j1];
 %      // i0=0, j0=1
 %       b[i1*(int)(pow(2,n-1))+j1+(int)pow(4,n-1)]=a[i1*(int)(pow(2,n))+j1+(int)pow(2,n-1)];
 %      // i0=1, j0=0
 %      b[((int)pow(2,n-1)-1-j1)*(int)(pow(2,n-1))+((int)pow(2,n-1)-1-i1)+3*(int)pow(4,n-1)]=a[i1*(int)(pow(2,n))+j1+(int)pow(2,2*n-1)];
 %      // i0=1, j0=1
 %      b[i1*(int)(pow(2,n-1))+j1+2*(int)pow(4,n-1)]=a[i1*(int)(pow(2,n))+j1+(int)pow(2,2*n-1)+(int)pow(2,n-1)];
 %      } }
 %      for (i=0; i<(int)pow(4,n); i++) a[i] = b[i];
 %      hilbert(n-1, &a[0]);
 %      hilbert(n-1, &a[(int)pow(4,n-1)]);
 %      hilbert(n-1, &a[2*(int)pow(4,n-1)]);
 %      hilbert(n-1, &a[3*(int)pow(4,n-1)]); } 
 %}   
 res  =a;     
      b = floor(zeros(1, floor(4^n)));
      
        
  if n == 1
      temp = res(3);
      res(3) = res(4);
      res(4) = temp;
      %res =a;
  else
      
              for i1 = 0: (floor((2^(n- 1)))-1)
                 for j1 = 0: (floor((2^(n- 1)))-1)
                  % i0 = 0, j0 =0
                  b(j1*(floor(2^(n-1)))+i1 +1)= a(i1*floor(2^n)+j1 +1);
           
                  % i0 = 0, j0 = 1
                  b(i1*(floor(2^(n-1)))+j1+(floor(4^(n-1))) +1)= a(i1*(floor(2^n))+j1+(floor(2^(n-1))) +1);
 
                  % i0 = 1, j0 = 0
                  b((floor(2^(n-1)-1-j1))*((floor(2^(n-1))))+((floor(2^(n-1)))-1-i1)+3*(floor(4^(n-1))) +1)=a(i1*(floor(2^n))+j1+(floor(2^(2*n-1))) +1);                  % i0 = 1, j0 = 1
                    
                  % i0 = 1, j0 = 1
                  b(i1*(floor(2^(n-1)))+j1+2*(floor(4^(n-1))) +1)= a(i1*((floor(2^n)))+j1+(floor(2^(2*n-1)))+(floor(2^(n-1))) +1);    
                  
                  
                 end 
              end


        
        for p = 1:(floor(4^(n)))
            res(p) = b(p); 
        end
 
        
        %%% appel de fonction récursive
        % Premier bloc entre deb = 1 à 4^(n-1)
        shift = 0;
        a1 = floor(zeros(1, floor(4^(n-1))));
        for i=1:4^(n-1)
            a1(i)=res(i+shift);
        end
        a1 = RecursiveHilbertTransform(a1, n-1);
        %%% Remis à  sa place
        for i=1:4^(n-1)
           res(i+shift) =  a1(i);
        end        

        shift = (floor(4^(n-1)));
        a2 = floor(zeros(1, floor(4^(n-1))));
        for i=1:4^(n-1)
            a2(i)=res(i+shift);
        end
        a2 = RecursiveHilbertTransform(a2, n-1);
        %%% Remis à  sa place
        for i=1:4^(n-1)
           res(i+shift) =  a2(i);
        end     
        
        
        
        shift = 2*(floor(4^(n-1)));
        a3 = floor(zeros(1, floor(4^(n-1))));
        for i=1:4^(n-1)
            a3(i)=res(i+shift);
        end
        a3 = RecursiveHilbertTransform(a3,n-1);
         %%% Remis à  sa place
        for i=1:4^(n-1)
           res(i+shift) =  a3(i);
        end            
        
        
        shift = 3*(floor(4^(n-1)));
        for i=1:4^(n-1)
            a4(i)=res(i+shift);
        end
        a4 = RecursiveHilbertTransform(a4,n-1);        
                %%% Remis à  sa place
        for i=1:4^(n-1)
           res(i+shift) =  a4(i);
        end  
        
       % res = a;
  end
    
  
  
end