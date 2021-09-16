function ff = fun_lbd(x)
global ox;
a = ox';
global t;
global PI;
global omg_bfgs;
n = length(t);
for i = 1:n
    if a(i) < 9999
        w(i) = 1;
    else
        w(i) = 0;
    end
end
ff = 0;

for i = 1:n
    f(i) =  1/2 * w(i) *((( exp( - x(1)*t(i) ) * (sin( 2*PI*omg_bfgs*t(i) ) + cos( 2*PI*omg_bfgs*t(i) )) - a(i))^2));
    ff = f(i) + ff;
    ff_num(i) = ff;
end
    
end
