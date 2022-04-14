function swing = swing_num(omg, lbd, x)
    global PI;
    n = length(x);
    fu = zeros(n,2);
    xx = x.';
    for i = 1:n
        fu(i,1) = exp( -lbd*i ) * ( sin( 2*PI*omg*i )); 
        fu(i,2) = exp( -lbd*i ) * ( cos( 2*PI*omg*i ));
    end
    fuu = fu.'; % ×ªÖÃ
    fuu1 = fuu*fu;
    fuuu = inv(fuu1);
    f = fuuu*fuu;
    ff = f*xx;
    swing = ff;
end