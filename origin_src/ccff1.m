function fu = ccff1(a,b,s,c,x)
n = length(x);
global lbd;
global omg;
global PI;
fu = zeros(n,1);
for i = 1:n
    %   ֮ǰ??omg
    fu(i) = a +b*x(i) + exp( -lbd*x(i) ) * ( s * sin( 2*PI*omg*x(i) ) + c * cos( 2*PI*omg*x(i) ) );
end

end