function I = right_up_optimum_area(I, xa,ya,xb,yb,xc,yc,xd,yd)
    if ((xa<xb)&&(xd<xc)&&(ya<yd)&&(yb<yc))
        % affichage
        l = min([yd-ya, yc-yb,xb-xa, xc-xd]);
%        disp('l');
%        disp(l);
        p=floor(log2(l));
        n = floor(2^p);
%        disp('n');
%        disp(n);
        
        Temp = zeros(n);
%        disp('traitement');
        x0b = xb;
        y0b = yb;

        for i = 1:n
            for j = 1:n
                Temp(i,n-j+1) = I(i+y0b-1,(x0b+1)-j);
            end
        end
        
        %%%% for part 0
%        x0a = xa;
%        y0a = yb-(n-1);
%        x0b = xb;
%        y0b = yb;
%        x0c = x0;
%        y0c = ya+n-1 ;
%        x0d = xb-(n-1);
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
%         disp(Temp); 
         
 %for part 1        
        x1a = xa;
        y1a = ya;
        x1b = xb-n;
        y1b = ya;
        x1c = xb-n;
        y1c = ya+n;
        x1d =  xa;
        y1d = ya+n;
        I = right_up_optimum_area(I, x1a,y1a,x1b,y1b,x1c,y1c,x1d,y1d);
  
 % for part 2       
        x2a = xa;
        y2a = ya+n;
        x2b = xb;
        y2b = yb+n;
        x2c = xc;
        y2c = yc;
        x2d =  xd;
        y2d = yd;
 
        I = right_up_optimum_area(I, x2a,y2a,x2b,y2b,x2c,y2c,x2d,y2d);
    end
end