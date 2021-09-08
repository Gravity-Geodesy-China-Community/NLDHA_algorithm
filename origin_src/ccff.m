function fu = ccff(a,b,d,s,c,x)
n = length(x);
global lbd;
global omg;
global PI;
fu = zeros(n,1);
for i = 1:n
    %   Ö®Ç°µÄomg
    fu(i) = a +b*x(i) + d*x(i)^2+exp( -lbd*x(i) ) * ( s * sin( 2*PI*omg*x(i) ) + c * cos( 2*PI*omg*x(i) ) );
end

end
