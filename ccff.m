function fu = ccff(swsin, swcos, x)
n = length(x);
global lbd;
global omg;
global PI;
fu = zeros(n,1);
for i = 1:n
    %   Ö®Ç°µÄomg 
    % fu(i) =  exp( -lbd*x(i) ) * ( s * sin( 2*PI*omg*x(i) ) + c * cos( 2*PI*omg*x(i) ) );
    fu(i) = exp( -lbd*i ) * swsin * ( sin( 2*PI*omg*i )) + exp( -lbd*i ) * swcos * ( cos( 2*PI*omg*i ));
end

end
% index_1 * i + index_2 * i^2 +   
% a +b*x(i) + f(i) = x(1)*xdate(i)+x(2)*(xdate(i)^2)+x(3)*(xdate(i)^3)+x(4) *(xdate(i)^4)+x(5)*(xdate(i)^5)+x(6)*(xdate(i)^6)
%             +x(7)*(xdate(i)^7)+x(8)*(xdate(i)^8)+x(9)*(xdate(i)^9)+x(10)+x(10)*(xdate(i)^10)+x(11)*(xdate(i)^11)
%             +x(12)*(xdate(i)^12)+x(13)*(xdate(i)^13)+x(14)*(xdate(i)^14)+x(15)*(xdate(i)^15)+x(16)*(xdate(i)^16)
%             +x(17)*(xdate(i)^17)+x(18)*(xdate(i)^18)+x(19)*(xdate(i)^19)+x(20)*(xdate(i)^20)+x(21);
%             