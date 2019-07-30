% x plus
% y moins
function I = left_down_optimum_area_QHT(I, xa,ya,xb,yb,xc,yc,xd,yd)
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
       
         x0d = xd;
         y0d = yd;

         
        for i = 1:n
            for j = 1:n
                Temp(n-i+1,j) = I((y0d+1)-i,j+(x0d-1));
            end
        end
        
%%%        disp('temp');
%%%        disp(Temp);
       % [L, m , n] = Linearize(Temp);
        resTemp =  QuantumHilbertTransform(Temp);
        
%%%        disp('restemp');
%%%        disp(resTemp);
       % resTemp = ULinearize(resTemp, m,n);
%%%        disp('restemp');
%%%        disp(resTemp);      
         for i = 1:n
            for j = 1:n
                I((y0d+1)-i,j+(x0d-1)) = resTemp(n-i+1,j);
            end
         end  
                 
%%%        disp('I eto');
%%%        disp(I);
        %%%% for part 0
%         x0d = xd;
%         y0d = yd;
%         x0b = xd+n-1;
%         y0b = yd-(n-1);
%         x0c = xa+n-1 ;
%         y0c = yd ;
%         x0a = xd;
%         y0a = yd-(n-1);

%                 disp('ok');
%
%        disp(x0a);
%        disp(y0a);
%        disp(x0b);
%        disp(y0b);
%        disp(x0c);
%        disp(y0c);
%        disp(x0d);
%        disp(y0d);

         
 %for part 1        
        x1a = xd+n;
        y1a = yd-n;
        x1b = xb;
        y1b = yd-n;
        x1c = xc;
        y1c = yc;
        x1d =  xd+n;
        y1d = yd;
        disp('ok 1 ');
        
%        disp(x1a);
%        disp(y1a);
%        disp(x1b);
%        disp(y1b);
%        disp(x1c);
%        disp(y1c);
%        disp(x1d);
%        disp(y1d);

        
        
        I = left_down_optimum_area_QHT(I, x1a,y1a,x1b,y1b,x1c,y1c,x1d,y1d);
  
 % for part 2       
        x2a = xa;
        y2a = ya;
        x2b = xb;
        y2b = yb;
        x2c = xb;
        y2c = yd-n;
        x2d =  xd;
        y2d = yd-n;
 
%        disp(x2a);
%        disp(y2a);
%        disp(x2b);
%        disp(y2b);
%        disp(x2c);
%        disp(y2c);
%        disp(x2d);
%        disp(y2d);
        
        
        I = left_down_optimum_area_QHT(I, x2a,y2a,x2b,y2b,x2c,y2c,x2d,y2d);
    end
end