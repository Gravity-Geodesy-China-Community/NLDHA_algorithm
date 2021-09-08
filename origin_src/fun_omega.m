function [ff, df] = fun_omega(x)


global PI;
global y;
global t;
n = length(t);
for i = 1:n
    if y(i) < 9999
        w(i) = 1;
    else
        w(i) = 0;
    end
end

ff = 0;
for i = 1:n
    f(i) =  1/2 * w(i) *((( sin( 2*PI*x(1)*t(i) ) + cos( 2*PI*x(1)*t(i) ) - y(i))^2));
    ff = f(i) + ff;
end
    
if nargout > 1
   df = zeros(n, 1);
   for i = 1:n
       df(i) =  w(i) *((( sin( 2*PI*x(1)*t(i) ) + cos( 2*PI*x(1)*t(i) ) - y(i))^2)) * (cos(2*PI*t(i) - sin(2*PI*t(i))));
       df = f(i) + df(i);
   end
end

end
