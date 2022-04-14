function lbd = lbd_math(ox, PI, omg)
n = length(ox);
pn = zeros(4*n,0);
atmp = zeros(n,2);
for i = 1:4*n
    nmd = (i-1)*0.01/(4*n);
    for t = 1:n
        atmp(t,1) = exp(-nmd*t)*cos(2*PI*omg*t);
        atmp(t,2) = exp(-nmd*t)*sin(2*PI*omg*t);
    end
    trans = atmp';
    R = trans*atmp;
    tmpox = ox';
    r = trans*tmpox;
    rt = r'
    RR = inv(R);
    rtRR = rt*RR;
    rtRRr =rtRR*r;
    Pn(i) = rtRRr(1,1)/n;
end
[high lbd]=find(Pn == max(max(Pn)));
lbd = lbd*0.01/(4*n);
ff1 = linspace(0,0.01,4*n);