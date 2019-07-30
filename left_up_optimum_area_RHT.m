function I = left_up_optimum_area_RHT(I, xa,ya,xb,yb,xc,yc,xd,yd)
    if ((xa<xb)&&(xd<xc)&&(ya<yd)&&(yb<yc))
        % affichage
        l = min([yd-ya, yc-yb,xb-xa, xc-xd]);
%%%        disp('l');
%%%        disp(l);
        p=floor(log2(l+1));
        n = floor(2^p);
%%%        disp('n');
%%%        disp(n);
        
        Temp = zeros(n);
%%%        disp('traitement');
        x0a = xa;
        y0a = ya;

        for i = 1:n
            for j = 1:n
                Temp(i,j) = I(i+y0a-1,j+x0a-1);
            end
        end
        
 %%%       disp('temp');
 %%%        disp(Temp);
        [L, p,q] = Linearize(Temp);
        resTemp = RecursiveHilbertTransform(L,log2(n));
        
 %%%        disp('restemp');
  %%%       disp(resTemp);
        resTemp = ULinearize(resTemp, p,q);
%%%        disp('restemp');
%%%        disp(resTemp);      
         for i = 1:n
            for j = 1:n
                I(i+y0a-1,j+x0a-1) = resTemp(i,j);
            end
         end  
        %%%% for part 0
%        x0a = xa;
%        y0a = ya;
%        x0b = xa+n-1;
%        y0b = ya;
%        x0c = xa+n-1 ;
%        y0c = ya+n-1 ;
%        x0d = xa;
%        y0d = ya+n-1;
        
%        disp(x0a);
%        disp(y0a);
%        disp(x0b);
%        disp(y0b);
%        disp(x0c);
%        disp(y0c);
%        disp(x0d);
%        disp(y0d);
%        disp('ok');
%%%         disp(Temp); 
         
 %for part 1        
        x1a = xa+n;
        y1a = ya;
        x1b = xb;
        y1b = yb;
        x1c = xc;
        y1c = yb+n;
        x1d =  xa+n;
        y1d = yb+n;
        I = left_up_optimum_area_RHT(I, x1a,y1a,x1b,y1b,x1c,y1c,x1d,y1d);
  
 % for part 2       
        x2a = xa;
        y2a = ya+n;
        x2b = xb;
        y2b = yb+n;
        x2c = xc;
        y2c = yc;
        x2d =  xd;
        y2d = yd;
 
        I = left_up_optimum_area_RHT(I, x2a,y2a,x2b,y2b,x2c,y2c,x2d,y2d);
    end
end