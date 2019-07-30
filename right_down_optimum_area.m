% x plus
% y moins
function I = right_down_optimum_area(I, xa,ya,xb,yb,xc,yc,xd,yd)
    if ((xa<xb)&&(xd<xc)&&(ya<yd)&&(yb<yc))
        % affichage
        l = min([yd-ya, yc-yb,xb-xa, xc-xd]);
        disp('l');
        disp(l);
        p=floor(log2(l));
        n = floor(2^p);
        disp('n');
        disp(n);
        
        Temp = zeros(n);
       
         x0c = xc;
         y0c = yc;

         
        for i = 1:n
            for j = 1:n
                Temp(n-i+1,n-j+1) = I((y0c+1)-i,(x0c+1)-j);
            end
        end
         disp('traitement');
         disp(Temp); 
        %%%% for part 0
%         x0a = xc-(n-1);
%         y0a = yc+(n-1);
%         x0b = xc;
%         y0b = yc+(n-1);
%         x0c = xa+n-1 ;
%         y0c = yd ;
%         x0d = xc-(n-1);
%         y0d = yc+(n-1);

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
        x1a = xa;
        y1a = yd+n;
        x1b = xb-n;
        y1b = yd+n;
        x1c = xb-n;
        y1c = yd+n;
        x1d =  xd;
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

        
        
        I = right_down_optimum_area(I, x1a,y1a,x1b,y1b,x1c,y1c,x1d,y1d);
  
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
        
        
        I = right_down_optimum_area(I, x2a,y2a,x2b,y2b,x2c,y2c,x2d,y2d);
    end
end