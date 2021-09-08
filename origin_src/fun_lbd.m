function ff = fun_lbd(x)


global PI;
global y;
global t;
global omg_bfgs;
n = length(t);
for i = 1:n
    if y(i) < 9999
        w(i) = 1;
    else
        w(i) = 0;
    end
end

 %% sum sin( 2*PI*omg*t(i) ) + cos( 2*PI*omg*t(i) ) )

%  for i = 1:n
%      temp_sin = 0;
%      for j = 1:k
%          temp= sin( 2*PI*omg(j)*t(i) ) + cos( 2*PI*omg(j)*t(i) ) ;
%          temp_sin = temp + temp_sin;
%      end
%      
%          ff(i) =  1/2 * w(i) *(((  temp_sin - x(i))^2));
%  end

ff = 0;
for i = 1:n
    f(i) =  1/2 * w(i) *((( exp( - x(1)*t(i) ) * (sin( 2*PI*omg_bfgs*t(i) ) + cos( 2*PI*omg_bfgs*t(i) )) - y(i))^2));
    ff = f(i) + ff;
end
    
end
