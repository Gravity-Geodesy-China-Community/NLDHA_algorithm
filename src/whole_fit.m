function fu = whole_fit(a,b,d,s,c,x)
n = length(x); 
fu = zeros(n,1);
global PI;
global omg_bfgs;
global lbd_bfgs;
for i = 1:n
    fu(i) = a +b*x(i) + d*x(i)^2+exp( -lbd_bfgs*x(i) ) * ( s * sin( 2*PI*omg_bfgs*x(i) ) + c * cos( 2*PI*omg_bfgs*x(i) ) );
end

end
