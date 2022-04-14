function index = verticalMigration(x)
    % global PI;
    n = length(x);
    fu = zeros(n,2);
    xx = x.';
    for i = 1:n
        fu(i,1) = i; 
        fu(i,2) = i^2;
    end
    fuu = fu.'; % ×ªÖÃ
    fuu1 = fuu*fu;
    fuuu = inv(fuu1);
    f = fuuu*fuu;
    ff = f*xx;
    index = ff;
    % index = 0;   
end