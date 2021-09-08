function fu = non_fit(x,lbd_bfgs,omg_bfgs)
global PI;
n = length(x);
fu = zeros(n,1);
for i = 1:n
    fu(i) = exp( -lbd_bfgs*x(i) ) * ( sin( 2*PI*omg_bfgs*x(i) ) + cos( 2*PI*omg_bfgs*x(i) ) );
end

end
