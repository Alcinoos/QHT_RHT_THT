  function img2 = QuantumHilbertTransform(img)
    [W, H, K] = size(img);
    if K==1
        img2 = re_scrmbl(img);
    else %image color
        [imgR,imgG,imgB] = get_composant_image(img);
        disp('k=1')
        imgR2 = scrmbl(imgR);
        disp('k=2')
        imgG2 = scrmbl(imgG);
        disp('k=3')
        imgB2 = scrmbl(imgB);

        img2 = set_composant_image(imgR2, imgG2, imgB2);   
    end
  end
  function [imgR, imgG, imgB] = get_composant_image(img_color)
    [W, H, K] = size(img_color);
    imgR = uint8(zeros(W,H));
    imgG = uint8(zeros(W,H));
    imgB = uint8(zeros(W,H));

    for (i=1:W)
      for(j=1:H)
            imgR(i,j) = img_color(i,j,1);
            imgG(i,j) = img_color(i,j,2);
            imgB(i,j) = img_color(i,j,3);
      end
    end
  end
  function img_color = set_composant_image(imgR, imgG, imgB)
    [W, H, K] = size(imgR);
    img_color = uint8(zeros(W,H,K));
    for (i=1:W)
      for(j=1:H)
            img_color(i,j,1) = imgR(i,j);
            img_color(i,j,2)= imgG(i,j);
            img_color(i,j,3) = imgB(i,j);
      end
    end
  end
  %----------Scrambeling--------------------
  %
  %
  %

  %--------initialisation-------------------

  %-----k is coordination of images------------
  %-----actually k = wigth+heigth or is equal to 2n in 2ˆn * nˆ2 ... images
  %----calculate k value in each image
  % ------for all images , that is calculated its k value
  
  function [Scrambeled_position]= scrmbl(imCvr)
    tic;
    disp('Please wait for Partitioning and Scrambeling ...');
    [new_position]=Partition(0,imCvr); %function Partition(0), ... initialization  
    Dim=size(imCvr);
    %% Cnot gate ..............................

    for j=2:2.0:Dim(2)
      for i=1:2.0:Dim(1)

         if mod(j,2) == 0 % even
           % swap pair cells
           t=new_position(j,i);
           new_position(j,i)=new_position(j,i+1);
           new_position(j,i+1)=t;
           % swap pair cells
           
         end
       end
    end
    %% Cnot gate ................................
 
    %-------Partitioning with Odd & ... Even%functions-----------------------------%
    Dim=size(imCvr);

   for i=1:log2(Dim(1))-1



       if i < log2(Dim(1))-1
         %% re partitioning ...
         [P_Matrix]= P_Matrix(i,new_position); % 512 to 256 ... (Blocking ...)
         [P_Matrix]= Partition(0,P_Matrix);
         [new_position]= Reverse_P_Matrix(i,P_Matrix,Dim(1)); % ... 256 to 512

       end


    if mod(i,2)==1 % odd

      % odd func
      [new_position] = odd(i, new_position);


    else %even

      % even func
      [new_position] = Even(i,new_position);


    end


  end


 Scrambeled_position = new_position;
 toc;

end


function [P_Matrix]= P_Matrix(k,new_position)

  row=1;
  col=1;


  for j=1:(2^k):length(new_position)
    for i=1:(2^k):length(new_position)

      P_Matrix{col,row} = new_position(j:j+(2^k)-1,i:i+(2^k)-1);

      row=row+1;
    end
    row=1;
    col=col+1;

  end
  
  
end
function [new_position]= Reverse_P_Matrix(k,P_Matrix,Dim)

  row=1;
  col=1;

  for j=1:(2^k):Dim
    for i=1:(2^k):Dim

      new_position(j:j+(2^k)-1,i:i+(2^k)-1)=P_Matrix{col,row};

      row=row+1;
    end
    row=1;
    col=col+1;

  end
  
  
end




 %%
 %----------reverse Scrambeling------------
 %
 %
 %

  function [stego_position] = re_scrmbl(emb_position)

    % inverse scrambeling ...
    disp('Please wait for rinverse scrambeling ... ');
    new_inverse_position=emb_position;
    for i=log2(size(emb_position,1))-1:-1:1
   
      if mod(i,2) ==1 % odd
        [new_inverse_position] = inverse_odd(i,new_inverse_position);
      else % even
        [new_inverse_position] = inverse_even(i,new_inverse_position);
      end
      if i<log2(size(emb_position,1))-1
        %% re partitioning ...
        [P_Matrix]= P_Matrix(i,new_inverse_position); % 512 ... to 256 (Blocking ...)
        [P_Matrix]= inv_partition(0,P_Matrix);
        [new_inverse_position]= Reverse_P_Matrix(i,P_Matrix,size(emb_position,1)); % ... 256 to 512

      end

    end

  % at the end of the re scrambeling phase, I do Cnot gate and so doing
  % the re partition(0) for finish this function.

  %% Cnot gate ...
  for j=2:2.0:size(emb_position,2)
     for i=1:2.0:size(emb_position,1)

       if mod(j,2) == 0 % even
         % swap pair cells
         t=new_inverse_position(j,i);
         new_inverse_position(j,i)=new_inverse_position(j,i+1);
         new_inverse_position(j,i+1)=t;
         % swap pair cells
       end

     end
   end


  %% so doing of re partition(0) ...
  % return Stego image ...
  [stego_position] = inv_partition(0,new_inverse_position);

  end

%function [P_Matrix]= P_Matrix(k,new_position)
%
%  row=1;
%  col=1;
%
%
%  for j=1:(2^k):length(new_position)
%    for i=1:(2^k):length(new_position)
%
%      P_Matrix{col,row} = new_position(j:j+(2^k)-1,i:i+(2^k)-1);
%
%      row=row+1;
%    end
%      row=1;
%      col=col+1;
%
%  end
%
%
%end
%function [new_position]= Reverse_P_Matrix(k,P_Matrix,Dim)
%
%  row=1;
%  col=1;
%
%  for j=1:(2^k):Dim
%    for i=1:(2^k):Dim
%
%      new_position(j:j+(2^k)-1,i:i+(2^k)-1)=P_Matrix{col,row};
%
%      row=row+1;
%    end
%    row=1;
%    col=col+1;
%
%  end
%
%
%end



%%
function [s]= xorbin(A,B)

  if A=='0' && B =='1'

    s='1';

   elseif A=='0' && B=='0'
       
     s= '0';

   elseif A=='1' && B=='1'

     s='0';

  elseif A=='1' && B=='0'

     s='1';
  end



end

function [new_position]=Partition(k,imCvr)
  Dim=size(imCvr);
  
   for j =1 : Dim(2) % array 2 ˆ n * 2 ˆ n (e.g, 512 * 512)
     for i=1 : Dim(1)

       % convert to bit format

       X=dec2bin(i-1,log2(Dim(1)));
       p=k+1;
       
       %----inverse bit ordering

      [IX]=inverse_bit(X);

      while p+2<=log2(Dim(1))
        [IX(p+2),IX(p+1)]=Swp(IX(p+1),IX(p+2));
        p=p+1;
      end

       p=p-1;
       Y=dec2bin(j-1,log2(Dim(2)));
      [IX(p+2),Y(log2(Dim(2)))]= Swp(Y(log2(Dim(2))),IX(p+2));

     %----new positions------
 
      [X]=inverse_bit(IX);

     %%%

      w= bin2dec(Y) +1;
      l=bin2dec(X)+1;
      new_position(w ,l)=imCvr(j,i);

     end
  end
end

%function [output]=inverse_bit(input)
%  m=length(input);
%  output=dec2bin(0,m);
%  for n=1 : m
%    output(n)= input(m);
%    m=m-1;
%  end
%
%end

%function [B,A]=Swp(A,B)
%
%  t=A;
%  A=B;
%  B=t;
%
%end

function [P_Matrix]=odd(k,Dimen)


  Dim= size(Dimen);
  for j=1:Dim(2)
    for i=1:Dim(1)
        
      X=dec2bin(i-1,log2(Dim(1)));
      Y=dec2bin(j-1,log2(Dim(2)));
      
      % step1
      [IX]=inverse_bit(X);
      [IY]=inverse_bit(Y);

      % swap Yk with Xk
      [IY(k+1),IX(k+1)]=Swp(IX(k+1),IY(k+1));

      if IX(k+1)=='1'
          IY(k+1)=xorbin(IX(k+1),IY(k+1));
      end

      % step2

      if IY(k+1)=='1'
          for m=1:k
            [IY(m),IX(m)]=Swp(IX(m),IY(m));
          end
      end

   % step3

    if IX(k+1)=='1' && IY(k+1)=='0'
      for m=1:k

       IY(m)= xorbin(IY(m),IX(k+1));
       IX(m)= xorbin(IX(m),IX(k+1));

      end
    end
    
    [X]=inverse_bit(IX);
    [Y]=inverse_bit(IY);

    %%%%%%%%%

    w= bin2dec(Y)+1;
    l= bin2dec(X)+1;
    P_Matrix(w,l)=Dimen(j ,i);

    end
  end
end

%function [output]=inverse_bit(input)
%  m=length(input);
%  output=dec2bin(0,m);
%  for n=1 : m
%    output(n)= input(m);
%    m=m-1;
%  end
%  
%end

%function [B,A]=Swp(A,B)
%
%  t=A;
%  A=B;
%  B=t;
%
%end
function [P_Matrix] = inverse_odd(k,Dimen)


  for j=1:size(Dimen,2)
    for i=1:size(Dimen,1)

      X=dec2bin(i-1,log2(size(Dimen,1)));
      Y=dec2bin(j-1,log2(size(Dimen,2)));
     [X]=inverse_bit(X);
     [Y]=inverse_bit(Y);

      % Step 1

     if X(k+1)=='1' && Y(k+1)=='0'
       for m=1:k
         
         Y(m)= xorbin(Y(m),X(k+1));
         X(m)= xorbin(X(m),X(k+1));

       end
     end

 % Step 2


     if Y(k+1)=='1'
       for m=k:-1:1
         [Y(m),X(m)]=Swp(X(m),Y(m));
       end
     end

 % Step 3

     if X(k+1)=='1'
        Y(k+1)=xorbin(X(k+1),Y(k+1));
     end

 % swap Yk with Xk
     [Y(k+1),X(k+1)]=Swp(X(k+1),Y(k+1));

     [X]=inverse_bit(X);
     [Y]=inverse_bit(Y);

 %%%%%%%%%

     w= bin2dec(Y)+1;
     l= bin2dec(X)+1;
     P_Matrix(w,l)=Dimen(j ,i);

    end
  end
 end

%function [output]=inverse_bit(input)
%  m=length(input);
%  output=dec2bin(0,m);
%  for n=1:m
%    output(n)= input(m);
%    m=m-1;
%  end
%
%end

%function [B,A]=Swp(A,B)
%
%  t=A;
%  A=B;
%  B=t;
%
%end

function [P_Matrix] = inverse_even(k,Dimen)

  for j=1:size(Dimen,2)
    for i=1:size(Dimen,1)

      X=dec2bin(i-1,log2(size(Dimen,1)));
      Y=dec2bin(j-1,log2(size(Dimen,2)));
      [X]=inverse_bit(X);
      [Y]=inverse_bit(Y);

      % Step 1

      if Y(k+1)=='1' && X(k+1) == '0'

        for m=1:k
          Y(m)=xorbin(Y(m),Y(k+1));
          X(m)=xorbin(X(m),Y(k+1));
        end

      end

     % step 2

     if X(k+1)=='1'
       for m=k:-1:1
         [Y(m),X(m)]=Swp(X(m),Y(m));
       end
     end

    % step 3
    
    if Y(k+1)=='1'
      X(k+1)=xorbin(X(k+1),Y(k+1));
    end


    [X]=inverse_bit(X);
    [Y]=inverse_bit(Y);


    %%%%%%%%%

    w= bin2dec(Y)+1;
    l= bin2dec(X)+1;
    P_Matrix(w ,l)=Dimen(j ,i);
    
    end
  end
end


%function [output]=inverse_bit(input)
%   m=length(input);
%   output=dec2bin(0,m);
%   for n=1:m
%     output(n)= input(m);
%     m=m-1;
%   end
%
%end

%function [B,A]=Swp(A,B)
%
%  t=A;
%  A=B;
%  B=t;
%
%end


function [new_inverse_position]= inv_partition(k,stego)

  for j=1 : size(stego,2)
    for i=1:size(stego,1)
        
      % YX is cell coordination
      % convert to bit format ...
      X=inverse_bit(dec2bin(i-1,log2(size(stego,1))));
      Y =inverse_bit(dec2bin(j-1,log2(size(stego,2))));
      [Y(k+1),X(log2(size(stego,1)))]=Swp(X(log2(size(stego,1))),Y(k+1));
      ed=log2(size(stego,1));
      while ed > k+2
        [X(ed),X(ed-1)]= Swp(X(ed-1),X(ed));
        ed=ed-1;
      end

      X=inverse_bit(X);
      Y=inverse_bit(Y);
      %%%
      w=bin2dec(Y)+1;
      l=bin2dec(X)+1;

      new_inverse_position(w,l)=stego(j,i);

    end
  end

end

%function [output]=inverse_bit(input)
%  m=length(input);
%  output=dec2bin(0,m);
%  for n=1:m
%    output(n)= input(m);
%    m=m-1;
%  end
%
%end

%function [B,A]=Swp(A,B)
%
%  t=A;
%  A=B;
%  B=t;
%
%end

function [P_Matrix]=Even(k,Dimen)


  Dim= size(Dimen);
  for j=1:Dim(2)
    for i=1:Dim(1)
        
      X=dec2bin(i-1,log2(Dim(1))); 
      Y=dec2bin(j-1,log2(Dim(2)));

      % step1
      [IX]=inverse_bit(X);
      [IY]=inverse_bit(Y);


      if IY(k+1)=='1'
        IX(k+1)=xorbin(IX(k+1),IY(k+1));
      end

      % step2

   if IX(k+1)=='1'
     for m=1:k
       [IY(m),IX(m)]=Swp(IX(m),IY(m));
     end
   end

   % step3
   
   if IY(k+1)=='1' && IX(k+1)=='0'
     for m=1:k
       IY(m) = xorbin(IY(m),IY(k+1));
       IX(m)= xorbin(IX(m),IY(k+1));
     end
   end

   [X]=inverse_bit(IX);
   [Y]=inverse_bit(IY);


   %%%%%%%%%

   w= bin2dec(Y)+1;
   l= bin2dec(X)+1;
   P_Matrix(w ,l)=Dimen(j ,i);



   end

  end
  
  
  
end

function [output]=inverse_bit(input)
  m=length(input);
  output=dec2bin(0,m);
  for n=1:m
    output(n)= input(m);
    m=m-1;
  end

end

function [B,A]=Swp(A,B)

  t=A;
  A=B;
  B=t;

end



